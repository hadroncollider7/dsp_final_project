%**********************************************
% This is the main workspace for the project.
% ********************************************%
%% Ex. Listen to a speech file
clear variables;clf;clc;close all;
y=load_or_audioread('sp01.wav');
soundsc(y,8000)
%% Listen to the noise
y=load('street.dat');
soundsc(y,8000)
%% Add noise to a clean speech signal
clear variables;clf;clc;close all;
[t]=addnoisex('sp01.wav','street.dat',30,'s01_noisy_snr30.wav');
%% Listen to speech data
soundsc(t,8000)
%% Part 6. Adding noise to a speech
clear variables;clf;clc;close all;

SNR=10;
[t]=addnoisex('sp01.wav','street.dat',SNR,'spXX_noisey_snrXX.wav');
soundsc(t,8000);




