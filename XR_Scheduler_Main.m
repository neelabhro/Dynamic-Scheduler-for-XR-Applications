clear;
clc;
close all;

%Diving into packet level scheduling, each packet is 1.32kB 
%Where the data(UDP) payload is 1.278kB

traceFile = readmatrix('ge_cities_40mbps_60fps'); %Google VR trace file
Burst_Size = traceFile(1 : end, 1);  %Represents the trace burst sizes in Bytes
t_nxt_frame = traceFile(1 : end, 2); %Represents the time to next arriving frame in seconds


n_pack_burst = Burst_Size./1320;       %Number of packets per burst 
Initial_QoE = floor(n_pack_burst./10); %Preliminarily defining this to be a
%fraction of the total number of packets encompassing a frame
plot(1:length(Initial_QoE),Initial_QoE);
title('QoE variations across varying bursts')

%n = length(t_nxt_frame);
n = 10;
btime = t_nxt_frame;

q = 0.016;            %quantum time- a round-robin scheduler generally employs time-sharing, giving each job a time slot or quantum
tatime = zeros(1,n);  %turn around time Net time for the process to be completed
wtime = zeros(1,n);   %waiting time
rtime = btime;        %intially remaining time= waiting time
b = 0;
t = 0;
flag = 0;             %this is set if process has burst time left after quantum time is completed
for i = 1:1:n         %running the processes for 1 quantum 
    if(rtime(i) >= q)
        fprintf('P%d\n',i);
        for j = 1:1:n
            if(j == i)
                rtime(i) = rtime(i)-q;    %setting the remaining time if it is the process scheduled
            else if(rtime(j) > 0)
                    wtime(j) = wtime(j)+q;    %incrementing wait time if it is not the process scheduled
                end
            end
        end
    else if(rtime(i) > 0)             
            fprintf('P%d\n',i);
            for j = 1:1:n
              if(j == i)
                rtime(i) = 0;                 %as the remaining time is less than quantum it will run the process and end it
              else if(rtime(j) > 0)
                    wtime(j) = wtime(j)+rtime(i);     %incrementing wait time if it is not the process scheduled
                  end 
              end
            end
        end
    end
end
for i = 1:1:n
    if(rtime(i) > 0)      %if remaining time is left set flag
        flag = 1;
    end
end
while(flag == 1)          %if flag is set run the above process again
    flag = 0;
    for i = 1:1:n
        if(rtime(i) >= q)
            fprintf('P%d\n',i);
            for j = 1:1:n
                if(j == i)
                    rtime(i) = rtime(i)-q;
                else if(rtime(j) > 0)
                        wtime(j) = wtime(j)+q;
                    end
                end
            end
        else if(rtime(i) > 0)
                fprintf('P%d\n',i);
                for j = 1:1:n
                    if(j == i)
                        rtime(i) = 0;
                    else if(rtime(j) > 0)
                            wtime(j) = wtime(j)+rtime(i);
                        end 
                    end
                end
            end
        end
    end
    for i = 1:1:n
        if(rtime(i) > 0)
            flag = 1;
        end
    end
end
for i = 1:1:n
    tatime(i) = wtime(i)+btime(i);    %calculating turn around time for each process by adding waiting time and burst time
end
disp('Process   Burst time  Waiting time    Turn Around time'); %displaying the final values
for i = 1:1:n
    fprintf('P%d\t\t\t%d\t\t\t%d\t\t\t\t%d\n',(i+1),btime(i),wtime(i),tatime(i));
    b = b+wtime(i);
    t = t+tatime(i);
end
fprintf('Average waiting time: %f\n',(b/n));
fprintf('Average turn around time: %f\n',(t/n));