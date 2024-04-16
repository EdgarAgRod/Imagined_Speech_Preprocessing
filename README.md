# Imagined Speech Preprocessing
The following repository uses MATLAB's toolbox EEGLAB to pre-process imagined speech signals.


## How to run
0. Before running
- Make sure you install MATLAB as well as the EEGLAB toolbox.
- Create folders for "AVANZAR", "RETROCEDER", "IZQUIERDA" and "DERECHA".

1. Data Preparation
- Open the "DataPreparation.m" file.
- Change all the commented folders to the corresponding paths on your computer. Note that this pre-processing pipeline was meant for a traditional and an experimental paradigm, but you may use it to run on any type of paradigm and condition.
- Run the "DataPreparation.m" file. This file excludes gyros and inserts channel locations.
- This will generate the "-Original.set" files for every participant.

2. Visual Inspection
- Visually inspect each signal and remove the corrupted data. It is recommended to only reject data were a channel disconnection is noticeable.

3. Pre-processing
- Open the "Preprocessing.m" file.
- Change all the commented folders to the corresponding paths on your computer. Note that this pre-processing pipeline was meant for a traditional and an experimental paradigm, but you may use it to run on any type of paradigm and condition.
- Run the "Preprocessing.m" file. This file re-references to M1 and M2, band-passes to 1-100Hz, applies a notch filter at 60Hz, and applies ICA. These files are saved as "-Cleaned.set".
- The ICA keeps components that have more that 60% brain activity or that have both more than 10% brain activity and more than 50% brain activity.
- Also, this file separates each of the four classes into their own folders.

4. Event Related Potentials
- - Open the "ERPs.m" file.
- Change all the commented folders to the corresponding paths on your computer. Note that this pre-processing pipeline was meant for a traditional and an experimental paradigm, but you may use it to run on any type of paradigm and condition.
- Run the "ERPs.m" file. This file will create ERP studies by averaging all instances of all participants across all channels for every word.
