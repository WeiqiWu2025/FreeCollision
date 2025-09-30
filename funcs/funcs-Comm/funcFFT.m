function [f,fft_signal] = funcFFT(inputSignal,sampleRate)
%%% using plor(f,fft_signal) to display spectrogram 

len = length(inputSignal);
Y = fft(inputSignal);
P2 = abs(Y/len);
P1 = P2(1:len/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = sampleRate*(0:(len/2))/len;
fft_signal = P1;
end
