% Example plulse


% Incresing ON

x=0:0.01:10

for i=1:1:size(x,2)

    if x(i)<1
        y(i)=0.033;
    end

     if (x(i)>=1 && x(i)<2)
         y(i)=1;
     end

     if (x(i)>=2 && x(i)>3)
         y(i)=0.033;
     end

     if (x(i)>=3 && x(i)<5)
         y(i)=1;
     end

     if (x(i)>=5 && x(i)>6)
         y(i)=0.033;
     end

        if (x(i)>=6 && x(i)<9)
         y(i)=1;
        end

     if (x(i)>=9)
         y(i)=0.033;
        end


end

figure
plot(x,y,'LineWidth',3)
ylim([0 1.5])
set(gca,'FontSize',20)
xlabel ('Time (h)')
ylabel ('0A~P')


%% 
% Incresing OFF

x=0:0.01:10

for i=1:1:size(x,2)

    if x(i)<1
        y(i)=0.033;
    end

     if (x(i)>1 && x(i)<2)
         y(i)=1;
     end

     if (x(i)>=2 && x(i)<4)
         y(i)=0.033;
     end

     if (x(i)>=4 && x(i)<5)
         y(i)=1;
     end

     if (x(i)>=5 && x(i)<8)
         y(i)=0.033;
     end

        if (x(i)>=8 && x(i)<9)
         y(i)=1;
        end

     if (x(i)>=10)
         y(i)=0.033;
     end


end

figure
plot(x,y,'LineWidth',3)
ylim([0 1.5])
set(gca,'FontSize',20)
xlabel ('Time (h)')
ylabel ('0A~P')