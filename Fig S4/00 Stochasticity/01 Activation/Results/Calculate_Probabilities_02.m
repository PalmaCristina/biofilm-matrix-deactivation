%Calculate probabilities
%Settinggs used to do the simulations

% This script calls 'N_activation' which cleans the data to only account with
% ON periods that are longer than a cell cycle. This is the difference to
% the 01

total_cells=2000;
factor=1;
gr_v=[0.4];


%% Calculate Probabilities

% OFF probabilites plot
for y=1:1:size(gr_v,2)
    gr=gr_v(y);
        
    % Activation load
    Name2 = ['Activation_', num2str(strrep(num2str(gr), '.', '_')), '.mat'];
    [~, filename, ~] = fileparts(Name2);
    % Load the file
    data_struct_A.(genvarname(filename)) = load(Name2);

    % Constant Activation load
    Name3 = ['Constant_Activation', num2str(strrep(num2str(gr), '.', '_')), '.mat'];
    [~, filename, ~] = fileparts(Name3);
    % Load the file
    data_struct_A.(genvarname(filename)) = load(Name3);

end   
    
   
%% Clean ON periods smaller than 1 cell cycle
fields = fieldnames(data_struct_A);

for i=1:1:size(fields,1)
[results_duration,timef_clean,resultsf_clean] = N_Activation_deactivation_03(total_cells,gr,data_struct_A.(fields{i}).timef,data_struct_A.(fields{i}).resultsf);
data_struct_A.(fields{i}).timef_clean=timef_clean;
data_struct_A.(fields{i}).resultsf_clean=resultsf_clean;
end



%% 
 fields = fieldnames(data_struct_A);

 for i=1:1:size(fields,1)
      [Inspect_times_02,P_ON] = Probabilities_A_vs_cycles_02(total_cells,gr,data_struct_A.(fields{i}).timef_clean,data_struct_A.(fields{i}).resultsf_clean)
 
 % Save the variables to the file
    if i==1
        Inspect_times_02_O_A=Inspect_times_02;
        P_ON_O_A=P_ON;
        save('DATA_O_ACTIVATION.mat', 'Inspect_times_02_O_A', 'P_ON_O_A');
    end

    if i==2
        Inspect_times_02_C_A=Inspect_times_02;
        P_ON_C_A=P_ON;
        save('DATA_C_ACTIVATION.mat', 'Inspect_times_02_C_A', 'P_ON_C_A');
    end

 end

% ADD LEGENDS
figure(5)
for F=1:1:size(fields,1)
legend_entries{F} = [strrep(fields{F},'_',' ')]; % Create legend entry
legend(legend_entries);
end
legend(legend_entries);

