%% Speech Recognition Project
% Process Overview
% Step 1. Record sample voice
% Step 2. Save to wav
% Step 3. Feature extraction
%          3.1 Entroypy
%          3.2 Windows
%          3.3 FFT
%          3.4 MFCC
% Step 4. Neuron Network Build
% Step 5. Training
% Step 6. Testing

%% Step 1. Record sample voice
recObj = audiorecorder(16000,16,2);             % audiorecorder(Fs,nBits,nChannels)
disp('Please speaking.')
recordblocking(recObj,2);
disp('End of recording.')

%%