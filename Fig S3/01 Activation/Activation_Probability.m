function [timef,resultsf,y1_v] = Activation_Probability(total_cells,gr,factor,x_ss_2,total_time)
tic;
total_cells=total_cells;
total_time=total_time; %((log(2)/gr))*50;

cells_end_results=zeros(1, total_cells);
resultsf=cell(1, total_cells);
timef=cell(1, total_cells);
y1_v=cell(1, total_cells);
for cells=1:1:total_cells

   x_ss=x_ss_2(cells,:);
   [ts,y1] = Simulation_Activation_stochastic_oscilation_Spo0A_V2(total_time,gr,factor,cells,x_ss);
    cells_end_results(1,cells)=y1(end,17);
    resultsf{1,cells}=y1(:,17);
    timef{1,cells}=ts(2:end);
    y1_v{1,cells}=y1;
end

end