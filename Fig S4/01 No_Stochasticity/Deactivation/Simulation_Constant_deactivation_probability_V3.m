function   [ts,y1,ap_values,tcyc_values,time_partition] = Simulation_Constant_deactivation_probability_V3(nr_cycles,grate,x_ss)

% Suppress all warning messages
warning('off', 'all');

%% STOCHASTIC

%Initialize
run('model_biofilm.m')
step=0.2;
nr_cell_cycles=nr_cycles;
y1=[];
ts=0;
cs = getconfigset(m, 'active');
run ('Update_species.m')
ap=0;
ap_values=[];
tcyc_values=[];

for cell_cycle=1:1:nr_cell_cycles
    tcyc=normrnd(log(2)/grate, 0*(log(2)/grate)); % Radomn cell cycle length generatuon
    tcyc_v(cell_cycle)=tcyc;  %Save cell cycle lengths generated
    % 
    % %Determine 0A~P dynamics during the cell cycle
    [Ap, time_nat,kgrowths1, tss,tsers,tdivs]=E_02_PhosphorelayGrowthModel_MSB_Extra_sda(grate);
  
    [index1]=find(diff(time_nat)==0); %Clean repeated values
    time_nat(index1)=[];
    Ap(index1)=[];

    [~, index2] = min(abs(time_nat - 80));  %Let the oscillation reach SS
    time_nat=time_nat(index2:end,1)-time_nat(index2,1);
    Ap=Ap(index2:end,1);
    ap=mean(Ap);  % For the constant 0A~P simulation we want the mean Ap value

    apd_value=(13+4.*ap-13^0.5*(13 + 8.*ap).^0.5)*125/2.^(0.95.*(1.1 - grate));  
    set (apd, 'InitialAmount',apd_value(1,1));

    run ('Update_rates.m')
    set(cs, 'StopTime', tcyc, 'SolverType', 'ssa');
    cs.SolverOptions.LogDecimation=1000;

    % Simulate the model
    [time, species] = sbiosimulate(m);
    x_ss=species(end,:);
    run ('Update_species.m')
    ts=[ts; time+ts(end)];
    y1=[y1; species];
    ap_values=[ap_values; ap(1,1)*ones(size(time,1),1)]; 
    tcyc_values=[tcyc_values; tcyc*ones(size(time,1),1)]; 
    
     %x_ss=species(end,:)./2;  %Partition cell contents between daughter cells
   
     v=species(end,:);
     group1 = zeros(size(v));
     idx = v > 100;  % Logical mask for values > 100
     group1(idx) = binornd(v(idx), 0.5);   % Use binornd for large values
     group1(~idx) = (v(~idx) / 2); % Equal split for small values
     x_ss=group1;
     
     run ('Update_species.m')
     y1(end,:)=x_ss;  %Partition cell contents
     time_partition(cell_cycle,1)=ts(end); %To save lineages
end


end