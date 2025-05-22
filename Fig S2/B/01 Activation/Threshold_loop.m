% Test 100 different threshold. 

rng(123); 
Thereshold_v =randi([25, 350], 1, 100);

for i=1:1:size(Thereshold_v,2)
    i
    theresh=Thereshold_v(1,i);
    run('Calculate_Probabilities_02.m');
    
end