clear
close all

% Create f(t) and g(t)
s_int = 0.1;
t = -10:s_int:10;
f = u(t) - u(t - 5);
t1 = -10:s_int:10;
go = u(t1 + 2) - u(t1 - 3);

% Animation calculations
g = fliplr(go);
tf = fliplr(-t1);
tf = tf + (min(t) - max(tf));
tc = [tf t(2:end)];
tc = tc + max(t1);
c = s_int * conv(f, go);

% Plot f(t) and go(t) statically
a_fig = figure;
set(a_fig, "Name", "Animated Convolution", "unit", "pixel", "Position", [300, 150, 600, 750]);
subplot(3, 1, 1)
plot(t, f, t1, go)
xlim([(min(t) - abs(max(tf) - min(tf) - 1)) (max(t) + abs(max(tf) - min(tf)) + 1)])
ylim([0, 1.5])
xlabel("t")
legend("f(t)", "go(t)", "Location", "northeast")
title("Graph of f(t) and go(t)")

% Initialize subplot 2
subplot(3, 1, 2)
p2 = plot(t, f);
hold on;
p22 = plot(tf, g);
xlim([(min(t) - abs(max(tf) - min(tf)) - 1) (max(t) + abs(max(tf) - min(tf)) + 1)])
ylim([0, 1.5])
xlabel("t")
legend("f(t)", "g", "Location", "northeast")
title("Graphical convolution of f(t) and g = g0(-t1)")

% Initialize subplot 3
subplot(3, 1, 3)
p3 = plot(tc, c);
xlim([(min(t) - abs(max(tf) - min(tf) - 1)) (max(t) + abs(max(tf) - min(tf)) + 1)])
ylim([0 6])
xlabel("t")
ylabel("c(t)")
title("Convolutional Product c(t)")

% Animate subplots 2 and 3
myVideo = VideoWriter("Graphical Convolution");
myVideo.FrameRate = 10;
open(myVideo)

for idx = 1:length(tc)
    % Control speed of animation
    pause(0);
    drawnow;
    
    % Update variables
    tf = tf + s_int;
    set(p22, "XData", tf, "YData", g);
    set(p3, "XData", tc(1:idx), "YData", c(1:idx));
    
    % Write frame to video
    frame = getframe(gcf);
    writeVideo(myVideo, frame);
end

close(myVideo)