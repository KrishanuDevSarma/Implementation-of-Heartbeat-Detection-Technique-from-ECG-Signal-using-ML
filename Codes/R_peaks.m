% finding number of peaks

[pks,locs]=findpeaks(ECG_filtered(1,:));
threshold=2*(rms(ECG_filtered(1,:)));
Rwave =pks>threshold;

% stem R-Peaks

R_wave = zeros(size(ECG_filtered(1,:)));
R_wave(locs(Rwave)) = max(ECG_filtered(1,:));

plot(ECG_filtered(1,:));
hold on
stem(R_wave,'r','*')
