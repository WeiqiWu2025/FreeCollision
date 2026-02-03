clc; 
clear; 
close all;
addpath(genpath(pwd)); 
rng(1993); % For repeatable results

BER_ConcurScatter_TGn_and_noise = [0.484162052117264,0.516014657980456,0.487793159609121];
BER_ConcurScatter_noise = [0.00108550488599349,0.000649022801302932,0.00101628664495114];
BER_ConcurScatter_channel = [0.502822475570033,0.487686482084691,0.494304560260586];


%% BER
BER_ConcurScatter_TGn_noise = mean(BER_ConcurScatter_TGn_and_noise);
BER_ConcurScatter_only_noise = mean(BER_ConcurScatter_noise);
BER_ConcurScatter_channel_noise = mean(BER_ConcurScatter_channel);

%% plot
vals_BER = [BER_ConcurScatter_channel_noise;BER_ConcurScatter_only_noise;BER_ConcurScatter_TGn_noise;];

colors = {[69,123,157]/255,[132,165,157]/255,[246,189,96]/255,[229,152,155]/255,[202,55,83]/255,[247,237,226]/255,[128,128,128]/255};
lineStyles = {'-','--','-.',':'};
lineMarker = {'*','h','o','+','x'};
markersize = 8;
linewidth = 2;


x =1:1:3;
%%%** plot BER **%%%
figure(1)
set(gcf,'unit','centimeters','position',[3 5 16 6]); 
b1 = bar(x,vals_BER,0.3);
b1(1).FaceColor = [132/255 165/255 157/255];
ax1 = gca;
ax1.FontSize = 12;
ax1.FontName = 'Times New Roman';
ax1.YLim = [5e-4 1e0];
ax1.YTick = [1e-4,1e-3,1e-2, 1e-1, 1e0];
ax1.YScale = 'log';
ax1.XTickLabel = {'model 1','model 2','model 3'};
grid on
ylabel('BER','FontSize',14,'FontName','Times New Roman');
xlabel('Channel model','FontSize',14,'FontName','Times New Roman');