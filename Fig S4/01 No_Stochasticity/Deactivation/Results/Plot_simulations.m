%Plot simulation

load('Deactivation_0_4.mat')
for i=20

    D=plot(timef{1,i},resultsf{1,i},'LineWidth',2); hold on;

end

th=200*ones(1,61);
plot(0:1:60,th,'k','LineStyle','--','LineWidth', 0.5)

load('Deactivation_0_4.mat')
for i=20

    D=plot(timef{1,i},resultsf{1,i},'LineWidth',2); hold on;

end

