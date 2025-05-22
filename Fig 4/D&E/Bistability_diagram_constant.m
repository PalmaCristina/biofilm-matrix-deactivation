% For no oscilation of spo0A
t=1
ap_v=[0.01:0.01:10]

ap_v=[0.01:0.01:10]

for i2=1:1:size(ap_v,2)

ap=ap_v(1,i2);
run('Bistability_CP_gr.m')
state(i2,:)=(SS_values(:,8)).';

end

gr_values = [gr_end:-dgr:gr_start];
p1 =imagesc(gr_values,ap_v,state); %Heatmap of state space

%Define separation of regions
high_threshold = 0.3;  %Define separation of regions
high_region = state > high_threshold;% Create a logical mask for points in the highregion
% p2=imagesc(gr_values,ap_v,high_region); %Heatmap of state space with only 2 regions (monostable and bistable)

% Find separation pixels of mono and bistability regions
border = bwperim(high_region,4) 
border(:,1)=0; %delete image boundaries
border(end,:)=0; %delete image boundaries
% p3=imagesc(gr_values,ap_v,(border));  %Heatmmap of thereshold

[r,c]=find(border==1) %Find boundary indexes

%Correpondes of indexes to gr and ap values
x=gr_values(c)
y=ap_v(r)

%Find the exact boundary
diff_y=diff(y);
y_boundary=y(find(diff_y ~=0))
x_boundary=x(find(diff_y ~=0))

% % 
figure
scatter(x_boundary,y_boundary) % PLot final boundary



