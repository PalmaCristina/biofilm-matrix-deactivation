
load('DATA_C_ACTIVATION.mat')
load('DATA_C_DEACTIVATION')

load('DATA_O_ACTIVATION.mat')
load('DATA_O_DEACTIVATION')

uon=1;
uoff=18; % To allow for a full oscilattion to happen the equivalent time is cut off
ton=501;
toff=501;

% Define your data sets
x1 = Inspect_times_02_C_A(:,uon:ton)-Inspect_times_02_C_A(:,uon); % Replace with your x1 data
y1 = P_ON_C_A(:,uon:ton)-P_ON_C_A(:,uon); % Replace with your y1 data

x2 = Inspect_times_02_C_D(:,uoff:toff)-Inspect_times_02_C_D(:,uoff); % Replace with your x2 data
y2 = P_OFF_C_D(:,uoff:toff)-P_OFF_C_D(:,uoff); % Replace with your y2 data

x3 = Inspect_times_02_O_A(:,uon:ton)-Inspect_times_02_O_A(:,uon); % Replace with your x1 data
y3 = P_ON_O_A(:,uon:ton)-P_ON_O_A(:,uon); % Replace with your y1 data


x4 = Inspect_times_02_O_D(:,uoff:toff)-Inspect_times_02_O_D(:,uoff); % Replace with your x2 data
y4= P_OFF_O_D(:,uoff:toff)-P_OFF_O_D(:,uoff); % Replace with your y2 data


% Define the fitting functions
%For constant parameters
fun1 = @(params, x) (params(1) / (params(1) + params(2))) * (1 - exp(-x * (params(1) + params(2))));
fun2 = @(params, x) (params(2) / (params(1) + params(2))) * (1 - exp(-x * (params(1) + params(2))));
%For oscillatory parameters
fun3 = @(params, x) (params(1) / (params(1) + params(3))) * (1 - exp(-x * (params(1) + params(3))));
fun4 = @(params, x) (params(3) / (params(1) + params(3))) * (1 - exp(-x * (params(1) + params(3))));

%mse=sum((Outputs-Measurements).^2./(Measurements).^2);
% Objective function to minimize
objective = @(params) sum(((y1 - fun1(params, x1))/y1).^2) + sum(((y2 - fun2(params, x2))/y2).^2) + sum(((y3 - fun3(params, x3))/y3).^2)...
    + sum(((y4 - fun4(params, x4))/y4).^2);


% objective = @(params) sum((y1 - fun1(params, x1)).^2)./y1.^2 + sum((y2 - fun2(params, x2)).^2)./y2.^2 + sum((y3 - fun3(params, x3)).^2)./y3.^2 ...
%     + sum((y4 - fun4(params, x4)).^2)./y4.^2;

% Initial guess for [kon, koff]
initial_guess = [0.0294,0.0777,0.1102]; % Replace with your initial guess
initial_guess = [0.01,0.4,0.3];
% Perform the fitting using fminsearch
lb = [0, 0,0]; % Replace with your bounds
ub = [0.5, 0.5,0.5]; % Replace with your bounds

% Perform the fitting using fmincon
options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');
best_params = fmincon(objective, initial_guess, [], [], [], [], lb, ub, [], options);

% Extract the best fitting parameters
kon_best = best_params(1)
koff_best_c = best_params(2)
koff_best_o = best_params(3)

% Optionally, plot the data and the fits
figure(1);
%subplot(1, 2, 1);
s1=scatter(x1, y1, 'o','MarkerEdgeColor',[0.8510    0.3255    0.0980],'MarkerFaceColor',[0.8510    0.3255    0.0980],'MarkerFaceAlpha',0.03,'MarkerEdgeAlpha',0.03); hold on;
s2=plot(x1, fun1(best_params, x1), '-','Color',[1.0000    0.4118    0.1608],'LineWidth',4); hold on;
% Calculate MSE
residuals = y1 - fun1(best_params, x1);      % Differences
mse_x1 = mean(residuals.^2) % Mean of squared differences


s3=scatter(x3, y3, 'o','MarkerEdgeColor',[0    0.4471    0.7412],'MarkerFaceColor',[0    0.4471    0.7412],'MarkerFaceAlpha',0.03,'MarkerEdgeAlpha',0.03); hold on;
s4=plot(x3, fun3(best_params, x3), '-','Color',[0    0.4471    0.7412],'LineWidth',4); hold on;
% Calculate MSE
residuals = y3 - fun3(best_params, x3);      % Differences
mse_x3 = mean(residuals.^2) % Mean of squared differences


xlabel('Time (h)');
ylabel('Fraction of active cells');
% legend('Constant 0A~P', 'Best-fit','Natural 0A~P Oscilation', 'Best-fit');
ylim([0 2])
set(gca,'FontSize',15)

currentFigure = gcf;
currentFigure.Position = [100, 500, 580, 500]; % [left, bottom, width, height]
saveas(gcf, 'P_ON.svg');

figure(1);
%subplot(1, 2, 2);
scatter(x2, 1-y2, 'o','MarkerEdgeColor',[0.8510    0.3255    0.0980],'MarkerFaceColor',[0.8510    0.3255    0.0980],'MarkerFaceAlpha',0.03,'MarkerEdgeAlpha',0.03); hold on;
plot(x2, 1-fun2(best_params, x2), '-','Color',[1.0000    0.4118    0.1608],'LineWidth',4); hold on;
% Calculate MSE
residuals = (1-y2) - (1-fun2(best_params, x2));  % Differences
mse_x2 = mean(residuals.^2) % Mean of squared differences

scatter(x4, 1-y4, 'o','MarkerEdgeColor',[0    0.4471    0.7412],'MarkerFaceColor',[0    0.4471    0.7412],'MarkerFaceAlpha',0.03,'MarkerEdgeAlpha',0.03); hold on;
plot(x4, 1-fun4(best_params, x4), '-','Color',[0    0.4471    0.7412],'LineWidth',4); hold on;
% Calculate MSE
residuals = (1-y4) - (1-fun4(best_params, x4));      % Differences
mse_x4 = mean(residuals.^2) % Mean of squared differences

xlabel('Time (h)');
ylabel('Fraction of active cells');
ylim([0 1])
xlim([0 40])
set(gca,'FontSize',15)

currentFigure = gcf;
currentFigure.Position = [100, 500, 580, 300]; % [left, bottom, width, height]
saveas(gcf, 'P_OFF.svg');
%% R2 VALUES
figure
[fitresultC, gofx1] = createFit(x1,y1,best_params(1),best_params(2),1); hold on;
% hC = plot( fitresultC, x1, y1 ); hold on;
% hC(1).Color=[  0.8510    0.3255    0.0980];
% hC(1).LineStyle='-';
% hC(1).LineWidth=1;
% hC(1).Marker='none';
% hC(2).Color=[  0.8510    0.3255    0.0980];
% hC(2).LineStyle='--';
% hC(2).LineWidth=2;
% gofx1

[fitresultC, gofx3] = createFit(x3,y3,best_params(1),best_params(3),1); hold on;
hC = plot( fitresultC, x3, y3 ); hold on;
% hC(1).Color='b';
% hC(1).LineStyle='-';
% hC(1).LineWidth=1;
% hC(1).Marker='none';
% hC(2).Color='b';
% hC(2).LineStyle='--';
% hC(2).LineWidth=2;
% gofx3
% ylabel('P ON')
% xlabel('Time (h)')

figure
[fitresultC, gofx2] = createFit(x2,y2,best_params(1),best_params(2),2);hold on;
% hC = plot( fitresultC, x2, y2 ); hold on;
% hC(1).Color=[  0.8510    0.3255    0.0980];
% hC(1).LineStyle='-';
% hC(1).LineWidth=1;
% hC(1).Marker='none';
% hC(2).Color=[  0.8510    0.3255    0.0980];
% hC(2).LineStyle='--';
% hC(2).LineWidth=2;
% gofx2

[fitresultC, gofx4] = createFit(x4,y4,best_params(1),best_params(3),2);hold on;
% hC = plot(fitresultC, x4, y4 ); hold on;
% hC(1).Color='b';
% hC(1).LineStyle='-';
% hC(1).LineWidth=1;
% hC(1).Marker='none';
% hC(2).Color='b';
% hC(2).LineStyle='--';
% hC(2).LineWidth=2;
% gofx4
% ylabel('P OFF')
% xlabel('Time (h)')


figure(1)
text('Units', 'normalized', 'Position', [0.7, 0.9], 'String', sprintf('kon = %.4f\nkoff_C = %.4f\nkoff_O = %.4f\nR^{2} = %.2f\nR^{2} = %.2f\nR^{2} = %.2f\nR^{2} = %.2f', kon_best, koff_best_c, koff_best_o, gofx1.rsquare, gofx2.rsquare, gofx3.rsquare, gofx4.rsquare), 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
set(gca,'FontSize',15)

%% Print values in txt box



function [fitresult, gof] = createFit(xData, yData,koff_fit, kon_fit,t)

%[xData, yData] = prepareCurveData(Inspect_times_02_C, P_ON_C,koff_fit, kon_fit);

if t==1
ft = fittype( '(kon/(kon+koff))*(1-exp(-x*(kon+koff)))', 'independent', 'x', 'dependent', 'y' );
end

if t==2
ft = fittype( '(koff/(kon+koff))*(1-exp(-x*(kon+koff)))', 'independent', 'x', 'dependent', 'y' );
end

opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.262971284540144 0.654079098476782];
%opts.StartPoint = [0 0];
opts.Lower=[kon_fit koff_fit];
opts.Upper=[kon_fit koff_fit];
% Fit model to data.
[fitresult, gof] = fit( xData.', yData.', ft, opts );

% Plot fit with data.
% figure
% h = plot( fitresult, xData, yData ); hold on;
% % Label axes
% xlabel( 'Inspect_times_02_C', 'Interpreter', 'none' );
% ylabel( 'P_ON_C', 'Interpreter', 'none' );
% grid on

end


