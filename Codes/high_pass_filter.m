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
