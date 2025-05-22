n=config('SinIR_model.txt');

gr=0.2;


SS_values = zeros(length(pulse_off_duration_v), 8);
Tap_value=zeros(length(pulse_off_duration_v), 1);


x0 = [0, 0, 0.7, 0, 0, 0, 0, 0]; % Initial condition, modify as needed
tspan = [0, 100]; % Time span for ODE solver
time_points=[0:0.01:100];

% Generate the bifurcation diagram
for i = 1:length(pulse_off_duration_v)
    pulse_off_duration = pulse_off_duration_v(i);
    pulse_on_duration = pulse_on_duration_v(i);
    % [time_model, y] = ode15s(@(t,x)SinIR(t,x,gr,pulse_on_duration,pulse_off_duration, pulse_height),[0,100],x0);
    [time_model, y] = ode15s(@(t,x)SinIR(t,x,gr,pulse_on_duration,pulse_off_duration, pulse_height),time_points,x0);
    spo0Ap_amount=spo0Ap_dynamics_square(time_model,pulse_on_duration, pulse_off_duration,pulse_height);
    % figure
    % plot(time_model,spo0Ap_amount)
    % figure
    % plot(time_model, y(:, 8))
    x_ss = y(end, :);
    SS_values(i, :) = x_ss;
    % x0 = x_ss;

    Tap_value(i)=SS_values(i, 8);
    T(1,i)=SS_values(i, 8);
    T(2,i)=pulse_off_duration+pulse_on_duration;
    T(3,i)=pulse_on_duration;
    T(4,i)=pulse_off_duration;
end


% plot(pulse_off_duration_v, SS_values(:, 8),'.','MarkerSize',20);hold on;
% xlabel('Pulse OFF duration (h)');
% ylabel('[TapA] steady state');




