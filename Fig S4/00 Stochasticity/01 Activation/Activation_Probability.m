function [timef,resultsf,ap_values_sto,tcyc_sto,time_division] = Activation_Probability(total_cells,gr_v,x_ss_2,nr_cycles)

cells_end_results=zeros(1, total_cells);
resultsf=cell(1, total_cells);
timef=cell(1, total_cells);

ap_values_sto=cell(1, total_cells);
tcyc_sto=cell(1, total_cells);
time_division=cell(1, total_cells);

for cells=1:1:total_cells

   x_ss=x_ss_2(cells,:);
   [ts,y1,ap_values,tcyc_values,time_partition] = Simulation_Activation_stochastic_oscilation_Spo0A_V3(nr_cycles,gr_v,x_ss);
    
    ap_values_sto{1,cells}=ap_values;
    tcyc_sto{1,cells}=tcyc_values;
    time_division{1,cells}=time_partition;
    resultsf{1,cells}=y1(:,17);
    timef{1,cells}=ts(2:end);
end

end