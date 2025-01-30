% Bar plot

kon_best = 0.0281;


koff_best_c = 0.0574;


koff_best_o = 0.1330;

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