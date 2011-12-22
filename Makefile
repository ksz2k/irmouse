# Name:      Makefile
# Project:   IRMouse
# Author:    Krzysiek Szczuka
# Creation   Date: 2007-01-12
# Tabsize:   4
# Copyright: (c) 2007 by Krzysiek Szczuka
# License:   Proprietary, free under certain conditions. See Documentation.
# $Id: Makefile 153 2007-03-18 21:41:20Z ksz $

# uC target
TARGET = attiny2313
# AVRDUDE uC target
AVRDUDE_TARGET = t2313
# programmer type
AVRDUDE_PROGRAMMER = pony-stk200

# Remote type, supported are:
# +--------------------------+-------------------------------------------------+
# |     Definition           |    Remote type                                  |
# +--------------------------+-------------------------------------------------+
# | PANASONIC_VEQ1141        | Panasonic VCR's VEQ1141                         |
# | SANYO_PLCXT10A           | Sanyo PLCXT10A/PLCXT15A projector's remote      |
# +--------------------------+-------------------------------------------------+
#
# To define your own use remotes/remote_template.h as good start.
# Remember, that right now there is only SPACE_ENCODED transmission supported!
REMOTE = PANASONIC_VEQ1141

#################################
# ATtiny2313 fuses (values for USB uC)
# Fuse high byte:
# 0xdb = 1 1 0 1   1 0 1 1 <-- RSTDISBL (reset pin is enabled)
#        ^ ^ ^ ^   \-+-/       BODLEVEL0
#        | | | |     +-------- BODLEVEL1 (2.7V)
#        | | | |               BODLEVEL2 
#        | | | +-------------- WDTON (WDT not always on)
#        | | +---------------- SPIEN (allow serial programming)
#        | +------------------ EESAVE (don't preserve EEPROM over chip erase)
#        +-------------------- DWEN (don't enable debugWIRE)
# Fuse low byte:
# 0xdf = 1 1 0 1   1 1 1 1
#        ^ ^ \ /   \--+--/
#        | |  |       +------- CKSEL 3..0 (external >8M crystal)
#        | |  +--------------- SUT 1..0 (crystal osc, BOD enabled)
#        | +------------------ CKOUT (no clock outpuy on CKOUT pin)
#        +-------------------- CKDIV8 (don't divide clock by 8)
#################################
# ATtiny2313 fuses (values for IR uC)
# Fuse high byte:
# 0xdb = 1 1 0 1   1 0 1 1 <-- RSTDISBL (reset pin is enabled)
#        ^ ^ ^ ^   \-+-/       BODLEVEL0
#        | | | |     +-------- BODLEVEL1 (2.7V)
#        | | | |               BODLEVEL2 
#        | | | +-------------- WDTON (WDT not always on)
#        | | +---------------- SPIEN (allow serial programming)
#        | +------------------ EESAVE (don't preserve EEPROM over chip erase)
#        +-------------------- DWEN (don't enable debugWIRE)
# Fuse low byte:
# 0xd4 = 1 1 1 0   0 1 0 0
#        ^ ^ \ /   \--+--/
#        | |  |       +------- CKSEL 3..0 (internal 8M RC oscillator)
#        | |  +--------------- SUT 1..0 (max start-up time)
#        | +------------------ CKOUT (no clock outpuy on CKOUT pin)
#        +-------------------- CKDIV8 (don't divide clock by 8)
HFUSEUSB = "0xdb"
HFUSEIR  = $(HFUSEUSB)
LFUSEUSB = "0xdf"
LFUSEIR  = "0xd4"

################################################################################
################################################################################
##          I don't think you need to change anything below                   ##
################################################################################

# package name (for make dist only)
PACKAGE = irmouse
# device version 
VER_MAJ = 00
VER_MIN = 21
VER = $(VER_MAJ).$(VER_MIN)
PACKAGE_STR = $(PACKAGE)-$(VER_MAJ).$(VER_MIN)

# usbdrv location
USBDRV = usbdrv

COMPILE = avr-gcc -Wall -Os -I$(USBDRV) -I. -I$(REMOTE_DIR) -mmcu=$(TARGET) \
	-DUSB_CFG_DEVICE_VERSION="0x$(VER_MIN),0x$(VER_MAJ)" -D$(REMOTE)

AVRDUDE = avrdude -p$(AVRDUDE_TARGET) -c$(AVRDUDE_PROGRAMMER) 

OBJECTSIR = main-ir.o 

OBJECTSUSB = $(USBDRV)/usbdrv.o $(USBDRV)/usbdrvasm.o main-usb.o 

# for make dist
SRCS = main-ir.c main-usb.c usbconfig.h Makefile defines.h 

# for make dist
CIRCUIT_DIR = circuit
CIRCUIT_FILES = \
	$(CIRCUIT_DIR)/irmouse.pro $(CIRCUIT_DIR)/irmouse.sch \
	$(CIRCUIT_DIR)/irmouse.png \
	$(CIRCUIT_DIR)/irmouse.brd $(CIRCUIT_DIR)/irmouse_board.pdf $(CIRCUIT_DIR)/irmouse_elements.pdf  

# for make dist
REMOTE_DIR = remotes
REMOTE_FILES = \
	$(REMOTE_DIR)/remote_template.h \
	$(REMOTE_DIR)/panasonic_veq1141.h \
	$(REMOTE_DIR)/sanyo_plcxt10a.h

# for make dist too
EXTRA_DIST = Readme.txt ChangeLog.txt 

# symbolic targets:
all:	main-ir_$(TARGET).hex  main-usb_$(TARGET).hex

################################################################################

.c.o:
	$(COMPILE) -c $< -o $@

.S.o:
	$(COMPILE) -x assembler-with-cpp -c $< -o $@
# "-x assembler-with-cpp" should not be necessary since this is the default
# file type for the .S (with capital S) extension. However, upper case
# characters are not always preserved on Windows. To ensure WinAVR
# compatibility define the file type manually.

.c.s:
	$(COMPILE) -S $< -o $@

flashusb:	main-usb_$(TARGET).hex
	$(AVRDUDE) -U flash:w:main-usb_$(TARGET).hex:i 

flashir:	main-ir_$(TARGET).hex
	$(AVRDUDE) -U flash:w:main-ir_$(TARGET).hex:i 

fuseusb:
	$(AVRDUDE) -U lfuse:w:"$(LFUSEUSB)":m -U hfuse:w:"$(HFUSEUSB)":m

fuseir:
	$(AVRDUDE) -U lfuse:w:"$(LFUSEIR)":m -U hfuse:w:"$(HFUSEIR)":m

clean:
	rm -f *.hex *.lst *.obj *.cof *.list *.map *.eep.hex *.bin *.o usbdrv/*.o \
		*.s usbdrv/oddebug.s usbdrv/usbdrv.s schema/*.?\#?
	rm -f $(OBJECTS)

dist:
	rm -rf $(PACKAGE_STR)
	mkdir  $(PACKAGE_STR)		 			|| exit
	mkdir  $(PACKAGE_STR)/usbdrv			|| exit
	mkdir  $(PACKAGE_STR)/$(CIRCUIT_DIR)	|| exit
	mkdir  $(PACKAGE_STR)/$(REMOTE_DIR)		|| exit
	cp -rf $(SRCS) $(EXTRA_DIST) $(PACKAGE_STR)
	cp -f $(USBDRV)/*.c $(USBDRV)/*.h $(USBDRV)/*.S $(USBDRV)/*.txt \
		$(PACKAGE_STR)/usbdrv
	cp -f $(CIRCUIT_FILES) $(PACKAGE_STR)/$(CIRCUIT_DIR)
	cp -f $(REMOTE_FILES)  $(PACKAGE_STR)/$(REMOTE_DIR)
	tar czf $(PACKAGE_STR).tar.gz $(PACKAGE_STR)
	zip -r $(PACKAGE_STR).zip $(PACKAGE_STR)
	rm -rf $(PACKAGE_STR)

# file targets:
main-ir_$(TARGET).bin:	$(OBJECTSIR)
	$(COMPILE) -o main-ir_$(TARGET).bin $(OBJECTSIR)

main-usb_$(TARGET).bin:	$(OBJECTSUSB)
	$(COMPILE) -o main-usb_$(TARGET).bin $(OBJECTSUSB)

main-ir_$(TARGET).hex:	main-ir_$(TARGET).bin
	rm -f main-ir_$(TARGET).hex main-ir_$(TARGET).eep.hex
	avr-objcopy -j .text -j .data -O ihex main-ir_$(TARGET).bin \
		main-ir_$(TARGET).hex
	./checksize main-ir_$(TARGET).bin
# do the checksize script as our last action to allow successful compilation
# on Windows with WinAVR where the Unix commands will fail.

main-usb_$(TARGET).hex:		main-usb_$(TARGET).bin
	rm -f main-usb_$(TARGET).hex main-usb_$(TARGET).eep.hex
	avr-objcopy -j .text -j .data -O ihex main-usb_$(TARGET).bin \
		main-usb_$(TARGET).hex
	./checksize main-usb_$(TARGET).bin

disasmir:	main-ir_$(TARGET).bin
	avr-objdump -d main-ir_$(TARGET).bin

disasmusb:	main-usb_$(TARGET).bin
	avr-objdump -d main-usb_$(TARGET).bin

cpp:
	$(COMPILE) -E main-ir.c
	$(COMPILE) -E main-usb.c

%.elf: $(OBJECTS)
	$(COMPILE) -o $@ $^ 

lst:  main-ir_$(TARGET).lst main-usb_$(TARGET).lst

%.lst: %.elf
	avr-objdump -h -S $< > $@

