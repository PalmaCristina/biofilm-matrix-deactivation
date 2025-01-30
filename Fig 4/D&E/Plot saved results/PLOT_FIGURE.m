% Plot final figure

%% Plot constant 0A~P diagram
% Bistability diagram constant produced the .mat file for the constant results. It takes 1 night to run because the step is small for GR

load('Constant_0A~P_diagram.mat')
figure(4)
plot(x_boundary, y_boundary,'-', 'LineWidth', 3,'Color',[0.8510    0.3255    0.0980]); hold on;
xlabel('Growth Rate (h^{-1})');
ylabel('[0A~P] (uM)');
xlim([0 0.8])
ylim([0 8])

figure(6)
plot(x_boundary, y_boundary,'-', 'LineWidth', 3,'Color',[0.8510    0.3255    0.0980]); hold on;
xlabel('Growth Rate (h^{-1})');
ylabel('[0A~P] (uM)');
xlim([0 0.8])
ylim([0 1])


%% %% Plot oscillation with a given period
load('Results.mat')


freq_v=freq_v(1,[2,3,5,7]); %Choose only the ones I decided to plot
x1=x1(1,[2,3,5,7]);
y1=y1(1,[2,3,5,7]);


set(gca,'colororder',parula(32))
color_map = lines(length(freq_v));
color_codes = color_map;
color_codes(end-1,:)=0.5;
color_codes(end,:)=0;


for i=1:1:size(x1,2)

figure(4)
xq=linspace(0.05, 0.9, 1000);
y1q{i}=interp1(x1{i},y1{i},xq)
s{i}=scatter(xq, y1q{i},'Color',[color_codes(i,:)]); hold on;
xlim([0 0.8])
ylim([0 6.5])
xlabel('GR (h^{-1})');
ylabel('[0A~P] (uM)');
title('Original from simulations')

figure(5)
s{i}=scatter(log(2)./xq, y1q{i},'Color',[color_codes(i,:)]); hold on;
xlim([0.8 7])
ylim([0 8])
xlabel('Cell cycle (h)');
ylabel('[0A~P] (uM)');
title('Original from simulations')

end

y_6=y1q{1};
y_5=y1q{2};
y_3=y1q{3};
y_1=y1q{4};

%6
[c index]=min(abs(y1q{1}-2.5))
y_6=y1q{1}(1,index:end);
xq_6=xq(1,index:end);

%5
[c index]=min(abs(y1q{2}-2.5))
y_5=y1q{2}(1,index:end);
xq_5=xq(1,index:end);

%3
[c index]=min(abs(y1q{3}-2.5))
y_3=y1q{3}(1,index:end);
xq_3=xq(1,index:end);

%1
[c index]=min(abs(y1q{4}-2.5))
y_1=y1q{4}(1,index:end);
xq_1=xq(1,index:end);

%% Fit exponentials
%Fits done with curve fitting tool box and saved
xFit = linspace(0.05, 0.9, 1000);
figure(4)

load('models_power_2.mat')
%T=6
yFit6 = feval(fittedmodel_6, xq);
yFit5 = feval(fittedmodel_5, xq);
yFit3 = feval(fittedmodel_3, xq);
yFit1 = feval(fittedmodel_1, xq);

plot(xq,yFit6,'LineWidth',1,'LineStyle','-'); hold on;
%s{i}=scatter(xq, y1q{1},'Color',[color_codes(i,:)]); hold on;

plot(xq,yFit5,'LineWidth',1,'LineStyle','-'); hold on;
%s{i}=scatter(xq, y1q{2},'Color',[color_codes(i,:)]); hold on;

plot(xq,yFit3,'LineWidth',1,'LineStyle','-'); hold on;
%s{i}=scatter(xq, y1q{3},'Color',[color_codes(i,:)]); hold on;

plot(xq,yFit1,'LineWidth',1,'LineStyle','-'); hold on;
%s{i}=scatter(xq, y1q{4},'Color',[color_codes(i,:)]); hold on;

xlim([0 0.8])
ylim([0 2])

% Plot inverse

figure(7)
plot(log(2)./xq,yFit6,'LineWidth',1,'LineStyle','-'); hold on;
plot(log(2)./xq,yFit5,'LineWidth',1,'LineStyle','-'); hold on;
plot(log(2)./xq,yFit3,'LineWidth',1,'LineStyle','-'); hold on;
plot(log(2)./xq,yFit1,'LineWidth',1,'LineStyle','-'); hold on;

% s{i}=scatter(log(2)./xq, y1q{1},'Color',[color_codes(i,:)]); hold on;
% s{i}=scatter(log(2)./xq, y1q{2},'Color',[color_codes(i,:)]); hold on;
% s{i}=scatter(log(2)./xq, y1q{3},'Color',[color_codes(i,:)]); hold on;
% s{i}=scatter(log(2)./xq, y1q{4},'Color',[color_codes(i,:)]); hold on;


title('Fit power 2')
xlabel('Cell cycle (h)');
ylabel('[0A~P] (uM)');


xlim([0.8 7])
ylim([0 2])


%% 

%Find point of one oscilation per cell cycle
xfit=(6.28./freq_v); %convert to GR
Val_natural(1)=feval(fittedmodel_6, log(2)/xfit(1));
Val_natural(2)=feval(fittedmodel_5, log(2)/xfit(2));
Val_natural(3)=feval(fittedmodel_3, log(2)/xfit(3));
Val_natural(4)=feval(fittedmodel_1, log(2)/xfit(4));

scatter(xfit, Val_natural,30,'filled','b')
%Fit model

load('model_fit_one_oscilation.mat')
plot(model_fit_one_oscilation_001,'b')
xlabel('Cell cycle length (h)');
ylabel('[0A~P] oscillation ');
xlim([0.8 7])
ylim([0 2])

%% Figure comparing constant with ones oscillation per cell cycle

% One oscillation per cell cycle
xFit = linspace(0, 8, 1000);
one_oscillation_cell_cycle=feval(model_fit_one_oscilation_001, xFit);

figure(6)
plot(log(2)./xFit, one_oscillation_cell_cycle,'b',LineWidth=2)
ylabel('[0A~P] (µM)');

xlim([0 0.8])
ylim([0 2])

%  currentFigure = gcf;
%  set(gca,'FontSize',20)
%  currentFigure.Position = [100, 500, 580, 400]; % [left, bottom, width, height]
%  saveas(gcf, 'E.svg');
