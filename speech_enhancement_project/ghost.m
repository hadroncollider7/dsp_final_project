%% Ex. Listen to a speech file
clear variables;clf;clc;close all;
y=load_or_audioread('sp01.wav');
soundsc(y)
%%
y=load('street.dat');
soundsc(y,8000)
%% 
clear variables;clf;clc;close all;
[t]=addnoisex('sp01.wav','street.dat',30,'s01_noisy_snr30.wav');
%% 
soundsc(t,8000)
%% Part 6. Adding noise to a speech
clear variables;clf;clc;close all;
s_clean=load_or_audioread('sp01.wav'); % clean speech
noise=load_or_audioread('white.dat');  % noise

SNR=30;
% L2 norm of clean speech
pspeech=norm(s_clean,2);

% L2 norm of desired noise
pDesiredNoise=pspeech./(10^(SNR/20));

% L2 norm of read in noise signal
pnoise=norm()





