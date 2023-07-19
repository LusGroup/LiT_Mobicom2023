#include <Wire.h>
void setup() {
  Serial.begin(9600);
  Wire.begin();
  Wire.beginTransmission(0x44);//i2c设备地址，第一个传感器
  Wire.write(0x01);//配置寄存器的地址0x01
  Wire.write(0xC6);//第10位和第9位都为1表示连续转换E：1110，6：0110
  Wire.write(0x10);//两次发送，一次一个字节
  Wire.endTransmission();
////  Serial.println("Data received \t\t Lux");
  Wire.beginTransmission(0x45);//i2c设备地址，第二个传感器
  Wire.write(0x01);//配置寄存器的地址0x01
  Wire.write(0xC6);//第10位和第9位都为1表示连续转换E：1110，6：0110
  Wire.write(0x10);//两次发送，一次一个字节
  Wire.endTransmission();
//  Serial.println("Data received \t\t Lux");
}

void loop() {
  Wire.beginTransmission(0x44);
  Wire.write(0x00);//结果寄存器的地址0x00
  Wire.endTransmission();
  Wire.requestFrom(0x44,2);//接收两个字节的数据
  uint16_t iData;
  uint8_t iBuff[2];
  while(Wire.available())
  {
      Wire.readBytes(iBuff,2);
      iData = (iBuff[0]<<8) | iBuff[1];
      float fLux = SensorOpt3002_convert(iData);
      Serial.print(fLux);
      Wire.endTransmission();
    }
      Serial.print(",");
      Wire.beginTransmission(0x45);
      Wire.write(0x00);//结果寄存器的地址0x00
      Wire.endTransmission();
      Wire.requestFrom(0x45,2);//接收两个字节的数据
      uint16_t iData1;
      uint8_t iBuff1[2];
      while(Wire.available())
  {
      Wire.readBytes(iBuff1,2);
      iData1 = (iBuff1[0]<<8) | iBuff1[1];
      float fLux1 = SensorOpt3002_convert(iData1);
      Serial.println(fLux1);
      Wire.endTransmission();
    }
    delay(100);
}
float SensorOpt3002_convert(uint16_t iRawData)//将寄存器内的数据转换为光强数据
{
    uint16_t iExponent, iMantissa;
    iMantissa = iRawData & 0x0FFF;
    iExponent = (iRawData & 0xF000)>>12;
    return iMantissa * (0.01*pow(2,iExponent));
  }
