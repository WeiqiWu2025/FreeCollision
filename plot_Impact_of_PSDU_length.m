clc;
clear;
close all;
addpath(genpath(pwd));
rng(1993); % For repeatable results

%% BER record
FreeeCollision_threeTags_Tag1 = [0.124300000000000;0.00961666666666667;0.00288043478260870;0.00182894736842105;0.00293954248366013;0.00713695652173913;0.0111213355048860;0.0167912147505423];
FreeeCollision_threeTags_Tag2 = [0.100933333333333;0.0117333333333333;0.00335869565217391;0.00329605263157895;0.00396405228758170;0.00780434782608696;0.0101881107491857;0.0221176789587853];
FreeeCollision_threeTags_Tag3 = [0.210950000000000;0.0215750000000000;0.00523913043478261;0.00455263157894737;0.00560947712418301;0.0113880434782609;0.0147573289902280;0.0318975054229935];

MultiRider_threeTags_Tag1 = [NaN;NaN;0;0;0;0;0;0.000203016241299304];
MultiRider_threeTags_Tag2 = [NaN;NaN;0.000343750000000000;0.000304347826086957;0.000205284552845528;0.000198750000000000;9.83754512635379e-05;0.000530742459396752];
MultiRider_threeTags_Tag3 = [NaN;NaN;0.000578125000000000;0.000646739130434783;0.000583333333333333;0.000671250000000000;0.000607400722021661;0.000933874709976798];

ParaFi_threeTags_Tag1 = [NaN;NaN;0.00267187500000000;0.00315217391304348;0.00506300813008130;0.00512875000000000;0.00672472924187726;0.00826624129930395];
ParaFi_threeTags_Tag2 = [NaN;NaN;0.00178125000000000;0.00410326086956522;0.00410772357723577;0.00555125000000000;0.00605685920577617;0.00887064965197216];
ParaFi_threeTags_Tag3 = [NaN;NaN;0.00264062500000000;0.00274456521739130;0.00463414634146341;0.00523000000000000;0.00555415162454874;0.00797563805104408];

ConcurScatter_threeTags_Tag1 = [0.502650000000000;0.497575000000000;0.499538043478261;0.499750000000000;0.498366013071895;0.499695652173913;0.498841205211726;0.501467462039046];
ConcurScatter_threeTags_Tag2 = [0.502333333333333;0.498550000000000;0.500027173913044;0.499197368421053;0.500457516339869;0.500926086956522;0.500802931596091;0.501924078091106];
ConcurScatter_threeTags_Tag3 = [0.498300000000000;0.497158333333333;0.497918478260870;0.498375000000000;0.499838235294118;0.499757608695652;0.498982899022801;0.499648047722343];

Mecha_threeTags_Tag1 = [NaN;NaN;0.000390625000000000;0.000347826086956522;0.000201219512195122;0.000470000000000000;0.000863718411552347;0.00192575406032483];
Mecha_threeTags_Tag2 = [NaN;NaN;0.000140625000000000;0.000592391304347826;0.000254065040650407;0.000237500000000000;0.00104602888086643;0.00129582366589327];
Mecha_threeTags_Tag3 = [NaN;NaN;0.000109375000000000;0.000217391304347826;0.000493902439024390;0.000757500000000000;0.000740072202166065;0.00169257540603248];



%% BER
FreeeCollision_threeTags = (FreeeCollision_threeTags_Tag1 + FreeeCollision_threeTags_Tag2 + FreeeCollision_threeTags_Tag3)./3;
MultiRider_threeTags = (MultiRider_threeTags_Tag1 + MultiRider_threeTags_Tag2 + MultiRider_threeTags_Tag3)./3;
ParaFi_threeTags = (ParaFi_threeTags_Tag1 + ParaFi_threeTags_Tag2 + ParaFi_threeTags_Tag3)./3;
ConcurScatter_threeTags = (ConcurScatter_threeTags_Tag1 + ConcurScatter_threeTags_Tag2 + ConcurScatter_threeTags_Tag3)./3;
Mecha_threeTags = (Mecha_threeTags_Tag1 + Mecha_threeTags_Tag2 + Mecha_threeTags_Tag3)./3;



%% plot BER
vals_BER = [FreeeCollision_threeTags,Mecha_threeTags,MultiRider_threeTags,ParaFi_threeTags,ConcurScatter_threeTags];

colors = {[69/255 123/255 157/255],[202/255 55/255 83/255],[128/255 128/255 128/255],[153 153 204]./255,[132/255 165/255 157/255],[229,152,155]/255,[247,237,226]/255,[246,189,96]/255};
lineStyles = {'-','--','-.',':'};
lineMarker = {'square','o','^','pentagram','diamond','*','h','o','+','x'};
markersize = 8;
linewidth = 1.5;

x =1:1:8;

%%%** plot BER **%%%
figure(1)
plot(x,vals_BER(:,1),'Marker',lineMarker{1},'MarkerSize',markersize,'LineWidth',linewidth,'color',colors{1},'MarkerFaceColor',colors{1});
grid on
set(gcf,'unit','centimeters','position',[3 5 19.5 7]);
ax = gca;
ax.FontSize = 14;
ax.FontName = 'Times New Roman';
ax.YScale = 'log';
ax.XTickLabel = {'100','200','300','500','1000','1500','2000','3000'};
ylabel('BER','FontSize',14,'FontName','Times New Roman');
xlabel('PSDU length (bytes)','FontSize',14,'FontName','Times New Roman');
hold on
plot(x,vals_BER(:,2),'Marker',lineMarker{2},'MarkerSize',markersize,'LineWidth',linewidth,'color',colors{2},'MarkerFaceColor',colors{2});
hold on
plot(x,vals_BER(:,3),'Marker',lineMarker{3},'MarkerSize',markersize,'LineWidth',linewidth,'color',colors{3},'MarkerFaceColor',colors{3});
hold on
plot(x,vals_BER(:,4),'Marker',lineMarker{4},'MarkerSize',markersize,'LineWidth',linewidth,'color',colors{4},'MarkerFaceColor',colors{4});
hold on
plot(x,vals_BER(:,5),'Marker',lineMarker{5},'MarkerSize',markersize,'LineWidth',linewidth,'color',colors{5},'MarkerFaceColor',colors{5});
ax.XLim = [1 7];
ax.YLim = [1e-5 1e0];
ax.YTick = [1e-6,1e-4,1e-2,1e0];
lgd = legend('FreeCollision','Mecha','MultiRider','ParaFi','ConcurScatter',...
    'FontSize',12,'FontName','Times New Roman','NumColumns',5,'Interpreter','latex');
lgd.Location = 'northoutside'; 