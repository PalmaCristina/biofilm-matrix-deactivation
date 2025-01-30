
% Data for the bars
data = [3.86, 3.97, 4.37, 4.87, 11.16];

% Labels for each bar
labels = {'Full', '+-+', '++-', '+--', '-++'};

% Create the bar plot
bar(data,'FaceColor',[0.5 0.5 0.5]);

% Set x-axis labels
set(gca, 'XTickLabel', labels);

% Add title and labels
ylabel('Cell cycle length for matrix deactivation (h)');
xlabel ('GR effects')

set(gca,'FontSize',15)

% Labels for each bar
labels = {'A', 'B', 'C', 'D', 'E'};

%legend(labels); % Places the legend outside the plot for better visibility

print('BarPlotFigure', '-dtiff', '-r300');
saveas(gcf, 'Barplot.svg');