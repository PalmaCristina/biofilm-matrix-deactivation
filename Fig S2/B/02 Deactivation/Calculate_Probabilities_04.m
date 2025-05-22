%Calculate probabilities
%Settinggs used to do the simulations

% This script calls 'N_activation' which cleans the data to only account with
% ON periods that are longer than a cell cycle. This is the difference to
% the 01

%This script also filters initial condition by SinR based on diagonal

total_cells=2000;
factor=1;
gr_v=[0.4];


%% Calculate Probabilities

% OFF probabilites plot
for y=1:1:size(gr_v,2)
    gr=gr_v(y);
    
    % Deactivation load
    Name1 = ['Deactivation_', num2str(strrep(num2str(gr), '.', '_')), '.mat'];
    [~, filename, ~] = fileparts(Name1);
    % Load the file
    data_struct_D.(genvarname(filename)) = load(Name1);

    % Constant Deactivation load
    Name3 = ['Constant_Deactivation_', num2str(strrep(num2str(gr), '.', '_')), '.mat'];
    [~, filename, ~] = fileparts(Name3);
    % Load the file
    data_struct_D.(genvarname(filename)) = load(Name3);
    
%     % Activation load
%     Name2 = ['Activation_', num2str(strrep(num2str(gr), '.', '_')), '.mat'];
%     [~, filename, ~] = fileparts(Name2);
%     % Load the file
%     data_struct_A.(genvarname(filename)) = load(Name2);
% 
%     % Constant Activation load
%     Name3 = ['Constant_Activation', num2str(strrep(num2str(gr), '.', '_')), '.mat'];
%     [~, filename, ~] = fileparts(Name3);
%     % Load the file
%     data_struct_A.(genvarname(filename)) = load(Name3);

end   
    
%% Filter active state also based on SinR
fields = fieldnames(data_struct_D);
for i=1:1:size(fields,1)
 t=1;
    for j=1:total_cells
        if (data_struct_D.(fields{i}).x_ss_2(j,13)>=data_struct_D.(fields{i}).x_ss_2(j,15))
            Index_removal{1,i}(t,1)=j;
            t=t+1;
        end
    end
       data_struct_D.(fields{i}).resultsf(1,[Index_removal{1,i}].')={3};
end

%Eliminate from resultsf 

for i=1:1:size(fields,1)
 t=1;
    for j=1:total_cells
        if (data_struct_D.(fields{i}).resultsf{1,j}==3)

        else 
            data_struct_D.(fields{i}).resultsf_corrected(1,t)=data_struct_D.(fields{i}).resultsf(1,j);
            data_struct_D.(fields{i}).timef_corrected(1,t)=data_struct_D.(fields{i}).timef(1,j);
            t=t+1;
        end
    end
end 


%% Clean ON periods smaller than 1 cell cycle
total_cells=size(data_struct_D.(fields{1}).timef_corrected,2);

fields = fieldnames(data_struct_D);

for i=1:1:size(fields,1)
[results_duration,timef_clean,resultsf_clean] = N_Activation_deactivation_03(total_cells,gr,data_struct_D.(fields{i}).timef_corrected,data_struct_D.(fields{i}).resultsf_corrected,theresh);
data_struct_D.(fields{i}).timef_corrected_clean=timef_clean;
data_struct_D.(fields{i}).resultsf_corrected_clean=resultsf_clean;
end



%% 
 fields = fieldnames(data_struct_D);

 for i=1:1:size(fields,1)
      [Inspect_times_02,P_OFF] = Probabilities_D_vs_cycles_02(total_cells,gr,data_struct_D.(fields{i}).timef_corrected_clean,data_struct_D.(fields{i}).resultsf_corrected_clean,theresh);

  % Save the variables to the file
    if i==1
        Inspect_times_02_O_D=Inspect_times_02;
        P_OFF_O_D=P_OFF;
        filename = sprintf('DATA_O_DEACTIVATION_%d.mat', theresh);
        save(filename, 'Inspect_times_02_O_D', 'P_OFF_O_D');
    end

    if i==2
        Inspect_times_02_C_D=Inspect_times_02;
        P_OFF_C_D=P_OFF;
        filename = sprintf('DATA_C_DEACTIVATION_%d.mat', theresh);
        save(filename, 'Inspect_times_02_C_D', 'P_OFF_C_D');
    end
 
 
 end
% ADD LEGENDS
% figure(5)
% for F=1:1:size(fields,1)
% legend_entries{F} = [strrep(fields{F},'_',' ')]; % Create legend entry
% legend(legend_entries);
% end
% legend(legend_entries);






