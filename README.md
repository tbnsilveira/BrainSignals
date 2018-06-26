# BrainSignals
This repository contains (i) a brain signal tutorial based on EDF (European Data Format) and (ii) a MatLab app for epoch selection based on wavelet discrete transform. 

## EDF Tutorial
This tutorial was written during my master research on drowsiness detection, in 2011, with the purpose to share to other students the steps needed not only to read but to interpret signals collected from electroencephalography (EEG). The signals considered in this document are available at [Physionet Sleep Database](http://physionet.org/physiobank/database/sleep-edf/).  

The tutorial is written in Portuguese and its translation to English is lacking. It would be great if someone could translate and update it ;)  


## HipnoWave 1.0 - Epoch Selector
After understanding how the brain signals are generated and recorded, it's time to start analyzing them. However, considering there are so much noise on signals from this nature and in order to first train the signal analysis, it is important to select *epoches* representing the desired event or phenomenon, e.g. drowsiness, epylepsy, awakeness, dreaming, etc.  

The HipnoWave was developed under MatLab for Windows and is able to read an EDF signal, performs Fourier and Wavelet analysis. The latter is done by already compiled code in C which calculates the discrete wavelet transform. However, such code can be easily adapted for any purpose.


## Licence
Any sourced code is under MIT license.
Documentation is under CC-BY-SA-4.0 license.


