function [ts,y1] = Simulation_Activation_stochastic_oscilation_Spo0A_V2(total_time,grate,factor,cells,x_ss)
%This version is different for v1 because the OFF state is not
%deterministic but stochastic. 

% Suppress all warning messages
warning('off', 'all');

%Initialize
grate=grate;

%Get phosphorelay dynamics
[Ap, time_nat,kgrowths1, tss,tsers,tdivs]=E_02_PhosphorelayGrowthModel_MSB_Extra_sda(grate);
[index]=find(diff(time_nat)==0);
time_nat(index)=[];
Ap(index)=[];

[Pk, lock]=(findpeaks(-Ap));
[r1,c1]=find(abs(diff(abs(Pk)))<0.00001);

time_nat=time_nat(lock(r1(1,1)):end,1)-time_nat(lock(r1(1,1)),1);
Ap=Ap(lock(r1(1,1)):end,1);
%plot(time_nat,Ap)

Ap=Ap*factor;


%% STOCHASTIC

%Initialize
run('model_biofilm.m')
step=0.1;
total_time=total_time;
nreps=(total_time)/step;

y1=[];
ts=0;
cs = getconfigset(m, 'active');
run ('Update_species.m')


% Simulate stochastically for oscillatory dynamics
for loop=1:nreps

ap=interp1(time_nat,Ap,ts(end));
ap_value_sanity(loop)=ap;
time_sanity(loop)=ts(end);

apd_value=(13+4.*ap-13^0.5*(13 + 8.*ap).^0.5)*125/2.^(0.95.*(1.1 - grate));
apd_value_sanity(loop)=apd_value;
set (apd, 'InitialAmount',apd_value);

run ('Update_rates.m')
set(cs, 'StopTime', step, 'SolverType', 'ssa');
cs.SolverOptions.LogDecimation=1000;


% Simulate the model
[time, species] = sbiosimulate(m);
x_ss=species(end,:);
run ('Update_species.m')
ts=[ts; time+ts(end)];
y1=[y1; species];

end

end