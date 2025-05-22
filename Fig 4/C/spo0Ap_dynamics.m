function spo0Ap_amount=spo0Ap_dynamics(t,max_val, min_val,freq,y0)

amplitude = (max_val - min_val) / 2;
offset = (max_val + min_val) / 2;


    for i=1:size(t,1)
    
       spo0Ap_amount(i)=amplitude*cos(freq*(t(i))) + offset;
       spo0Ap_amount=spo0Ap_amount.';
    end



end




