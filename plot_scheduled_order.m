clear;
clc;
close all;
x = 1:8;


File11 = cell2mat(struct2cell(load('Atlantis results/sched_1_FCFS_120khz.mat')));
File21 = cell2mat(struct2cell(load('Atlantis results/sched_2_FCFS_120khz.mat')));
File31 = cell2mat(struct2cell(load('Atlantis results/sched_3_FCFS_120khz.mat')));
File41 = cell2mat(struct2cell(load('Atlantis results/sched_4_FCFS_120khz.mat')));
File51 = cell2mat(struct2cell(load('Atlantis results/sched_5_FCFS_120khz.mat')));
File61 = cell2mat(struct2cell(load('Atlantis results/sched_6_FCFS_120khz.mat')));
File71 = cell2mat(struct2cell(load('Atlantis results/sched_7_FCFS_120khz.mat')));
File81 = cell2mat(struct2cell(load('Atlantis results/sched_8_FCFS_120khz.mat')));

File_1 = {File11, File21, File31, File41, File51, File61, File71, File81};

File1a1 = cell2mat(struct2cell(load('Atlantis results/sched_1_WT_120khz_a1.mat')));
File1a2 = cell2mat(struct2cell(load('Atlantis results/sched_1_WT_120khz_a2.mat')));
File1a3 = cell2mat(struct2cell(load('Atlantis results/sched_1_WT_120khz_a3.mat')));

File2a1 = cell2mat(struct2cell(load('Atlantis results/sched_2_WT_120khz_a1.mat')));
File2a2 = cell2mat(struct2cell(load('Atlantis results/sched_2_WT_120khz_a2.mat')));
File2a3 = cell2mat(struct2cell(load('Atlantis results/sched_2_WT_120khz_a3.mat')));

File3a1 = cell2mat(struct2cell(load('Atlantis results/sched_3_WT_120khz_a1.mat')));
File3a2 = cell2mat(struct2cell(load('Atlantis results/sched_3_WT_120khz_a2.mat')));
File3a3 = cell2mat(struct2cell(load('Atlantis results/sched_3_WT_120khz_a3.mat')));

File4a1 = cell2mat(struct2cell(load('Atlantis results/sched_4_WT_120khz_a1.mat')));
File4a2 = cell2mat(struct2cell(load('Atlantis results/sched_4_WT_120khz_a2.mat')));
File4a3 = cell2mat(struct2cell(load('Atlantis results/sched_4_WT_120khz_a3.mat')));

File5a1 = cell2mat(struct2cell(load('Atlantis results/sched_5_WT_120khz_a1.mat')));
File5a2 = cell2mat(struct2cell(load('Atlantis results/sched_5_WT_120khz_a2.mat')));
File5a3 = cell2mat(struct2cell(load('Atlantis results/sched_5_WT_120khz_a3.mat')));

File6a1 = cell2mat(struct2cell(load('Atlantis results/sched_6_WT_120khz_a1.mat')));
File6a2 = cell2mat(struct2cell(load('Atlantis results/sched_6_WT_120khz_a2.mat')));
File6a3 = cell2mat(struct2cell(load('Atlantis results/sched_6_WT_120khz_a3.mat')));

File7a1 = cell2mat(struct2cell(load('Atlantis results/sched_7_WT_120khz_a1.mat')));
File7a2 = cell2mat(struct2cell(load('Atlantis results/sched_7_WT_120khz_a2.mat')));
File7a3 = cell2mat(struct2cell(load('Atlantis results/sched_7_WT_120khz_a3.mat')));

File8a1 = cell2mat(struct2cell(load('Atlantis results/sched_8_WT_120khz_a1.mat')));
File8a2 = cell2mat(struct2cell(load('Atlantis results/sched_8_WT_120khz_a2.mat')));
File8a3 = cell2mat(struct2cell(load('Atlantis results/sched_8_WT_120khz_a3.mat')));


File_a1 = {File1a1, File2a1, File3a1, File4a1, File5a1, File6a1, File7a1, File8a1};
File_a2 = {File1a2, File2a2, File3a2, File4a2, File5a2, File6a2, File7a2, File8a2};
File_a3 = {File1a3, File2a3, File3a3, File4a3, File5a3, File6a3, File7a3, File8a3};



throughput_1 = {0,0,0,0,0,0,0,0};
dropped_throughput_1 = {0,0,0,0,0,0,0,0};
deadline_violation_1 = {0,0,0,0,0,0,0,0};
for j = 1:8
    for i = 1:length(File_1{j})
        if File_1{j}(i,6) < File_1{j}(i,5)
            throughput_1{j} = File_1{j}(i,4) + throughput_1{j};
        else
            dropped_throughput_1{j} = File_1{j}(i,4) + dropped_throughput_1{j};
        end  

%         if File_1{j}(i,6) > File_1{j}(i,5)
%             deadline_violation_1{j} = 1 + deadline_violation_1{j};
%         end    

    end
end    


throughput_a1 = {0,0,0,0,0,0,0,0};
dropped_throughput_a1 = {0,0,0,0,0,0,0,0};
deadline_violation_a1 = {0,0,0,0,0,0,0,0};
for j = 1:8
    for i = 1:length(File_a1{j})
        if File_a1{j}(i,6) < File_a1{j}(i,5)
            throughput_a1{j} = File_a1{j}(i,4) + throughput_a1{j};
        else
            dropped_throughput_a1{j} = File_a1{j}(i,4) + dropped_throughput_a1{j};
        end    
%         
%         if File_1{j}(i,6) > File_1{j}(i,5)
%             deadline_violation_a1{j} = 1 + deadline_violation_a1{j};
%         end    
    end
end  

throughput_a2 = {0,0,0,0,0,0,0,0};
dropped_throughput_a2 = {0,0,0,0,0,0,0,0};
deadline_violation_a2 = {0,0,0,0,0,0,0,0};
for j = 1:8
    for i = 1:length(File_a2{j})
        if File_a2{j}(i,6) < File_a2{j}(i,5)
            throughput_a2{j} = File_a2{j}(i,4) + throughput_a2{j};
        else
            dropped_throughput_a2{j} = File_a2{j}(i,4) + dropped_throughput_a2{j};
        end    
%         
%         if File_1{j}(i,6) > File_1{j}(i,5)
%             deadline_violation_a2{j} = 1 + deadline_violation_a2{j};
%         end    
    end
end  

throughput_a3 = {0,0,0,0,0,0,0,0};
dropped_throughput_a3 = {0,0,0,0,0,0,0,0};
deadline_violation_a3 = {0,0,0,0,0,0,0,0};
for j = 1:8
    for i = 1:length(File_a3{j})
        if File_a3{j}(i,6) < File_a3{j}(i,5)
            throughput_a3{j} = File_a3{j}(i,4) + throughput_a3{j};
        else
            dropped_throughput_a3{j} = File_a3{j}(i,4) + dropped_throughput_a3{j};
        end    
%         
%         if File_1{j}(i,6) > File_1{j}(i,5)
%             deadline_violation_a3{j} = 1 + deadline_violation_a3{j};
%         end    
    end
end  

%sched = 1000*[cell2mat(struct2cell(File11)), cell2mat(struct2cell(File21)), cell2mat(struct2cell(File31)), cell2mat(struct2cell(File41)), cell2mat(struct2cell(File51)), cell2mat(struct2cell(File61)), cell2mat(struct2cell(File71)), cell2mat(struct2cell(File81))];
%sched_ = 1000*sched_;
throughput_1 = cell2mat(throughput_1);
throughput_a1 = cell2mat(throughput_a1);
throughput_a2 = cell2mat(throughput_a2);
throughput_a3 = cell2mat(throughput_a3);
%sched__a1 = 1000*[cell2mat(struct2cell(File1a1)), cell2mat(struct2cell(File2a1)), cell2mat(struct2cell(File3a1)), cell2mat(struct2cell(File4a1)), cell2mat(struct2cell(File5a1)), cell2mat(struct2cell(File6a1)), cell2mat(struct2cell(File7a1)), cell2mat(struct2cell(File8a1))];
%sched__a2 = 1000*[cell2mat(struct2cell(File1a2)), cell2mat(struct2cell(File2a2)), cell2mat(struct2cell(File3a2)), cell2mat(struct2cell(File4a2)), cell2mat(struct2cell(File5a2)), cell2mat(struct2cell(File6a2)), cell2mat(struct2cell(File7a2)), cell2mat(struct2cell(File8a2))];
%sched__a3 = 1000*[cell2mat(struct2cell(File1a3)), cell2mat(struct2cell(File2a3)), cell2mat(struct2cell(File3a3)), cell2mat(struct2cell(File4a3)), cell2mat(struct2cell(File5a3)), cell2mat(struct2cell(File6a3)), cell2mat(struct2cell(File7a3)), cell2mat(struct2cell(File8a3))];
bar(throughput_1);
hold on;
bar(throughput_1);
hold on;
bar(throughput_a1);
hold on;
bar(throughput_a2);
hold on;
bar(throughput_a3);
% plot(x,(sched_), 'LineWidth', 2);
% hold on;
% plot(x,(sched_), 'LineWidth', 2);
% hold on;
% plot(x,(sched__a1 ), 'LineWidth', 2);
% hold on;
% plot(x,(sched__a2 ), 'LineWidth', 2);
% hold on;
% plot(x,(sched__a3 ), 'LineWidth', 2);
% grid on;
 legend('FCFS', 'EDF', 'WT \alpha = 1', 'WT \alpha = 2', 'WT \alpha = 3');
% title('Average System time for SCS=120KHz/Time slots=0.0125ms')
% xlabel('Number of users');
% ylabel('Average System Time (ms)');