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
%% ************** ENHANCE THE NOISE CORRUPTED SPEECH *****************
clc;
clear i j;
clear enhanced_s noisy_file;
for i=1:30
    if i<10
        for j=0:10:30
            % The noise corrupted speech to be enhanced
            % spXX_noisy_[noiseType]_snrX.wav
            noisy_file_white=['sp0' num2str(i) '_noisy_white_snr' num2str(j) '.wav'];
            noisy_file_exhibition=['sp0' num2str(i) '_noisy_exhibition_snr' num2str(j) '.wav'];
            noisy_file_train=['sp0' num2str(i) '_noisy_train_snr' num2str(j) '.wav'];
            noisy_file_street=['sp0' num2str(i) '_noisy_street_snr' num2str(j) '.wav'];
            
            % The output file .wav file containing the enhanced speech
            % spXX_enhanced_[noiseType]_snrX
            enhanced_s_white=['sp0' num2str(i) '_enhanced_white_snr' num2str(j) '.wav'];
            enhanced_s_exhibition=['sp0' num2str(i) '_enhanced_exhibition_snr' num2str(j) '.wav'];
            enhanced_s_train=['sp0' num2str(i) '_enhanced_train_snr' num2str(j) '.wav'];
            enhanced_s_street=['sp0' num2str(i) '_enhanced_street_snr' num2str(j) '.wav'];
            
            % perform the enhancement
            wiener_as(noisy_file_white,enhanced_s_white);
            wiener_as(noisy_file_exhibition,enhanced_s_exhibition);
            wiener_as(noisy_file_train,enhanced_s_train);
            wiener_as(noisy_file_street,enhanced_s_street);
        end
    else
        for j=0:10:30
            % The noise corrupted speech to be enhanced
            % spXX_noisy_[noiseType]_snrX.wav
            noisy_file_white=['sp' num2str(i) '_noisy_white_snr' num2str(j) '.wav'];
            noisy_file_exhibition=['sp' num2str(i) '_noisy_exhibition_snr' num2str(j) '.wav'];
            noisy_file_train=['sp' num2str(i) '_noisy_train_snr' num2str(j) '.wav'];
            noisy_file_street=['sp' num2str(i) '_noisy_street_snr' num2str(j) '.wav'];
            
            % The output file .wav file containing the enhanced speech
            % spXX_enhanced_[noiseType]_snrX
            enhanced_s_white=['sp' num2str(i) '_enhanced_white_snr' num2str(j) '.wav'];
            enhanced_s_exhibition=['sp' num2str(i) '_enhanced_exhibition_snr' num2str(j) '.wav'];
            enhanced_s_train=['sp' num2str(i) '_enhanced_train_snr' num2str(j) '.wav'];
            enhanced_s_street=['sp' num2str(i) '_enhanced_street_snr' num2str(j) '.wav'];

            % perform the enhancement
            wiener_as(noisy_file_white,enhanced_s_white);
            wiener_as(noisy_file_exhibition,enhanced_s_exhibition);
            wiener_as(noisy_file_train,enhanced_s_train);
            wiener_as(noisy_file_street,enhanced_s_street);
        end
    end
end
%% ****************** PESQ  *********************
clc;
clear variables;
% ********** PESQ FOR ENHANCED SPEECH *****************%

%***************** Create 30x4 matrix ******************
% - Rows for 30 sentences
% - Columns for 0, 10, 20, 30 dBs 
% *****************************************************%
pval_white_enhanced=zeros(30,4);
pval_exhibition_enhanced=zeros(30,4);
pval_train_enhanced=zeros(30,4);
pval_street_enhanced=zeros(30,4);

for i=1:30
    if i<10
        k=1;
        for j=0:10:30
            % spXX.wav
            clean_file=['sp0' num2str(i) '.wav'];
            
            % spXX_enhanced_[noiseType]_snrX
            enhanced_s_white=['sp0' num2str(i) '_enhanced_white_snr' num2str(j) '.wav'];
            enhanced_s_exhibition=['sp0' num2str(i) '_enhanced_exhibition_snr' num2str(j) '.wav'];
            enhanced_s_train=['sp0' num2str(i) '_enhanced_train_snr' num2str(j) '.wav'];
            enhanced_s_street=['sp0' num2str(i) '_enhanced_street_snr' num2str(j) '.wav'];
            
            pval_white_enhanced(i,k)=pesq(clean_file,enhanced_s_white);
            pval_exhibition_enhanced(i,k)=pesq(clean_file,enhanced_s_exhibition);
            pval_train_enhanced(i,k)=pesq(clean_file,enhanced_s_train);
            pval_street_enhanced(i,k)=pesq(clean_file,enhanced_s_street);

            k=k+1;
        end
    else
        k=1;
        for j=0:10:30
            % spXX.wav
            clean_file=['sp' num2str(i) '.wav'];

            % spXX_enhanced_[noiseType]_snrX
            enhanced_s_white=['sp' num2str(i) '_enhanced_white_snr' num2str(j) '.wav'];
            enhanced_s_exhibition=['sp' num2str(i) '_enhanced_exhibition_snr' num2str(j) '.wav'];
            enhanced_s_train=['sp' num2str(i) '_enhanced_train_snr' num2str(j) '.wav'];
            enhanced_s_street=['sp' num2str(i) '_enhanced_street_snr' num2str(j) '.wav'];
            
            pval_white_enhanced(i,k)=pesq(clean_file,enhanced_s_white);
            pval_exhibition_enhanced(i,k)=pesq(clean_file,enhanced_s_exhibition);
            pval_train_enhanced(i,k)=pesq(clean_file,enhanced_s_train);
            pval_street_enhanced(i,k)=pesq(clean_file,enhanced_s_street);

            k=k+1;
        end
    end
end

%% ************* PESQ, NOISE CORRUPTED SPEECH ***************
clear i j k;
clear pval_white_noisy;
clear pval_exhibition_noisy;
clear pval_train_noisy;
clear pval_street_noisy;

pval_white_noisy=zeros(30,4);
pval_exhibition_noisy=zeros(30,4);
pval_train_noisy=zeros(30,4);
pval_street_noisy=zeros(30,4);

for i=1:30
    if i<10
        k=1;
        for j=0:10:30
            % spXX.wav
            clean_file=['sp0' num2str(i) '.wav'];

            % spXX_noisy_[noiseType]_snrX.wav
            noisy_file_white=['sp0' num2str(i) '_noisy_white_snr' num2str(j) '.wav'];
            noisy_file_exhibition=['sp0' num2str(i) '_noisy_exhibition_snr' num2str(j) '.wav'];
            noisy_file_train=['sp0' num2str(i) '_noisy_train_snr' num2str(j) '.wav'];
            noisy_file_street=['sp0' num2str(i) '_noisy_street_snr' num2str(j) '.wav'];

            pval_white_noisy(i,k)=pesq(clean_file,noisy_file_white);
            pval_exhibition_noisy(i,k)=pesq(clean_file,noisy_file_exhibition);
            pval_train_noisy(i,k)=pesq(clean_file,noisy_file_train);
            pval_street_noisy(i,k)=pesq(clean_file,noisy_file_street);

            k=k+1;
        end
    else
        k=1;
        for j=0:10:30
            % spXX.wav
            clean_file=['sp' num2str(i) '.wav'];

            % spXX_noisy_[noiseType]_snrX.wav
            noisy_file_white=['sp' num2str(i) '_noisy_white_snr' num2str(j) '.wav'];
            noisy_file_exhibition=['sp' num2str(i) '_noisy_exhibition_snr' num2str(j) '.wav'];
            noisy_file_train=['sp' num2str(i) '_noisy_train_snr' num2str(j) '.wav'];
            noisy_file_street=['sp' num2str(i) '_noisy_street_snr' num2str(j) '.wav'];

            pval_white_noisy(i,k)=pesq(clean_file,noisy_file_white);
            pval_exhibition_noisy(i,k)=pesq(clean_file,noisy_file_exhibition);
            pval_train_noisy(i,k)=pesq(clean_file,noisy_file_train);
            pval_street_noisy(i,k)=pesq(clean_file,noisy_file_street);

            k=k+1;
        end
    end
end

%% ******************* 95% CONFIDENCE INTERALS ************************
clear variables;clc;clf;close all;
load('pesq_values_workspace.mat');
%****************** SNR 0 ********************%
n=30; % no. of observations
Z=1.96; % Z-value of 95% confidence interval
% enhanced speech
snr0_enh_mean_pesq=zeros(1,4); % [white, exhibition, train, street]
snr0_enh_std_pesq=zeros(1,4);
snr0_enh_CI=zeros(1,4);
% noise corrupted speech
snr0_noi_mean_pesq=zeros(1,4); % [white, exhibition, train, street]
snr0_noi_std_pesq=zeros(1,4);
snr0_noi_CI=zeros(1,4);

% white noise
i=1;
snr0_enh_mean_pesq(i)=mean(pval_white_enhanced(:,1));
snr0_enh_std_pesq(i)=std(pval_white_enhanced(:,1));
snr0_enh_CI(i)=Z*snr0_enh_std_pesq(i)/(sqrt(n));

snr0_noi_mean_pesq(i)=mean(pval_white_noisy(:,1));
snr0_noi_std_pesq(i)=std(pval_white_noisy(:,1));
snr0_noi_CI(i)=Z*snr0_noi_std_pesq(i)/(sqrt(n));


% exhibition noise, enhanced speech
i=2;
snr0_enh_mean_pesq(i)=mean(pval_exhibition_enhanced(:,1));
snr0_enh_std_pesq(i)=std(pval_exhibition_enhanced(:,1));
snr0_enh_CI(i)=Z*snr0_enh_std_pesq(i)/(sqrt(n));

snr0_noi_mean_pesq(i)=mean(pval_exhibition_noisy(:,1));
snr0_noi_std_pesq(i)=std(pval_exhibition_noisy(:,1));
snr0_noi_CI(i)=Z*snr0_noi_std_pesq(i)/(sqrt(n));


% train noise, enhanced speech
i=3;
snr0_enh_mean_pesq(i)=mean(pval_train_enhanced(:,1));
snr0_enh_std_pesq(i)=std(pval_train_enhanced(:,1));
snr0_enh_CI(i)=Z*snr0_enh_std_pesq(i)/(sqrt(n));

snr0_noi_mean_pesq(i)=mean(pval_train_noisy(:,1));
snr0_noi_std_pesq(i)=std(pval_train_noisy(:,1));
snr0_noi_CI(i)=Z*snr0_noi_std_pesq(i)/(sqrt(n));

% street noise, enhanced speech
i=4;
snr0_enh_mean_pesq(i)=mean(pval_street_enhanced(:,1));
snr0_enh_std_pesq(i)=std(pval_street_enhanced(:,1));
snr0_enh_CI(i)=Z*snr0_enh_std_pesq(i)/(sqrt(n));

snr0_noi_mean_pesq(i)=mean(pval_street_noisy(:,1));
snr0_noi_std_pesq(i)=std(pval_street_noisy(:,1));
snr0_noi_CI(i)=Z*snr0_noi_std_pesq(i)/(sqrt(n));


%% ****************** SNR 10 ********************
% enhanced speech
snr10_enh_mean_pesq=zeros(1,4); % [white, exhibition, train, street]
snr10_enh_std_pesq=zeros(1,4);
snr10_enh_CI=zeros(1,4);
% noise corrupted speech
snr10_noi_mean_pesq=zeros(1,4); % [white, exhibition, train, street]
snr10_noi_std_pesq=zeros(1,4);
snr10_noi_CI=zeros(1,4);

% white noise
i=1;
snr10_enh_mean_pesq(i)=mean(pval_white_enhanced(:,2));
snr10_enh_std_pesq(i)=std(pval_white_enhanced(:,2));
snr10_enh_CI(i)=Z*snr10_enh_std_pesq(i)/(sqrt(n));

snr10_noi_mean_pesq(i)=mean(pval_white_noisy(:,2));
snr10_noi_std_pesq(i)=std(pval_white_noisy(:,2));
snr10_noi_CI(i)=Z*snr10_noi_std_pesq(i)/(sqrt(n));


% exhibition noise, enhanced speech
i=2;
snr10_enh_mean_pesq(i)=mean(pval_exhibition_enhanced(:,2));
snr10_enh_std_pesq(i)=std(pval_exhibition_enhanced(:,2));
snr10_enh_CI(i)=Z*snr10_enh_std_pesq(i)/(sqrt(n));

snr10_noi_mean_pesq(i)=mean(pval_exhibition_noisy(:,2));
snr10_noi_std_pesq(i)=std(pval_exhibition_noisy(:,2));
snr10_noi_CI(i)=Z*snr10_noi_std_pesq(i)/(sqrt(n));


% train noise, enhanced speech
i=3;
snr10_enh_mean_pesq(i)=mean(pval_train_enhanced(:,2));
snr10_enh_std_pesq(i)=std(pval_train_enhanced(:,2));
snr10_enh_CI(i)=Z*snr10_enh_std_pesq(i)/(sqrt(n));

snr10_noi_mean_pesq(i)=mean(pval_train_noisy(:,2));
snr10_noi_std_pesq(i)=std(pval_train_noisy(:,2));
snr10_noi_CI(i)=Z*snr10_noi_std_pesq(i)/(sqrt(n));

% street noise, enhanced speech
i=4;
snr10_enh_mean_pesq(i)=mean(pval_street_enhanced(:,2));
snr10_enh_std_pesq(i)=std(pval_street_enhanced(:,2));
snr10_enh_CI(i)=Z*snr10_enh_std_pesq(i)/(sqrt(n));

snr10_noi_mean_pesq(i)=mean(pval_street_noisy(:,2));
snr10_noi_std_pesq(i)=std(pval_street_noisy(:,2));
snr10_noi_CI(i)=Z*snr10_noi_std_pesq(i)/(sqrt(n));


%% ****************** SNR 20 ********************
% enhanced speech
snr20_enh_mean_pesq=zeros(1,4); % [white, exhibition, train, street]
snr20_enh_std_pesq=zeros(1,4);
snr20_enh_CI=zeros(1,4);
% noise corrupted speech
snr20_noi_mean_pesq=zeros(1,4); % [white, exhibition, train, street]
snr20_noi_std_pesq=zeros(1,4);
snr20_noi_CI=zeros(1,4);

% white noise
i=1;
snr20_enh_mean_pesq(i)=mean(pval_white_enhanced(:,3));
snr20_enh_std_pesq(i)=std(pval_white_enhanced(:,3));
snr20_enh_CI(i)=Z*snr20_enh_std_pesq(i)/(sqrt(n));

snr20_noi_mean_pesq(i)=mean(pval_white_noisy(:,3));
snr20_noi_std_pesq(i)=std(pval_white_noisy(:,3));
snr20_noi_CI(i)=Z*snr20_noi_std_pesq(i)/(sqrt(n));


% exhibition noise, enhanced speech
i=2;
snr20_enh_mean_pesq(i)=mean(pval_exhibition_enhanced(:,3));
snr20_enh_std_pesq(i)=std(pval_exhibition_enhanced(:,3));
snr20_enh_CI(i)=Z*snr20_enh_std_pesq(i)/(sqrt(n));

snr20_noi_mean_pesq(i)=mean(pval_exhibition_noisy(:,3));
snr20_noi_std_pesq(i)=std(pval_exhibition_noisy(:,3));
snr20_noi_CI(i)=Z*snr20_noi_std_pesq(i)/(sqrt(n));


% train noise, enhanced speech
i=3;
snr20_enh_mean_pesq(i)=mean(pval_train_enhanced(:,3));
snr20_enh_std_pesq(i)=std(pval_train_enhanced(:,3));
snr20_enh_CI(i)=Z*snr20_enh_std_pesq(i)/(sqrt(n));

snr20_noi_mean_pesq(i)=mean(pval_train_noisy(:,3));
snr20_noi_std_pesq(i)=std(pval_train_noisy(:,3));
snr20_noi_CI(i)=Z*snr20_noi_std_pesq(i)/(sqrt(n));

% street noise, enhanced speech
i=4;
snr20_enh_mean_pesq(i)=mean(pval_street_enhanced(:,3));
snr20_enh_std_pesq(i)=std(pval_street_enhanced(:,3));
snr20_enh_CI(i)=Z*snr20_enh_std_pesq(i)/(sqrt(n));

snr20_noi_mean_pesq(i)=mean(pval_street_noisy(:,3));
snr20_noi_std_pesq(i)=std(pval_street_noisy(:,3));
snr20_noi_CI(i)=Z*snr20_noi_std_pesq(i)/(sqrt(n));

%% ****************** SNR 30 ********************
% enhanced speech
snr30_enh_mean_pesq=zeros(1,4); % [white, exhibition, train, street]
snr30_enh_std_pesq=zeros(1,4);
snr30_enh_CI=zeros(1,4);
% noise corrupted speech
snr30_noi_mean_pesq=zeros(1,4); % [white, exhibition, train, street]
snr30_noi_std_pesq=zeros(1,4);
snr30_noi_CI=zeros(1,4);

% white noise
i=1;
snr30_enh_mean_pesq(i)=mean(pval_white_enhanced(:,4));
snr30_enh_std_pesq(i)=std(pval_white_enhanced(:,4));
snr30_enh_CI(i)=Z*snr30_enh_std_pesq(i)/(sqrt(n));

snr30_noi_mean_pesq(i)=mean(pval_white_noisy(:,4));
snr30_noi_std_pesq(i)=std(pval_white_noisy(:,4));
snr30_noi_CI(i)=Z*snr30_noi_std_pesq(i)/(sqrt(n));


% exhibition noise, enhanced speech
i=2;
snr30_enh_mean_pesq(i)=mean(pval_exhibition_enhanced(:,4));
snr30_enh_std_pesq(i)=std(pval_exhibition_enhanced(:,4));
snr30_enh_CI(i)=Z*snr30_enh_std_pesq(i)/(sqrt(n));

snr30_noi_mean_pesq(i)=mean(pval_exhibition_noisy(:,4));
snr30_noi_std_pesq(i)=std(pval_exhibition_noisy(:,4));
snr30_noi_CI(i)=Z*snr30_noi_std_pesq(i)/(sqrt(n));


% train noise, enhanced speech
i=3;
snr30_enh_mean_pesq(i)=mean(pval_train_enhanced(:,4));
snr30_enh_std_pesq(i)=std(pval_train_enhanced(:,4));
snr30_enh_CI(i)=Z*snr30_enh_std_pesq(i)/(sqrt(n));

snr30_noi_mean_pesq(i)=mean(pval_train_noisy(:,4));
snr30_noi_std_pesq(i)=std(pval_train_noisy(:,4));
snr30_noi_CI(i)=Z*snr30_noi_std_pesq(i)/(sqrt(n));

% street noise, enhanced speech
i=4;
snr30_enh_mean_pesq(i)=mean(pval_street_enhanced(:,4));
snr30_enh_std_pesq(i)=std(pval_street_enhanced(:,4));
snr30_enh_CI(i)=Z*snr30_enh_std_pesq(i)/(sqrt(n));

snr30_noi_mean_pesq(i)=mean(pval_street_noisy(:,4));
snr30_noi_std_pesq(i)=std(pval_street_noisy(:,4));
snr30_noi_CI(i)=Z*snr30_noi_std_pesq(i)/(sqrt(n));


%% PLOTS OF 95% CONFIDENCE INTERVALS (4 PLOTS)
clf; close all;
figure(1)
errorbar(snr0_enh_mean_pesq,snr0_enh_CI,'s','LineWidth',2)
hold on;
errorbar(snr0_noi_mean_pesq,snr0_noi_CI,'s','LineWidth',2)
hold off;
ax=gca;
ax.XTick=[1 2 3 4];
ax.XTickLabel={'White', 'Exhibition', 'Train', 'Street'};
xlim([0 5])
xlabel('Noise Type')
ylabel('Mean PESQ')
legend('Enhanced','Noise')
grid

figure(2)
errorbar(snr10_enh_mean_pesq,snr10_enh_CI,'s','LineWidth',2)
hold on;
errorbar(snr10_noi_mean_pesq,snr10_noi_CI,'s','LineWidth',2)
hold off;
ax=gca;
ax.XTick=[1 2 3 4];
ax.XTickLabel={'White', 'Exhibition', 'Train', 'Street'};
xlim([0 5])
xlabel('Noise Type')
ylabel('Mean PESQ')
legend('Enhanced','Noise')
grid

figure(3)
errorbar(snr20_enh_mean_pesq,snr20_enh_CI,'s','LineWidth',2)
hold on;
errorbar(snr20_noi_mean_pesq,snr20_noi_CI,'s','LineWidth',2)
hold off;
ax=gca;
ax.XTick=[1 2 3 4];
ax.XTickLabel={'White', 'Exhibition', 'Train', 'Street'};
xlim([0 5])
xlabel('Noise Type')
ylabel('Mean PESQ')
legend('Enhanced','Noise')
grid

figure(4)
errorbar(snr30_enh_mean_pesq,snr30_enh_CI,'s','LineWidth',2)
hold on;
errorbar(snr30_noi_mean_pesq,snr30_noi_CI,'s','LineWidth',2)
hold off;
ax=gca;
ax.XTick=[1 2 3 4];
ax.XTickLabel={'White', 'Exhibition', 'Train', 'Street'};
xlim([0 5])
xlabel('Noise Type')
ylabel('Mean PESQ')
legend('Enhanced','Noise')
grid












