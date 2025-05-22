[Ap, ts,kgrowths1, tss,tsers,tdivs]=PhosphorelayGrowthModel_CP

%Calculate Mean of Ap
% Define the row numbers to calculate the means between
 row_numbers =find(diff(kgrowths1)~=0)
 row_numbers(end+1,1)=size(Ap,1);
% Initialize an array to store the mean values
means = zeros(length(row_numbers), 1);

% Calculate the means for each range
start_idx = 1; % Start from the first row
for i = 1:length(row_numbers)
    end_idx = row_numbers(i);
    Ap_means(start_idx:end_idx) = min(Ap(start_idx:end_idx));
    start_idx = end_idx + 1; % Update start index for the next range
end



[ts, ia] = unique(ts, 'stable'); % 'stable' keeps the original order
Ap_means = Ap_means(ia);
kgrowths1 = kgrowths1(ia);

% plot(ts,Ap_means,'LineWidth',2)

%Ap_f=Ap_means*3;
Ap_f=Ap_means


%plot(ts,Ap_f,'LineWidth',2)


n=config('SinIR_model.txt');

gr=0.5;


x0 = [0, 0, 0.6, 0, 0, 0, 0, 0.6]; % Initial condition, modify as needed
tspan = [0, 70]; % Time span for ODE solver


[x, y] = ode15s(@(t,x)SinIR(t,x,kgrowths1,Ap_f,ts),[0,70],x0); 

x_ss = y(end, :);
Tap_value=y(:, 8);


figure
subplot(311)
map=2;box on;
%area(tss,map*tsers,'FaceColor',0.9*ones(1,3),'EdgeColor','none');hold on;
plot(ts,kgrowths1,'k','Linewidth',3);ylim([0 map]);xlim([0 max(ts)]);set(gca,'FontSize',15)
line([tdivs;tdivs],[zeros(1,numel(tdivs));map*ones(1,numel(tdivs))],'LineStyle',':','Color','k');
set(gca,'XTick',0:10:max(ts),'YTick',0:.1:max(kgrowths1));
% xlabel('Time(h)');
ylabel('Growth Rate (h^{-1})');
xlim([0 70])
ylim([0 0.52])

subplot(312)
map=max(Ap_f)*50;
%area(tss,map*tsers,'FaceColor',0.9*ones(1,3),'EdgeColor','none');hold on;
plot(ts,Ap_f,'Color',[0.4941    0.1843    0.5569],'Linewidth',3);xlim([0 max(ts)]);ylim([0 map]);set(gca,'FontSize',15)
line([tdivs;tdivs],[zeros(1,numel(tdivs));map*ones(1,numel(tdivs))],'LineStyle',':','Color','k');
set(gca,'XTick',0:10:max(ts));box on;
% xlabel('Time(h)');
ylabel('[0A~P] (\muM)');
xlim([0 70])
ylim([0 2.5])

subplot(313)
plot(x, Tap_value, 'Color',[0.4941    0.1843    0.5569],'Linewidth',3);hold on;set(gca,'FontSize',15)
ylabel('[TapA] (\muM)');
xlabel('Time (h)');
xlim([0 70])
ylim([0 1.2])

