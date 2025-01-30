
fRepDuration=@(x) (0.15./x+0.78);


gr=0.6  %Change here to produce the plot for different GRs
Nr_cycles=2; 

Cell_Cyc_ori=(log(2)/gr);
RepDuration=fRepDuration(gr);

%double=(pos*RepDuration)/360;

time=0:0.01:(Nr_cycles*Cell_Cyc_ori);
count=1*ones(1,size(time,2));

for i=1:1:size(time,2)

    if (time(1,i)< Cell_Cyc_ori)

        if (time(1,i)< RepDuration)
            count(1,i)=count(1,i);
    
        end
    
        if (time(1,i)> RepDuration)
            count(1,i)=count(1,i)+1;
    
        end

    end

       if (time(1,i)>Cell_Cyc_ori)

          cycle=(time(1,i)/Cell_Cyc_ori)
           fraction_cycle = cycle - floor(cycle);

            
        if (fraction_cycle*Cell_Cyc_ori < RepDuration)
            count(1,i)=count(1,i);
    
        end
    
        if (fraction_cycle*Cell_Cyc_ori>= RepDuration)
            count(1,i)=count(1,i)+1;
    
        end

    end




end

%Constant level copy two
y=2*ones(1,size(time,2));

% Plot areas of replication and post-replication
funtser=@(t,t2,st) logical(mod(t,st)>=0).*logical(mod(t,st)<t2);
t0=0;
ts1=0;
tss=0;
tsers=0;
tdivs=0;
for i=1:1:Nr_cycles
ts1=linspace(0,Cell_Cyc_ori,round(Cell_Cyc_ori)*100)';
tser=funtser(ts1,RepDuration,Cell_Cyc_ori);
tss=[tss;t0+ts1];tsers=[tsers;tser];
tdivs=[tdivs t0+Cell_Cyc_ori];
t0=tss(end);
end


figure
map=2.1;
area(tss,map*tsers,'FaceColor',0.9*ones(1,3),'EdgeColor','none');hold on;
plot(time, y,'Color',[0.4667    0.6745    0.1882], LineWidth=8); hold on;
plot(time, count,'Color',[193    149   196]./255, LineWidth=8); hold on;
% line([tdivs(:,2:end-1);tdivs(:,2:end-1)],[zeros(1,numel(tdivs(:,2:end-1)));map*ones(1,numel(tdivs(:,2:end-1)))],'LineStyle',':','LineWidth',2.5,'Color','k');
xlabel('Time (h)')
ylabel('Copy nr.')
set(gca,'FontSize',25)
ylim([0.9 2.1])
xlim([0 Nr_cycles*Cell_Cyc_ori])



currentFigure = gcf;
currentFigure.Position = [100, 500, 650, 300]; % [left, bottom, width, height]
set(gca,'FontSize',30)
saveas(gcf, 'H_GR.png');
savefig('H_GR.fig');


x=[0,0];
y=[0.96,2.04];

plot(x,y,'Color',[0.4667    0.6745    0.1882], LineWidth=8); hold on;


set(gca,'FontSize',25)
currentFigure = gcf;
currentFigure.Position = [100, 500, 480, 250]; % [left, bottom, width, height]