#ifndef _LED_H
#define _LED_H

#define LED_RED                   0
#define LED_GREEN                 1
#define LED_BLUE                  2	 
//#define LED_RED_ADCCHAN           0
#define LED_RED_ADCCHAN           6
#define LED_GREEN_ADCCHAN         1
#define LED_BLUE_ADCCHAN          2
#define LED_RED_RESISTOR          150
#define LED_GREEN_RESISTOR        91
#define LED_BLUE_RESISTOR         91

#define LED_MAX_PWM               0xffff
#define ADC_MAX                   0x3ff
#define ADC_VOLTAGE               3.3

// the 2 values below might be correlated unintentionally
// The larger the default scale, the more attenuation of the brightness on the low end
// but note, the range is huge.  For example, there isn't much difference between 20000 and 60000
#define LED_DEFAULT_SCALE         60000.0
#define LED_DEFAULT_MAX_CURRENT   750  // uA, can be as high as 20000, but it's difficult to look at (too bright!)

void led_init();
void led_setPWM(uint8_t led, uint16_t pwm);
void led_set(uint8_t led, uint8_t val);
int32_t led_setRGB(const uint8_t &r, const uint8_t &g, const uint8_t &b, Chirp *chirp=NULL);
int32_t led_setMaxCurrent(const uint32_t &uamps, Chirp *chirp=NULL);
uint32_t led_getMaxCurrent(Chirp *chirp=NULL);


#endif
