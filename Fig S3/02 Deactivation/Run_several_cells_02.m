%Settings
tic;
total_time=80;
total_cells=2;
factor=1;
gr_v=[0.4];

%% Generate random ON states:
for off_state=1:1:total_cells
    species=zeros(1,23); species(1,17)=100;
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

for y=1:1:size(gr_v,2)
    gr=gr_v(y);
    [Ap, ts,kgrowths1, tss,tsers,tdivs]=E_02_PhosphorelayGrowthModel_MSB_Extra_sda(gr);

    [index]=find(diff(ts)==0);
    ts(index)=[];
    Ap(index)=[];

    [Pk, lock]=(findpeaks(-Ap));
    [r1,c]=find(abs(diff(abs(Pk)))<0.00001);

    ts=ts(lock(r1(1,1)):end,1)-ts(lock(r1(1,1)),1);
    Ap=Ap(lock(r1(1,1)):end,1);

    plot(ts,Ap)

    ap_val=mean(Ap*factor);
% 
    %Deactivation
    [timef,resultsf] = Deactivation_Probability(total_time,total_cells,gr,factor,x_ss_2);
    filename = ['Deactivation_', num2str(strrep(num2str(gr), '.', '_')), '.mat'];
    save(filename);
    clearvars -except total_cells min_val max_val ap_val gr gr_v x_ss_2 total_time
    state=1
    gr


    %Constant Deactivation
    [timef,resultsf] = Constant_Deactivation_probability(total_time,total_cells,ap_val,gr,x_ss_2);
    filename = ['Constant_Deactivation_', num2str(strrep(num2str(gr), '.', '_')), '.mat'];
    save(filename);
    clearvars -except total_cells min_val max_val ap_val gr gr_v x_ss_2 total_time
    state=3
    gr


end

toc



