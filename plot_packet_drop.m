clear;
clc;
%close all;
x = 1:8;

packet_a_OPT = [2556	5280	8625	12427	16351	20533	25619	30444];
packet_a_OPTd = [2556	5280	8625	12414	16335	18648	21437	21438];

packet_a_1 = [2582	5184	8651	12264	16380	20533	25586	30386];
packet_a_1D = [2582	5184	8651	12264	16350	18712	21413	21424];

packet_a_3 = [2556	5210	8689	12415	16513	20641	25452	30381];
packet_a_3D = [2556	5210	8689	12399	16481	18757	21272	21407];

packet_FCFS = [2556	5280	8759	12345	16334	20548	25549	30288];
packet_FCFSd = [2556	5280	8759	12311	16279	18650	21324	21344];

packet_EDF = [2582	5184	8689	12415	16351	20512	25637	30303];
packet_EDFd = [2582	5184	8689	12409	16328	18694	21459	21368];

packet_RR = [2556	5159	7803	12286	16546	20352	24649	28722];
packet_RRd = [2556	5159	6724	10445	12404	13354	16538	16828];

packet_a_OPT_drop = 100*(packet_a_OPT - packet_a_OPTd)./packet_a_OPT;
packet_a_1_drop = 100*(packet_a_1 - packet_a_1D)./packet_a_1;
packet_a_3_drop = 100*(packet_a_3 - packet_a_3D)./packet_a_3;

packet_a_OPT_drop = 100*(packet_a_OPTd)./packet_a_OPT;
packet_a_1_drop = 100*(packet_a_1D)./packet_a_1;
packet_a_3_drop = 100*(packet_a_3D)./packet_a_3;
packet_FCFS_drop = 100*(packet_FCFSd)./packet_FCFS;
packet_EDF_drop = 100*(packet_EDFd)./packet_EDF;
packet_RR_drop = 100*(packet_RRd)./packet_RR;


plot(x, packet_a_OPT_drop, 'LineWidth', 2);
hold on;
plot(x, packet_a_1_drop, 'LineWidth', 2);
hold on;
plot(x, packet_a_3_drop, 'LineWidth', 2);
hold on;
plot(x, packet_FCFS_drop, 'LineWidth', 2);
hold on;
plot(x, packet_RR_drop, 'LineWidth', 2);
hold on;
plot(x, packet_EDF_drop, 'LineWidth',2);
legend('WT \alpha = optimum(2.732)', 'WT \alpha = 1', 'WT \alpha = 3', 'FCFS', 'RR', 'EDF');
title('Packet delivery rate vs # of Users being served');
xlabel('Number of users being served');
ylabel('Packet Delivery %age')