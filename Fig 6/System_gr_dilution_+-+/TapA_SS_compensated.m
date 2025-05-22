function [Tap_value,L,R,R_total,L_total,ti]=TapA_SS_compensated(ts,Ap,Cell_Cyc)

% figure
pks=findpeaks(Ap,'MinPeakHeight',0.15, 'MinPeakDistance', 50);
diff_pks=diff(pks);
[r c]=find(abs(diff_pks)<0.005);
[index_AP,c]=find(Ap==pks(r(1)+1));
Ts_cut=ts(index_AP:end,1)-ts(index_AP);
Ap_cut=Ap(index_AP:end,1);


%fit spline
Ap_spline=csaps(Ts_cut, Ap_cut);
x_val=[0:0.001:Ts_cut(end,end)];
Ap_spline_continuous= fnval(Ap_spline,x_val);
pks=findpeaks(Ap_spline_continuous);
[r c]=find(Ap_spline_continuous==pks(1,end));
x_val_cut=x_val(1,1:c);
Ap_spline_continuous_cut=Ap_spline_continuous(1,1:c);
% plot(x_val_cut,Ap_spline_continuous_cut);

while (x_val_cut(end,end)<100)
    add=x_val_cut(end,end)+x_val_cut;
    x_val_cut=[x_val_cut add(:,2:end)];
    Ap_spline_continuous_cut=[Ap_spline_continuous_cut Ap_spline_continuous_cut(:,2:end)];

end




gr=(log(2)/Cell_Cyc);


n=config('SinIR_model_stable_compensated.txt');

x0 = [0, 0, 0.7, 0, 0, 0, 0,0.7]; % Initial condition, modify as needed
tspan = [0, 100]; % Time span for ODE solver

[ti, y] = ode15s(@(t,x)SinIR(t,x,gr,Ap_spline_continuous_cut,x_val_cut),[0:0.01:100],x0); 

x_ss = y(end, :);
Tap_value=y(:, 8);
L=y(:, 4);
R=y(:, 6);
R_total=y(:, 6)+(y(:, 2)./2)+y(:, 5)+(y(:, 7).*2);
L_total=y(:, 4)+y(:, 5);


end






