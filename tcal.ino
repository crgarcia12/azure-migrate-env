#include <TCA6416A.h>

#define I2C_SDA 21
#define I2C_SCL 22
#define TCAL6416_ADDR 0x20  // I2C address (ADDR pin = GND)
#define OUTPUT_ENABLED_PIN 16

TCA6416A expander;

void setup() {
  Serial.begin(115200);

  pinMode(OUTPUT_ENABLED_PIN, OUTPUT);
  digitalWrite(OUTPUT_ENABLED_PIN, LOW);

  Serial.println("Wire.Begin");
  pinMode(I2C_SDA, INPUT_PULLUP);
  pinMode(I2C_SCL, INPUT_PULLUP);
  Wire.begin(I2C_SDA, I2C_SCL);

  Serial.println("Connecting");
	while (!expander.begin(TCAL6416_ADDR, &Wire)) { // replace 0 with the address bit of your TCA6416A
    	Serial.println("TCA6416A not found");
		delay(1000);
	}

  Serial.println("TCA6416A found");
  expander.pin_mode(7, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println("Read");
  int read = expander.pin_read(7);
  Serial.println(read);
  delay(1000);

  // Serial.println("Low 2");
  // expander.pin_write(7, LOW);
  // delay(1000);
}
