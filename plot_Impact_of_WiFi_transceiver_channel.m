clc;
clear;
close all;
addpath(genpath(pwd));
rng(1993); % For repeatable results


%% BER record
FreeCollision_high_threeTags = [0.000748484848484849,0.000877777777777778,0.00146616161616162];
FreeCollision_medium_threeTags = [0.0767404040404040,0.0820025252525253,0.0951068181818182];
FreeCollision_low_threeTags = [0.596337121212121,0.608497474747475,0.631094949494950];

ParaFi_high_threeTags = [7.57246376811594e-05,8.00724637681159e-05,8.44202898550725e-05];
ParaFi_medium_threeTags = [7.57246376811594e-05,8.00724637681159e-05,8.44202898550725e-05];
ParaFi_low_threeTags = [7.57246376811594e-05,8.00724637681159e-05,8.44202898550725e-05];

Mecha_high_threeTags = [3.69565217391304e-05,3.22463768115942e-05,7.60869565217391e-05];
Mecha_medium_threeTags = [0.0189630434782609,0.0187394927536232,0.0192003623188406];
Mecha_low_threeTags = [0.248703623188406,0.249648550724638,0.249917391304348];

MultiRider_high_threeTags = [0,7.24637681159420e-06,1.37681159420290e-05];
MultiRider_medium_threeTags = [0.0421800724637681,0.0468634057971015,0.0503608695652174];
MultiRider_low_threeTags = [0.546541666666667,0.550737318840580,0.553721376811594];

ConcurScatter_high_threeTags = [0.500062719298246,0.499025438596491,0.500203508771930];
ConcurScatter_medium_threeTags = [0.500267982456140,0.499270833333333,0.499888377192982];
ConcurScatter_low_threeTags = [0.566389035087719,0.566602631578947,0.567146929824561];


FreeCollision_threeTags = [mean(FreeCollision_low_threeTags);mean(FreeCollision_medium_threeTags);mean(FreeCollision_high_threeTags)];
MultiRider_threeTags = [mean(MultiRider_low_threeTags);mean(MultiRider_medium_threeTags);mean(MultiRider_high_threeTags)];
Mecha_threeTags = [mean(Mecha_low_threeTags);mean(Mecha_medium_threeTags);mean(Mecha_high_threeTags)];
ConcurScatter_threeTags = [mean(ConcurScatter_low_threeTags);mean(ConcurScatter_medium_threeTags);mean(ConcurScatter_high_threeTags)];
ParaFi_threeTags = [mean(ParaFi_low_threeTags);mean(ParaFi_medium_threeTags);mean(ParaFi_high_threeTags)];

%% BER
vals_BER = [FreeCollision_threeTags,Mecha_threeTags,MultiRider_threeTags,ParaFi_threeTags,ConcurScatter_threeTags];

x = 1:1:3;
%%%** plot BER **%%%
figure(1)
set(gcf,'unit','centimeters','position',[3 5 19.5 7]); 
b1 = bar(x,vals_BER);
b1(1).FaceColor = [69/255 123/255 157/255];
b1(2).FaceColor = [202/255 55/255 83/255];
b1(3).FaceColor =  [128/255 128/255 128/255];
b1(4).FaceColor = [153 153 204]./255;
b1(5).FaceColor = [132/255 165/255 157/255];
ax1 = gca;
ax1.FontSize = 14;
ax1.FontName = 'Times New Roman';

ax1.YLim = [1e-7 1e0];
ax1.YTick = [1e-6,1e-4,1e-2,1e0];
ax1.YScale = 'log';
ax1.XTickLabel = {'low quality','medium quality','high quality'};
grid on
ylabel('BER','FontSize',14,'FontName','Times New Roman');
xlabel('WiFi transceiver channel','FontSize',14,'FontName','Times New Roman');
lgd = legend('FreeCollision','Mecha','MultiRider','ParaFi','ConcurScatter',...
    'FontSize',12,'FontName','Times New Roman','NumColumns',5,'Interpreter','latex');
lgd.Location = 'northoutside'; 