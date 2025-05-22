
n=config('SinIR_CP.txt');


% Continuation method for bifurcation diagram
gr_start =0.02; %0.02; % Start value for gr
gr_end = 1.2; % End value for gr
dgr = 0.001; % Increment for gr
%ap = 4; % Set ap value (it's not the bifurcation parameter in this example)


     gr_values = gr_start:dgr:gr_end;
     gr_values = [gr_end:-dgr:gr_start];

SS_values = zeros(length(gr_values), 8);
Tap_value=zeros(length(gr_values), 1);

x0 = [0, 0, 0.5, 0, 0, 0, 0, 0]; % Initial condition, modify as needed

tspan = [0, 100]; % Time span for ODE solver

% Generate the bifurcation diagram
for i = 1:length(gr_values)
    gr = gr_values(i);
    [~, y] = ode15s(@(t, x) SinIR(t, x, ap, gr), tspan, x0);
    x_ss = y(end, :);
    SS_values(i, :) = x_ss;
    x0 = x_ss;

    Tap_value(i)=SS_values(i, 8);
end



