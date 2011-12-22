
#define F_CPU   8000000L // clock frequency

#include <avr/io.h>
#include <avr/interrupt.h>
//#include <avr/pgmspace.h>
#include <avr/wdt.h>
#include <inttypes.h>
#include <string.h>

//#include "defines.h"

/******************* REMOTE CONFIG ********************************************/
#ifdef PANASONIC_VEQ1141
# include "panasonic_veq1141.h"
#else
# ifdef SANYO_PLCXT10A
#  include "sanyo_plcxt10a.h"
# else		// !SANYO_PLCXT10A
#  error "No remote type defined!!!"
# endif		// SANYO_PLCXT10A
#endif		// PANASONIC_VEQ1141

#define ZERO_TEST


/******************* PINOUT CONFIG ********************************************/
#define LED_PIN		PINB	// LED PIN
#define LED_DDR		DDRB	// LED DDR
#define LED_PORT	PORTB	// LED PORT
#define LED_PWR		0		// zasilanie
#define LED_PWR_ON	do { LED_PORT |= _BV(LED_PWR); } while(0)
#define LED_PWR_OFF	do { LED_PORT &= ~_BV(LED_PWR); }  while(0)
#define LED_IR		1		// odbior w podczerwieni
#define LED_IR_ON	do { LED_PORT |= _BV(LED_IR); }  while(0)
#define LED_IR_OFF	do { LED_PORT &= ~_BV(LED_IR); }   while(0)
#define LED_C		2		// kod przycisku pasuje do zdefiniowanych
#define LED_C_ON	do { LED_PORT |= _BV(LED_C); }  while(0)
#define LED_C_OFF	do { LED_PORT &= ~_BV(LED_C); }   while(0)
#define LED_MASK	(_BV(LED_IR) | _BV(LED_PWR) | _BV(LED_C))

// jumper okreslania sposobu sprawdzania pakietow (zwarty -sprawdza tylko pierwszy pakiet)
#define MODE_SW_PIN	PINB
#define MODE_SW_DDR	DDRB
#define MODE_SW_PORT PORTB
#define MODE_SW		3



/******************* MISC CONFIG **********************************************/
// szybkosc kursora (w pikselach)
#define MOVE		0x04

#define	TIMEOUT		3500	
#define	IR_MAX		96		
#define	SCALING		8		

/******************************************************************************/

#define calcIRTime(val) ((val + (1 << (SCALING-3-1))) >> (SCALING-3))

static	struct			// 
{
	unsigned char	length;
	unsigned char	count;
	unsigned char	data[IR_MAX];
}		ir;

static	unsigned char			edges;
static	unsigned int			irdelta;
static	uint32_t				lastcode = 0;
static	volatile unsigned char	flags = 0;
static	unsigned char    		reportBuffer[3] = {0}; 

#define IR_INTS_ON	do{TIMSK |= (_BV(OCIE1A) | _BV(ICIE1));} while(0)
#define IR_INTS_OFF	do{TIMSK &= ~(_BV(OCIE1A) | _BV(ICIE1));} while(0)
//#define IR_INTS_OFF	do{TIMSK = 0;}while(0)


static char makeReport(void);
static void sendReport(void);

// zmiana zbocza na ICP
ISR(TIMER1_CAPT_vect)
{
	static	unsigned int	prev;
	unsigned int			stamp;
	unsigned char			delta;

	stamp = ICR1;
	TCCR1B ^= _BV(ICES1);
	LED_IR_ON;
	
	delta = calcIRTime(stamp - prev);
	asm volatile("" : : "r"(delta) );
	
	prev  = stamp;
	// update timeout value 
	OCR1A = stamp + TIMEOUT * CYCLES_PER_US / 8;

	if ( !(flags & (FLG_IGNORE_PACKET | FLG_MAKING_REPORT)) )
	{
		ir.length = 0;
		if	( edges > 0 )
			ir.data[edges - 1] = delta;
		++edges;
	}
}


// timeout odbioru pakietu w podczerwieni
ISR(TIMER1_COMPA_vect)
{
	IR_INTS_OFF;
	LED_IR_OFF;
	
	if ( edges >= 40 &&
		!(flags & (FLG_IGNORE_PACKET | FLG_MAKING_REPORT))
		)
	{
		ir.count++;
		ir.length = edges - 1;		// nowy pakiet kompletny
		flags |= FLG_IR_RECEIVED;
	}
	edges = 0;
	flags &= ~FLG_IGNORE_PACKET;
	
	TCCR1B &= ~_BV(ICES1);
	
	
	TCNT0 = TCNT0V;
	TIMSK |= _BV(TOIE0);
	
	IR_INTS_ON;
	
}


ISR(TIMER0_OVF_vect)
{
	if( !edges ) {
		if( (ir.count > 0) && 
			( (lastcode == CLMB) || (lastcode == CRMB) ) ) {	
			// raportuj uwolnienie przycisku LMB/RMB
			reportBuffer[0] = 0;
			reportBuffer[1] = 0;
			reportBuffer[2] = 0;
	    	flags |= FLG_SENDING_REPORT;
		    sendReport();
        	flags &= ~FLG_SENDING_REPORT;
        }
		ir.count = 0;
		lastcode = 0;
	}
	TCNT0 = TCNT0V;	
	TIMSK &= ~_BV(TOIE0);
}


static char makeReport(void)
{
	unsigned char i = 0;
	unsigned char retval = 0;
	unsigned char cc = ir.length-2;
	uint32_t code = 0;	
	
	flags |= FLG_MAKING_REPORT;
	
	if( !(MODE_SW_PIN & _BV(MODE_SW)) && (ir.count > 0) )
		code = lastcode;
	else {
		for ( i = 0 ; i < 24 ; i++ ) {
			if (edges)
				flags |= FLG_IGNORE_PACKET;
		#ifdef ZERO_TEST
			if( ir.data[cc] > irdelta )
				code &= ~_BV(i);
			else
				code |= _BV(i);
		#else
			if( ir.data[cc] > irdelta )
				code |= _BV(i);
			else
				code &= ~_BV(i);
		#endif
			cc -= 2;
		}
	}
	
	flags &= ~FLG_MAKING_REPORT;	
	
	//if ( !(flags & FLG_SENDING_REPORT) ) {
		switch (code) {
			case CUPH:
				reportBuffer[0] = 1;
				reportBuffer[1] = 0;
				reportBuffer[2] = -MOVE;
				lastcode = code;
				retval = 1;
				break;
			case CDOWNH:
				reportBuffer[0] = 1;
				reportBuffer[1] = 0;
				reportBuffer[2] = MOVE;
				lastcode = code;
				retval = 1;
				break;
			case CLEFTH:
				reportBuffer[0] = 1;
				reportBuffer[1] = -MOVE;
				reportBuffer[2] = 0;
				lastcode = code;
				retval = 1;
				break;
			case CRIGHTH:
				reportBuffer[0] = 1;
				reportBuffer[1] = MOVE;
				reportBuffer[2] = 0;
				lastcode = code;
				retval = 1;
				break;
			case CUP:
				reportBuffer[0] = 0;
				reportBuffer[1] = 0;
				reportBuffer[2] = -MOVE;
				lastcode = code;
				retval = 1;
				break;
			case CDOWN:
				reportBuffer[0] = 0;
				reportBuffer[1] = 0;
				reportBuffer[2] = MOVE;
				lastcode = code;
				retval = 1;
				break;
			case CLEFT:
				reportBuffer[0] = 0;
				reportBuffer[1] = -MOVE;
				reportBuffer[2] = 0;
				lastcode = code;
				retval = 1;
				break;
			case CRIGHT:
				reportBuffer[0] = 0;
				reportBuffer[1] = MOVE;
				reportBuffer[2] = 0;
				lastcode = code;
				retval = 1;
				break;
			case CLMB:
				reportBuffer[0] = 1;
				reportBuffer[1] = 0;
				reportBuffer[2] = 0;
				lastcode = code;
				retval = 1;
				break;
			case CRMB:
				reportBuffer[0] = 2;
				reportBuffer[1] = 0;
				reportBuffer[2] = 0;
				lastcode = code;
				retval = 1;
				break;
			case CRMBH:
				reportBuffer[0] = 3;
				reportBuffer[1] = 0;
				reportBuffer[2] = 0;
				lastcode = code;
				retval = 1;
				break;
			default:
				reportBuffer[0] = 0;
				reportBuffer[1] = 0;
				reportBuffer[2] = 0;
				break;
		}
	//}
    return retval;
}


static void sendReport(void)
{
	unsigned char i;
	for ( i=0 ; i< sizeof(reportBuffer) ; i++ ) {
		while(!(UCSRA & _BV(UDRE))) ;
		UDR = reportBuffer[i];
	}
}

static void hardwareInit(void)
{
    MODE_SW_PORT |= _BV(MODE_SW);
    MODE_SW_DDR &= ~_BV(MODE_SW);

    LED_DDR |= LED_MASK;
    
    TCCR1B = _BV(ICNC1)	
	       | _BV(CS11);	

	// ir interrupts (OCIE1A, ICIE1)
	IR_INTS_ON;

	/*** UART init ***/
	// baud rate
	UBRRH = (unsigned char)(((F_CPU)/((BAUD_RATE)*16l)-1)>>8);
    UBRRL = (unsigned char) ((F_CPU)/((BAUD_RATE)*16l)-1);
	// potrzebujemy tylko tx
	UCSRB = _BV(TXEN);
	// asynchronous mode, 8N1
	UCSRC = _BV(UCSZ1) | _BV(UCSZ0);

	// Timer0 prescaler na 1024
	TCCR0B |= _BV(CS02) | _BV(CS00);
}



/* ------------------------------------------------------------------------- */

int	main(void)
{
# ifdef ZERO_TEST
	irdelta = calcIRTime(TZEROH);
# else
	irdelta = calcIRTime(TONEH);
# endif

	wdt_enable(WDTO_1S);
	hardwareInit();
	sei();
	LED_PWR_ON;
	LED_IR_OFF;
	LED_C_OFF;

	for(;;){
		wdt_reset();
		if ( (flags & FLG_IR_RECEIVED) ) {
		    if ( makeReport() ) {
				LED_C_ON;
		    	flags |= FLG_SENDING_REPORT;
			    sendReport();
	        	LED_C_OFF;
	        	ir.length = 0;				
			}
			flags &= ~( FLG_SENDING_REPORT | FLG_IR_RECEIVED );
		}
	}
	return 0;
}

/* ------------------------------------------------------------------------- */
