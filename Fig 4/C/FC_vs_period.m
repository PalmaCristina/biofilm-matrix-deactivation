%% Reproduce Results
T=0.1:1:15;
freq_v=(2*pi)./T;

for p=1:1:size(freq_v,2)
freq=freq_v(p);
run('Bifurcation_amplitude_02.m');
result=SS_values(:, 8);
diff_result=diff(result);
[r c]=find(diff_result<-0.5);
Threshold_value=oscilation_mean(1,r);
Threshold_vector(p)=Threshold_value;
p=i
end

figure
scatter(T, Threshold_vector)

%% Saved results
load('Results.mat')

figure
%scatter(T, Threshold_vector); hold on;

load('Model_fit.mat')

xFit = linspace(0.01, 15, 1000);
Threshold_vector_fit=feval(power_2, xFit);
plot(xFit,Threshold_vector_fit,'LineWidth',3.5,'LineStyle','-','Color','k'); hold on;
xlabel('Period of oscillation (h)');
ylabel({'[0A~P] oscillation mean ';'deactivation threshold (μM)'});
set(gca,'FontSize',15)

ylim([0 2.2])
xlim([0 15])


