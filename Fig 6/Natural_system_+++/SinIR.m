function dx=SinIR(t,x,gr,Ap,ts)
apd =interp1(ts.',Ap.',t);
vi=0.0291;vr=0.0525;vl=0.0461;vi0=0;vl0=0;
kdr= 722.6400;kdi=722.6400;kudr=247.34;kudi=169.53;
kb1= 770.8160;kb2=770.8160; Ki=0.01; Kl=9.4238e-04;kdlr=0.9940;
kdeg=gr+0.2; kdegl=gr+0.8;
vt=0.0125;Kt=0.0021;
I=x(1);
IR=x(2);
Id=x(3);
L=x(4);
LR=x(5);
R=x(6);
Rt=x(7);
T=x(8);
dx(1)=(vi0+vi*(apd)/(Ki+apd))*fglobal(gr,0.8)*400/8.3*1-kdi*I*I*2+kudi*Id*2-kdeg*I*1;
dx(2)=kb1*Id*R*2-kdeg*IR*1;
dx(3)=-kb1*Id*R*1+kdi*I*I*1-kudi*Id*1-kdeg*Id*1;
dx(4)=(vl0+vl*Kl/(Rt+Kl))*fglobal(gr,0.3)*200/8.3*1-kb2*L*R*1+kdlr*LR*1-kdegl*L*1;
dx(5)=kb2*L*R*1-kdlr*LR*1-kdeg*LR*1;
dx(6)=vr*fglobal(gr,0.8)*200/8.3*1-kb1*Id*R*1-kdr*R*R*2+kudr*Rt*2-kb2*L*R*1+kdlr*LR*1-kdeg*R*1;
dx(7)=kdr*R*R*1-kudr*Rt*1-kdeg*Rt*1;
dx(8)=vt*Kt/(Rt+Kt)*fglobal(gr,0.4)*200/8.3*1-1*T*1;
dx=dx';
end
