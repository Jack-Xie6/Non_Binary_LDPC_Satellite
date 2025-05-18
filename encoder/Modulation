%% === BPSK Modulation and AWGN Channel Simulation ===

% Ensure readSymbols is a column vector
readSymbols = readSymbols(:);

% Create a BPSK modulator with π phase offset
bpskModulator = comm.BPSKModulator('PhaseOffset', pi);

% Apply BPSK modulation to the binary bitstream (0→+1, 1→−1)
modulatedSignal = bpskModulator(readSymbols);

% Define Signal-to-Noise Ratio (SNR) in dB
SNR = 15;  % You can change this value to test different noise levels

% Create an AWGN (Additive White Gaussian Noise) channel object
awgnChannel = comm.AWGNChannel( ...
    'NoiseMethod', 'Signal to noise ratio (SNR)', ...
    'SNR', SNR);  % Set desired SNR

% Transmit the modulated signal through the AWGN channel
receivedSignal = awgnChannel(modulatedSignal);

% Display the first 10 BPSK symbols (modulated)
disp('First 10 BPSK modulated symbols:');
disp(modulatedSignal(1:10));

% Display the first 10 received symbols after AWGN channel
disp('First 10 received symbols (after AWGN):');
disp(receivedSignal(1:10));
