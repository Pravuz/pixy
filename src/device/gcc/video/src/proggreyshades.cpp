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

#include "proggreyshades.h"
#include "pixy_init.h"
#include "camera.h"
#include "serial.h"
#include "param.h"
#include "qqueue.h"

Program g_progGreyshades = {
		"grey",
		"perform shades of grey analysis",
		greySetup,
		greyLoop
};

static GreyShades g_greyShades((uint8_t *) LAST_REGION_MEMORY);
Qqueue *m_qqueue;
GreyRegion currentRegion;

GreyShades::GreyShades(uint8_t *lastRegionMem) {
	m_lastRegion = lastRegionMem;
}

GreyShades::~GreyShades() {

}

void GreyShades::setParams(const uint8_t deltaP, const uint32_t nOfP) {
	if (deltaP < 1 || deltaP > 255)
		this->deltaP = 15; //invalid, using default.
	else
		this->deltaP = deltaP;

	if (nOfP > 32000 || nOfP < 1)
		this->nOfP = 3000; //invalid, using default.
	else
		this->nOfP = nOfP;
}

void GreyShades::handleImage() {
	uint8_t len = 36;
	uint8_t *frame = (uint8_t *) SRAM1_LOC;

	switch (currentRegion) {
	case REG_A1:
		cam_getFrame(frame + len, SRAM1_SIZE - len, CAM_GRAB_M1R2, 0,
		REGION_A_OFFSET_Y, REGIONS_WIDTH, REGION_AC_HEIGHT);
		convertRawToGrey(false);
		currentRegion = REG_A2; // Finished with this region
		break;
	case REG_A2:
		cam_getFrame(frame + len, SRAM1_SIZE - len, CAM_GRAB_M1R2, 0,
		REGION_A_OFFSET_Y, REGIONS_WIDTH, REGION_AC_HEIGHT);
		convertRawToGrey(true);
		separateObjects();
		currentRegion = REG_B1; // Finished with this region
		break;
	case REG_B1:
		cam_getFrame(frame + len, SRAM1_SIZE - len, CAM_GRAB_M1R2, 0,
		REGION_B_OFFSET_Y, REGIONS_WIDTH, REGION_B_HEIGHT);
		convertRawToGrey(false);
		currentRegion = REG_B2; // Finished with this region
		break;
	case REG_B2:
		cam_getFrame(frame + len, SRAM1_SIZE - len, CAM_GRAB_M1R2, 0,
		REGION_B_OFFSET_Y, REGIONS_WIDTH, REGION_B_HEIGHT);
		convertRawToGrey(true);
		separateObjects();
		currentRegion = REG_C1; // Finished with this region
		break;
	case REG_C1:
		cam_getFrame(frame + len, SRAM1_SIZE - len, CAM_GRAB_M1R2, 0,
		REGION_C_OFFSET_Y, REGIONS_WIDTH, REGION_AC_HEIGHT);
		convertRawToGrey(false);
		currentRegion = REG_C2; // Finished with this region
		break;
	case REG_C2:
		cam_getFrame(frame + len, SRAM1_SIZE - len, CAM_GRAB_M1R2, 0,
		REGION_C_OFFSET_Y, REGIONS_WIDTH, REGION_AC_HEIGHT);
		convertRawToGrey(true);
		separateObjects();
		currentRegion = FINISHED; // Finished with this region
		break;
	case FINISHED:
		objCalcs();
		//todo: send vector to arduino via UART/SPI/I2C.
		currentRegion = REG_A1; // Restart.
		break;
	}
}

void GreyShades::convertRawToGrey(const bool compare) {
	uint32_t temp;
	uint16_t x, y, r, g, b, width, nOfPCount;
	uint8_t *pixels;
	nOfPCount = 0;
	bool nOfPAboveTresh = false;
	width = g_rawFrame.m_width;
	pixels = g_rawFrame.m_pixels;

	//skip first line
	pixels += width;

	// Skipping top, left and rightmost rows/columns
	for (y = 1; y < g_rawFrame.m_height - 1; y++, pixels += width) {
		for (x = 1; x < width - 1; x++) {
			// Interpolating Bayer.
			if (y & 1) { //odd row
				if (x & 1) { //odd column
					r = pixels[x];
					g = (pixels[x - 1] + pixels[x + 1] + pixels[x + width]
							+ pixels[x - width]) >> 2;
					b = (pixels[x - width - 1] + pixels[x - width + 1]
							+ pixels[x + width - 1] + pixels[x + width + 1])
							>> 2;
				} else { //even column
					r = (pixels[x - 1] + pixels[x + 1]) >> 1;
					g = pixels[x];
					b = (pixels[x - width] + pixels[x + width]) >> 1;
				}
			} else { //even row
				if (x & 1) { //odd column
					r = (pixels[x - width] + pixels[x + width]) >> 1;
					g = pixels[x];
					b = (pixels[x - 1] + pixels[x + 1]) >> 1;
				} else { //even column
					r = (pixels[x - width - 1] + pixels[x - width + 1]
							+ pixels[x + width - 1] + pixels[x + width + 1])
							>> 2;
					g = (pixels[x - 1] + pixels[x + 1] + pixels[x + width]
							+ pixels[x - width]) >> 2;
					b = pixels[x];
				}
			}

			//converting to greyscale
			temp = ((r + g + b) * 341 >> 10) | 1; // (r+g+b)/3 => (r+g+b)*341>>10..
			// |1 sets minimum value for each pixel to 1
			// a pixel value of 0 will be used for indicating motion in this pixel

			// Is maximum amount of pixelchanges reached?
			if (nOfPCount >= nOfP)
				nOfPAboveTresh = true;

			// Is the value for the previous pixel minus this pixel above pixelchange treshold 'deltaP'?
			if (compare
					&& (abs(m_lastRegion[(width - 2) * y + x - 1]) - temp)
							> deltaP && !nOfPAboveTresh) {
				nOfPCount++;
				temp = 0x00; // this pixel now indicates motion.
			}

			//saves this pixel in last frame.
			m_lastRegion[(width - 2) * y + x - 1] = (uint8_t) temp;
		}
	}
}

void GreyShades::objCalcs() {
	// find largest object and calc midpoint and vector to crosshair.
}

void GreyShades::separateObjects() {
	bool noMatchFound = true;
	Point16 point; //curent pixel point.
	uint8_t height = REGION_AC_HEIGHT - 2;
	if (currentRegion != REG_B2)
		height -= 2;

	for (int y = 2; y <= height; y++)
		for (int x = 2; x <= REGIONS_WIDTH - 4; x++) {
			if (m_lastRegion[(REGIONS_WIDTH - 4)*y + x] != 0x00)
				continue; //skip this iteration, this pixel doesn't have a change.

			noMatchFound = true;
			point.m_x = x;
			point.m_y = y;

			// loops trough existing objects, checking if this pixel may belong to one of the detected objects.
			if (!m_DetectedObjects.empty()) {
				for (std::list<DetectedObject>::iterator i =
						m_DetectedObjects.begin();
						noMatchFound && i != m_DetectedObjects.end(); i++) {
					if (i->sameObject(point))
						noMatchFound = false; //this pixel now belongs to an existing object.
				}
			}
			if (noMatchFound)
				m_DetectedObjects.push_back(DetectedObject(point, point)); //this pixels belongs in a new object.
		}
}

int greySetup() {
	//initial currentRegion
	currentRegion = REG_A1;

	// setup camera mode
	cam_setMode(CAM_MODE1);

	// load parameters
	greyLoadParams();

	// setup qqueue and M0
	m_qqueue = new Qqueue;
	m_qqueue->flush();
	exec_runM0(0);

	return 0;
}

int greyLoop() {
	g_greyShades.handleImage();
	//call handleImage();
	return 0;
}

void greyLoadParams() {
	prm_add("Pixel-change treshold", 0,
			"@c 4-20 recommended. Depends on weather, lighting etc. (default 15)",
			UINT8(15), END);
	prm_add("Pixel-change cutoff", 0,
			"@c 1-32000, keep as low as possible, higher => moar cpu demanding. Use depending on distance to object. (default 3000)",
			UINT16(3000), END);

	uint8_t g_deltaP;
	uint32_t g_nOfP;
	prm_get("Pixel-change treshold", &g_deltaP, END);
	prm_get("Pixel-change cutoff", &g_nOfP, END);
	g_greyShades.setParams(g_deltaP, g_nOfP);
}
