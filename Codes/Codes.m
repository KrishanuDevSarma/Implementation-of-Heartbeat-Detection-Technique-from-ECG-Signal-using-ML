% This code calculates the heart rate
clf
clear all;
clc;
% loading the ECG
ECG= load('100m.mat')
ECG_1= ECG.val(1,:);
ECG_2= ECG.val(2,:);


% ploting the original ECG
subplot(3,1,1)
plot(ECG_1)
hold on;
title('Original ECG data')

ylabel('ECG Amplitude')

%% designing low pass filter:

fs =360;
filterorder=10;
cutoffFreq=18;
[b, a]=butter(filterorder, cutoffFreq/(fs/2),'low');
% plot frequency response
[h,w]= freqz(b, a);
figure(2)
subplot(2,2,1)
plot(w/pi*fs/2, abs(h), '-');
% apply low pass filter
ECG_highpass = filter(b,a,ECG_1)
figure (1)
subplot(3,1,2)
plot(ECG_highpass(1,:))
title('Jitter and noise  removed')

%% designing high pass filter:

fs =360;
filterorder=10;
cutoffFreq=4;
[b, a]=butter(filterorder, cutoffFreq/(fs/2),'high');

% plot frequency response
[h,w]= freqz(b, a);
figure(2)
subplot(2,2,1)
plot(w/pi*fs/2, abs(h), '-');

% apply high pass filter

ECG_filtered = filter(b,a,ECG_highpass)
figure (1)
subplot(3,1,3)
plot(ECG_filtered(1,:))
title('movement artifits removed')

% shifting the ECG to time domain:
ts=(0:10/length(ECG_filtered):10-10/length(ECG_filtered));

% ploting the original ECG
figure(3)

plot(ts,ECG_filtered)
hold on;
title(' ECG data')
xlabel('Time (in seconds)') 
ylabel('ECG Amplitude')

% finding number of peaks
[pks,locs]=findpeaks(ECG_filtered(1,:));
threshold=2*(rms(ECG_filtered(1,:)));
Rwave =pks>threshold;

% stem R-Peaks
R_wave = zeros(size(ECG_filtered(1,:)));
R_wave(locs(Rwave)) = max(ECG_filtered(1,:));
figure(4)
plot(ECG_filtered(1,:));
hold on
stem(R_wave,'r','*')

%% heart rate calculation:
Total_number_beat= sum(Rwave)
Heart_rate= (Total_number_beat/10)*60
