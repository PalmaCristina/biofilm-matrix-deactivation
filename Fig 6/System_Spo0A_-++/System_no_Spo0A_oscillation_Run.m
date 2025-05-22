% Generate Natural dynamics of AP

gr=0.2;
fRepDuration=@(x) (0.15./x+0.78);

Cell_Cyc_ori=(log(2)/gr);
RepDuration_ori=fRepDuration(gr);
Non_rep_ori=Cell_Cyc_ori-RepDuration_ori;

[Ap_original, ts_original,kgrowths1, tss,tsers,tdivs]=PhosphorelayGrowthModel_CP(gr);

T=[3.4657:0.1:15];

gr_v=log(2)./T;


for i=1:size(gr_v,2)


       gr=gr_v(1,i);

       [Ap, ts,kgrowths1, tss,tsers,tdivs]=PhosphorelayGrowthModel_CP(gr);
       ts=[0:0.01:100];
       Ap=mean(Ap)*ones(1,size(ts,2));


       Spo0AP{:,i}=Ap;
       time{:,i}=ts;
       Cell_Cyc_v{:,i}=log(2)/gr;
      
 end



 for i=1:1:size(Spo0AP,2)
     [Tap_value,L,R,R_total,ti]=TapA_SS_compensated(time{:,i},Spo0AP{:,i},Cell_Cyc_v{:,i});
     Tap_Value_end(i,:)=Tap_value(end,end);
     Period(i,:)=Cell_Cyc_v{:,i};
 end
 

  figure
  scatter(Period,Tap_Value_end,'MarkerEdgeColor','k', 'MarkerFaceColor','k'); hold on;
  xlabel ('T (h)')
  ylabel('[TapA] SS')
  xlim([3.4657 17])
  title('System with constant Spo0A~P and gr effects')

