% Bar plot

kon_best = 0.0229; %0.0281;


koff_best_c = 0.0553; %0.0574;


koff_best_o = 0.1474; %0.1330;

% Data for the bar plot
categories = {'k_{ON}', 'k_{OFF} _{constant}', 'k_{OFF} _{pulsing}'};
values = [kon_best, koff_best_c, koff_best_o];

% Create the bar plot
figure;
bar(values, 0.6); % 0.6 sets the bar width
set(gca, 'XTickLabel', categories, 'FontSize', 12); % Set category labels
%xlabel('Rates', 'FontSize', 12);
ylabel('Values (h^{-1})', 'FontSize', 12);
grid on; % Optional: add a grid

%% Extra bar plot
% Example data: 4 groups (dots), 3 bars per group
data = [0.0343;
        0.0222;    % Kon values fit1 and fit2
        0.0779;   % Koff constant
        0.1229];   % group 3
       

% Create grouped bar plot
figure;
bar(data, 'grouped');

% Set x-axis labels (optional)
xticklabels({'k_{ON} _{constant}','k_{ON} _{pulsing}', 'k_{OFF} _{constant}', 'k_{OFF} _{pulsing}'});

% Add legend (optional)
legend({'Fit with constrained k_{ON}', 'Free fit'});
xtickangle(45);
ylabel('Values (h^{-1})', 'FontSize', 12);
grid on; % Optional: add a grid
set(gca, 'FontSize', 20); % Set category labels



%% Bar plot

kon_best_c = 0.0343; %0.0281;

kon_best_o = 0.0222; %0.0281;


koff_best_c = 0.0779; %0.0574;


koff_best_o = 0.1229; %0.1330;

% Data for the bar plot
categories = {'k_{ON} _{constant}','k_{ON} _{pulsing}', 'k_{OFF} _{constant}', 'k_{OFF} _{pulsing}'};
values = [kon_best_c,kon_best_o, koff_best_c, koff_best_o];

% Create the bar plot
figure;
bar(values, 0.5); % 0.6 sets the bar width
set(gca, 'XTickLabel', categories, 'FontSize', 12); % Set category labels
%xlabel('Rates', 'FontSize', 12);
ylabel('Values (h^{-1})', 'FontSize', 12);
grid on; % Optional: add a grid
ylim([0 0.13])