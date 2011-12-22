/* 
 * plik dla pilota zastepczego, do testow ukladu w domu
 */
#ifndef _PANASONIC_VEQ1141_
#define _PANASONIC_VEQ1141_

#include "defines.h"	// for CYCLES_PER_US


/*
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

# define TSTARTL	(3400 * CYCLES_PER_US / 8)
# define TSTARTH	(1500 * CYCLES_PER_US / 8)
# define TONEL		(450  * CYCLES_PER_US / 8)
# define TONEH		(250  * CYCLES_PER_US / 8)
# define TZEROL		(450  * CYCLES_PER_US / 8)
# define TZEROH		(1100 * CYCLES_PER_US / 8)

# define TCNT0V		(0xFF - (25000 * CYCLES_PER_US / 1024))
// buttons codes
# define CLMB		0xFFFF9F96	// left button
# define CRMB		0xFFFFcFc6	// right button
# define CDOWN		0xFFFFAFA6	// down
# define CUP		0xFFFFFFF6	// up
# define CLEFT		0xFFFFbfb6	// left
# define CRIGHT		0x00003f36	// right
# define CRMBH		0xFFFF0F06	// rmb, hold on
// they're just for no compiler's errors
# define CDOWNH		0xb0ae04FF	// down, hold on
# define CUPH		0xb0fe89FF	// up, hold on
# define CLEFTH		0xb0265dFF	// left, hold on
# define CRIGHTH	0xb0da1cFF	// right, hold on
//# define CLMBH	CLMB		// left button with hold on



#endif	// _PANASONIC_VEQ1141_
