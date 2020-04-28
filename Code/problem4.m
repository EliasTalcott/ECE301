clear
close all

s_int = 0.01;
t = -10:s_int:10;

% Calculate the frequency spectral for a = 1, 10, and 100
f1 = exp(-1 * (t .^ 2)) / numel(t);
f10 = exp(-10 * (t .^ 2)) / numel(t);
f100 = exp(-100 * (t .^ 2)) / numel(t);


% Plot the frequency spectrals
specs = figure;
subplot(3, 1, 1)
plot(t, abs(fftshift(fft(f1))))
ylim([0 0.15])
xlabel("Frequency")
ylabel("Magnitude")
title("Frequency Spectral for a = 1")
subplot(3, 1, 2)
plot(t, abs(fftshift(fft(f10))))
ylim([0 0.05])
xlabel("Frequency")
ylabel("Magnitude")
title("Frequency Spectral for a = 10")
subplot(3, 1, 3)
plot(t, abs(fftshift(fft(f100))))
ylim([0 0.05])
xlabel("Frequency")
ylabel("Magnitude")
title("Frequency Spectral for a = 100")

% Save plot
saveas(specs, "Spectrals.png")