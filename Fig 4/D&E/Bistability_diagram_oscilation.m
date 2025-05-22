% For no oscilation of spo0A
t=1;

min_val=0;
% freq=1.77;

% Continuation method for bifurcation diagram
max_val_start =min_val; % Start value for gr
max_val_end = 30 %30; % End value for gr
dmax_val = 0.3; %0.05; % Increment for gr
% max_val_v = [max_val_end:-dmax_val:max_val_start];
max_val_v = [max_val_start:dmax_val:max_val_end];

for i2=1:1:size(max_val_v,2)

max_val=max_val_v(1,i2);
run('Bifurcation_amplitude_03.m')
state(i2,:)=(SS_values(:,8)).';

end

% max_val_v = [max_val_end:-dmax_val:max_val_start];
max_val_v = [max_val_start:dmax_val:max_val_end];
% figure
% p1 =imagesc(gr_values,oscilation_mean,state); %Heatmap of state space

%Define separation of regions
high_threshold = 0.3;  %Define separation of regions
high_region = state > high_threshold;% Create a logical mask for points in the highregion
 %p2=imagesc(gr_values,oscilation_mean,high_region); %Heatmap of state space with only 2 regions (monostable and bistable)

% Find separation pixels of mono and bistability regions
border = bwperim(high_region,4); 
border(:,1)=0; %delete image boundaries
border(end,:)=0; %delete image boundaries
% border(1,:)=0; %delete image boundaries
% p3=imagesc(gr_values,oscilation_mean,(border));  %Heatmmap of thereshold

[r,c]=find(border==1); %Find boundary indexes

%Correpondes of indexes to gr and ap values
x=gr_values(c);
y=oscilation_mean(r);

%Find the exact boundary horizontal
diff_y=diff(y);
y_boundary=y(find(diff_y ~=0));
x_boundary=x(find(diff_y ~=0));

%Find the exact boundary vertical
diff_x_boundary=diff(x_boundary);
x_boundary_v=x_boundary((find(diff_x_boundary ~=0)+1));
y_boundary_v=y_boundary((find(diff_x_boundary ~=0)+1));




