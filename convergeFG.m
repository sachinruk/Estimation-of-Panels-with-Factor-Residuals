function [Beta F G Q_last]=convergeFG(B,M,S,T,nf,d,lags,regressors, F)

T=T-lags;
iter=500;
parameters=zeros(regressors+(d*nf)+(T*nf),iter);
Q=zeros(iter);
for i=1:iter
    [~, G]=concentrateG(B, M, F, S, d, T, nf, regressors);
    [Beta F]=concentrateF(B, M, G, S, d, T, nf, regressors);
    parameters(:,i)=[Beta; G(:); F(:)];
    a=G*F';
    b=M*[1; -Beta]-S*a(:);
    Q(i)=b'*b;
end
D=diff(parameters,1,2);
dist=sum(abs(D),1);
plot(dist); title('Convergence'); xlabel('Iteration'); ylabel('Distance');
figure; plot(Q)
Q_last=Q(iter);