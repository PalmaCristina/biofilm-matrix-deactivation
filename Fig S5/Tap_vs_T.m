
pulse_height_v=[1]; %Kepp Constant
pulse_on_duration_v2=[1:0.01:5];
pulse_off_duration_v2=[1:0.01:5];


%% For period increasing by keeping OFF and changing ON
pulse_on_duration_v=[1:0.01:12];
pulse_off_duration_v=1*ones(1,size(pulse_on_duration_v,2));

for r=1:1:size(pulse_height_v,2)

         pulse_height=pulse_height_v(1,r);
         run('Bifurcation_amplitude_02.m') 
end

p2=plot(T(2,:), T(1,:),'.','MarkerSize',20);hold on;
xlabel('T (h)');
ylabel('[TapA] steady state');

xlim([2 5])
ylim([0 1])
set(gca,'FontSize',15)

%% For period increasing by keeping ON and changing OFF

T(2,:)=[];T(1,:)=[];

pulse_off_duration_v=pulse_off_duration_v2;
pulse_on_duration_v=1*ones(1,size(pulse_off_duration_v2,2));


for r=1:1:size(pulse_height_v,2)

         pulse_height=pulse_height_v(1,r);
         run('Bifurcation_amplitude_02.m') 
end

p3=plot(T(2,:), T(1,:),'.','MarkerSize',20);hold on;
xlabel('Pulse period (h)');
ylabel('[TapA] (µM)');

xlim([2 5])
ylim([0 1])
set(gca,'FontSize',15)
