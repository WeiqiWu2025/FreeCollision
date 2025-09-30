function [chanEst] = survey_FreeCollision_funcGetLn(rx,cfgHT,ind,fs,n)

% if n == 25
%     aaa = 1;
% end

% Packet detect and determine coarse packet offset
coarsePktOffset = wlanPacketDetect(rx,cfgHT.ChannelBandwidth);
if isempty(coarsePktOffset)
    coarsePktOffset = 0;
end
%if isempty(coarsePktOffset) % If empty no L-STF detected; packet error
%    numPacketErrors = numPacketErrors+1;
%    n = n+1;
%    return;
    %continue; % Go to next loop iteration
%end
        
% Extract L-STF and perfrom coarse frequency offset correction
lstf = rx(coarsePktOffset+(ind.LSTF(1):ind.LSTF(2)),:);
        
coarseFreqOff = wlanCoarseCFOEstimate(lstf,cfgHT.ChannelBandwidth);
rx = helperFrequencyOffset(rx,fs,-coarseFreqOff);
        
% Extract the non-HT fields and determine fine packet offset
nonhtfields = rx(coarsePktOffset+(ind.LSTF(1):ind.LSIG(2)),:);
finePktOffset = wlanSymbolTimingEstimate(nonhtfields,...
    cfgHT.ChannelBandwidth);
        
% Determine final packet offset
pktOffset = coarsePktOffset+finePktOffset;
        
% If packet detected outwith the range of expected delays from the 
% channel modeling; packet error
%if pktOffset>15
%    numPacketErrors = numPacketErrors+1;
%    n = n+1;
%    return;
%    %continue; % Go to next loop iteration
%end

% Extract L-LTE and perform fine frequency offset correction
lltf = rx(pktOffset+(ind.LLTF(1):ind.LLTF(2)),:);
fineFreqOff = wlanFineCFOEstimate(lltf,cfgHT.ChannelBandwidth);
rx = helperFrequencyOffset(rx,fs,-fineFreqOff);
        
% Extract HT-LTE samples from the waveform, demodulate and perform
% channel estimateion
htltf = rx(pktOffset+(ind.HTLTF(1):ind.HTLTF(2)),:);
htltfDemod = wlanHTLTFDemodulate(htltf,cfgHT);
chanEst = wlanHTLTFChannelEstimate(htltfDemod,cfgHT);

end

