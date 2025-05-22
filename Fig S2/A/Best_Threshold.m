
load('SS_values.mat')
%% To get TapA values run this section
% total_cells=1000;
% gr_v=0.4;
% %% Check best threshold to be used:
% for off_state=1:1:total_cells
%     grate=gr_v;
%     ap = 2; 
%     run('model_biofilm_replicates_Chen_paper_stochastic.m')
%     apd_value=(13+4.*ap-13^0.5*(13 + 8.*ap).^0.5)*125/2.^(0.95.*(1.1 - gr_v));
%     run ('Update_rates_Trial_paper_stochastic_02.m')
%     load('OFF_state.mat') % IC
%     run ('Update_species.m')
%     cs = getconfigset(m, 'active');
%     set (apd, 'InitialAmount',apd_value);
%     set(cs, 'StopTime', 50, 'SolverType', 'ssa');
%     cs.SolverOptions.LogDecimation=1000;
%     set(cs, 'MaximumWallClock', 60*5)
%     % Simulate the model
%     [time, species] = sbiosimulate(m);
%     x_ss_2(off_state,:)=species(end,:); %Random OFF state
%     u=1;
%     % % if species(end,17)>=500
%     % %     off_state=off_state-1;
%     % %     if (off_state==total_cells)
%     % %        x_ss_2(off_state,:)=x_ss_2(off_state-1,:);
%     % %     end
%     % % end
%  end
%% Plot bimodal distirbution

TapA_values=x_SS_02(:,17);

figure
histogram(TapA_values,70)
ylabel('Counts')
xlabel('TapA')


GMModel = fitgmdist(TapA_values,2)
%% 
SINR_values=x_SS_02(:,13);

figure
histogram(SINR_values,70)
ylabel('Counts')
xlabel('SINR')

%% 
SlrR_values=x_SS_02(:,15);

figure
histogram(SlrR_values,70)
ylabel('Counts')
xlabel('SlrR')


%%
figure
data = [SINR_values,SlrR_values];
hist3(data,'Nbins',[30 200],'CdataMode','auto') 
xlabel('SINR values') 
ylabel('SlrR values')

colorbar
view(2)
caxis([0,10])