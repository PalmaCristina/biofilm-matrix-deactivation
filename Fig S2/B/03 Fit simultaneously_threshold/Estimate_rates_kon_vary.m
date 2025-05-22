% Do fit for the 100 threshold data tested

%Load 100 files inside the folder

%% Load activation_C_files
folderPath_C_A = ['D:\Work\6-Ongoing Papers\06 Model Spo0A\Submitted\PLOS\01 PLOS comp bio\01 Review_1\t_Clean tools_v4\' ...
    'Fig 3 - threshold\03 Fit simultaneously_th_loop\Data_activation_C']; % Change to your actual folder path
fileList_C_A = dir(fullfile(folderPath_C_A, '*.mat')); % Adjust extension if needed

folderPath_O_A = ['D:\Work\6-Ongoing Papers\06 Model Spo0A\Submitted\PLOS\01 PLOS comp bio\01 Review_1\t_Clean tools_v4\' ...
    'Fig 3 - threshold\03 Fit simultaneously_th_loop\Data_activation_O']; % Change to your actual folder path
fileList_O_A = dir(fullfile(folderPath_O_A, '*.mat')); % Adjust extension if needed

folderPath_C_D = ['D:\Work\6-Ongoing Papers\06 Model Spo0A\Submitted\PLOS\01 PLOS comp bio\01 Review_1\t_Clean tools_v4\' ...
    'Fig 3 - threshold\03 Fit simultaneously_th_loop\Data_deactivation_C']; % Change to your actual folder path
fileList_C_D = dir(fullfile(folderPath_C_D, '*.mat')); % Adjust extension if needed

folderPath_O_D = ['D:\Work\6-Ongoing Papers\06 Model Spo0A\Submitted\PLOS\01 PLOS comp bio\01 Review_1\t_Clean tools_v4\' ...
    'Fig 3 - threshold\03 Fit simultaneously_th_loop\Data_deactivation_O']; % Change to your actual folder path
fileList_O_D = dir(fullfile(folderPath_O_D, '*.mat')); % Adjust extension if needed


for k = 1:length(fileList_C_A)

    %C_A load
    fileName_C_A = fileList_C_A(k).name;
    fullFilePath = fullfile(folderPath_C_A, fileName_C_A);
    load(fullFilePath);  % Load the file contents

    %O_A load
    fileName_O_A = fileList_O_A(k).name;
    fullFilePath = fullfile(folderPath_O_A, fileName_O_A);
    load(fullFilePath);  % Load the file contents

    %C_D load
    fileName_C_D = fileList_C_D(k).name;
    fullFilePath = fullfile(folderPath_C_D, fileName_C_D);
    load(fullFilePath);  % Load the file contents

    %O_D load
    fileName_O_D = fileList_O_D(k).name;
    fullFilePath = fullfile(folderPath_O_D, fileName_O_D);
    load(fullFilePath);  % Load the file contents

    run('Fit_simultaneously_kon_vary.m')
    kon_c(1,k)=kon_best_c;
    kon_o(1,k)=kon_best_o;
    koff_c(1,k)=koff_best_c;
    koff_o(1,k)=koff_best_o;

    clearvars -except folderPath_C_A fileList_C_A...
        folderPath_O_A fileList_O_A...
        folderPath_C_D  fileList_C_D...
         folderPath_O_D  fileList_O_D...
          k kon_c kon_o kon_v koff_c koff_o
end

%% Do bar plots

%  data
x = 1:4;
y = [mean(kon_c), mean(kon_o), mean(koff_c), mean(koff_o)];  % Mean values (heights of bars)
std_dev = [std(kon_c), std(kon_o), std(koff_c), std(koff_o)];  % Standard deviations

% Create bar plot
figure;
bar(x, y, 'FaceColor', [0.6 0.6 0.6]); % Gray bars

% Add error bars
hold on;
errorbar(x, y, std_dev, 'k', 'linestyle', 'none', 'LineWidth', 1.5);
hold off;

% Optional: Labeling
xticks(x);
xticklabels({'k_{ON} _{constant}','k_{ON} _{pulsing}', 'k_{OFF} _{constant}', 'k_{OFF} _{pulsing}'});
ylabel('Values (h^{-1})', 'FontSize', 12);

