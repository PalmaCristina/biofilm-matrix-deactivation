function [Ap, ts,kgrowths1, tss,tsers,tdivs]=PhosphorelayGrowthModel_CP(gr)
% clc;clear;format('compact');
% close all;

%Set Phosphorelay Parameters

pars=setpars;

%Calculate Initial Conditions

xii=zeros(1,20);
par1=pars;
par1(20)=0.5;par1(36)=2*pars(36);
[~,y]=ode15s(@eqnsint,[0 2e3],xii,[],par1);xi=y(end,:);

tsers=[];t0=0;ts=[];y1=[];kgrowths1=[];tss=[];tdivs=[];

% Set Growth History

kgs=logspace(log10(gr),log10(gr),12);
kgrowths=[gr*ones(1,3),fliplr(kgs)];nrep=numel(kgrowths);

funtser=@(t,t2,st) logical(mod(t,st)>=0).*logical(mod(t,st)<t2);

%Growth dependence of gene expression rate

fvk=@(x) (3.466*exp(-log(2)./1)+3.743)./(3.466*exp(-log(2)./x)+3.743); % Cell length relative to Cell length of cell with GR of 1 %CP
vind=[1 2 3 4 21 24 27 30 31];

%Growth dependence of DNA replication duration
fRepDuration=@(x) (0.15./x+0.78);

for i=1:nrep
    par1=pars;
    % CellCycDuration=log(2)/kgrowths(i);
    %RepDuration=fRepDuration(kgrowths(i));
    CellCycDuration=log(2)/kgrowths(i);
    RepDuration=fRepDuration(kgrowths(i));
    par1(20)=kgrowths(i);  %update dilution rate constant %CP
    par1(vind)=pars(vind)*fvk(kgrowths(i));
    
    ts1=linspace(0,CellCycDuration,round(CellCycDuration)*100)';
    tser=funtser(ts1,RepDuration,CellCycDuration);
    tss=[tss;t0+ts1];tsers=[tsers;tser];
    tdivs=[tdivs t0+CellCycDuration];
    
    par2=par1;
    par2(36)=2*pars(36); 
   
    [t,y]=ode15s(@eqnsint,[t0,t0+RepDuration],xi,[],par2);xi=y(end,:);

ts=[ts;t];y1=[y1;y];kgrowths1=[kgrowths1;kgrowths(i)*ones(size(t))];

    if CellCycDuration>RepDuration
        par2=par1;
        par2([35 36])=2*pars([35 36]);

[t,y]=ode15s(@eqnsint,[t0+RepDuration,t0+CellCycDuration],xi,[],par2);
xi=y(end,:);

ts=[ts;t];y1=[y1;y];kgrowths1=[kgrowths1;kgrowths(i)*ones(size(t))];
    end
    t0=t(end);
end


Ap=y1(:,13);

% figure
% subplot(211)
% map=0.5;box on;
% area(tss,map*tsers,'FaceColor',0.9*ones(1,3),'EdgeColor','none');hold on;
% plot(ts,kgrowths1,'b');ylim([0 map]);xlim([0 max(ts)]);
% line([tdivs;tdivs],[zeros(1,numel(tdivs));map*ones(1,numel(tdivs))],'LineStyle',':','Color','k');
% set(gca,'XTick',0:10:max(ts),'YTick',0:.1:max(kgrowths1));
% xlabel('Time(hrs)');ylabel('Growth Rate (hr-1)');
% subplot(212)
% map=2.5;
% area(tss,map*tsers,'FaceColor',0.9*ones(1,3),'EdgeColor','none');hold on;
% plot(ts,Ap,'r');xlim([0 max(ts)]);ylim([0 map]);
% line([tdivs;tdivs],[zeros(1,numel(tdivs));map*ones(1,numel(tdivs))],'LineStyle',':','Color','k');
% set(gca,'XTick',0:10:max(ts));box on;
% xlabel('Time(hrs)');ylabel('[0A~P] (\muM)');

function pars=setpars
%Phosphorelay Parameters
kb=5e3;kb2=1*kb;
ks=12;ksd=1;
k1=500;k2=300;k3=.5e3;k4=200;k5=800;
k6=200;k7=800;
k8=100;k9=100;k10=100;k11=100;
kdpa=2;kpa=0.05;
kdeg0=0.3;kdil=0.1;

vb=0.3;vr=0.075;ve=0.03;
vk=0.9;fk=1.5;Kk=.025;nk=1;
vf=.15;f0F=3;K0F=.15;nf=2;
va=1.5;f0A=6;K0A=0.35;na=2;
ngk=1;ngf=1;

pars=[vk,vf,vb,va,ks,ksd,kb,kb2,k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,kdil,...
f0F,K0F,nf,f0A,K0A,na,fk,Kk,nk,vr,ve,kdpa,...
kdeg0,kpa,ngk,ngf];

function dx=eqnsint(~,x,pars)
pars=num2cell(pars);

[vk,vf,vb,va,ks,ksd,kb,kb2,k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,kdil,...
f0F,K0F,nf,f0A,K0A,na,fk,Kk,nk,vr,ve,kdpa,...
kdeg0,kpa,ngk,ngf]=deal(pars{:});

kdeg=kdeg0+kdil;kb3=kb;

Kt=x(1);Ft=x(2);Bt=x(3);At=x(4);Rt=x(5);Et=x(6);
Kp=x(7);KpF=x(8);
Fp=x(9);KF=x(10);
Bp=x(11);FpB=x(12);
Ap=x(13);BpA=x(14);
FpR=x(15);ApE=x(16);
sKt=x(17);sFt=x(18);sBt=x(19);sAt=x(20);

K=max(Kt-Kp-KpF-KF);F=max(Ft-Fp-KpF-KF-FpB-FpR);
B=max(Bt-Bp-FpB-BpA);A=max(At-Ap-BpA-ApE);
R=max(Rt-FpR);E=max(Et-ApE);

vkp=vk+fk*Ap^nk/(Kk^nk+Ap^nk);
vfp=vf+f0F*Ap^nf/(K0F^nf+Ap^nf);
vap=va+f0A*Ap^na/(K0A^na+Ap^na);

dx(1)=ngk*sKt-kdeg*Kt;
dx(2)=ngf*sFt-kdeg*Ft;
dx(3)=ngk*sBt-kdeg*Bt;
dx(4)=ngk*sAt-kdeg*At;
dx(5)=vr-kdeg*Rt;
dx(6)=ve-kdeg*Et;

dx(7)=ks*K-ksd*Kp-kb*Kp*F+k1*KpF-kdeg*Kp;
dx(8)=kb*Kp*F-(k1+k2+kdeg)*KpF+kb3*K*Fp;
dx(9)=k2*KpF-kdeg*Fp-kb*Fp*B+k4*FpB-kb*Fp*R+k8*FpR-kdpa*Fp-kb3*K*Fp;
dx(10)=kb2*K*F-(k3+kdeg)*KF;
dx(11)=-kdeg*Bp-kb*F*Bp+k5*FpB-kb*A*Bp+k6*BpA;
dx(12)=kb*(Fp*B+Bp*F)-FpB*(kdeg+k4+k5);
dx(13)=-kdeg*Ap-kb*B*Ap+k7*BpA-kb*Ap*E+k10*ApE-kdpa*Ap+kpa*A;
dx(14)=kb*(Ap*B+Bp*A)-BpA*(kdeg+k6+k7);
dx(15)=kb*Fp*R-(k8+k9+kdeg)*FpR;
dx(16)=kb*Ap*E-(k10+k11+kdeg)*ApE;


ep=1.*kdeg;
dx(17)=ep*(vkp-sKt);
dx(18)=ep*(vfp-sFt);
dx(19)=ep*(vb-sBt);
dx(20)=ep*(vap-sAt);
dx=dx';

