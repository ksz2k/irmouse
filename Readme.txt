Readme for IRMouse - infra red controlled USB mouse device (HID class)

http://szczuka.eu/en/avr/irmouse

	ABOUT IRMouse

IRMouse is an USB mouse controlled by ir remote..
It receives packets from remote, decodes, and (if ir code matching) sends 
reports to PC via USB.. Reports are as in standard USB mouse, so there is no
need for additional programs/drivers on PC side, everything is done in IRMouse
and system recognizes it as standard USB mouse..

It is built on two ATtiny2313 uC's connected via USART..
I've tried to make it on one ATmega8, but there was too much interrupts at
the same time (from USB host and from IR), and one AVR couldn't make it work,
after few packets received from remote, the device was disapeared from USB bus.
If you're more interested on this problem, see
http://forums.obdev.at/viewtopic.php?t=243  (-;


	HARDWARE / FIRMWARE MISC INFORMATION

For now firmware decodes only SPACE_ENCODED standards of IR transmittion,
if you'll add your own, let me know..

The USB ATtiny is clocked by external 12MHz crystal, IR ATtiny by internal 
8MHz clock.

Aditionally I've used some strange Sanyo remote, that for every ir packet was 
sending different code, and only first was always the same, so there is an 
option for check only first code, and send reports without later ir code 
recheck. This happens when JP1 is closed to GND..


	PRE-BUILD CONFIGURATION

You probably want to change the remote codes and timings, I'm using separate .h
file for every remote, in remotes/ there is remote_template.h as template, just
rename it to yours remote and define it's timings and codes. Then change
REMOTE in Makefile and add #ifdef in main-ir.c

If ZERO_TEST in main-ir.c is defined, device comparing the TZEROH time, else 
TONEH. You may need to compare other times, you can change it in main-ir.c in 
main() and makeReport() functions..

In usbconfig.h you can change the device/vendor names, but be careful, because
the compilers' output file for USB is 2036B size, so it's almost full..

USART speed is 38400bd, it can be changed in defines.h


	BUILD INFORMATION

The firmware code was written for and tested with avr-gcc (avr-libc 1.4), 
compiled on Linux, but with WinAVR on Windows should work fine too.. For 
programming the AVR's I've used great AVRDUDE.. See Makefile for info and some
config options..

To build firmware, just 'make' and there should be two .hex files.. 
'make flashir' flashes the IR target, and 'make flashusb' - USB target. 
Also you can set fuses of both targets ('make fuseir' and 'make fuseusb'). 
For more details see Makefile's comments..


	LICENSE

The project is built with AVR USB driver by Objective Development, which is
published under a proprietary Open Source license. To conform with this
license, IRMouse is distributed under the same license conditions. See the
file usbdrv/License.txt for details. 


	FILES IN THE DISTRIBUTION

Readme.txt ............. The file you are currently reading
usbdrv ................. AVR USB driver by Objective Development
usbdrv/License.txt ..... Public license for AVR USB driver and IRMouse
circuit ................ Circuit diagram in PNG and EAGLE format
remotes ................ Different remotes header files
main-ir.c .............. Main file for IR ATtiny
main-usb.c ............. Main file for USB ATtiny
usbconfig.h ............ USB configuration file
defines.h .............. Some definitions for both IR and USB uC's
