function [phi F G Hansen_stat Cov]=convergeFG2(M,S,T,nf,d,lags,regressors,method,ZT,X,seed,N)
global isOctave;
T=T-lags;
B=eye(size(S,1));
C=B;

%get initial value for F
% for i=1:2
%     f=@minfunc;
%     opts=optimset('MaxIter',10000000); %'Display','iter',
%     F=rand(T,nf);       %starting value of F
%     F_=fminsearch(@(F) f(B, M, F, S, d, T, nf, regressors), F,opts);
%     F=F_; [phi, G]=concentrateG(B, M, F, S, d, T, nf, regressors);
%     GFT=G*F';
%     b=M*[1; -phi]-S*GFT(:);
%     Hansen_stat=b'*b;
%     [Delta Delta_inv]=DeltaMatrix(ZT,X,phi,S,GFT);
%     Cov=SD(M,G,F, S, B, C, Delta, phi,T);            
%     C=Delta_inv;
%     B=chol(C);
%     report_stats(phi,Cov,1,Hansen_stat);
% end

%
iter=500;
rng(seed);
B=eye(size(S,1));
F=rand(T,nf);       %starting value of F
f=@minfunc;
opts=optimset('MaxIter',10000000); %'Display','iter',
%F=rand(T,nf);       %starting value of F
F=fminsearch(@(F) f(B, M, F, S, d, T, nf, regressors), F,opts);
[phi, G]=concentrateG(B, M, F, S, d, T, nf, regressors);
for j=1:2
    
%     GFT=G*F';
%     b=M*[1; -phi]-S*GFT(:);
%     Hansen_stat=b'*b;
%     [Delta Delta_inv]=DeltaMatrix(ZT,X,phi,S,GFT);
%     Cov=SD(M,G,F, S, B, C, Delta, phi,T);            
%     C=Delta_inv;
%     B=chol(C);
%     report_stats(phi,Cov,1,Hansen_stat);
    
    for i=1:iter
        [~, G]=concentrateG(B, M, F, S, d, T, nf, regressors);
        [phi F]=concentrateF(B, M, G, S, d, T, nf, regressors);
        GFT=G*F';
        b=M*[1; -phi]-S*GFT(:);
    end
    b=B*(M*[1; -phi]-S*GFT(:));
    Hansen_stat=b'*b;
    [Delta Delta_inv]=DeltaMatrix(ZT,X,phi,S,GFT);
    Cov=SD(M,G,F, S, B, C, Delta, phi,T,N);            
    C=Delta_inv;
    B=chol(C);
    report_stats(phi,Cov,1,Hansen_stat);
end
        
function Hansen_stat=minfunc(B, M, F, S, d, T, nf, regressors)

[phi, G]=concentrateG(B, M, F, S, d, T, nf, regressors);
GFT=G*F';
b=M*[1; -phi]-S*GFT(:);
Hansen_stat=b'*b;

