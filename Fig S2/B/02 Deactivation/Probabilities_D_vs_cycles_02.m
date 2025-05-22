function [Inspect_times_02,P_OFF] = Probabilities_D_vs_cycles_02(total_cells,g,timef,resultsf,theresh)

%% Plot
grate=g;
% figure
%     for i=871:1:total_cells
%     plot(timef{:,i},resultsf{:,i}); hold on;
%     ylabel('Molecule count')
%     xlabel('Time (h)')
%     set(gca,'FontSize',15)
%     end
%%
Inspect_times=[0:1:80];
Inspect_times=((log(2)/grate)).*Inspect_times;
 

% As function of cell cycle
for i=1:1:total_cells
        for t=1:size(Inspect_times,2)
            
            sub=abs((timef{:,i}-Inspect_times(1,t)));
            [v,r]=(min(sub));
            tapA_inspect(i,t)=resultsf{:,i}(r,1);
        end
end 

%As a function of time
Inspect_times_02=[0:0.1:60];
for i=1:1:total_cells
        for t=1:size(Inspect_times_02,2)
            
            sub=abs((timef{:,i}-Inspect_times_02(1,t)));
            [v,r]=(min(sub));
            tapA_inspect_time(i,t)=resultsf{:,i}(r,1);
        end
end


%% Convert values

binary_matrix= tapA_inspect<=theresh;

binary_matrix_time= tapA_inspect_time<=theresh;

%% Sum columns for Number of cells OFF at that time moment

column_sums = sum(binary_matrix, 1);

column_sums_time = sum(binary_matrix_time, 1);

%% Plot
% figure(4)
% Number_cycles=[0:1:80];
P_OFF=column_sums./total_cells;
% s1=plot(Number_cycles,column_sums./total_cells,'LineWidth',2); hold on;
% ylabel('Probability of being OFF')
% xlabel('Cell Cycle')
% set(gca,'FontSize',15)
% legend([s1],{'Freq', num2str(grate)})

% figure(5)
P_OFF=column_sums_time./total_cells;
% s2=plot(Inspect_times_02,column_sums_time./total_cells,'LineWidth',2); hold on;
% ylabel('Probability of being OFF')
% xlabel('Time(h)')
% set(gca,'FontSize',15)
% legend([s2],{'Freq', num2str(grate)})


end


