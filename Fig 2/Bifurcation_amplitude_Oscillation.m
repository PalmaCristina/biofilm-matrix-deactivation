[Ap, ts,kgrowths1, tss,tsers,tdivs]=PhosphorelayGrowthModel_CP %Run Phospho model


diff_ap=diff(Ap);
[r c]=find(diff_ap==0);
Ap(r) = [];
ts(r) = [];
kgrowths1(r)= [];

Ap_f=Ap;

n=config('SinIR_model.txt');


x0 = [0, 0, 0.6, 0, 0, 0, 0, 0.6]; % Initial condition, modify as needed
tspan = [0, 70]; % Time span for ODE solver


[x, y] = ode15s(@(t,x)SinIR(t,x,kgrowths1,Ap_f,ts),[0,70],x0); 

x_ss = y(end, :);
Tap_value=y(:, 8);


% figure
subplot(311)
map=1;box on;
plot(ts,kgrowths1,'k',LineWidth=3);ylim([0 map]);xlim([0 max(ts)]);set(gca,'FontSize',15);hold on;
line([tdivs;tdivs],[zeros(1,numel(tdivs));map*ones(1,numel(tdivs))],'LineStyle',':','Color','k');
set(gca,'XTick',0:10:max(ts),'YTick',0:.2:max(kgrowths1));
%xlabel('Time(h)');
ylabel('Growth Rate (h^{-1})');
xlim([0 70])
ylim([0 0.52])

subplot(312)
map=max(Ap_f)+1;
plot(ts,Ap_f,'Color',[0    0.4471    0.7412],LineWidth=3);xlim([0 max(ts)]);ylim([0 map]);set(gca,'FontSize',15);hold on;
line([tdivs;tdivs],[zeros(1,numel(tdivs));map*ones(1,numel(tdivs))],'LineStyle',':','Color','k');
set(gca,'XTick',0:10:max(ts));box on;
%xlabel('Time(h)');
ylabel('[0A~P] (\muM)');
xlim([0 70])
ylim([0 2.5])

subplot(313)
plot(x, Tap_value,'Color',[0    0.4471    0.7412],LineWidth=3);hold on;set(gca,'FontSize',15)
ylabel('[TapA] (\muM)');
xlabel('Time (h)');
xlim([0 70])
ylim([0 1.2])