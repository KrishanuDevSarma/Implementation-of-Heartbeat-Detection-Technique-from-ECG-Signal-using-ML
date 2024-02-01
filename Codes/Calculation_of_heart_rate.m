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
