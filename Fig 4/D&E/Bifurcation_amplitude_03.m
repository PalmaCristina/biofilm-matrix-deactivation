%n=config('SinIR_CP_v2_slrR_stable.txt');
n=config('SinIR_CP_model.txt');

% Continuation method for bifurcation diagram
gr_start =0.001; %0.02; % Start value for gr
gr_end = 3; % End value for gr
dgr = 0.01; %0.01; % Increment for gr


gr_values = [gr_end:-dgr:gr_start];


amplitude = (max_val_v - min_val) / 2;
offset = (max_val_v + min_val) / 2;

for k=1:size(amplitude,2)

x=1:0.01:100;
oscilation=amplitude(k)*cos(freq*(x))+offset(k);
oscilation_mean(1,k)=mean(oscilation); 
end


SS_values = zeros(length(max_val), 8);
Tap_value=zeros(length(max_val), 1);


x0 = [0, 0, 0.5, 0, 0, 0, 0, 0]; % Initial condition, modify as needed
tspan = [0, 60]; % Time span for ODE solver


% Generate the bifurcation diagram
for i = 1:length(gr_values)
    gr = gr_values(i);
%     [~, y] = ode15s(@(t, x) SinIR(t, x, gr,amp,p), tspan, x0);
    [~, y] = ode15s(@(t,x)SinIR(t,x,gr,max_val,min_val,freq),[0,100],x0);
    x_ss = y(end, :);
    SS_values(i, :) = x_ss;
    x0 = x_ss;

    Tap_value(i)=SS_values(i, 8);
end

var_names = {'I', 'IR', 'Id', 'L', 'LR', 'R', 'Rt', 'T'};
%  [unstable_eq_points, unstable_ap_values]=Unstable_Newton_ap_CP;
% 
 %for i = 1:8
% for i = 8
%     fig1=subplot(2, 4, i);
%     plot(gr_values, SS_values(:, i),'.');hold on;
%     xlabel('gr (h^{-1})');
%     ylabel(sprintf('%s Steady State', var_names{1,i}));
%     title(sprintf('Bifurcation Diagram for %s', var_names{1,i}));
% end

% %     figure
%     fig2=subplot(2, 4, i);
%     plot(amplitude, SS_values(:, i), '.','MarkerSize',10);hold on;
%     xlabel('amp');

%     figure
%     fig3=subplot(2, 4, i);
%     plot(offset, SS_values(:, i), '.','MarkerSize',10);hold on;
%     xlabel('offset');

% %      figure
% %     fig4=subplot(2, 4, i);
    % plot(gr_values, SS_values(:, 8), '.','MarkerSize',10);hold on;
    % xlabel('gr_values');
    % ylabel('TapA steady state');
% % plot(unstable_ap_values, unstable_eq_points(:,i), '--','Color','k');
% 


% %      plot(unstable_ap_values, unstable_eq_points(:,i), '--','Color','k');

  
%     ylabel(sprintf('%s Steady State', var_names{1,i}));
%     title(sprintf('Bifurcation Diagram for %s', var_names{1,i}));
% end
