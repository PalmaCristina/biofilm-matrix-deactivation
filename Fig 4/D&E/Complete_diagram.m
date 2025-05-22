%Run diagram constant

% Run diagram oscilation
x1=cell(1,1);
y1=cell(1,1);

freq_v=[6.28./7 6.28./6 6.28./5 6.28./4 6.28./3 6.28./2 6.28./1 6.28./0.866] ;

color_map = lines(length(freq_v));
color_codes = color_map;

for z=1:1:size(freq_v,2)
clearvars -except  z freq_v  color_codes fit2  labels s x1 y1
freq=freq_v(z)
run('Bistability_diagram_oscilation.m')
s{z}=scatter(x_boundary_v, y_boundary_v, 'o', 'filled','MarkerFaceColor',[color_codes(z,:)]); hold on;
real_freq=(6.28./freq);
labels{z} = ['Freq = ' num2str(real_freq,'%.2f') ' h^{-1}'];  % Create a label for the legend
set(s{z},'Color',[color_codes(z,:)],'LineWidth',2);
xlabel('Growth Rate (h^{-1})');
ylabel('[Spo0A~P] (uM)');
x1{z}=x_boundary_v;
y1{z}=y_boundary_v;
end
labels = cellfun(@char, labels, 'UniformOutput', false);
legend([s{:}], labels)