load('DATA_C_ACTIVATION.mat')
load('DATA_C_DEACTIVATION')

load('DATA_O_ACTIVATION.mat')
load('DATA_O_DEACTIVATION')


Inspect_times_02_C_A=Inspect_times_02_C_A(:,1:601);
Inspect_times_02_O_A=Inspect_times_02_O_A(:,1:601);
P_ON_C_A=P_ON_C_A(:,1:601);
P_ON_O_A=P_ON_O_A(:,1:601);


%%Constant
%ON+OFF
figure
Total_C=P_ON_C_A+P_OFF_C_D;
Constant=plot(Inspect_times_02_C_A,Total_C,'Color',[ 0.8510    0.3255    0.0980],'LineWidth',3); hold on


Total_O=P_ON_O_A+P_OFF_O_D;
Osci=plot(Inspect_times_02_C_A,Total_O,'Color','b','LineWidth',3); hold on
xlim([0 60])
ylim([0 1.01])
xlabel('Time (h)');
ylabel ('P_{ON} + P_{OFF}')
legend ([Osci, Constant], {'Pulsing 0A~P','Constant 0A~P'})
set(gca,'FontSize',15)