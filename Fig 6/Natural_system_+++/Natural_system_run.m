% Generate Natural dynamics of AP

gr=0.2;
fRepDuration=@(x) (0.15./x+0.78);

Cell_Cyc_ori=(log(2)/gr);
RepDuration_ori=fRepDuration(gr);
Non_rep_ori=Cell_Cyc_ori-RepDuration_ori;

[Ap_original, ts_original,kgrowths1, tss,tsers,tdivs]=PhosphorelayGrowthModel_CP(gr);
 

T=[3.4657:0.1:5];
gr_v=log(2)./T;


for i=1:size(gr_v,2)

       gr=gr_v(1,i);

       [Ap, ts,kgrowths1, tss,tsers,tdivs]=PhosphorelayGrowthModel_CP(gr);

       Spo0AP{:,i}=Ap;
       time{:,i}=ts;
       Cell_Cyc_v{:,i}=log(2)/gr;
      
 end



 for i=1:1:size(Spo0AP,2)
     [Tap_value]=TapA_SS(time{:,i},Spo0AP{:,i},Cell_Cyc_v{:,i});
     Tap_Value_end(i,:)=Tap_value(end,end);
     Period(i,:)=Cell_Cyc_v{:,i};
 end
 

  figure
  scatter(Period,Tap_Value_end,'MarkerEdgeColor',[0.4667    0.6745    0.1882],'MarkerFaceColor',[0.4667    0.6745    0.1882]); hold on;
  xlabel ('T (h)')
  ylabel('[TapA] SS')
  xlim([(log(2)./0.2)  7])
  title('Natural system')

