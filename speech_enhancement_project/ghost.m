%**********************************************
% This is the main workspace for the project.
% ********************************************%
%% Ex. Listen to a speech file
clear variables;clf;clc;close all;
y=load_or_audioread('sp13.wav');
soundsc(y,8000)
%% Listen to the noise
y=load('street.dat');
soundsc(y,8000)
%% Add noise to a clean speech signal
clear variables;clf;clc;close all;
[t]=addnoisex('sp13.wav','street.dat',30,'s01_noisy_snr30.wav');
%% Listen to speech data
soundsc(t,8000)
%% Part 6. Adding noise to a speech
clear variables;clf;clc;close all;

SNR=20;
[t]=addnoisex('sp13.wav','exhibition.dat',SNR,'spXX_noisey_snrXX.wav');
y=load_or_audioread('spXX_noisey_snrXX.wav');
soundsc(y,8000);

%% ***************** Part 8: Weiner Filter *********************
clear variables;clf;clc;close all;
% Part 1. Create noise corrupted speech
[t30]=addnoisex('sp13.wav','train.dat',30,'sp13_noisey_snr30.wav');
[t20]=addnoisex('sp13.wav','train.dat',20,'sp13_noisey_snr20.wav');
[t10]=addnoisex('sp13.wav','train.dat',10,'sp13_noisey_snr10.wav');
[t00]=addnoisex('sp13.wav','train.dat',0,'sp13_noisey_snr00.wav');
% Part 8.2. Enhance the noisy speech
wiener_as('sp13_noisey_snr30.wav','sp13_enhanced_snr30.wav');
wiener_as('sp13_noisey_snr20.wav','sp13_enhanced_snr20.wav');
wiener_as('sp13_noisey_snr10.wav','sp13_enhanced_snr10.wav');
wiener_as('sp13_noisey_snr00.wav','sp13_enhanced_snr00.wav');
% 8.2. Load the enhanced speech
y30=load_or_audioread('sp13_enhanced_snr30.wav');
y20=load_or_audioread('sp13_enhanced_snr20.wav');
y10=load_or_audioread('sp13_enhanced_snr10.wav');
y00=load_or_audioread('sp13_enhanced_snr00.wav');
%% 8.2 Listen to enhanced speech
soundsc(y00);
%% 8.3 Run pesq.m on noisey speech
pval_noisey=zeros(1,4);
pval_noisey(4)=pesq('sp13.wav','sp13_noisey_snr30.wav');
pval_noisey(3)=pesq('sp13.wav','sp13_noisey_snr20.wav');
pval_noisey(2)=pesq('sp13.wav','sp13_noisey_snr10.wav');
pval_noisey(1)=pesq('sp13.wav','sp13_noisey_snr00.wav');
% 8.3 Run pesq.m on enhanced speech
pval_enhanced=zeros(1,4);
pval_enhanced(4)=pesq('sp13.wav','sp13_enhanced_snr30.wav');
pval_enhanced(3)=pesq('sp13.wav','sp13_enhanced_snr20.wav');
pval_enhanced(2)=pesq('sp13.wav','sp13_enhanced_snr10.wav');
pval_enhanced(1)=pesq('sp13.wav','sp13_enhanced_snr00.wav');
%% 8.3 Plot pesq values
clf;close all; clear X;
X=[0 10 20 30]; % horizontal axis are snr values
figure
stem(X,pval_enhanced,'LineWidth',2)
hold on;
stem(X,pval_noisey,'LineWidth',2)
hold off;
xlabel('SNR (dB)')
ylabel('PESQ')
grid
legend('Enhanced Signel','Noisey Signel')

%% ************************* PART 9 ********************************
%* DO NOT RUN WILLY NILLY!!!!! 
% -Part 1. Add white, exhibition, train, and street noise to all 
%   clean speech files at SNR 0, 10, 20, and 30 dB
% ******************************************************************%
clear variables;clc;clf;close all;
for i=1:30
    if i<10
        for j=0:10:30
            % spXX.wav
            clean_file=['sp0' num2str(i) '.wav'];
            
            % spXX_noisy_[noiseType]_snrX.wav
            noisy_file_white=['sp0' num2str(i) '_noisy_white_snr' num2str(j) '.wav'];
            noisy_file_exhibition=['sp0' num2str(i) '_noisy_exhibition_snr' num2str(j) '.wav'];
            noisy_file_train=['sp0' num2str(i) '_noisy_train_snr' num2str(j) '.wav'];
            noisy_file_street=['sp0' num2str(i) '_noisy_street_snr' num2str(j) '.wav'];
            
            [t_white]=addnoisex(clean_file,'white.dat',j,noisy_file_white);
            [t_exhib]=addnoisex(clean_file,'exhibition.dat',j,noisy_file_exhibition);
            [t_train]=addnoisex(clean_file,'train.dat',j,noisy_file_train);
            [t_stree]=addnoisex(clean_file,'street.dat',j,noisy_file_street);
       end
    else
        for j=0:10:30
            % spXX.wav
            clean_file=['sp' num2str(i) '.wav'];

            % spXX_noisy_[noiseType]_snrX.wav
            noisy_file_white=['sp' num2str(i) '_noisy_white_snr' num2str(j) '.wav'];
            noisy_file_exhibition=['sp' num2str(i) '_noisy_exhibition_snr' num2str(j) '.wav'];
            noisy_file_train=['sp' num2str(i) '_noisy_train_snr' num2str(j) '.wav'];
            noisy_file_street=['sp' num2str(i) '_noisy_street_snr' num2str(j) '.wav'];
            
            [t_white]=addnoisex(clean_file,'white.dat',j,noisy_file_white);
            [t_exhib]=addnoisex(clean_file,'exhibition.dat',j,noisy_file_exhibition);
            [t_train]=addnoisex(clean_file,'train.dat',j,noisy_file_train);
            [t_stree]=addnoisex(clean_file,'street.dat',j,noisy_file_street);
        end
    end
end
%% Enhance white noise corrupted speech
clc;
clear i j;
clear enhanced_s noisy_file;
for i=1:30
    if i<10
        for j=0:10:30
            % spXX_noisy_snrX.wav
            noisy_file=['sp0' num2str(i) '_noisy_snr' num2str(j) '.wav'];
            % spXX_enhanced_snrX
            enhanced_s=['sp0' num2str(i) '_enhanced_snr' num2str(j) '.wav'];
            wiener_as(noisy_file,enhanced_s);
        end
    else
        for j=0:10:30
            noisy_file=['sp' num2str(i) '_noisy_snr' num2str(j) '.wav'];
            enhanced_s=['sp' num2str(i) '_enhanced_snr' num2str(j) '.wav'];
            wiener_as(noisy_file,enhanced_s);
        end
    end
end
%% ****************** PESQ for white noise *********************
clc;
clear i j k;
clear clean_file;
clear enhanced_s;
% **********PESQ, ENHANCED SPEECH, WHITE NOISE *****************%

%***************** Create 30x4 matrix ******************
% - Rows for 30 sentences
% - Columns for 0, 10, 20, 30 dBs 
% *****************************************************%
pval_white_enhanced=zeros(30,4);

for i=1:30
    if i<10
        k=1;
        for j=0:10:30
            % spXX.wav
            clean_file=['sp0' num2str(i) '.wav'];
            % spXX_enhanced_snrX.wav
            enhanced_s=['sp0' num2str(i) '_enhanced_snr' num2str(j) '.wav'];
            pval_white_enhanced(i,k)=pesq(clean_file,enhanced_s);
            k=k+1;
        end
    else
        k=1;
        for j=0:10:30
            % spXX.wav
            clean_file=['sp' num2str(i) '.wav'];
            % spXX_enhanced_snrX.wav
            enhanced_s=['sp' num2str(i) '_enhanced_snr' num2str(j) '.wav'];
            pval_white_enhanced(i,k)=pesq(clean_file,enhanced_s);
            k=k+1;
        end
    end
end

%% ************* PESQ, NOISE CORRUPTED SPEECH, WHITE NOISE ***************
clear i j k;
clear clean_file;
clear noisy_file;

pval_white_noisy=zeros(30,4);
for i=1:30
    if i<10
        k=1;
        for j=0:10:30
            clean_file=['sp0' num2str(i) '.wav'];
            noisy_file=['sp0' num2str(i) '_noisy_snr' num2str(j) '.wav'];
            pval_white_noisy(i,k)=pesq(clean_file,enhanced_s);
            k=k+1;
        end
    else
        k=1;
        for j=0:10:30
            clean_file=['sp' num2str(i) '.wav'];
            noisy_file=['sp' num2str(i) '_noisy_snr' num2str(j) '.wav'];
            pval_white_noisy(i,k)=pesq(clean_file,enhanced_s);
            k=k+1;
        end
    end
end

%% PART 9-TRAIN






















