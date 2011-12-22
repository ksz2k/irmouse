/* 
 * Project:       IR-Mouse
 * File desc.:    This file contains template for new remote
 * Author:        Krzysiek Szczuka
 * Creation Date: 2007-03-01
 * Tabsize:       4
 * Copyright:     (c) 2007 by Krzysiek Szczuka
 * License:       Proprietary, free under certain conditions. See Documentation.
 * This Revision: $Id: remote_template.h 146 2007-03-01 22:19:35Z ksz $
 */
#ifndef _REMOTE_TEMPLATE_
#define _REMOTE_TEMPLATE_

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

/* 
 * maybe check on http://lirc.org/remotes/ for your remote
 */
# define TSTARTL	(0 * CYCLES_PER_US / 8)
# define TSTARTH	(0 * CYCLES_PER_US / 8)
# define TONEL		(0 * CYCLES_PER_US / 8)
# define TONEH		(0 * CYCLES_PER_US / 8)
# define TZEROL		(0 * CYCLES_PER_US / 8)
# define TZEROH		(0 * CYCLES_PER_US / 8)
/*
 * 
 * initial timer0 value (after this time program checks, that we still have ir
 * data receiving..) 
 * 0 is time in us (-;  change it for your remote
 */
# define TCNT0V		(0xFF - (0 * CYCLES_PER_US / 1024))
// buttons codes
# define CLMB		0x00	// left button
# define CRMB		0x00	// right button
# define CDOWN		0x00	// down
# define CUP		0x00	// up
# define CLEFT		0x00	// left
# define CRIGHT		0x00	// right
# define CRMBH		0x00	// rmb, hold on
# define CDOWNH		0x00	// down, hold on
# define CUPH		0x00	// up, hold on
# define CLEFTH		0x00	// left, hold on
# define CRIGHTH	0x00	// right, hold on
//# define CLMBH	0x00	// left button with hold on



#endif	// _REMOTE_TEMPLATE_
