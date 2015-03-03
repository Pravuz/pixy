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

Program g_progGreyshades = { "grey", "perform shades of grey analysis",
		greySetup, greyLoop };

static GreyShades g_greyShades((uint8_t *) LAST_REGION_MEMORY);
GreyShades *g_gShades = &g_greyShades;
GreyRegion currentRegion;
Point16 m_medianVector;

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

void GreyShades::setMute(const bool mute) {
	m_mutex = mute;
}

void GreyShades::handleImage() {
	uint8_t *frame = (uint8_t *) SRAM1_LOC;
	int response;

	switch (currentRegion) {
	case REG_A1:
		response = cam_getFrame(frame, SRAM1_SIZE, CAM_GRAB_M1R2, 0,
		REGION_A_OFFSET_Y, REGIONS_WIDTH, REGION_AC_HEIGHT);
		if (response != 0)
			convertRawToGrey(false);
		currentRegion = REG_A2; // Finished with this region
		break;
	case REG_A2:
		response = cam_getFrame(frame, SRAM1_SIZE, CAM_GRAB_M1R2, 0,
		REGION_A_OFFSET_Y, REGIONS_WIDTH, REGION_AC_HEIGHT);
		if (response != 0)
			convertRawToGrey(true);
		separateObjects();
		currentRegion = REG_B1; // Finished with this region
		break;
	case REG_B1:
		response = cam_getFrame(frame, SRAM1_SIZE, CAM_GRAB_M1R2, 0,
		REGION_B_OFFSET_Y, REGIONS_WIDTH, REGION_B_HEIGHT);
		if (response != 0)
			convertRawToGrey(false);
		currentRegion = REG_B2; // Finished with this region
		break;
	case REG_B2:
		response = cam_getFrame(frame, SRAM1_SIZE, CAM_GRAB_M1R2, 0,
		REGION_B_OFFSET_Y, REGIONS_WIDTH, REGION_B_HEIGHT);
		if (response != 0)
			convertRawToGrey(true);
		separateObjects();
		currentRegion = REG_C1; // Finished with this region
		break;
	case REG_C1:
		response = cam_getFrame(frame, SRAM1_SIZE, CAM_GRAB_M1R2, 0,
		REGION_C_OFFSET_Y, REGIONS_WIDTH, REGION_AC_HEIGHT);
		if (response != 0)
			convertRawToGrey(false);
		currentRegion = REG_C2; // Finished with this region
		break;
	case REG_C2:
		response = cam_getFrame(frame, SRAM1_SIZE, CAM_GRAB_M1R2, 0,
		REGION_C_OFFSET_Y, REGIONS_WIDTH, REGION_AC_HEIGHT);
		if (response != 0)
			convertRawToGrey(true);
		separateObjects();
		currentRegion = FINISHED; // Finished with this region
		break;
	case FINISHED:
		objCalcs();
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

void GreyShades::separateObjects() {
	bool noMatchFound = true;
	Point16 point; //curent pixel point.
	uint8_t height = REGION_AC_HEIGHT - 2;
	if (currentRegion != REG_B2)
		height -= 2;

	for (int y = 2; y <= height; y++)
		for (int x = 2; x <= REGIONS_WIDTH - 4; x++) {
			if (m_lastRegion[(REGIONS_WIDTH - 4) * y + x] != 0x00)
				continue; //skip this iteration, this pixel doesn't have a change.

			noMatchFound = true;
			point.m_x = x;
			point.m_y = y;
			if (currentRegion == REG_A2)
				point.m_y += REGION_A_OFFSET_Y;
			if (currentRegion == REG_B2)
				point.m_y += REGION_B_OFFSET_Y;
			if (currentRegion == REG_C2)
				point.m_y += REGION_C_OFFSET_Y;

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
				m_DetectedObjects.push_back(DetectedObject(point)); //this pixels belongs in a new object.
		}
}

void GreyShades::objCalcs() {
	// find largest object and calc midpoint and vector to crosshair.
	// If there is absolutely no movement detected, theres no need to do any further calculations.
	if (m_DetectedObjects.empty())
		return;
	DetectedObject m_largestObj = m_DetectedObjects.front();
	m_DetectedObjects.pop_front();
	if (!m_DetectedObjects.empty())
		for (std::list<DetectedObject>::iterator i = m_DetectedObjects.begin();
				i != m_DetectedObjects.end(); i++)
			if (m_largestObj.objPixels < i->objPixels)
				m_largestObj = *i;

	// memory leakage deluxe if we don't clear this after each image is produced.
	// this is also the most reasonable (if not the only) place where we can safely clear the list.
	m_DetectedObjects.clear();

	Point16 m_vector;

	m_vector.m_x = X_CENTER
			- (((m_largestObj.bottomRight.m_x - m_largestObj.topLeft.m_x) >> 1)
					+ m_largestObj.topLeft.m_x);
	m_vector.m_y = Y_CENTER
			- (((m_largestObj.topLeft.m_y - m_largestObj.bottomRight.m_y) >> 1)
					+ m_largestObj.bottomRight.m_y);

	if (m_vectorsToCenter.size() == 5) {
		std::list<int> medianOfVTC_x, medianOfVTC_y;
		for (std::list<Point16>::iterator i = m_vectorsToCenter.begin();
				i != m_vectorsToCenter.end(); i++) {
			medianOfVTC_x.push_back(i->m_x);
			medianOfVTC_y.push_back(i->m_y);
		}

		medianOfVTC_x.sort();
		medianOfVTC_y.sort();

		//getting median X vector
		medianOfVTC_x.pop_front();
		medianOfVTC_x.pop_front();
		m_medianVector.m_x = medianOfVTC_x.front();

		//getting median Y vector
		medianOfVTC_y.pop_front();
		medianOfVTC_y.pop_front();
		m_medianVector.m_y = medianOfVTC_y.front();

		// We now have a vector ready for arduino
		m_mutex = false;
	}

	m_vectorsToCenter.push_back(m_vector);
	while (m_vectorsToCenter.size() > 5)
		m_vectorsToCenter.pop_front();

}

uint32_t GreyShades::spiCallback(uint8_t *buf, uint32_t buflen) {
	uint16_t *buf16 = (uint16_t *) buf;
	uint16_t len = 7;  // default

	if (buflen < 8 * sizeof(uint16_t))
		return 0;
	if (m_mutex) {
		buf16[0] = 0;
		buf16[1] = 0;
		return 2;
	}

	//buf16[0] = 0xaa55; //begin marker
	len++;

	for (int i = 0; i < 8; i++) {
		if (i & 1)
			buf16[i] = m_medianVector.m_y;
		else
			buf16[i] = m_medianVector.m_x;
	}

	m_mutex = true;
	return len * sizeof(uint16_t);
}

int greySetup() {
	//initial currentRegion
	currentRegion = REG_A1;
	// setup camera mode
	cam_setMode(CAM_MODE0); //not running 1 for some reason, what does modes entail?

	// load parameters
	greyLoadParams();

	//init vector
	m_medianVector.m_x = 0;
	m_medianVector.m_y = 0;

#if 0 //fucks with my shit
	// setup qqueue and M0
	m_qqueue = new Qqueue;//when/where do i use qqueue?
	m_qqueue->flush();

	//does this need exec_init(*chirp) and cam_mode1 ?
	exec_runM0(0);


	// flush serial receive queue
	uint8_t c;
	while (ser_getSerial()->receive(&c, 1))
		;
#endif
	return 0;
}

int greyLoop() {
	//handle images in parts.
	g_greyShades.handleImage();

	//handle serial recieve data
	//serialReceive();

	//update serial buffer
	//ser_getSerial()->update();

	return 0;
}

void serialReceive() {

	//todo Handle commands and parameters from arduino.
#if 0
	uint8_t i, a;
	static uint8_t state=0, b=1;
	uint16_t s0, s1;
	Iserial *serial = ser_getSerial();

	for (i=0; i<10; i++)
	{
		switch(state)
		{
			case 0: // look for sync
			if(serial->receive(&a, 1)<1)
			return;
			if (a==0xff && b==0x00)
			state = 1;
			b = a;
			break;

			case 1:// read rest of data
			if (serial->receiveLen()>=4)
			{
				serial->receive((uint8_t *)&s0, 2);
				serial->receive((uint8_t *)&s1, 2);

				//cprintf("servo %d %d\n", s0, s1);
				rcs_setPos(0, s0);
				rcs_setPos(1, s1);

				state = 0;
			}
			break;

			default:
			state = 0;
			break;
		}
	}
#endif
}

void greyLoadParams() {
#if 0 //fuck off params
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
#endif
	//default params.
	g_greyShades.setParams(15,10500);
	//mute callback until we have something to return
	g_greyShades.setMute(true);
}
