% Create a new model object
m = sbiomodel('gene_expression');

% Add a compartment
compartment = addcompartment(m, 'cell', 1);

% Add species
% gene = addspecies(compartment, 'Gene', 1);
% mRNA = addspecies(compartment, 'mRNA', 0);
% protein = addspecies(compartment, 'Protein', 0);
    gi0 = addspecies(compartment, 'gi0', 1);
    gi = addspecies(compartment, 'gi', 0);
    apd = addspecies(compartment, 'apd', 0);
    
    gslr0 = addspecies(compartment, 'gslr0', 0);
    gslr = addspecies(compartment, 'gslr', 1);
    Rt = addspecies(compartment, 'Rt', 0);
    
    gtap0 = addspecies(compartment, 'gtap0', 0);
    gtap = addspecies(compartment, 'gtap', 1);

    gr = addspecies(compartment, 'gr', 1);
    r = addspecies(compartment, 'r', 0);

    i = addspecies(compartment, 'i', 0);
    I = addspecies(compartment, 'I', 0);

    R = addspecies(compartment, 'R', 0);

    l = addspecies(compartment, 'l', 0);
    L = addspecies(compartment, 'L', 0);

    t = addspecies(compartment, 't', 0);
    T = addspecies(compartment, 'T', 0);

    Id = addspecies(compartment, 'Id', 5000);
    IR = addspecies(compartment, 'IR', 0);

    LR = addspecies(compartment, 'LR', 0);

    gisc = addspecies(compartment, 'gisc', 0);

    gslrsc= addspecies(compartment, 'gslrsc', 0);

    gtap0sc= addspecies(compartment, 'gtap0sc', 0);

% % Add parameters
% k1 = addparameter(m, 'k1', 1); % transcription rate
% k2 = addparameter(m, 'k2', 1); % translation rate
% gamma1 = addparameter(m, 'gamma1', 0.1); % mRNA degradation rate
% gamma2 = addparameter(m, 'gamma2', 0.01); % protein degradation rate
kgsini = addparameter(m, 'kgsini', 0); 
dgsini = addparameter(m, 'dgsini', 0); 
kgslrr = addparameter(m, 'kgslrr', 0); 
dgslrr = addparameter(m, 'dgslrr', 0); 
kgtap = addparameter(m, 'kgtap', 0); 
dgtap = addparameter(m, 'dgtap', 0); 
vi = addparameter(m, 'vi', 0); % GENE COPY NUMBER HERE
trsini = addparameter(m, 'trsini', 0); 
kdeg_RNA = addparameter(m, 'kdeg_RNA', 0); 
kdeg = addparameter(m, 'kdeg', 0); % GR in protein dilution
vr = addparameter(m, 'vr', 0); % GENE COPY NUMBER HERE
trsinr = addparameter(m, 'trsinr', 0); 
vl = addparameter(m, 'vl', 0); % GENE COPY NUMBER HERE
kdegl = addparameter(m, 'kdegl', 0); % GR in protein dilution
vt = addparameter(m, 'vt', 0); % % GENE COPY NUMBER HERE
kdeg_T= addparameter(m, 'kdeg_T', 0); 
kb1= addparameter(m, 'kb1', 0); 
kdr= addparameter(m, 'kdr', 0); 
kudr= addparameter(m, 'kudr', 0); 
kdi= addparameter(m, 'kdi', 0); 
kudi= addparameter(m, 'kudi', 0); 
kb2= addparameter(m, 'kb2', 0); 
kdlr= addparameter(m, 'kdlr', 0); 
klock_i= addparameter(m, 'klock_i', 0); 
kunlock_i= addparameter(m, 'kunlock_i', 0); 
klock_lt= addparameter(m, 'klock_lt', 0); 
kunlock_lt= addparameter(m, 'kunlock_lt', 0); 

% % Add reactions
% R1 = addreaction(m, 'Gene -> Gene + mRNA');
% K1 = addkineticlaw(R1, 'MassAction');
% K1.ParameterVariableNames = {'k1'};
% 
% R2 = addreaction(m, 'mRNA -> mRNA + Protein');
% K2 = addkineticlaw(R2, 'MassAction');
% K2.ParameterVariableNames = {'k2'};
% 
% R3 = addreaction(m, 'mRNA -> null');
% K3 = addkineticlaw(R3, 'MassAction');
% K3.ParameterVariableNames = {'gamma1'};
% 
% R4 = addreaction(m, 'Protein -> null');
% K4 = addkineticlaw(R4, 'MassAction');
% K4.ParameterVariableNames = {'gamma2'};

%gi0+apd->gi | kgsini*gi0*apd;
R1 = addreaction(m, 'gi0 + apd -> gi');
K1 = addkineticlaw(R1, 'MassAction');
K1.ParameterVariableNames = {'kgsini'};
%gi->gi0+apd| dgsini*gi;
R2 = addreaction(m, 'gi -> gi0 + apd');
K2 = addkineticlaw(R2, 'MassAction');
K2.ParameterVariableNames = {'dgsini'};

% %gslr0+Rt-> gslr |kgslrr*Rt*gslr0;
R3 = addreaction(m, 'gslr0 + Rt -> gslr');
K3 = addkineticlaw(R3, 'MassAction');
K3.ParameterVariableNames = {'kgslrr'};
%gslr->gslr0+Rt  |dgslrr*gslr;
R4 = addreaction(m, 'gslr -> gslr0 + Rt');
K4 = addkineticlaw(R4, 'MassAction');
K4.ParameterVariableNames = {'dgslrr'};
% 
%gtap0+Rt->gtap  |kgtap*Rt*gtap0;
R5 = addreaction(m, 'gtap0 + Rt -> gtap');
K5 = addkineticlaw(R5, 'MassAction');
K5.ParameterVariableNames = {'kgtap'};
%gtap->gtap0+Rt  |dgtap*gtap;
R6 = addreaction(m, 'gtap -> gtap0 + Rt');
K6 = addkineticlaw(R6, 'MassAction');
K6.ParameterVariableNames = {'dgtap'};

%->i    |((vi0*gi0)+(vi*gi))*fglobal(gr,0.8);
R7 = addreaction(m, 'gi -> i + gi');
K7 = addkineticlaw(R7, 'MassAction');
K7.ParameterVariableNames = {'vi'};
% ->I    |    (trsini)*i;
R8 = addreaction(m, 'i -> I + i');
K8 = addkineticlaw(R8, 'MassAction');
K8.ParameterVariableNames = {'trsini'};
%Degradation
%i-> |kdeg_RNA*i
R9 = addreaction(m, 'i -> null');
K9 = addkineticlaw(R9, 'MassAction');
K9.ParameterVariableNames = {'kdeg_RNA'};
%I->|kdeg*I
R10 = addreaction(m, 'I -> null');
K10 = addkineticlaw(R10, 'MassAction');
K10.ParameterVariableNames = {'kdeg'};

%->r		|   vr*fglobal(gr,0.8);
R11 = addreaction(m, 'gr -> r + gr');
K11 = addkineticlaw(R11, 'MassAction');
K11.ParameterVariableNames = {'vr'};
%->R     |   (trsinr)*r;
R12 = addreaction(m, 'r -> R + r');
K12 = addkineticlaw(R12, 'MassAction');
K12.ParameterVariableNames = {'trsinr'};
%Degradation
%r-> |kdeg_RNA*r
R13 = addreaction(m, 'r -> null');
K13 = addkineticlaw(R13, 'MassAction');
K13.ParameterVariableNames = {'kdeg_RNA'};
%R->|kdeg*R
R14 = addreaction(m, 'R -> null');
K14 = addkineticlaw(R14, 'MassAction');
K14.ParameterVariableNames = {'kdeg'};

%->l     |   ((gslr0*vl)+(gslr*vl0))*fglobal(gr,0.3);
R15 = addreaction(m, 'gslr0 -> l + gslr0');
K15 = addkineticlaw(R15, 'MassAction');
K15.ParameterVariableNames = {'vl'};
%->L     |   (trsinr)*l;
R16 = addreaction(m, 'l -> L + l');
K16 = addkineticlaw(R16, 'MassAction');
K16.ParameterVariableNames = {'trsinr'};
%l-> |kdeg_RNA*l
R17 = addreaction(m, 'l -> null');
K17 = addkineticlaw(R17, 'MassAction');
K17.ParameterVariableNames = {'kdeg_RNA'};
%L->|kdegl*L
R18 = addreaction(m, 'L -> null');
K18 = addkineticlaw(R18, 'MassAction');
K18.ParameterVariableNames = {'kdegl'};

%->t     |   ((gtap0*vt)+(gtap*0))*fglobal(gr,0.4);
R19 = addreaction(m, 'gtap0 -> t + gtap0');
K19 = addkineticlaw(R19, 'MassAction');
K19.ParameterVariableNames = {'vt'};
%->T     |   (trsinr)*t;
R20 = addreaction(m, 't -> T + t');
K20 = addkineticlaw(R20, 'MassAction');
K20.ParameterVariableNames = {'trsinr'};
%t-> |kdeg_RNA*t
R21 = addreaction(m, 't -> null');
K21 = addkineticlaw(R21, 'MassAction');
K21.ParameterVariableNames = {'kdeg_RNA'};
%T->|1*T
R22 = addreaction(m, 'T -> null');
K22 = addkineticlaw(R22, 'MassAction');
K22.ParameterVariableNames = {'kdeg_T'};

%Id+R->2*IR | kb1*Id*R
R23 = addreaction(m, 'Id + R -> IR + IR');
K23 = addkineticlaw(R23, 'MassAction');
K23.ParameterVariableNames = {'kb1'};
%IR->|kdeg*IR
R24 = addreaction(m, 'IR -> null');
K24 = addkineticlaw(R24, 'MassAction');
K24.ParameterVariableNames = {'kdeg'};

%2*R -> Rt | kdr*R*R
R25 = addreaction(m, 'R + R -> Rt');
K25 = addkineticlaw(R25, 'MassAction');
K25.ParameterVariableNames = {'kdr'};
%Rt -> 2*R| kudr*Rt
R26 = addreaction(m, 'Rt -> R + R');
K26 = addkineticlaw(R26, 'MassAction');
K26.ParameterVariableNames = {'kudr'};
%Rt->|kdeg*Rt
R27 = addreaction(m, 'Rt -> null');
K27 = addkineticlaw(R27, 'MassAction');
K27.ParameterVariableNames = {'kdeg'};

%2*I -> Id | kdi*I*I
R28 = addreaction(m, 'I + I -> Id');
K28 = addkineticlaw(R28, 'MassAction');
K28.ParameterVariableNames = {'kdi'};
%Id  ->2*I| kudi*Id
R29 = addreaction(m, 'Id -> I + I');
K29 = addkineticlaw(R29, 'MassAction');
K29.ParameterVariableNames = {'kudi'};
%Id->|kdeg*Id
R30 = addreaction(m, 'Id -> null');
K30 = addkineticlaw(R30, 'MassAction');
K30.ParameterVariableNames = {'kdeg'};

%L+R->LR | kb2*L*R
R31 = addreaction(m, 'L + R -> LR');
K31 = addkineticlaw(R31, 'MassAction');
K31.ParameterVariableNames = {'kb2'};
%LR-> L+R  | kdlr*LR
R32 = addreaction(m, 'LR -> L + R');
K32 = addkineticlaw(R32, 'MassAction');
K32.ParameterVariableNames = {'kdlr'};
%LR->|kdeg*LR
R33 = addreaction(m, 'LR -> null');
K33 = addkineticlaw(R33, 'MassAction');
K33.ParameterVariableNames = {'kdeg'};


%gi0->gisc |klock*gi0
R34 = addreaction(m, 'gi0 -> gisc');
K34 = addkineticlaw(R34, 'MassAction');
K34.ParameterVariableNames = {'klock_i'};
%gisc->gi0 |kunlock*gisc
R35 = addreaction(m, 'gisc -> gi0');
K35 = addkineticlaw(R35, 'MassAction');
K35.ParameterVariableNames = {'kunlock_i'};


%gslr0-> gslrsc ||klock*gslr0
R36 = addreaction(m, 'gslr0 -> gslrsc');
K36 = addkineticlaw(R36, 'MassAction');
K36.ParameterVariableNames = {'klock_lt'};
%gslrsc-> gslr0 ||kunlock*gslrsc
R37 = addreaction(m, 'gslrsc -> gslr0');
K37 = addkineticlaw(R37, 'MassAction');
K37.ParameterVariableNames = {'kunlock_lt'};

%gtap0-> gtap0sc ||klock*gtap0
R38 = addreaction(m, 'gtap0 -> gtap0sc');
K38 = addkineticlaw(R38, 'MassAction');
K38.ParameterVariableNames = {'klock_lt'};
%gtap0sc-> gtap0 ||kunlock*gtap0sc
R39 = addreaction(m, 'gtap0sc -> gtap0');
K39 = addkineticlaw(R39, 'MassAction');
K39.ParameterVariableNames = {'kunlock_lt'};

