clear
close all

% Save animation as a gif file (0 no) (1 yes)
flagAG = 0;

% Frequency of temporal signal (x-position) = rotations/s of spot (Hz)
f0 = 1;
nCycles = 6;

% Size of image
Nx = 300;
Ny = 300;

% Displaying rotated images accordingly to visualization rate
scrsz = get(groot, "ScreenSize");
pFull = 0.8;
height = pFull * scrsz(4);
b = scrsz(4) - height - scrsz(4)/10;
h = figure("Units", "normalized", "Position", [0.05 0.2 0.4 0.6]);

%% [case: redundant] Nyquist freq >> signal freq
frame1 = 0;
frameRate = 8*f0;
titulo = sprintf("Nyquist freq = %3.2f Hz >> Signal freq f_0 = %3.2f Hz [case: redundant]", frameRate, f0);
oscAliasingPlot(f0, frameRate, nCycles, Nx, Ny, titulo, h, flagAG, frame1);
% iowait(msgbox(msg, "ok", "modal"));

%% [case: fair] Nyquist freq > signal freq
frame1 = frame1 + 1 + fix(nCycles * frameRate / f0);
frameRate = 3*f0;
titulo = sprintf("Nyquist freq = %3.2f Hz > Signal freq f_0 = %3.2f Hz [case: fair]", frameRate, f0);
oscAliasingPlot(f0, frameRate, nCycles, Nx, Ny, titulo, h, flagAG, frame1);
% iowait(msgbox(msg, "ok", "modal"));

%% [case: Nyquist criterion limit] Nyquist freq = signal freq
frame1 = frame1 + 1 + fix(nCycles * frameRate / f0);
frameRate = 2*f0;
titulo = sprintf("Nyquist freq = %3.2f Hz = Signal freq f_0 = %3.2f Hz [case: Nyquist criterion limit]", frameRate, f0);
oscAliasingPlot(f0, frameRate, nCycles, Nx, Ny, titulo, h, flagAG, frame1);
% iowait(msgbox(msg, "ok", "modal"));

%% [case: aliasing < 2 Nyquist freq] Nyquist freq < signal freq
frame1 = frame1 + 1 + fix(nCycles * frameRate / f0);
frameRate = 1.2*f0;
titulo = sprintf("Nyquist freq = %3.2f Hz < Signal freq f_0 = %3.2f Hz [case: aliasing < 2 Nyquist freq]", frameRate, f0);
oscAliasingPlot(f0, frameRate, nCycles, Nx, Ny, titulo, h, flagAG, frame1);
% iowait(msgbox(msg, "ok", "modal"));

%% [case: aliasing = 2 Nyquist freq] Nyquist freq = (1/2) signal freq
frame1 = frame1 + 1 + fix(nCycles * frameRate / f0);
frameRate = 1*f0;
titulo = sprintf("Nyquist freq = %3.2f Hz = (1/2) Signal freq f_0 = %3.2f Hz [case: aliasing = 2 Nyquist freq]", frameRate, f0);
oscAliasingPlot(f0, frameRate, nCycles, Nx, Ny, titulo, h, flagAG, frame1);
% iowait(msgbox(msg, "ok", "modal"));

%% [case: aliasing > 2 Nyquist freq] Nyquist freq < (1/2) signal freq
frame1 = frame1 + 1 + fix(nCycles * frameRate / f0);
frameRate = 0.8*f0;
titulo = sprintf("Nyquist freq = %3.2f Hz < (1/2) Signal freq f_0 = %3.2f Hz [case: aliasing > 2 Nyquist freq]", frameRate, f0);
oscAliasingPlot(f0, frameRate, nCycles, Nx, Ny, titulo, h, flagAG, frame1);
% iowait(msgbox(msg, "ok", "modal"));

%%
function oscAliasingPlot(freqSignal, frameRate, nCycles, Nx, Ny, titulo, h, flagAG, frame1)
    ag_name = "ag_aliasing.gif";
    delay = 0.4;
    
    % Generate and show rotating spot
    clf(h)
    tFrame = 1 / frameRate;
    nFrames = fix(nCycles * frameRate / freqSignal);
    x_v = zeros(nFrames, 1);
    dt_sig = 1 / (50 * freqSignal);
    n_sig = nCycles / freqSignal / dt_sig;
    rot_init = pi;
    t_sig = (0:n_sig - 1) * dt_sig;
    [~, ~, ~, dSpot_c] = oscAliasingSpot(Nx, Ny, rot_init);
    x_sig = dSpot_c * sin(rot_init - t_sig * freqSignal * 2 * pi);
    y_sig = dSpot_c * cos(rot_init - t_sig * freqSignal * 2 * pi);
    
    for n = 1:nFrames
        if (n == 1), tic; end
        rot = rot_init - ((n-1) * tFrame * freqSignal * 2 * pi);
        [circ_rot, xSpot, ySpot, dSpot_c] = oscAliasingSpot(Nx, Ny, rot);
        x_v(n) = xSpot;
        figure(h);
       
        subplot(3, 1, 1)
        imagesc(1:Nx, 1:Ny, circ_rot); axis image; xlabel("x"); ylabel("y");
        title(sprintf("Constant Rotation f_0 = %3.2f Hz    Sampled freq f_S = %3.2 Hz", freqSignal, frameRate));
        t_v = (0:n-1) * tFrame; t = (n-1) * tFrame;
        set(gca, "fontsize", 12)
        axis off
   
        subplot(3, 1, 2)
        hold on
        plot(t_sig, -y_sig, "k", "LineWidth", 1);
        hPlot = plot(t_v, -x_v(1:n), "bo");
        set(hPlot, "markersize", 6, "markerfacecolor", "b")
        hPlot = plot(t, -xSpot, "mo");
        set(hPlot, "markersize", 6, "markerfacecolor", "m")
        grid on
        
        axis([0 (nCycles / freqSignal) -Nx/2 Nx/2]);
        xlabel("time [s]"); ylabel("Y spot position [a.u.]");
        title(titulo);
        set(gca, "fontsize", 12)
        box on
        fNyq = frameRate / 2;
        
        subplot(3, 1, 3)
        line([freqSignal freqSignal], [0 1], "color", "b", "linewidth", 3);
        line([fNyq fNyq], [0 0.7], "color", "r", "linewidth", 3);
        axis([0 5 0 1.2]); xlabel("frequency [Hz]"); ylabel("a.u");
        set(gca, "fontsize", 12)
        box on
        
        if (fNyq >= freqSignal)
            legend("Signal", "Nyquist");
            title("Frequency domain: Signal freq and Nyquist freq");
        else
            f_alias = abs(2*fNyq - freqSignal);
            f_aliasSign = sign(2*fNyq - freqSignal);
            while (f_alias > fNyq), f_alias = abs(2*fNyq-f_alias); f_aliasSign = sign(2*fNyq - freqSignal); end
            line([f_alias f_alias], [0 1], "color", "g", "linewidth", 3);
            legend("Signal", "Nyquist", "Alias");
            title(sprintf("Frequency domain: Signal freq, Nyquist freq and alias freq = %3.2f Hz", (-f_aliasSign)*f_alias));
        end
        
        if flagAG > 0
            frame1 = frame1 + 1;
            frame = getFrame(1);
            im = frame2im(frame);
            [imind, cm] = rgb2ind(im, 256);
            if frame == 1
                imwrite(imind, cm, ag_name, "gif", "DelayTime", delay, "loopcount", inf);
            else
                imwrite(imind, cm, ag_name, "gif", "DelayTime", delay, "writemode", "append");
            end
        end
        
        drawnow;
        
        if (n == 1), elapsedTime = toc; end
        tWait = max(tFrame - elapsedTime, 0);
        pause(tWait);
    end
end


function [circ, xSpot, ySpot, dSpot_c] = oscAliasingSpot(Nx, Ny, spotAngle)
    R = fix(0.4 * Nx);
    cx = fix(Nx / 2) + 1;
    cy = fix(Ny / 2) + 1;
    circ = zeros(Nx, Ny);
    spotR = fix(R / 8);
    dSpot_c = R - spotR - 2;
    xSpot = dSpot_c * cos(spotAngle);
    ySpot = dSpot_c * sin(spotAngle);
    cxSpot = cx + xSpot;
    cySpot = cy + ySpot;
    
    for iy = 1:Ny
        for ix = 1:Nx
            d = sqrt((ix - cx) ^ 2 + (iy - cy) ^ 2);
            if (d > R), continue, end
            circ(ix, iy) = 1;
            dSpotCenter = sqrt((ix - cxSpot) ^ 2 + (iy - cySpot) ^ 2);
            if (dSpotCenter > spotR), continue, end
            circ(ix, iy) = circ(ix, iy) + 1;
        end
    end
end