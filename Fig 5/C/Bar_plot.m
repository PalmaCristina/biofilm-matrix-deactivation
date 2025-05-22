
figure
% Data for the bars
data = [3.77, 4.67];

% Labels for each bar
%labels = {'Replication time', {'Replication and'; 'Non-replication time'}, 'Non-replication time'};
labels = {'Replication','Non-replication'};
labels = cellfun(@(x) strrep(x,'  ','\newline'), labels,'UniformOutput',false);

% Create the bar plot
bar(data,'FaceColor',[0.5, 0.5, 0.5]);

% Set x-axis labels
set(gca, 'XTickLabel', labels);
xtickangle(45)
% Add title and labels
% title('Sample Bar Plot');
ylabel({'Cell cycle length';'for matrix deactivation (h)'});
% xlabel('Time increase');
% ylabel('Values');
set(gca,'FontSize',15)
print('-dtiff', ['-r' num2str(300)], 'bar_plot.tiff');
saveas(gcf, 'Bar_plot.svg');