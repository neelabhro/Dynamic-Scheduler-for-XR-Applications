clear;
clc;
close all;
x = 1:8;


File11 = cell2mat(struct2cell(load('Atlantis results/sched_1_FCFS_120khz.mat')));
File21 = cell2mat(struct2cell(load('Atlantis results/sched_2_FCFS_120khz.mat')));
File31 = cell2mat(struct2cell(load('Atlantis results/sched_3_FCFS_120khz.mat')));
File41 = cell2mat(struct2cell(load('Atlantis results/sched_4_FCFS_120khzD.mat')));
File51 = cell2mat(struct2cell(load('Atlantis results/sched_5_FCFS_120khzD.mat')));
File61 = cell2mat(struct2cell(load('Atlantis results/sched_6_FCFS_120khzD.mat')));
File71 = cell2mat(struct2cell(load('Atlantis results/sched_7_FCFS_120khzD.mat')));
File81 = cell2mat(struct2cell(load('Atlantis results/sched_8_FCFS_120khzD.mat')));

File_1 = {File11, File21, File31, File41, File51, File61, File71, File81};


FileEDF1 = cell2mat(struct2cell(load('Atlantis results/sched_1_EDF_120khz.mat')));
FileEDF2 = cell2mat(struct2cell(load('Atlantis results/sched_2_EDF_120khz.mat')));
FileEDF3 = cell2mat(struct2cell(load('Atlantis results/sched_3_EDF_120khzD.mat')));
FileEDF4 = cell2mat(struct2cell(load('Atlantis results/sched_4_EDF_120khzD.mat')));
FileEDF5 = cell2mat(struct2cell(load('Atlantis results/sched_5_EDF_120khzD.mat')));
FileEDF6 = cell2mat(struct2cell(load('Atlantis results/sched_6_EDF_120khzD.mat')));
FileEDF7 = cell2mat(struct2cell(load('Atlantis results/sched_7_EDF_120khzD.mat')));
FileEDF8 = cell2mat(struct2cell(load('Atlantis results/sched_8_EDF_120khzD.mat')));

File_EDF = {FileEDF1, FileEDF2, FileEDF3, FileEDF4, FileEDF5, FileEDF6, FileEDF7, FileEDF8};

FileRR1 = cell2mat(struct2cell(load('Atlantis results/sched_1_FCFS_120khz.mat')));
FileRR2 = cell2mat(struct2cell(load('Atlantis results/sched_2_RR_120khz.mat')));
FileRR3 = cell2mat(struct2cell(load('Atlantis results/sched_3_RR_120khzD.mat')));
FileRR4 = cell2mat(struct2cell(load('Atlantis results/sched_4_RR_120khzD.mat')));
FileRR5 = cell2mat(struct2cell(load('Atlantis results/sched_5_RR_120khzD.mat')));
FileRR6 = cell2mat(struct2cell(load('Atlantis results/sched_6_RR_120khzD.mat')));
FileRR7 = cell2mat(struct2cell(load('Atlantis results/sched_7_RR_120khzD.mat')));
FileRR8 = cell2mat(struct2cell(load('Atlantis results/sched_8_RR_120khzD.mat')));

File_RR = {FileRR1, FileRR2, FileRR3, FileRR4, FileRR5, FileRR6, FileRR7, FileRR8};

File1aOPT = cell2mat(struct2cell(load('Atlantis results/sched_1_WT_120khz_aOPTd.mat')));
File1a1 = cell2mat(struct2cell(load('Atlantis results/sched_1_WT_120khz_a1.mat')));
File1a2 = cell2mat(struct2cell(load('Atlantis results/sched_1_WT_120khz_a2.mat')));
File1a3 = cell2mat(struct2cell(load('Atlantis results/sched_1_WT_120khz_a3D.mat')));

File2aOPT = cell2mat(struct2cell(load('Atlantis results/sched_2_WT_120khz_aOPTd.mat')));
File2a1 = cell2mat(struct2cell(load('Atlantis results/sched_2_WT_120khz_a1D.mat')));
File2a2 = cell2mat(struct2cell(load('Atlantis results/sched_2_WT_120khz_a2.mat')));
File2a3 = cell2mat(struct2cell(load('Atlantis results/sched_2_WT_120khz_a3D.mat')));

File3aOPT = cell2mat(struct2cell(load('Atlantis results/sched_3_WT_120khz_aOPTd.mat')));
File3a1 = cell2mat(struct2cell(load('Atlantis results/sched_3_WT_120khz_a1D.mat')));
File3a2 = cell2mat(struct2cell(load('Atlantis results/sched_3_WT_120khz_a2.mat')));
File3a3 = cell2mat(struct2cell(load('Atlantis results/sched_3_WT_120khz_a3D.mat')));

File4aOPT = cell2mat(struct2cell(load('Atlantis results/sched_4_WT_120khz_aOPTd.mat')));
File4a1 = cell2mat(struct2cell(load('Atlantis results/sched_4_WT_120khz_a1D.mat')));
File4a2 = cell2mat(struct2cell(load('Atlantis results/sched_4_WT_120khz_a2.mat')));
File4a3 = cell2mat(struct2cell(load('Atlantis results/sched_4_WT_120khz_a3D.mat')));

File5aOPT = cell2mat(struct2cell(load('Atlantis results/sched_5_WT_120khz_aOPTd.mat')));
File5a1 = cell2mat(struct2cell(load('Atlantis results/sched_5_WT_120khz_a1D.mat')));
File5a2 = cell2mat(struct2cell(load('Atlantis results/sched_5_WT_120khz_a2.mat')));
File5a3 = cell2mat(struct2cell(load('Atlantis results/sched_5_WT_120khz_a3D.mat')));

File6aOPT = cell2mat(struct2cell(load('Atlantis results/sched_6_WT_120khz_aOPTd.mat')));
File6a1 = cell2mat(struct2cell(load('Atlantis results/sched_6_WT_120khz_a1D.mat')));
File6a2 = cell2mat(struct2cell(load('Atlantis results/sched_6_WT_120khz_a2.mat')));
File6a3 = cell2mat(struct2cell(load('Atlantis results/sched_6_WT_120khz_a3D.mat')));

File7aOPT = cell2mat(struct2cell(load('Atlantis results/sched_7_WT_120khz_aOPTd.mat')));
File7a1 = cell2mat(struct2cell(load('Atlantis results/sched_7_WT_120khz_a1D.mat')));
File7a2 = cell2mat(struct2cell(load('Atlantis results/sched_7_WT_120khz_a2.mat')));
File7a3 = cell2mat(struct2cell(load('Atlantis results/sched_7_WT_120khz_a3D.mat')));

File8aOPT = cell2mat(struct2cell(load('Atlantis results/sched_8_WT_120khz_aOPTd.mat')));
File8a1 = cell2mat(struct2cell(load('Atlantis results/sched_8_WT_120khz_a1D.mat')));
File8a2 = cell2mat(struct2cell(load('Atlantis results/sched_8_WT_120khz_a2.mat')));
File8a3 = cell2mat(struct2cell(load('Atlantis results/sched_8_WT_120khz_a3D.mat')));

File_aOPT = {File1aOPT, File2aOPT, File3aOPT, File4aOPT, File5aOPT, File6aOPT, File7aOPT, File8aOPT};
File_a1 = {File1a1, File2a1, File3a1, File4a1, File5a1, File6a1, File7a1, File8a1};
File_a2 = {File1a2, File2a2, File3a2, File4a2, File5a2, File6a2, File7a2, File8a2};
File_a3 = {File1a3, File2a3, File3a3, File4a3, File5a3, File6a3, File7a3, File8a3};



throughput_1 = {0,0,0,0,0,0,0,0};
dropped_throughput_1 = {0,0,0,0,0,0,0,0};
deadline_violation_1 = {0,0,0,0,0,0,0,0};
for j = 1:8
    for i = 1:length(File_1{j})
        %if File_1{j}(i,6) < File_1{j}(i,5)
            throughput_1{j} = File_1{j}(i,4) + throughput_1{j};
        %else
            dropped_throughput_1{j} = File_1{j}(i,4) + dropped_throughput_1{j};
        %end  

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
        %if File_a1{j}(i,6) < File_a1{j}(i,5)
            throughput_a1{j} = File_a1{j}(i,4) + throughput_a1{j};
        %else
            dropped_throughput_a1{j} = File_a1{j}(i,4) + dropped_throughput_a1{j};
        %end    
%         
%         if File_1{j}(i,6) > File_1{j}(i,5)
%             deadline_violation_a1{j} = 1 + deadline_violation_a1{j};
%         end    
    end
end  
%throughput_a1{7} = 82158;

throughput_aOPT = {0,0,0,0,0,0,0,0};
dropped_throughput_aOPT = {0,0,0,0,0,0,0,0};
deadline_violation_aOPT = {0,0,0,0,0,0,0,0};
for j = 1:8
    for i = 1:length(File_aOPT{j})
        %if File_a1{j}(i,6) < File_a1{j}(i,5)
            throughput_aOPT{j} = File_aOPT{j}(i,4) + throughput_aOPT{j};
        %else
            dropped_throughput_aOPT{j} = File_aOPT{j}(i,4) + dropped_throughput_aOPT{j};
        %end    
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
        %if File_a2{j}(i,6) < File_a2{j}(i,5)
            throughput_a2{j} = File_a2{j}(i,4) + throughput_a2{j};
        %else
            dropped_throughput_a2{j} = File_a2{j}(i,4) + dropped_throughput_a2{j};
        %end    
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
        %if File_a3{j}(i,6) < File_a3{j}(i,5)
            throughput_a3{j} = File_a3{j}(i,4) + throughput_a3{j};
        %else
            dropped_throughput_a3{j} = File_a3{j}(i,4) + dropped_throughput_a3{j};
        %end    
%         
%         if File_1{j}(i,6) > File_1{j}(i,5)
%             deadline_violation_a3{j} = 1 + deadline_violation_a3{j};
%         end    
    end
end  


throughput_EDF = {0,0,0,0,0,0,0,0};
dropped_throughput_EDF = {0,0,0,0,0,0,0,0};
deadline_violation_EDF = {0,0,0,0,0,0,0,0};
for j = 1:8
    for i = 1:length(File_EDF{j})
        %if File_a3{j}(i,6) < File_a3{j}(i,5)
            throughput_EDF{j} = File_EDF{j}(i,4) + throughput_EDF{j};
        %else
            dropped_throughput_EDF{j} = File_EDF{j}(i,4) + dropped_throughput_EDF{j};
        %end    
%         
%         if File_1{j}(i,6) > File_1{j}(i,5)
%             deadline_violation_a3{j} = 1 + deadline_violation_a3{j};
%         end    
    end
end  


throughput_RR = {0,0,0,0,0,0,0,0};
dropped_throughput_RR = {0,0,0,0,0,0,0,0};
deadline_violation_RR = {0,0,0,0,0,0,0,0};
for j = 1:8
    for i = 1:length(File_RR{j})
        %if File_a3{j}(i,6) < File_a3{j}(i,5)
            throughput_RR{j} = File_RR{j}(i,4) + throughput_RR{j};
        %else
            dropped_throughput_RR{j} = File_RR{j}(i,4) + dropped_throughput_RR{j};
        %end    
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
throughput_aOPT = cell2mat(throughput_aOPT);
throughput_EDF = cell2mat(throughput_EDF);
throughput_RR = cell2mat(throughput_RR);
%sched__a1 = 1000*[cell2mat(struct2cell(File1a1)), cell2mat(struct2cell(File2a1)), cell2mat(struct2cell(File3a1)), cell2mat(struct2cell(File4a1)), cell2mat(struct2cell(File5a1)), cell2mat(struct2cell(File6a1)), cell2mat(struct2cell(File7a1)), cell2mat(struct2cell(File8a1))];
%sched__a2 = 1000*[cell2mat(struct2cell(File1a2)), cell2mat(struct2cell(File2a2)), cell2mat(struct2cell(File3a2)), cell2mat(struct2cell(File4a2)), cell2mat(struct2cell(File5a2)), cell2mat(struct2cell(File6a2)), cell2mat(struct2cell(File7a2)), cell2mat(struct2cell(File8a2))];
%sched__a3 = 1000*[cell2mat(struct2cell(File1a3)), cell2mat(struct2cell(File2a3)), cell2mat(struct2cell(File3a3)), cell2mat(struct2cell(File4a3)), cell2mat(struct2cell(File5a3)), cell2mat(struct2cell(File6a3)), cell2mat(struct2cell(File7a3)), cell2mat(struct2cell(File8a3))];
bar(throughput_1);
hold on;
bar(throughput_1);
hold on;
bar(throughput_a1);
hold on;
%bar(throughput_a2);
%hold on;
bar(throughput_a3);
hold on;
bar(throughput_aOPT);
 legend('FCFS', 'EDF', 'WT \alpha = 1', 'WT \alpha = optimum', 'WT \alpha = 3');
figure;

plot(x,throughput_1, 'LineWidth', 2);
hold on;
plot(x,throughput_a1, 'LineWidth', 2);
hold on;
plot(x,throughput_a3, 'LineWidth', 2);
hold on;
plot(x,throughput_aOPT, 'LineWidth', 2); 
hold on;
plot(x,throughput_EDF, 'LineWidth', 2);
hold on;
plot(x,throughput_RR, 'LineWidth', 2); 
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
 %legend('FCFS', 'EDF', 'WT \alpha = 1', 'WT \alpha = 2', 'WT \alpha = 3');
legend('FCFS', 'WT \alpha = 1','WT \alpha = 3', 'WT \alpha = optimum', 'EDF', 'RR');
title('Throughput for SCS=120KHz/Time slots=0.0125ms')
xlabel('Number of users');
ylabel('Sum value of delivered packets');
figure;


plot(x,throughput_1./throughput_RR, 'LineWidth', 2);
hold on;
plot(x,throughput_a1./throughput_RR, 'LineWidth', 2);
hold on;
plot(x,throughput_a3./throughput_RR, 'LineWidth', 2);
hold on;
plot(x,throughput_aOPT./throughput_RR, 'LineWidth', 2); 
hold on;
plot(x,throughput_EDF./throughput_RR, 'LineWidth', 2);
legend('FCFS', 'WT \alpha = 1','WT \alpha = 3', 'WT \alpha = optimum', 'EDF');
title('Throughput for SCS=120KHz/Time slots=0.0125ms as a ratio with RR')
xlabel('Number of users');
ylabel('Sum value of delivered packets');
%figure;


































File11ND = cell2mat(struct2cell(load('Atlantis results/sched_1_FCFS_120khz.mat')));
File21ND = cell2mat(struct2cell(load('Atlantis results/sched_2_FCFS_120khz.mat')));
File31ND = cell2mat(struct2cell(load('Atlantis results/sched_3_FCFS_120khz.mat')));
File41ND = cell2mat(struct2cell(load('Atlantis results/sched_4_FCFS_120khz.mat')));
File51ND = cell2mat(struct2cell(load('Atlantis results/sched_5_FCFS_120khz.mat')));
File61ND = cell2mat(struct2cell(load('Atlantis results/sched_6_FCFS_120khz.mat')));
File71ND = cell2mat(struct2cell(load('Atlantis results/sched_7_FCFS_120khz.mat')));
File81ND = cell2mat(struct2cell(load('Atlantis results/sched_8_FCFS_120khz.mat')));

File_1ND = {File11ND, File21ND, File31ND, File41ND, File51ND, File61ND, File71ND, File81ND};


FileEDF1ND = cell2mat(struct2cell(load('Atlantis results/sched_1_EDF_120khz.mat')));
FileEDF2ND = cell2mat(struct2cell(load('Atlantis results/sched_2_EDF_120khz.mat')));
FileEDF3ND = cell2mat(struct2cell(load('Atlantis results/sched_3_EDF_120khz.mat')));
FileEDF4ND = cell2mat(struct2cell(load('Atlantis results/sched_4_EDF_120khz.mat')));
FileEDF5ND = cell2mat(struct2cell(load('Atlantis results/sched_5_EDF_120khz.mat')));
FileEDF6ND = cell2mat(struct2cell(load('Atlantis results/sched_6_EDF_120khz.mat')));
FileEDF7ND = cell2mat(struct2cell(load('Atlantis results/sched_7_EDF_120khz.mat')));
FileEDF8ND = cell2mat(struct2cell(load('Atlantis results/sched_8_EDF_120khz.mat')));

File_EDFND = {FileEDF1ND, FileEDF2ND, FileEDF3ND, FileEDF4ND, FileEDF5ND, FileEDF6ND, FileEDF7ND, FileEDF8ND};

FileRR1ND = cell2mat(struct2cell(load('Atlantis results/sched_1_FCFS_120khz.mat')));
FileRR2ND = cell2mat(struct2cell(load('Atlantis results/sched_2_RR_120khz.mat')));
FileRR3ND = cell2mat(struct2cell(load('Atlantis results/sched_3_RR_120khz.mat')));
FileRR4ND = cell2mat(struct2cell(load('Atlantis results/sched_4_RR_120khz.mat')));
FileRR5ND = cell2mat(struct2cell(load('Atlantis results/sched_5_RR_120khz.mat')));
FileRR6ND = cell2mat(struct2cell(load('Atlantis results/sched_6_RR_120khz.mat')));
FileRR7ND = cell2mat(struct2cell(load('Atlantis results/sched_7_RR_120khz.mat')));
FileRR8ND = cell2mat(struct2cell(load('Atlantis results/sched_8_RR_120khz.mat')));

File_RRND = {FileRR1ND, FileRR2ND, FileRR3ND, FileRR4ND, FileRR5ND, FileRR6ND, FileRR7ND, FileRR8ND};

File1aOPTND = cell2mat(struct2cell(load('Atlantis results/sched_1_WT_120khz_aOPT.mat')));
File1a1ND = cell2mat(struct2cell(load('Atlantis results/sched_1_WT_120khz_a1.mat')));
File1a2ND = cell2mat(struct2cell(load('Atlantis results/sched_1_WT_120khz_a2.mat')));
File1a3ND = cell2mat(struct2cell(load('Atlantis results/sched_1_WT_120khz_a3.mat')));

File2aOPTND = cell2mat(struct2cell(load('Atlantis results/sched_2_WT_120khz_aOPT.mat')));
File2a1ND = cell2mat(struct2cell(load('Atlantis results/sched_2_WT_120khz_a1.mat')));
File2a2ND = cell2mat(struct2cell(load('Atlantis results/sched_2_WT_120khz_a2.mat')));
File2a3ND = cell2mat(struct2cell(load('Atlantis results/sched_2_WT_120khz_a3.mat')));

File3aOPTND = cell2mat(struct2cell(load('Atlantis results/sched_3_WT_120khz_aOPT.mat')));
File3a1ND = cell2mat(struct2cell(load('Atlantis results/sched_3_WT_120khz_a1.mat')));
File3a2ND = cell2mat(struct2cell(load('Atlantis results/sched_3_WT_120khz_a2.mat')));
File3a3ND = cell2mat(struct2cell(load('Atlantis results/sched_3_WT_120khz_a3.mat')));

File4aOPTND = cell2mat(struct2cell(load('Atlantis results/sched_4_WT_120khz_aOPT.mat')));
File4a1ND = cell2mat(struct2cell(load('Atlantis results/sched_4_WT_120khz_a1.mat')));
File4a2ND = cell2mat(struct2cell(load('Atlantis results/sched_4_WT_120khz_a2.mat')));
File4a3ND = cell2mat(struct2cell(load('Atlantis results/sched_4_WT_120khz_a3.mat')));

File5aOPTND = cell2mat(struct2cell(load('Atlantis results/sched_5_WT_120khz_aOPT.mat')));
File5a1ND = cell2mat(struct2cell(load('Atlantis results/sched_5_WT_120khz_a1.mat')));
File5a2ND = cell2mat(struct2cell(load('Atlantis results/sched_5_WT_120khz_a2.mat')));
File5a3ND = cell2mat(struct2cell(load('Atlantis results/sched_5_WT_120khz_a3.mat')));

File6aOPTND = cell2mat(struct2cell(load('Atlantis results/sched_6_WT_120khz_aOPT.mat')));
File6a1ND = cell2mat(struct2cell(load('Atlantis results/sched_6_WT_120khz_a1.mat')));
File6a2ND = cell2mat(struct2cell(load('Atlantis results/sched_6_WT_120khz_a2.mat')));
File6a3ND = cell2mat(struct2cell(load('Atlantis results/sched_6_WT_120khz_a3.mat')));

File7aOPTND = cell2mat(struct2cell(load('Atlantis results/sched_7_WT_120khz_aOPT.mat')));
File7a1ND = cell2mat(struct2cell(load('Atlantis results/sched_7_WT_120khz_a1.mat')));
File7a2ND = cell2mat(struct2cell(load('Atlantis results/sched_7_WT_120khz_a2.mat')));
File7a3ND = cell2mat(struct2cell(load('Atlantis results/sched_7_WT_120khz_a3.mat')));

File8aOPTND = cell2mat(struct2cell(load('Atlantis results/sched_8_WT_120khz_aOPT.mat')));
File8a1ND = cell2mat(struct2cell(load('Atlantis results/sched_8_WT_120khz_a1.mat')));
File8a2ND = cell2mat(struct2cell(load('Atlantis results/sched_8_WT_120khz_a2.mat')));
File8a3ND = cell2mat(struct2cell(load('Atlantis results/sched_8_WT_120khz_a3.mat')));

File_aOPTND = {File1aOPTND, File2aOPTND, File3aOPTND, File4aOPTND, File5aOPTND, File6aOPTND, File7aOPTND, File8aOPTND};
File_a1ND = {File1a1ND, File2a1ND, File3a1ND, File4a1ND, File5a1ND, File6a1ND, File7a1ND, File8a1ND};
File_a2ND = {File1a2ND, File2a2ND, File3a2ND, File4a2ND, File5a2ND, File6a2ND, File7a2ND, File8a2ND};
File_a3ND = {File1a3ND, File2a3ND, File3a3ND, File4a3ND, File5a3ND, File6a3ND, File7a3ND, File8a3ND};



throughput_1ND = {0,0,0,0,0,0,0,0};
dropped_throughput_1ND = {0,0,0,0,0,0,0,0};
deadline_violation_1ND = {0,0,0,0,0,0,0,0};
for j = 1:8
    for i = 1:length(File_1{j})
        %if File_1{j}(i,6) < File_1{j}(i,5)
            throughput_1ND{j} = File_1ND{j}(i,4) + throughput_1ND{j};
        %else
            dropped_throughput_1ND{j} = File_1ND{j}(i,4) + dropped_throughput_1ND{j};
        %end  

%         if File_1{j}(i,6) > File_1{j}(i,5)
%             deadline_violation_1{j} = 1 + deadline_violation_1{j};
%         end    

    end
end    


throughput_a1ND = {0,0,0,0,0,0,0,0};
dropped_throughput_a1ND = {0,0,0,0,0,0,0,0};
deadline_violation_a1ND = {0,0,0,0,0,0,0,0};
for j = 1:8
    for i = 1:length(File_a1ND{j})
        %if File_a1{j}(i,6) < File_a1{j}(i,5)
            throughput_a1ND{j} = File_a1ND{j}(i,4) + throughput_a1ND{j};
        %else
            dropped_throughput_a1ND{j} = File_a1ND{j}(i,4) + dropped_throughput_a1ND{j};
        %end    
%         
%         if File_1{j}(i,6) > File_1{j}(i,5)
%             deadline_violation_a1{j} = 1 + deadline_violation_a1{j};
%         end    
    end
end  
%throughput_a1{7} = 82158;

throughput_aOPTND = {0,0,0,0,0,0,0,0};
dropped_throughput_aOPTND = {0,0,0,0,0,0,0,0};
deadline_violation_aOPTND = {0,0,0,0,0,0,0,0};
for j = 1:8
    for i = 1:length(File_aOPTND{j})
        %if File_a1{j}(i,6) < File_a1{j}(i,5)
            throughput_aOPTND{j} = File_aOPTND{j}(i,4) + throughput_aOPTND{j};
        %else
            dropped_throughput_aOPTND{j} = File_aOPTND{j}(i,4) + dropped_throughput_aOPTND{j};
        %end    
%         
%         if File_1{j}(i,6) > File_1{j}(i,5)
%             deadline_violation_a1{j} = 1 + deadline_violation_a1{j};
%         end    
    end
end  




throughput_a2ND = {0,0,0,0,0,0,0,0};
dropped_throughput_a2ND = {0,0,0,0,0,0,0,0};
deadline_violation_a2ND = {0,0,0,0,0,0,0,0};
for j = 1:8
    for i = 1:length(File_a2ND{j})
        %if File_a2{j}(i,6) < File_a2{j}(i,5)
            throughput_a2ND{j} = File_a2ND{j}(i,4) + throughput_a2ND{j};
        %else
            dropped_throughput_a2ND{j} = File_a2ND{j}(i,4) + dropped_throughput_a2ND{j};
        %end    
%         
%         if File_1{j}(i,6) > File_1{j}(i,5)
%             deadline_violation_a2{j} = 1 + deadline_violation_a2{j};
%         end    
    end
end  

throughput_a3ND = {0,0,0,0,0,0,0,0};
dropped_throughput_a3ND = {0,0,0,0,0,0,0,0};
deadline_violation_a3ND = {0,0,0,0,0,0,0,0};
for j = 1:8
    for i = 1:length(File_a3ND{j})
        %if File_a3{j}(i,6) < File_a3{j}(i,5)
            throughput_a3ND{j} = File_a3ND{j}(i,4) + throughput_a3ND{j};
        %else
            dropped_throughput_a3ND{j} = File_a3ND{j}(i,4) + dropped_throughput_a3ND{j};
        %end    
%         
%         if File_1{j}(i,6) > File_1{j}(i,5)
%             deadline_violation_a3{j} = 1 + deadline_violation_a3{j};
%         end    
    end
end  


throughput_EDFND = {0,0,0,0,0,0,0,0};
dropped_throughput_EDFND = {0,0,0,0,0,0,0,0};
deadline_violation_EDFND = {0,0,0,0,0,0,0,0};
for j = 1:8
    for i = 1:length(File_EDFND{j})
        %if File_a3{j}(i,6) < File_a3{j}(i,5)
            throughput_EDFND{j} = File_EDFND{j}(i,4) + throughput_EDFND{j};
        %else
            dropped_throughput_EDFND{j} = File_EDFND{j}(i,4) + dropped_throughput_EDFND{j};
        %end    
%         
%         if File_1{j}(i,6) > File_1{j}(i,5)
%             deadline_violation_a3{j} = 1 + deadline_violation_a3{j};
%         end    
    end
end  


throughput_RRND = {0,0,0,0,0,0,0,0};
dropped_throughput_RRND = {0,0,0,0,0,0,0,0};
deadline_violation_RRND = {0,0,0,0,0,0,0,0};
for j = 1:8
    for i = 1:length(File_RRND{j})
        %if File_a3{j}(i,6) < File_a3{j}(i,5)
            throughput_RRND{j} = File_RRND{j}(i,4) + throughput_RRND{j};
        %else
            dropped_throughput_RRND{j} = File_RRND{j}(i,4) + dropped_throughput_RRND{j};
        %end    
%         
%         if File_1{j}(i,6) > File_1{j}(i,5)
%             deadline_violation_a3{j} = 1 + deadline_violation_a3{j};
%         end    
    end
end  

throughput_1ND = cell2mat(throughput_1ND);
throughput_a1ND = cell2mat(throughput_a1ND);
throughput_a2ND = cell2mat(throughput_a2ND);
throughput_a3ND = cell2mat(throughput_a3ND);
throughput_aOPTND = cell2mat(throughput_aOPTND);
throughput_EDFND = cell2mat(throughput_EDFND);
throughput_RRND = cell2mat(throughput_RRND);
figure;
plot(x,throughput_1./throughput_1ND, 'LineWidth', 2);
hold on;
plot(x,throughput_a1./throughput_a1ND, 'LineWidth', 2);
hold on;
plot(x,throughput_a3./throughput_a3ND, 'LineWidth', 2);
hold on;
plot(x,throughput_aOPT./throughput_aOPTND, 'LineWidth', 2); 
hold on;
plot(x,throughput_EDF./throughput_EDFND, 'LineWidth', 2);
hold on;
plot(x,throughput_RR./throughput_RRND, 'LineWidth', 2); 
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
 %legend('FCFS', 'EDF', 'WT \alpha = 1', 'WT \alpha = 2', 'WT \alpha = 3');
legend('FCFS', 'WT \alpha = 1','WT \alpha = 3', 'WT \alpha = optimum', 'EDF', 'RR');
title('Ratio of delivered throughput to total throughput vs # of Users')
xlabel('Number of users');
ylabel('Ratio of delivered throughput to total throughput');