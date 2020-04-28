clear
close all

% Generate sawtooth wave
s_int = 0.01;
t = -6*pi:s_int:6*pi;
f = sawtooth(t)*0.5 + 0.5;

% Solve 3 terms Fourier series
N = 3;
k = -N:1:N;
dk = 1i ./ (2 * pi * k);
dk(:,N+1) = 0.5 * 1i;
f3 = 0 * t;
for val = k
    fk = dk(:,val+N+1) .* exp(1i * val * t);
    f3 = f3 + fk;
end
f3 = f3 + 0.5;

% Solve 5 terms Fourier series
N = 5;
k = -N:1:N;
dk = 1i ./ (2 * pi * k);
dk(:,N+1) = 0.5 * 1i;
f5 = 0 * t;
for val = k
    fk = dk(:,val+N+1) .* exp(1i * val * t);
    f5 = f5 + fk;
end
f5 = f5 + 0.5;

% Solve 10 terms Fourier series
N = 10;
k = -N:1:N;
dk = 1i ./ (2 * pi * k);
dk(:,N+1) = 0.5 * 1i;
f10 = 0 * t;
for val = k
    fk = dk(:,val+N+1) .* exp(1i * val * t);
    f10 = f10 + fk;
end
f10 = f10 + 0.5;

% Plot Fourier series representations against original sawtooth
fig = figure;
subplot(3, 1, 1)
plot(t, f)
hold on
plot(t, real(f3))
xlim([-6*pi 6*pi])
ylim([0 1])
xlabel("t")
xticks([-6*pi -5*pi -4*pi -3*pi -2*pi -pi 0 pi 2*pi 3*pi 4*pi 5*pi 6*pi])
xticklabels({'-6\pi', '-5\pi', '-4\pi', '-3\pi','-2\pi','-\pi','0','\pi','2\pi','3\pi', '4\pi', '5\pi', '6\pi',})
grid("on")
title("Fourier Series Representation with 3 terms")
legend("f(t)", "f3(t)")
subplot(3, 1, 2)
plot(t, f)
hold on
plot(t, real(f5))
xlim([-6*pi 6*pi])
ylim([0 1])
xlabel("t")
xticks([-6*pi -5*pi -4*pi -3*pi -2*pi -pi 0 pi 2*pi 3*pi 4*pi 5*pi 6*pi])
xticklabels({'-6\pi', '-5\pi', '-4\pi', '-3\pi','-2\pi','-\pi','0','\pi','2\pi','3\pi', '4\pi', '5\pi', '6\pi',})
grid("on")
title("Fourier Series Representation with 5 terms")
legend("f(t)", "f5(t)")
subplot(3, 1, 3)
plot(t, f)
hold on
plot(t, real(f10))
xlim([-6*pi 6*pi])
ylim([0 1])
xlabel("t")
xticks([-6*pi -5*pi -4*pi -3*pi -2*pi -pi 0 pi 2*pi 3*pi 4*pi 5*pi 6*pi])
xticklabels({'-6\pi', '-5\pi', '-4\pi', '-3\pi','-2\pi','-\pi','0','\pi','2\pi','3\pi', '4\pi', '5\pi', '6\pi',})
grid("on")
title("Fourier Series Representation with 10 terms")
legend("f(t)", "f10(t)")

% Save figure
saveas(fig, "Sawtooth.png")