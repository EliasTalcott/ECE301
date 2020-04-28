clear
close all

% Load and play audio file
X = load("RFspectrum.mat");
X = X.H;
soundsc(X, 44100)