

#define F_CPU   12000000L

#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>
#include <avr/wdt.h>
#include <inttypes.h>

#include "usbdrv.h"


static	unsigned char volatile	flags = 0;
static	uchar    				reportBuffer[3];    

#include "defines.h"


ISR(USART_RX_vect)
{
	static unsigned char bc = 0;
	
	reportBuffer[bc++] = UDR;
	
	if( (bc%3) == 0 ) {
		flags |= FLG_IR_RECEIVED;
		bc = 0;
		UCSRB &= ~_BV(RXCIE);
	}
}



static void hardwareInit(void)
{
uchar	i, j;
    
    PORTD = 0xe3;   
    DDRD = 0x1c;  
	j = 0;
	while(--j){
		i = 0;
		while(--i); 
	}
    DDRD = 0x10;   
    
    /*** UART init ***/
	// baud rate
	UBRRH = (unsigned char)(((F_CPU)/((BAUD_RATE)*16l)-1)>>8);
    UBRRL = (unsigned char) ((F_CPU)/((BAUD_RATE)*16l)-1);
	UCSRB = _BV(RXEN) | _BV(RXCIE);
	// asynchronous mode, 8N1
	UCSRC = _BV(UCSZ1) | _BV(UCSZ0);
}



/* ------------------------------------------------------------------------- */
/* ----------------------------- USB interface ----------------------------- */
/* ------------------------------------------------------------------------- */


// deskryptor USB
char usbHidReportDescriptor[] = {
    0x05, 0x01,                    // USAGE_PAGE (Generic Desktop)
    0x09, 0x02,                    // USAGE (Mouse)
    0xa1, 0x01,                    // COLLECTION (Application)
    0x09, 0x01,                    //   USAGE (Pointer)
    0xa1, 0x00,                    //   COLLECTION (Physical)
    0x05, 0x09,                    //     USAGE_PAGE (Button)
    0x19, 0x01,                    //     USAGE_MINIMUM (Button 1)
    0x29, 0x03,                    //     USAGE_MAXIMUM (Button 3)
    0x15, 0x00,                    //     LOGICAL_MINIMUM (0)
    0x25, 0x01,                    //     LOGICAL_MAXIMUM (1)
    0x95, 0x03,                    //     REPORT_COUNT (3)
    0x75, 0x01,                    //     REPORT_SIZE (1)
    0x81, 0x02,                    //     INPUT (Data,Var,Abs)
    0x95, 0x01,                    //     REPORT_COUNT (1)
    0x75, 0x05,                    //     REPORT_SIZE (5)
    0x81, 0x03,                    //     INPUT (Cnst,Var,Abs)
    0x05, 0x01,                    //     USAGE_PAGE (Generic Desktop)
    0x09, 0x30,                    //     USAGE (X)
    0x09, 0x31,                    //     USAGE (Y)
    0x15, 0x81,                    //     LOGICAL_MINIMUM (-127)
    0x25, 0x7f,                    //     LOGICAL_MAXIMUM (127)
    0x75, 0x08,                    //     REPORT_SIZE (8)
    0x95, 0x02,                    //     REPORT_COUNT (2)
    0x81, 0x06,                    //     INPUT (Data,Var,Rel)
    0xc0,                          //   END_COLLECTION
    0xc0                           // END_COLLECTION
};

uchar	usbFunctionSetup(uchar data[8])
{
usbRequest_t    *rq = (void *)data;

    usbMsgPtr = reportBuffer;
    if((rq->bmRequestType & USBRQ_TYPE_MASK) == USBRQ_TYPE_CLASS){ 
        if(rq->bRequest == USBRQ_HID_GET_REPORT){  
            return sizeof(reportBuffer);
        }
    }else{
        /* no vendor specific requests implemented */
    }
	return 0;
}


/* ------------------------------------------------------------------------- */

int	main(void)
{
	wdt_enable(WDTO_2S);
	hardwareInit();
	usbInit();
	usbDeviceConnect();
	sei();

	for(;;){
		wdt_reset();
		usbPoll();
		if (flags & FLG_IR_RECEIVED) {
			if (usbInterruptIsReady()){
            	usbSetInterrupt(reportBuffer, sizeof(reportBuffer));
            }
           	flags &= ~FLG_IR_RECEIVED;
            UCSRB |= _BV(RXCIE);
		}
	}
	return 0;
}

/* ------------------------------------------------------------------------- */
