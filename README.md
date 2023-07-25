# LiT: Toothbrushing Monitoring System
LiT is a toothbrushing monitoring system based on a commercial LED toothbrush. It utilizes commercial blue light sterilization toothbrushes, where blue LEDs are used as transmitters, and only 2 low-cost photosensors are required to be mounted on the toothbrush head as receivers. LiT is capable of monitoring 16 Bass technique surfaces by analyzing the dynamic light intensity change.

## Contents
This repository includes the following components:  
 &nbsp 1.Workflow Instruction: Instructions on how to set up and run LiT successfully.  
 &nbsp 2.Hardware Deployment: Guidance and documentation for deploying LiT on the hardware.  
 &nbsp 3.Signal Processing Source Code: Source code for signal processing, enabling the analysis of light intensity changes.  

## How to Use
### HardWare
(1)Please download the Gerber file(Gerber PCB single pd.zip in hardware folder) and send it to a professional flexible PCB manufacturer to print the flexible PCB (one toothbrush needs two printed flexible PCBs). 
(2)As shown in picture(hardware_deployment.jpg(middle)), connect the photosensors (flexible PCBs) and Arduino UNO with the Dupont wire and breadboard according to the circuit diagram (hardware_deployment.jpg(left)). Note
that, the ADDR pins of the two photosensors were connected
to the GND and VCC pins of the Arduino, respectively, to assign different addresses.
(3) As shown in picture(hardware_deployment.jpg(right)), glue two photosensors to the side
of the toothbrush hand using silicone rubber near the top, and
at approximately 60° from the toothbrush orientation, and then
cover the sensors’ surface with a layer of about 0.6mm transparent food-grade silicone rubber, which prevented saliva from
short-circuiting the sensor and ensured excellent light transmittance. Note that, make sure the silicone rubber is fully cured.
(4) As shown in Figure 3, connect the Arduino UNO to a personal
computer using a USB cable, and use Arduino IDE to burn the
Arduino program (arduino code.ino in hardware folder)
for Arduino UNO.
(5) Connect the Arduino UNO to a personal computer using a USB cable, and use Matlab code
(Step1 collect data.m) to collect a toothbrushing signal with Matlab.
### SoftWare
(1) matlab code(Step1 collect Data.m) was used to collect brushing data based on bass brushing method.
We also provided data (in data folder)on 16 brushing surfaces for a single user for demonstration purposes.
(2) Run the Step2 signal processing and analysis.m to execute the LiT algorithm’s MATLAB code, which processes the collected toothbrushing signal with labels.
(3) Obtain the 10-fold cross-validation accuracy of toothbrushing surface recognition from the labeled data.
## Requirements
### HardWare dependencies
1.Modified toothbrush hardware (containing Abitelax F7 blue light
sterilization electric toothbrush, Printed flexible PCB, Arduino UNO,
DuPont wire, and Breadboard),
2.Windows Personal computer (used for Arduino code burning and
signal processing),
3.USB cable (connecting Modified toothbrush hardware and personal
computer).
### SoftWare dependencies
(1) Arduino IDE 1.8.19 for burning code to Arduino UNO, and (2)Matlab R2021a for signal processing.

## Contributions

Contributions to the project are welcome. If you encounter any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request.
## License
This project is licensed under the GNU General Public License.
For more details about LiT and its functionalities, please refer to the individual components of this repository.
