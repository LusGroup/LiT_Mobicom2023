# LiT: Toothbrushing Monitoring System
&emsp; LiT is a toothbrushing monitoring system based on a commercial LED toothbrush. It utilizes commercial blue light sterilization toothbrushes, where blue LEDs are used as transmitters, and only 2 low-cost photosensors are required to be mounted on the toothbrush head as receivers. LiT is capable of monitoring 16 Bass technique surfaces by analyzing the dynamic light intensity change.

## Description
This repository includes the following components:  
&emsp;1. Artifact Operation Demo (demo_address file): Preparatory work guidance and a complete artifact usage example.  
&emsp;2. Artifact Operation Description (Artifact_description.pdf): Instructions on how to set up and run LiT successfully.
&emsp;3. Hardware Source Files (hardware folder): Source files and guidance for hardware deployment.
&emsp;4. Software Source Code (all Matlab files): Source code for signal processing and brushing surface recognition.
 
 ## Folder
 ```
|-- data  
|-- hardware  
    |-- Gerber_PCB_single_pd.zip  
    |-- arduino_code.ino  
    |-- hardware_deployment.jpg  
|-- Step1_collect_data.m  
|-- Step2_signal_processing_and_analysis.m  
|-- calculateFeature.m  
|-- cancellation.m  
|-- Matlab environment requirement  
|-- segment.m  
|-- trainClassifier.m
|-- demo_address
|-- Artifact_description.pdf
```

## Demo
You can get our artifact operation demo from the following YouTube URL: 
https://youtu.be/ZDvkZsqzj4I  
If you have any questions about accessing this demo, please contact us at: 2017133035@email.szu.edu.cn

## How to Use
### HardWare
&emsp;1. Download the Gerber file ('Gerber_PCB_single_pd.zip' in the hardware folder) and send it to a professional flexible PCB manufacturer to print the flexible PCB (each toothbrush requires two printed flexible PCBs).   
&emsp;2. Connect the photosensors (flexible PCBs) and Arduino UNO using Dupont wires and a breadboard, following the circuit diagram ('hardware_deployment.jpg' - left). Note that the ADDR pins of the two photosensors should be connected to the GND and VCC pins of the Arduino to assign different addresses.
Note that, the ADDR pins of the two photosensors were connected to the GND and VCC pins of the Arduino, respectively, to assign different addresses.  
&emsp;3. Attach two photosensors to the side of the toothbrush hand near the top, at approximately 60° from the toothbrush orientation. Cover the sensors' surface with a layer of about 0.6mm transparent food-grade silicone rubber to prevent saliva from short-circuiting the sensors and ensure excellent light transmittance. Ensure that the silicone rubber is fully cured.  
&emsp;4. Connect the Arduino UNO to a personal computer using a USB cable and use the Arduino IDE to burn the program ('arduino_code.ino' in the hardware folder) into the Arduino UNO.  
&emsp;5. Connect the Arduino UNO to a personal computer using a USB cable and use the Matlab code ('Step1_collect_data.m') to collect toothbrushing signals with Matlab.  
### SoftWare
&emsp;1. Use the Matlab code ('Step1_collect_Data.m') to collect brushing data based on the Bass brushing technique. We also provide data (in the 'data' folder) on 16 brushing surfaces of one user for demonstration purposes.  
&emsp;2. Run the 'Step2_signal_processing_and_analysis.m' file to execute the LiT algorithm's MATLAB code, which processes the collected toothbrushing signals with labels.  
&emsp;3. Obtain the 10-fold cross-validation accuracy of toothbrushing surface recognition from the labeled data.   
  
&emsp;By following the above steps, you can set up and use the LiT toothbrushing monitoring system effectively. Please refer to the respective files and folders for detailed instructions and data.

## Requirements
### HardWare dependencies
&emsp;1. Modified toothbrush hardware (containing Abitelax F7 blue light sterilization electric toothbrush, Printed flexible PCB, Arduino UNO, DuPont wire, and Breadboard).  
&emsp;2. Windows Personal computer (used for Arduino code burning and Matlab signal processing and brushing surface recognition).  
&emsp;3. USB cable (connecting Modified toothbrush hardware and personal computer).
### SoftWare dependencies
&emsp;(1) Arduino IDE 1.8.19 for burning code to Arduino UNO, and (2) Matlab R2021a (with 2 toolboxes) for signal processing and brushing surface recognition.
## License
This project is licensed under the GNU General Public License.
For more details about LiT and its functionalities, please refer to the individual components of this repository.
