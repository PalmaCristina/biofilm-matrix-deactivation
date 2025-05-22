function [results_duration,timef_clean,resultsf_clean] = N_Activation_deactivation_02(total_cells,g,timef,resultsf,theresh)

grate=g;
th=theresh;
min_state=log(2)/grate;
difference_crossing_time=[1];

    for i=1:1:total_cells
        %Temp plot
        %plot(timef{:,i},resultsf{:,i}); hold on; ylabel('Molecule count'); xlabel('Time (h)');set(gca,'FontSize',15)
        values=resultsf{:,i};
        values(find(values==th))=th+2;
        time=timef{:,i};
        difference_crossing_time=[1 1];
    
        while isempty(find(difference_crossing_time(1,2:end)<min_state, 1))==0 % Is there states smaller than 2 hours? If yes, continue
        
            % Initialize an array to store the crossing times
            crossing_times = [];
            % Loop through the values to detect crossings at th
            for i2 = 1:length(values)-1
                if (values(i2) < th && values(i2+1) >= th) || (values(i2) >= th && values(i2+1) <= th)
                    % Linear interpolation to find the exact crossing time
                    t_cross = time(i2) + (th - values(i2)) * (time(i2+1) - time(i2)) / (values(i2+1) - values(i2));
                    crossing_times = [crossing_times, t_cross];
                end
            end
            crossing_times=[0, crossing_times];

%              % Temp plot
%                  figure
%                  scatter(crossing_times,ones(1,size(crossing_times,2))*th); hold on;
%                  plot(time,values)
%         
             %Calculate period length
             difference_crossing_time=diff(crossing_times);
             %Track if it is ON or OFF
             for i3=1:1:size(crossing_times-1,2) 
                if mod(i3, 2) == 0
                Period{1,i3}='ON';
                else
                Period{1,i3}='OFF';
                end
             end
             %Find periods smaller than th
            [r,c]=find(difference_crossing_time<min_state);
                if isempty(c)==0
                    if c(1,1)==1 
                        c=c(:,2:end);
                    end
                end
                if isempty(c)==0
               % if (Period {c(1,1)-1} == {'ON'} && Period {c(1,1)+1} == {'ON'})
                  if(strcmp(Period {c(1,1)-1}, 'ON')==1 & strcmp(Period {c(1,1)+1}, 'ON')==1)
                    closest_2=(time-crossing_times(1,c(1,1)+1));
                    [right]=find(abs(closest_2)==min(abs(closest_2)));
    
                    closest_1=(time-crossing_times(1,c(1,1)));
                    [left]=find(abs(closest_1)==min(abs(closest_1)));  
    
                    % Change values
                    values((left(1)-1):(right(end)+1),1)=th+2;
          
                  end
    
                  if(strcmp(Period {c(1,1)-1}, 'OFF')==1 & strcmp(Period {c(1,1)+1}, 'OFF')==1)
                        closest_2=(time-crossing_times(1,c(1,1)+1));
                        [right]=find(abs(closest_2)==min(abs(closest_2)));
    
                        closest_1=(time-crossing_times(1,c(1,1)));
                        [left]=find(abs(closest_1)==min(abs(closest_1)));  
    
                            % Change values
                            if left(1,1)==1
                                values((left(1)):(right(end)+1),1)=th-2;
                            end
                            if left(1,1)>1
                            values((left(1)-1):(right(end)+1),1)=th-2;
                            end
   
                    end
                end

                if isempty(difference_crossing_time)==1 %For the cases it never crosses
                        difference_crossing_time=[1, min_state+1];
                end

        end


             % Temp plot
%                figure
%                scatter(crossing_times,ones(1,size(crossing_times,2))*th); hold on;
%                plot(time,values)

    %Adding of last period
    difference_crossing_time(1,(size(difference_crossing_time,2)+1))=time(end,1)-crossing_times(end);

     %Average duration of ON and OFF
     t1=1; t2=1;
     OFF_duration=[];
     ON_duration=[];
        for i4=1:1:size(difference_crossing_time,2)

            if(mod(i4, 2) == 0)
                OFF_duration(1,t1)=difference_crossing_time(1,i4);
                t1=t1+1;
            else
                ON_duration(1,t2)=difference_crossing_time(1,i4);
                t2=t2+1;
            end

        end

       % Delete spurius bursts

    results_duration(1,i)=mean(ON_duration);
    results_duration(2,i)=mean(OFF_duration);
    results_duration(3,i)=size(ON_duration,2)./timef{:,i}(end);
    results_duration(4,i)=size(OFF_duration,2)./timef{:,i}(end);

   % i

   timef_clean{1,i}=time;
   resultsf_clean{1,i}=values;
    end


end