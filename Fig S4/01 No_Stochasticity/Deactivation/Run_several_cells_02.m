%Settings
tic;
nr_cycles=30;
total_cells=100;
gr_v=[0.4];

%% Generate random ON states:
for off_state=1:1:total_cells
    species=zeros(1,20); species(1,17)=100;
  while species(end,17)<200
    grate=gr_v;
    ap = 2; 
    run('model_biofilm.m')
    apd_value=(13+4.*ap-13^0.5*(13 + 8.*ap).^0.5)*125/2.^(0.95.*(1.1 - gr_v));
    run ('Update_rates.m')
    load('OFF_state.mat') % IC
    run ('Update_species.m')
    cs = getconfigset(m, 'active');
    set (apd, 'InitialAmount',apd_value);
    set(cs, 'StopTime', 50, 'SolverType', 'ssa');
    cs.SolverOptions.LogDecimation=1000;
    set(cs, 'MaximumWallClock', 60*5)

    % Simulate the model
    [time, species] = sbiosimulate(m);
    x_ss_2(off_state,:)=species(end,:); %Random OFF state
    u=1;
 end
end


%% Run probabilities 

for y=1:1:size(gr,2)
    
    %Activation
    [timef,resultsf,ap_values_sto,tcyc_sto,time_division] = Deactivation_Probability(total_cells,gr_v,x_ss_2,nr_cycles);
    filename = ['Deactivation_', num2str(strrep(num2str(gr_v), '.', '_')), '.mat'];
    save(filename);
    clearvars -except total_cells  gr_v  x_ss_2  nr_cycles
    state=1


    %Constant Activation
    [timef,resultsf,ap_values_sto,tcyc_sto,time_division] = Constant_Deactivation_Probability_V3(total_cells,gr_v,x_ss_2,nr_cycles);
    filename = ['Constant_Deactivation_', num2str(strrep(num2str(gr_v), '.', '_')), '.mat'];
    save(filename);
    state=2
   
end

toc




