function [] = plot_weighted_throughput(results)
[data_point_length, number_of_runs] = size(results);
dataPoints = 1:1:data_point_length;

p=norminv([0.05 0.95],0,1);
errorbars = true;

weigthed_throughput = zeros(1,data_point_length);
std_dev = zeros(1,data_point_length);

styleGraphs = {'-','--', ':', '-.'};
styleNames = {'*','o','s'};
styleColors = [204 102 0;0, 204, 0;0 128 255]./255;

for n = 1:data_point_length
    temp_all_results = [];
    for sim_instance = 1:number_of_runs
        temp_all_results = [temp_all_results results{n,sim_instance}.val];
    end
    weigthed_throughput(n) = mean(temp_all_results);
    std_dev(n) = std(temp_all_results);
end
std_err = std_dev./sqrt(number_of_runs);

figure
if(errorbars)
    errorbar(dataPoints,weigthed_throughput,std_err.*p(2),strcat(styleGraphs{1},styleNames{1}),'LineWidth',1.5,'MarkerSize',8,'Color',styleColors(1,:))
else
    plot(dataPoints,weigthed_throughput,strcat(styleGraphs{1},styleNames{1}),'LineWidth',1.5,'MarkerSize',8,'Color',styleColors(1,:))
    hold on    
end
xlabel('Number of UEs')
ylabel('Weighted throughput')
legend('Optimal')
grid on

end