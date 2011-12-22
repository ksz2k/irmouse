
#ifndef _DEFINES_
#define _DEFINES_

// USART baud rate
#define BAUD_RATE			38400

#define CYCLES_PER_US 		((F_CPU+500000)/1000000)

// flagi do ustawiania w 'flags' w plikach main-[ir,usb].c 
#define FLG_IR_RECEIVED		0x01
#define FLG_MAKING_REPORT	0x02
#define FLG_SENDING_REPORT	0x04
#define FLG_IGNORE_PACKET	0x08

#endif	// _DEFINES_
