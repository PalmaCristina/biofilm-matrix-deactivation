n=config('SinIR_model.txt');
%n=config('SinIR_CP_test.txt');

gr=0.2;
min_val=0;
%freq=6.28


% Continuation method for bifurcation diagram
max_val_start =min_val; % Start value for gr
max_val_end = 4 %15; % End value for gr
dmax_val = 0.01; % Increment for gr



     % max_val_v = max_val_start:dmax_val:max_val_end;
     max_val_v = [max_val_end:-dmax_val:max_val_start];


amplitude = (max_val_v - min_val) / 2;
offset = (max_val_v + min_val) / 2;

for k=1:size(amplitude,2)

x=1:0.01:100;
oscilation=amplitude(k)*cos(freq*(x))+offset(k);
oscilation_mean(1,k)=mean(oscilation); 
end


SS_values = zeros(length(max_val_v), 8);
Tap_value=zeros(length(max_val_v), 1);


x0 = [0, 0, 0.5, 0, 0, 0, 0, 0]; % Initial condition, modify as needed
tspan = [0, 100]; % Time span for ODE solver


% Generate the bifurcation diagram
for i = 1:length(max_val_v)
    max_val = max_val_v(i);
%     [~, y] = ode15s(@(t, x) SinIR(t, x, gr,amp,p), tspan, x0);
    [~, y] = ode15s(@(t,x)SinIR(t,x,gr,max_val,min_val,freq),[0,100],x0);
    x_ss = y(end, :);
    SS_values(i, :) = x_ss;
    x0 = x_ss;

    Tap_value(i)=SS_values(i, 8);
end

var_names = {'I', 'IR', 'Id', 'L', 'LR', 'R', 'Rt', 'T'};

     plot(oscilation_mean, SS_values(:, 8),'.','MarkerSize',20);hold on;
     xlabel('Oscilation mean');
     ylabel('[TapA] steady state');


