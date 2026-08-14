clc;
clear;
close all;
addpath(genpath(pwd));
rng(1993); % For repeatable results

%% BER
FreeCollision_B = [0.000204545454545455,0.000337121212121212];
FreeCollision_Q = [0.0167424242424242,0.0117424242424242,0.0159848484848485,0.0264393939393939];

ConcurScatter_B = [0,0.00357142857142857];
ConcurScatter_Q = [0.0187500000000000,0.0553571428571429];
ConcurScatter_8 = [0.169642857142857,0.241071428571429];


ParaFi_basic = [0.000150000000000000,0.000183035714285714];
ParaFi_enhanced = [5.00000000000000e-05,1.60714285714286e-05];

	

MultiRider = [0,8.92857142857143e-07];
Mecha = [1.60714285714286e-05,2.23214285714286e-05];


%% TP
k1 = 250;
k2 = 500;
k3 = 750;
TP_FreeCollision_B = (2-2*mean(FreeCollision_B)).*k1;
TP_FreeCollision_Q = (2-2*mean(FreeCollision_Q)).*k2;
TP_ParaFi_basic = (2-2*mean(ParaFi_basic)).*k1;
TP_ParaFi_enhanced = (2-2*mean(ParaFi_enhanced)).*k1;
TP_Mecha = (2-2*mean(Mecha)).*k1;
TP_MultiRider = (2-2*mean(MultiRider)).*k1;
TP_ConcurScatter_B = (2-2*mean(ConcurScatter_B)).*k1;
TP_ConcurScatter_Q = (2-2*mean(ConcurScatter_Q)).*k2;
TP_ConcurScatter_8 = (2-2*mean(ConcurScatter_8)).*k3;

vals_BER = [mean(FreeCollision_B),mean(FreeCollision_Q),mean(Mecha),mean(MultiRider),mean(ParaFi_basic),mean(ParaFi_enhanced),mean(ConcurScatter_B),mean(ConcurScatter_Q),mean(ConcurScatter_8)];

vals_TP = [TP_FreeCollision_B,TP_FreeCollision_Q,TP_Mecha,TP_MultiRider,TP_ParaFi_basic,TP_ParaFi_enhanced,TP_ConcurScatter_B,TP_ConcurScatter_Q,TP_ConcurScatter_8];


vals_BER(vals_BER == 0) = 1e-6;

colors = {[69/255 123/255 157/255],[202/255 55/255 83/255],[128/255 128/255 128/255],[153 153 204]./255,[132/255 165/255 157/255],[229,152,155]/255,[247,237,226]/255,[246,189,96]/255};
lineStyles = {'-','--','-.',':'};
lineMarker = {'square','o','^','pentagram','diamond','*','h','o','+','x'};
markersize = 8;
linewidth = 1.5;

x = 1:1:9;

%% Plot throughput
%%%** plot BER **%%%
figure(2)
set(gcf,'unit','centimeters','position',[3 5 40 10]);  
b2 = bar(x,vals_TP,0.5);
b2(1).FaceColor = [69/255 123/255 157/255];
ax2 = gca;
ax2.FontSize = 10;
ax2.FontName = 'Times New Roman';
ax2.XTickLabel = {'FreeCollision-BPSK','FreeCollision-QPSK','Mecha','MultiRider','ParaFi-Basic','ParaFi-Enhanced','ConcurScatter-BPSK','ConcurScatter-QPSK','ConcurScatter-8PSK'};
ax2.YLim = [200 1250];
grid on
ylabel('Throughput (Kbps)','FontSize',12,'FontName','Times New Roman');
xlabel('Configurations','FontSize',12,'FontName','Times New Roman');
set(gcf,'PaperType','a4');
set(gcf,'PaperOrientation','landscape');
print(gcf,'TP.pdf','-dpdf','-bestfit');




