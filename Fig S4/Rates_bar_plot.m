% Values for each group 
data1 = [0.0385 0.0326 0.1059 0.1315];  %Without stochasticity
data2 = [0.0313 0.0291 0.0893 0.1227];  % With stochasticity  

% Settings
bar_width = 0.2;
spacing = 0.3;           % Equal spacing between bars within a group
group_distance = 1.5;      % Distance between groups

% X positions for bars in each group (centered)
x1 = (-1.5:1:1.5) * spacing;             % Group 1 at center 0
x2 = x1 + group_distance;               % Group 2 shifted right

% Combine all
x_all = [x1, x2];
y_all = [data1, data2];

% Plot
figure;
hold on;
for i = 1:length(x_all)
    bar(x_all(i), y_all(i), bar_width);
        if i <= 4
         bar(x_all(i), y_all(i), bar_width, 'FaceColor', 'k');      % Group 1: black
        else
         bar(x_all(i), y_all(i), bar_width, 'FaceColor', [0.6 0.6 0.6]);  % Group 2: grey
        end
end

% Define xtick labels for each bar
xticks(x_all);
xticklabels({'k_{ON} _{constant}','k_{ON} _{pulsing}', 'k_{OFF} _{constant}', 'k_{OFF} _{pulsing}', ...
             'k_{ON} _{constant}','k_{ON} _{pulsing}', 'k_{OFF} _{constant}', 'k_{OFF} _{pulsing}'});

% Set axis
xtickangle(45);  % Optional: tilt labels for clarity
ylabel('Rate value (h^{-1})')
xlim([min(x_all)-0.2, max(x_all)+0.2]);
set(gca, 'FontSize', 15); % Set category labels
grid on;
hold off;
