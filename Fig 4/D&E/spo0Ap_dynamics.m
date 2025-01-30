function spo0Ap_amount=spo0Ap_dynamics(t,max_val, min_val,freq,y0)

amplitude = (max_val - min_val) / 2;
offset = (max_val + min_val) / 2;

% % define a function handle f
% f = @(x) y0 - amplitude*cos(freq*(x)) - offset;
% 
% % use the fzero function to find the root of f
% shift = fzero(f, 0);

    for i=1:size(t,1)
    
       spo0Ap_amount(i)=amplitude*cos(freq*(t(i))) + offset;
       spo0Ap_amount=spo0Ap_amount.';
    end

%      if amplitude==0.38
%          xx=1
%      end

end




