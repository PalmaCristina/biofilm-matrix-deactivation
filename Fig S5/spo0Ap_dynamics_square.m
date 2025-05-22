function spo0Ap_amount=spo0Ap_dynamics_square(t,pulse_on_duration, pulse_off_duration,pulse_height)


% Create the square pulse signal

for i=1:size(t,1)

total_duration = pulse_on_duration + pulse_off_duration;
spo0Ap_amount(i) = ((pulse_height/2) * square(2 * pi / total_duration * (t(i)), pulse_on_duration/total_duration*100) + (pulse_height/2))+0.05;

% pulse_signal = (pulse_height/2) * square(2 * pi / total_duration * t, pulse_on_duration/total_duration*100) + (pulse_height/2);

spo0Ap_amount=spo0Ap_amount.';
end

end




