
gr=0.2;

[Ap, ts,kgrowths1, tss,tsers,tdivs]=PhosphorelayGrowthModel_CP_10(gr) %Modified to change cell cycle in a specific way

diff_ap=diff(Ap);
[r c]=find(diff_ap==0);
Ap(r) = [];
ts(r) = [];
kgrowths1(r)= [];
Ap_f=Ap

n=config('SinIR_model.txt');



x0 = [0, 0, 0.7, 0, 0, 0, 0, 0.7]; % Initial condition, modify as needed
tspan = [0, 450]; % Time span for ODE solver


[x, y] = ode15s(@(t,x)SinIR(t,x,kgrowths1,Ap_f,ts),[0,450],x0); 

x_ss = y(end, :);
Tap_value=y(:, 8);


figure
subplot(311)
map=0.5;box on;
area(tss,map*tsers,'FaceColor',0.9*ones(1,3),'EdgeColor','none');hold on;
plot(ts,kgrowths1,'b');ylim([0 map]);xlim([0 max(ts)]);set(gca,'FontSize',15);hold on;
line([tdivs;tdivs],[zeros(1,numel(tdivs));map*ones(1,numel(tdivs))],'LineStyle',':','Color','k');
set(gca,'XTick',0:10:max(ts),'YTick',0:.1:max(kgrowths1));
xlabel('Time(h)');ylabel('Growth Rate (hr^{-1})');
subplot(312)
map=max(Ap_f);
area(tss,map*tsers,'FaceColor',0.9*ones(1,3),'EdgeColor','none');hold on;
plot(ts,Ap_f,'r');xlim([0 max(ts)]);ylim([0 map]);set(gca,'FontSize',15);hold on;
line([tdivs;tdivs],[zeros(1,numel(tdivs));map*ones(1,numel(tdivs))],'LineStyle',':','Color','k');
set(gca,'XTick',0:10:max(ts));box on;
xlabel('Time(h)');ylabel('[0A~P] (\muM)');
subplot(313)

plot(x, Tap_value, 'g','Linewidth',1.5);hold on;set(gca,'FontSize',15)
ylabel('[TapA] uM');
xlabel('Time (h)');

%Delete until SS of first peak (to avoid hving that big peak in the
%beggining)
cut_time=find(ts==(log(2)/kgrowths1(1,1))*2);


figure
map=3*max(Ap_f);
area(tss(1000:end,1)-tdivs(:,2),map*tsers(1000:end,1),'FaceColor',0.9*ones(1,3),'EdgeColor','none');hold on;
plot(ts(cut_time:end,1)-ts(cut_time,1),Ap_f(cut_time:end,1),'r', LineWidth=2);xlim([0 max(ts)]);ylim([0 map]);set(gca,'FontSize',15)
line([tdivs(:,3:end)-tdivs(:,2);tdivs(:,3:end)-tdivs(:,2)],[zeros(1,numel(tdivs(:,3:end)));map*ones(1,numel(tdivs(:,3:end)))],'LineStyle',':','Color','k');
set(gca,'XTick',0:10:max(ts));box on;
xlabel('Time(h)');ylabel('[0A~P] (\muM)');

% Identify and print deactivation cycle

[r c] = find (Tap_value < 0.5)
[v index]=min(abs(ts-x(r(1,1),1)));

Cell_cycle_deactivation=log(2)/kgrowths1(index,1) 