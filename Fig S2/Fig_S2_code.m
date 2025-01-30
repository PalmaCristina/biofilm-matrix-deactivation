% Load your data
load('SS_values.mat')
TapA_values=x_SS_02(:,17);
data = [TapA_values];
    

% Create a histogram
edges = linspace(0, max(data), 200); % 200 bins
bin_centers = edges(1:end-1) + diff(edges)/2; % Bin centers
hist_values = histcounts(data, edges, 'Normalization', 'pdf'); % Normalized histogram

% Define Gaussian function
gaussian = @(params, x) params(1) * exp(-((x - params(2)).^2) / (2 * params(3)^2));

% Define the combined model (sum of two Gaussians)
combined_model = @(params, x) ...
    gaussian(params(1:3), x) + ...
    gaussian(params(4:6), x);

% Initial guesses for parameters [amp1, mean1, std1, amp2, mean2, std2]
%initial_params = [0.01, 100, 50, 0.01, 600, 100];
initial_params = [0.01, 50, 50, 0.01, 600, 100];

% Set bounds for the parameters
lower_bounds = [0.005, 0, 70, 0, 400, 50];   % Lower bounds
upper_bounds = [0.005, 10, 100, Inf, 800, 300]; % Upper bounds

% Fit the model using lsqcurvefit
xdata = bin_centers';
ydata = hist_values';
options = optimset('MaxFunEvals', 5000); % Increase max iterations
fit_params = lsqcurvefit(combined_model, initial_params, xdata, ydata, lower_bounds, upper_bounds, options);

% Generate the fitted Gaussians
fit_gauss1 = gaussian(fit_params(1:3), xdata);
fit_gauss2 = gaussian(fit_params(4:6), xdata);
fit_total = fit_gauss1 + fit_gauss2;

% Plot the histogram and fits
figure;
%bar(bin_centers, hist_values, 'histc', 'FaceAlpha', 0.5, 'EdgeColor', 'none');

histogram(data, 'BinWidth', 10, 'Normalization', 'pdf', 'FaceColor', [0.3, 0.3, 1], 'EdgeColor', 'none');

hold on;
plot(xdata, fit_gauss1, 'LineWidth', 4, 'DisplayName', sprintf('Gaussian 1: mean=%.2f, std=%.2f', fit_params(2), fit_params(3)));
plot(xdata, fit_gauss2, 'LineWidth', 4, 'DisplayName', sprintf('Gaussian 2: mean=%.2f, std=%.2f', fit_params(5), fit_params(6)));
%plot(xdata, fit_total, '--', 'LineWidth', 2, 'DisplayName', 'Total Fit');
xlabel('Values');
ylabel('Density');
ylim([0 0.005])
xlim([0 1600])
set(gca,'FontSize',15)
hold off;
ylabel('PDF')
xlabel('TapA molecules')
