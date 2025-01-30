function [time_constant,results_constant] = Constant_Activation_probability(total_cells,ap_val,grate,x_ss_I,total_time)

cells=total_cells;
total_time=total_time; %((log(2)/grate))*50;


for cell_run=1:1:cells
run('model_biofilm.m')

ap = ap_val; 
grate=grate;
apd_value=(13+4.*ap-13^0.5*(13 + 8.*ap).^0.5)*125/2.^(0.95.*(1.1 - grate));

% Configure and run the deterministc simulation

run ('Update_rates.m')
x_ss=x_ss_I(cell_run,:);
run ('Update_species.m')

cs = getconfigset(m, 'active');
set (apd, 'InitialAmount',apd_value);
set(cs, 'StopTime', total_time, 'SolverType', 'ssa');
cs.SolverOptions.LogDecimation=1000;
set(cs, 'MaximumWallClock', 60*5)
% Simulate the model

[time, species] = sbiosimulate(m);

cells_end_results(1,cell_run)=species(end,17);
results_constant{1,cell_run}=species(:,17);
time_constant{1,cell_run}=time(1:end);

end


end