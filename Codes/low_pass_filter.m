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
