
n=config('SinIR_model.txt');


% Continuation method for bifurcation diagram
ap_start = 0.001; % Start value for gr
ap_end = 2; % End value for gr
dap = 0.0001; % Increment for gr
gr = 0.2; % Set ap value (it's not the bifurcation parameter in this example)

          ap_values = ap_start:dap:ap_end;
          ap_values = [ap_end:-dap:ap_start]; %Comment to get the low black line

SS_values = zeros(length(ap_values), 8);
Tap_value=zeros(length(ap_values), 1);

x0 = [0, 0, 0.7, 0, 0, 0, 0, 0.7]; % Initial condition, modify as needed

tspan = [0, 60]; % Time span for ODE solver

% Generate the bifurcation diagram
for i = 1:length(ap_values)
    ap = ap_values(i);
    [~, y] = ode15s(@(t, x) SinIR(t, x, ap, gr), tspan, x0);
    x_ss = y(end, :);
    SS_values(i, :) = x_ss;
    x0 = x_ss;

    Tap_value(i)=SS_values(i, 8);
end


%figure
plot(ap_values, SS_values(:, 8),'.','MarkerSize',20);hold on;
xlabel('[Spo0A~P] (µM)');
ylabel('TapA steady state');
set(gca, 'FontSize', 15);

xlim([0 0.8])
ylim([0 1])



currentFigure = gcf;
currentFigure.Position = [100, 500, 680, 300]; % [left, bottom, width, height]
% saveas(gcf, 'Additivity.svg');