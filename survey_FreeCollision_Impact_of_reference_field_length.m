clc;
clear;
close all;
addpath(genpath(pwd));
rng(1993); % For repeatable results


%%%%%*** Waveform Configuration ***%%%%%
% Create a format configuration object for a 1-by-1 HT transmission
cfgHT = wlanHTConfig;
cfgHT.ChannelBandwidth = 'CBW20'; % 20 MHz channel bandwidth
cfgHT.NumTransmitAntennas = 1; % 1 transmit antennas
cfgHT.NumSpaceTimeStreams = 1; % 1 space-time streams
cfgHT.PSDULength = 2000; % PSDU length in bytes % 64
cfgHT.MCS = 0; % 1 spatial streams, BPSK rate-1/2
cfgHT.ChannelCoding = 'BCC'; % BCC channel coding

fs = wlanSampleRate(cfgHT); % Get the baseband sampling rate
ofdmInfo = wlanHTOFDMInfo('HT-Data',cfgHT); % Get the OFDM info
ind = wlanFieldIndices(cfgHT); % Indices for accessing each field within the time-domain packet

%%%%%*** Simulation Parameters ***%%%%%
snr = 0:5:15;
global numTags;
numTags = 3;
maxNumPackets = 20; % The maximum number of packets at an SNR point
global pLen;
pLen = 20; %20;
S = numel(snr); % 返回数组snr中元素的个数
numBitErrs = zeros(S,numTags); % numBitErrs: The number of bit errors
berEst = zeros(S,numTags);


for i = 1:S
    % Set random substream index per iteration to ensure that each
    % iteration uses a repeatable set of random numbers
    stream = RandStream('combRecursive','Seed',0);
    stream.Substream = i;
    RandStream.setGlobalStream(stream);
    
    % Loop to simulate multiple packets
    n = 1; % Index of packet transmitted
    while n <= maxNumPackets
        disp(['SNR: ',num2str(snr(i)),' dB  -> ','n: ',num2str(n),'-th packet']);
        %%%%%*** TX side ***%%%%%
        % Generate a packet waveform
        txPSDU = randi([0 1],cfgHT.PSDULength*8,1); % PSDULength in bytes
        tx = wlanWaveformGenerator(txPSDU,cfgHT); % generate txWaveform
        tx = [tx; zeros(15,cfgHT.NumTransmitAntennas)];  % Add trailing zeros to allow for channel filter delay
        
        exSig = [];
        H_TX_Tags = [];
        %%%%%*** TX-Tags backscatter channel & AWGN
        for chane_tx_tag_idx1 = 1:numTags
            bx_coeff_TxTag_real = (-1+(1+1)*rand(1,1)).*0.1;
            bx_coeff_TxTag_imag = (-1+(1+1)*rand(1,1)).*0.1;
            bx_coeff_TxTag = bx_coeff_TxTag_real + 1i*bx_coeff_TxTag_imag;
            tmp_exSig = tx.*bx_coeff_TxTag;
            exSig = [exSig,tmp_exSig];
            H_TX_Tags = [H_TX_Tags,bx_coeff_TxTag];
        end
        
        %%%%%*** Tags side ***%%%%%
        % compute the number of bits embeded in a packet
        temp = ceil((cfgHT.PSDULength*8+16+6)/26);
        numSymForPsdu = 0;
        numSymForTailPad = 0;
        if mod(temp,2) == 1
            numSymForPsdu = (numel(tx)-720-15-80-80-80)/80;
            numSymForTailPad = 2;
        else
            numSymForPsdu = (numel(tx)-720-15-80-80)/80;
            numSymForTailPad = 1;
        end
        numTagData = numSymForPsdu; % modulate one tag data per one symbol
        
        % Initial tags data
        tagData = randi([0,1],numTagData-pLen,numTags);
        tagData = [ones(pLen,numTags);tagData];
        
        % Perform backscatter operation
        for tag_idx1 = 1:numTags
            bxSig{tag_idx1} = survey_FreeCollision_funcBackscatter(exSig(:,tag_idx1),tagData(:,tag_idx1),1);
        end
        
        H_Tags_RX = [];
        %%%%%** Tags-RX backscatter channel & AWGN **%%%%%
        for chan_tag_rx_idx1 = 1:numTags
            bx_coeff_TagRx_real = (-1+(1+1)*rand(1,1)).*0.01;
            bx_coeff_TagRx_imag = (-1+(1+1)*rand(1,1)).*0.01;
            bx_coeff_TagRx = bx_coeff_TagRx_real + 1i*bx_coeff_TagRx_imag;
            rece_Sig{chan_tag_rx_idx1} = bxSig{chan_tag_rx_idx1}.*bx_coeff_TagRx;
            H_Tags_RX = [H_Tags_RX,bx_coeff_TagRx];
        end
        actualH = H_TX_Tags.*H_Tags_RX;
        
        %%%%%***Backscatter Receiver side ***%%%%%
        rxSig = complex(zeros(length(rece_Sig{1}),1));
        for rx_idx1 = 1:numTags
            rxSig = rxSig + rece_Sig{rx_idx1};
        end
        [rxSig,~,~] = func_awgn(rxSig,snr(i),'measured');
        
        [ofdmDemodPilots,ofdmDemodData] = survey_FreeCollision_funcDemodOFDM(rxSig(ind.HTData(1):ind.HTData(2)),cfgHT,1);
        z = 3;
        pilots = wlan.internal.htPilots(numSymForPsdu+1+numSymForTailPad,z,cfgHT.ChannelBandwidth,1);
        pilots = complex(pilots);
        
        % WiFi Receiver
        [~,ofdmSymDerived] = survey_FreeCollision_funcOFDMSymDerived(txPSDU,cfgHT);
        [cfgOFDM,dataInd,pilotInd] = wlan.internal.wlanGetOFDMConfig(cfgHT.ChannelBandwidth, cfgHT.GuardInterval, 'HT', cfgHT.NumSpaceTimeStreams);
        ofdmDataDerived = ofdmSymDerived(cfgOFDM.DataIndices,:,:);
        ofdmPilotsDerived = ofdmSymDerived(cfgOFDM.PilotIndices,:,:);
        
        chanEst = survey_FreeCollision_funcGetLn(rxSig,cfgHT,ind,fs,n);
        chanEst_data = chanEst(dataInd);
        
        final_data = [];
        for rx_idx2 = 1:length(chanEst_data)
            tmp_L1 = chanEst_data(rx_idx2);
            tmp_Ym1 = ofdmDemodData(rx_idx2,:);
            tmp_Xm1 = ofdmDataDerived(rx_idx2,:);
            tmp_Y_1_m1 = tmp_Ym1./tmp_L1;
            %%% Estimate H^{T}1
            tmp_A = tmp_Y_1_m1(2:(1+pLen));
            tmp_B = tmp_Xm1(2:(1+pLen));
            tmp_H_real = funcLSEstimator(tmp_B(1,:)',real(tmp_A(1,:))');
            tmp_H_imag = funcLSEstimator(tmp_B(1,:)',imag(tmp_A(1,:))');
            tmp_est_H_T_1 = tmp_H_real + 1i*tmp_H_imag;
            %%% Compensate the channel estimation error
            tmp_Y_1_m1_L_1 = tmp_Y_1_m1./tmp_est_H_T_1; % The left part of Eq.(5)
            final_data = [final_data;tmp_Y_1_m1_L_1];
        end
        
        Q = [];
        for rx_idx3 = 2:(size(tagData,1)+1)
            tmp_A = final_data(:,rx_idx3);
            tmp_B = ofdmDataDerived(:,rx_idx3);
            tmp_H_real = funcLSEstimator(tmp_B,real(tmp_A));
            tmp_H_imag = funcLSEstimator(tmp_B,imag(tmp_A));
            tmp_est_q = tmp_H_real + 1i*tmp_H_imag;
            Q = [Q,tmp_est_q];
        end
        [clusterLabels,clusterCenters] = survey_FreeCollision_funcSymbolClustering(Q,power(2,numTags));
        complex_clusterCenters = clusterCenters(:,1) + 1i*clusterCenters(:,2);
        
        omega = (1-complex_clusterCenters)./2; % The next part of Eq.(6)
        
        % find normalized channel coefficients
        estBaseH = survey_FreeCollision_funcFindNormalizedChannelCoefficients(complex(1),omega,numTags);
        demodData = survey_FreeCollision_funcDemd(estBaseH,numTagData,Q,numTags);
            
        tmp_id = 1:numTags;
        for comm_idx1 = 1:numTags
            target_data = demodData(:,comm_idx1);
            tmp_errs = Inf(1,numTags);
            for comm_idx2 = 1:length(tmp_id)
                tmp_errs(tmp_id(comm_idx2)) = biterr(tagData(:,tmp_id(comm_idx2)),target_data);
            end
            [~,est_tagID] = min(tmp_errs);
            tmp_id(tmp_id==est_tagID) = [];
            numBitErrs(i,comm_idx1) = numBitErrs(i,comm_idx1) + biterr(tagData(:,est_tagID),demodData(:,comm_idx1));
        end
        n = n + 1;
    end
    for comm_idx3 = 1:numTags
        berEst(i,comm_idx3) = numBitErrs(i,comm_idx3)/(numTagData*maxNumPackets);
    end
    
end
aaa = 1;

