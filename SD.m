function Cov=SD(M,G,F, S, B, C, Delta, phi,t,N)

beta=[1;-phi];
p=length(phi);
%if you do not want B in here delete the percentage sign in the next line
%B=1
v=B*(M*beta-S*kron(F,eye(p*t))*G(:));
%Derivatives
db_dphi=-1*ones(size(beta)); db_dphi(1)=0;
dv_dphi=B*M*db_dphi;
dv_df=-B*S*kron(eye(t),G);
dv_dg=-B*S*kron(F,eye(p*t));
dv_dtheta=[dv_dphi dv_df dv_dg];

%Gamma=(2*v'*dv_dtheta)';
Gamma=dv_dtheta;
Cov=pinv(Gamma'*C*Gamma)*(Gamma'*C*Delta*C*Gamma)*pinv(Gamma'*C*Gamma)/N;
% beta=ones(2,1);beta[2,1]=-phi;
% vvv=cvechm*beta-cs*(bigf.*.eye(p*t) )*g;
% dbdphi=zeros(2,1); dbdphi[2,1]=-1;
% dvvvdphi=cvechm*dbdphi;
% dvvvdf=-cs*(eye(t).*.bigg);
% dvvvdg=-cs*((bigf.*.eye(p*t)));
% dvvvdtheta=dvvvdphi~dvvvdf~dvvvdg;
%  
% gradu=2*(vvv')*dvvvdtheta;
% gradu=gradu';