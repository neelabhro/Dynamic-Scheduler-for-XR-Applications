%function [] = plot_system_time_SCS(results1, results2, results3)

% algos = {'edf_alpha1', 'edf_alpha2', 'edf_alpha3'};
% %algos = {'bipartite_matching', 'maximum_weight' 'fcfs_sj'};
% 
% legend_names = {'#Users = 5', '#Users = 10', '#Users = 15', '#Users = 20'};
% %legend_names = {'MWBM', 'Maximum Weight' 'FCFS'};
% [data_point_length, ~] = size(results.(algos{2}));
clc;
close all;
legend_names = {'TS = 0.25ms / SCS = 60KHz', 'TS = 0.125ms / SCS = 120KHz', 'TS = 0.0625ms / SCS = 240KHz'};
results.minumumSL = load('Thesis_Data/point625ms.mat');
results.minumumSL = results.minumumSL.results_system_time.max_weight;

results.mediumSL = load('Thesis_Data/125ms.mat');
results.mediumSL = results.mediumSL.results_system_time.max_weight;

results.maximumSL = load('Thesis_Data/25ms.mat');
results.maximumSL = results.maximumSL.results_system_time.max_weight;

algos = {'minumumSL', 'mediumSL', 'maximumSL'};
[data_point_length, number_of_runs] = size(results.(algos{2}));
dataPoints = 1:2:data_point_length*2;

p=norminv([0.05 0.95],0,1);
errorbars = true;

weigthed_throughput = zeros(1,data_point_length);
std_dev = zeros(1,data_point_length);


styleGraphs = {'-','--', ':', '-.', ':'};
styleNames = {'*','o','s', 'd', 'x'};
styleColors = [204 102 0; 0 204 0; 0 128 255; 128 0 255; 0 255 128 ]./255;
algo_index = [1,2,3];
figure

h=[];
index=1;
min_ax=[];
max_ax=[];

for algo = 1:length(algo_index)
    
    i = algo_index(algo);
    h_algo = plot(-1,-1,['k' strcat(styleGraphs{1},styleNames{algo_index(algo)})],'Color',styleColors(algo,:));
    %hi = semilogy(-1,-1,style_names{i});
    hold on
    h(algo) = h_algo;
    
    for n = 1:data_point_length
        temp_all_results.(algos{algo_index(algo)}) = [];
        for sim_instance = 1:number_of_runs
            temp_all_results.(algos{algo_index(algo)}) = [temp_all_results.(algos{algo_index(algo)}) results.(algos{algo_index(algo)}){n,sim_instance}.val];
        end
        weigthed_throughput(n) = mean(temp_all_results.(algos{algo_index(algo)}));
        std_dev(n) = std(temp_all_results.(algos{algo_index(algo)}));
    end
    std_err = std_dev./sqrt(number_of_runs);
    
    
    if(errorbars)
        hp_1 = errorbar(dataPoints,weigthed_throughput,std_err.*p(2),strcat(styleGraphs{1},styleNames{algo_index(algo)}),'LineWidth',1.5,'MarkerSize',8,'Color',styleColors(algo,:));
        %errorbar(dataPoints,weigthed_throughput,std_err.*p(2),strcat(styleGraphs{1},styleNames{algo_index(algo)}),'LineWidth',1.5,'MarkerSize',8,'Color',styleColors(algo,:))
        hold on
    else
        hp_1 = plot(dataPoints,weigthed_throughput,strcat(styleGraphs{1},styleNames{algo_index(algo)}),'LineWidth',1.5,'MarkerSize',8,'Color',styleColors(algo,:));
        %plot(dataPoints,weigthed_throughput,strcat(styleGraphs{1},styleNames{algo_index(algo)}),'LineWidth',1.5,'MarkerSize',8,'Color',styleColors(algo,:))
        hold on
    end
    
    min_ax=[min_ax min(get(hp_1,'YData'))];
    max_ax=[max_ax max(get(hp_1,'YData'))];
    index=index+1;
end

aghsnd=legend(h',legend_names{algo_index});
grid on

xlabel('Number of Users')
ylabel('Average system time (ms)')
axis([1 20 1 15]);
%aghsnd=legend(h',legend_names{algo_index});
%legend('MWBM', 'EDF-\alpha(3)', 'Max Weight', 'FCFS', 'EDF');
grid on

%end