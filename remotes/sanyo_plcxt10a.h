/* 
 * Project:       IR-Mouse
 * File desc.:    This file contains Sanyo PLCXT10A projector's remote codes and 
 *                timings
 * Author:        Krzysiek Szczuka
 * Creation Date: 2007-03-01
 * Tabsize:       4
 * Copyright:     (c) 2007 by Krzysiek Szczuka
 * License:       Proprietary, free under certain conditions. See Documentation.
 * This Revision: $Id: sanyo_plcxt10a.h 146 2007-03-01 22:19:35Z ksz $
 */
#ifndef _SANYO_PLCXT10A_
#define _SANYO_PLCXT10A_

#include "defines.h"	// for CYCLES_PER_US


/*
 * Remote timings symbols. Example is for Sanyo PLCXT10A projector's remote:
 *
 * ... --------_________---__------__--_
 *
 *  \ | /      |        |  | |     | | ^----- and so on..
 *   \|/       |        |  | |     | +------- TZEROH	(Zero Hight)
 *    |        |        |  | |     +--------- TZEROL	(Zero Low)
 *    |        |        |  | +--------------- TONEH		(One Hight)
 *    |        |        |  +----------------- TONEL		(One Low)
 *    |        |        +-------------------- TSTARTH	(Start Hight)
 *    |        +----------------------------- TSTARTL	(Start Low)
 *    +-------------------------------------- no ir signals
 */


/*
 * times are: 
 *  TIMEus * CYCLES_PER_US / 8  
 */

/* here are Sanyo's remote codes and timings */
#  define TSTARTL	(1500 * CYCLES_PER_US / 8)
#  define TSTARTH	(650  * CYCLES_PER_US / 8)
#  define TONEL		(360  * CYCLES_PER_US / 8)
#  define TONEH		(1000 * CYCLES_PER_US / 8)
#  define TZEROL	TONEL //(380  * CYCLES_PER_US / 8)
#  define TZEROH	(280  * CYCLES_PER_US / 8)
/*
 * initial timer0 value (after this time program checks, that we still have ir
 * data receiving..) 
 * 20000 is time in us
 */
#  define TCNT0V	(0xFF - (20000 * CYCLES_PER_US / 1024))
 // buttons codes
#  define CLMB		0x00b00201	// left button
#  define CRMB		0x00b00102	// right button
//# define CLMBH	CLMB		// left button with hold on
#  define CRMBH		0x00b00202	// right button with hold on
#  define CDOWN		0x00b001fd	// down
#  define CUP		0x00b00180	// up
#  define CLEFT		0x00b0fd01	// left
#  define CRIGHT	0x00b08001	// right
#  define CDOWNH	0x00b0ae04	// down, hold on
#  define CUPH		0x00b0fe89	// up, hold on
#  define CLEFTH	0x00b0265d	// left, hold on
#  define CRIGHTH	0x00b0da1c	// right, hold on

#endif	// _SANYO_PLCXT10A_
