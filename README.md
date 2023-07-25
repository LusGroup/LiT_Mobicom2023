# LiT: Toothbrushing Monitoring System
LiT is a toothbrushing monitoring system based on a commercial LED toothbrush. It utilizes commercial blue light sterilization toothbrushes, where blue LEDs are used as transmitters, and only 2 low-cost photosensors are required to be mounted on the toothbrush head as receivers. LiT is capable of monitoring 16 Bass technique surfaces by analyzing the dynamic light intensity change.

## Description
This repository includes the following components:  
 1.Workflow Instruction: Instructions on how to set up and run LiT successfully.  
 2.Hardware Deployment: Guidance and documentation for deploying LiT on the hardware.  
 3.Signal Processing Source Code: Source code for signal processing, enabling the analysis of light intensity changes.  
 
 ## Folder
 ```
|-- data  
|-- hardware  
    |-- Gerber_PCB_single_pd.zip  
    |-- arduino_code.ino  
    |-- jardware_deploument.jpg  
|-- Step1_collect_data.m  
|-- Step2_analysis_and_classification.m  
|-- calculateFeature.m  
|-- cancellation.m  
|-- requirement.m  
|-- segment.m  
|-- trainClassifier.m  
```
## How to Use
### HardWare
1.Download the Gerber file ('Gerber PCB single pd.zip' in the hardware folder) and send it to a professional flexible PCB manufacturer to print the flexible PCB (each toothbrush requires two printed flexible PCBs).   
2.Connect the photosensors (flexible PCBs) and Arduino UNO using Dupont wires and a breadboard, following the circuit diagram ('hardware_deployment.jpg' - left). Note that the ADDR pins of the two photosensors should be connected to the GND and VCC pins of the Arduino to assign different addresses.
Note that, the ADDR pins of the two photosensors were connected to the GND and VCC pins of the Arduino, respectively, to assign different addresses.  
3.Attach two photosensors to the side of the toothbrush handle near the top, at approximately 60° from the toothbrush orientation. Cover the sensors' surface with a layer of about 0.6mm transparent food-grade silicone rubber to prevent saliva from short-circuiting the sensors and ensure excellent light transmittance. Ensure that the silicone rubber is fully cured.  
4.Connect the Arduino UNO to a personal computer using a USB cable and use the Arduino IDE to burn the program ('arduino code.ino' in the hardware folder) onto the Arduino UNO.  
5.Connect the Arduino UNO to a personal computer using a USB cable and use the Matlab code ('Step1 collect data.m') to collect toothbrushing signals with Matlab.  
### SoftWare
1.Use the Matlab code ('Step1 collect Data.m') to collect brushing data based on the bass brushing method. We also provide data (in the 'data' folder) on 16 brushing surfaces for a single user for demonstration purposes.  
2.Run the 'Step2 signal_processing_and_analysis.m' file to execute the LiT algorithm's MATLAB code, which processes the collected toothbrushing signals with labels.
3.Obtain the 10-fold cross-validation accuracy of toothbrushing surface recognition from the labeled data.  
By following the above steps, you can set up and use the LiT toothbrushing monitoring system effectively. Please refer to the respective files and folders for detailed instructions and data.

## Requirements
### HardWare dependencies
1.Modified toothbrush hardware (containing Abitelax F7 blue light sterilization electric toothbrush, Printed flexible PCB, Arduino UNO, DuPont wire, and Breadboard),
2.Windows Personal computer (used for Arduino code burning and signal processing),
3.USB cable (connecting Modified toothbrush hardware and personal computer).
### SoftWare dependencies
(1) Arduino IDE 1.8.19 for burning code to Arduino UNO, and (2)Matlab R2021a for signal processing.
## Contributions
Contributions to the project are welcome. If you encounter any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request.
## License
This project is licensed under the GNU General Public License.
For more details about LiT and its functionalities, please refer to the individual components of this repository.
