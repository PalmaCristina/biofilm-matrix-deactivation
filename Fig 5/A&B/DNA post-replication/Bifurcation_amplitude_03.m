[Ap, ts,kgrowths1, tss,tsers,tdivs]=PhosphorelayGrowthModel_CP

diff_ap=diff(Ap);
[r c]=find(diff_ap==0);
Ap(r) = [];
ts(r) = [];
kgrowths1(r)= [];
Ap_f=Ap

%Delete until SS of first peak (to avoid hving that big peak in the
%beggining)
cut_time=find(ts==(log(2)/kgrowths1(1,1))*5);


figure
map=3*max(Ap_f);
area(tss(1500:end,1)-tdivs(:,5),map*tsers(1500:end,1),'FaceColor',0.9*ones(1,3),'EdgeColor','none');hold on;
%area(tss,map*tsers,'FaceColor',0.9*ones(1,3),'EdgeColor','none');hold on;
plot(ts(cut_time:end,1)-ts(cut_time,1),Ap_f(cut_time:end,1),'r', LineWidth=2);xlim([0 max(ts)]);ylim([0 map]);set(gca,'FontSize',15)
%plot(ts,Ap_f,'r', LineWidth=2);xlim([0 max(ts)]);ylim([0 map]);set(gca,'FontSize',15)
line([tdivs(:,5:end)-tdivs(1,5);tdivs(:,5:end)-tdivs(1,5)],[zeros(1,numel(tdivs(:,5:end)));map*ones(1,numel(tdivs(:,5:end)))],'LineStyle',':','Color','k');
%line([tdivs;tdivs],[zeros(1,numel(tdivs));map*ones(1,numel(tdivs))],'LineStyle',':','Color','k');
set(gca,'XTick',0:10:max(ts));box on;
xlabel('Time(h)');ylabel('[0A~P] (\muM)');


xlim([0 30.56])
ylim([0 1.5])

 currentFigure = gcf;
 set(gca,'FontSize',20)
 currentFigure.Position = [100, 500, 580, 210]; % [left, bottom, width, height]
 saveas(gcf, 'E.svg');
 set(gca,'FontSize',15)