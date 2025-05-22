
        %Parameters
        n=10;
  
    %         kgsini = addparameter(m, 'kgsini', 0.4426); 
                 set(kgsini,'Value',1.2*20);
    %         dgsini = addparameter(m, 'dgsini', 0.48); 
                 set(dgsini,'Value',0.48*20);
    %         kgslrr = addparameter(m, 'kgslrr', 2.1994); 
                 set(kgslrr,'Value',1.2);
    %         dgslrr = addparameter(m, 'dgslrr', 5);
                set(dgslrr,'Value',5);
    %         kgtap = addparameter(m, 'kgtap', 1); 
                set(kgtap,'Value',1.2);
    %         dgtap = addparameter(m, 'dgtap', 5); 
                set(dgtap,'Value',5);
    %         vi = addparameter(m, 'vi', (70/n)*1.9237); % GENE COPY NUMBER HERE
                set(vi,'Value',(25/n)*fglobal(grate,0.8));
    %         trsini = addparameter(m, 'trsini', 400*n); 
                set(trsini,'Value',200*n);
    %         kdeg_RNA = addparameter(m, 'kdeg_RNA', 8.3); 
                set(kdeg_RNA,'Value',8.3);
    %         kdeg = addparameter(m, 'kdeg', 0.2+0.5); % GR in protein dilution
                % set(kdeg,'Value',0.2+grate);
                set(kdeg,'Value',0.2);
    %         vr = addparameter(m, 'vr', (126.4777/n)*1.9237); % GENE COPY NUMBER HERE
                set(vr,'Value',(40/n)*fglobal(grate,0.8)); %126.4777
    %         trsinr = addparameter(m, 'trsinr', 200*n);
                set(trsinr,'Value',100*n);
    %         vl = addparameter(m, 'vl', (110.9821/n)*2.5231); % GENE COPY NUMBER HERE
                set(vl,'Value',(80/n)*fglobal(grate,0.3));
    %         kdegl = addparameter(m, 'kdegl', 0.8+0.5); % GR in protein dilution
                %set(kdegl,'Value',0.8+grate);
                set(kdegl,'Value',0.8);
    %         vt = addparameter(m, 'vt', (30/n)*2.3899); % % GENE COPY NUMBER HERE
                set(vt,'Value',(30/n)*fglobal(grate,0.4));
    %         kdeg_T= addparameter(m, 'kdeg_T', 1); 
                set(kdeg_T,'Value',1.2);
    %         kb1= addparameter(m, 'kb1', 0.32); 
                set(kb1,'Value',0.32);
    %         kdr= addparameter(m, 'kdr', 0.3); 
                set(kdr,'Value',0.3);
    %         kudr= addparameter(m, 'kudr', 247.34); 
                set(kudr,'Value',39.7);
    %         kdi= addparameter(m, 'kdi', 0.3); 
                set(kdi,'Value',0.3);
    %         kudi= addparameter(m, 'kudi', 169.53); 
                set(kudi,'Value',214.8);
    %         kb2= addparameter(m, 'kb2', 0.32); 
                set(kb2,'Value',0.32);
    %         kdlr= addparameter(m, 'kdlr', 0.9940); 
                set(kdlr,'Value',3.32);

