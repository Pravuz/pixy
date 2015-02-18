//
// begin license header
//
// This file is part of Pixy CMUcam5 or "Pixy" for short
//
// All Pixy source code is provided under the terms of the
// GNU General Public License v2 (http://www.gnu.org/licenses/gpl-2.0.html).
// Those wishing to use Pixy source code, software and/or
// technologies under different licensing terms should contact us at
// cmucam@cs.cmu.edu. Such licensing terms are available for
// all portions of the Pixy codebase presented here.
//
// end license header
//

#ifndef _PROGGREYSHADES_H
#define _PROGGREYSHADES_H

#include "exec.h"
#include <list>
#include "pixytypes.h"

extern Program g_progGreyshades;

#define X_CENTER    (CAM_RES2_WIDTH/2)
#define Y_CENTER    ((CAM_RES2_HEIGHT-2)/2)

// Regions in a 320x198 frame divided into 3 regions with 4 pixel overlap.
#define REGIONS_WIDTH			0x140	//320
#define REGION_AC_HEIGHT		0x44	//68
#define REGION_B_HEIGHT			0x46	//70
#define REGION_AC_SIZE			(REGIONS_WIDTH*REGION_AC_HEIGHT)	//21760
#define REGION_B_SIZE			(REGIONS_WIDTH*REGION_B_HEIGHT)	//22400
#define REGION_A_OFFSET_Y		0x00	//0
#define REGION_B_OFFSET_Y		0x40	//64
#define REGION_C_OFFSET_Y		0x82	//1307

//making room at the end of the 72K SRAM bank for storage.
#define LAST_REGION_SIZE 		(REGIONS_WIDTH - 2)*(REGION_B_HEIGHT - 2)
#define LAST_REGION_MEMORY 		((uint8_t *)SRAM1_LOC + SRAM1_SIZE - LAST_REGION_SIZE)

struct DetectedObject { //Each object is theoretically 32bit*3points + 16 = 112bit = 14Bytes
	bool sameObject(const Point16 &p) {
		if (topLeft.m_x - 2 <= p.m_x && p.m_x <= bottomRight.m_x + 2
				&& bottomRight.m_y /* - 2 */<= p.m_y
				&& p.m_y <= topLeft.m_y + 2) { //will never be below bottomRight.m_y
			if (topLeft.m_x > p.m_x)
				topLeft.m_x = p.m_x;
			else if (bottomRight.m_x < p.m_x)
				bottomRight.m_x = p.m_x;
			if (topLeft.m_y < p.m_y)
				topLeft.m_y = p.m_y;
			/*else if (bottomRight.m_y > p.m_y)
			 bottomRight.m_y = p.m_y;*/ // never needed due to how a frame is iterated.
			objPixels++;
			return true;
		}
		return false;
	}

	DetectedObject() {
		objPixels = 0;
		topLeft.m_x = topLeft.m_y = 0;
		bottomRight.m_x = bottomRight.m_y = 0;
		midPoint.m_x = midPoint.m_y = 0;
	}

	DetectedObject(Point16 tL, Point16 bR) {
		objPixels = 1;
		topLeft = tL;
		bottomRight = bR;
	}
	uint16_t objPixels;
	Point16 topLeft, bottomRight, midPoint;
};

enum GreyRegion {
	REG_A1, REG_A2, REG_B1, REG_B2, REG_C1, REG_C2, FINISHED
};

int greySetup();
int greyLoop();
void greyLoadParams();

class GreyShades {
public:
	GreyShades(uint8_t *lastRegionMem);
	~GreyShades();
	void setParams(const uint8_t deltaP, const uint32_t nOfP);
	void handleImage();

private:
	uint32_t nOfP;
	uint8_t *m_lastRegion;
	uint8_t deltaP;
	std::list<DetectedObject> m_DetectedObjects;

	void convertRawToGrey(const bool compare);
	void objCalcs();
	void separateObjects();
};

#endif
