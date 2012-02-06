function cholesky
% ait(row,ccc)=cst(s,t,betahat,f,g,x,z)'cst(uuu,v,betahat,f,g,x,z)/n;
%                         uuu=uuu+1;
%                   endo;
%                   v=v+1;
%            endo;
%            s=s+1;
%      endo;
%      t=t+1;
% endo;
% ait=0.5*(ait+ait');
% /*  {va,ve}=eighv(ait);
%  t=1;do while t<=t*(t+1)/2;if abs(va(t,1))<10^(-10);va(t,1)=0;else; va(t,1)=va(t,1)^-.5;endif;t=t+1;endo;
% ait=diagrv(zeros(t*(t+1)/2,t*(t+1)/2),va)*ve; */
% 
% ait=inv(ait);ait=0.5*(ait+ait');
% ait=chol(ait);
% 
% colst=zis.*xit-gs*ft*ones(n,1); mcolst=colst'ones(n,1)/n;colst=colst-mcolst*ones(n,1);

a=G*F';
e=M*(1; -Beta)-Sel2*a(:);
B=e*e';
B=0.5*(B+B');
B=inv(B);


ait=zeros(c,c);

for t=1:T_eff
    for s=1:t
        col=col+1;
        row=1;
        for v=1:t
            u=1;
            for u=1:v
                row=row+1;
                ait(row,col)=cst(s,t,betahat,f,g,x,z)'cst(u,v,betahat,f,g,x,z)/n;
            end
        end
    end
end

function colst=cst(s,t,betahat,f,g,x,z)
%local colst,gs,bigg,bigf,ft,xit,zis,mcolst;
%bigf=reshape(f,t,nf);
%bigg=reshape(g,nf,p*t)';
gs=G(p*(s-1)+1:p*s,:);
ft=F(t,:);
xit=x((t-1)*n+1:t*n,:)*betahat;
zis=z((s-1)*n+1:s*n,:);
colst=zis.*xit-gs*ft*ones(n,1); 
%minus the mean
colst=colst-mean(colst);