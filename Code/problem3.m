clear
close all

% Generate input signal
s_int = 0.01;
t = 0:s_int:10;
f = square(t * (2 * pi));

% Find the Fourier series coefficients of the output signal
N = 10;
k = -N:1:N;
f10 = 0 * t;
dk = 0 * k;
for val = k
    odd = (2 * val) - 1;
    dk(:,val+N+1) = (2 / (pi * odd));
    fk = (2 / (pi * odd)) * sin(2 * pi * odd * t);
    f10 = f10 + fk;
end

% Plot magnitude and phase of input signal
inp = figure;
subplot(2, 1, 1)
plot(t, f10)
title("Magnitude of Input Signal")
subplot(2, 1, 2)
plot(t, angle(f10))
title("Phase of Input Signal")

% Calculate the frequency response of the RC circuit
w = -N*2*pi:2*pi:N*2*pi;
Hw = 1 ./ (1 + 1i * 0.05 * w);
tfunc = figure;
subplot(2, 1, 1)
plot(w, abs(Hw))
xlabel("Frequency (\omega)")
ylabel("|H(\omega)|")
grid on
title("Magnitude of Transfer Function")
subplot(2, 1, 2)
plot(w, angle(Hw))
xlabel("Frequency (\omega)")
ylabel("\angle H(\omega)")
yticks([-pi/2 0 pi/2])
yticklabels(["-\pi/2", "0", "\pi/2"])
grid on
title("Phase of Transfer Function")

% Save tranfser function plots
saveas(tfunc, "TransferFunction.png")

% Calculate the output from the input coefficients and frequency response
y = 0 * t;
for val = k    
    odd = (2 * val) - 1;
    yk = dk(:,val+N+1) * Hw(:,val+N+1) * sin(2 * pi * odd * t);
    y = y + yk;
end

% Plot distorted output
out = figure;
subplot(2, 1, 1)
plot(t, f)
ylim([-1.5 1.5])
xlabel("t")
ylabel("x(t)")
title("Input Signal x(t)")
subplot(2, 1, 2)
plot(t, real(y))
ylim([-1.5 1.5])
xlabel("t")
ylabel("y(t)")
title("Distorted Output Signal y(t)")

% Save output plots
saveas(out, "OutputSignal.png")