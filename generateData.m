function data=generateData(N,T,corr_lamda,nf,a,a_x)

%     GENERATING RANDOM ERRORS
    v=randn(N,T); lamda=randn(N,1); lamda_noise=randn(N,1); 
    lamda_x=corr_lamda*lamda+sqrt(1-corr_lamda^2)*lamda_noise; 
    e=randn(N,T); 
    f=randn(T,nf);
%     f=ones(T,1);
%     GENERATING Y, X1, X2
    x1(:,1)=lamda_x*f(1,1)+v(:,1);
    x2=randn(N,T);
%     y(:,1)=lamda*f(1,1)+beta*x1(:,1)+beta*x2(:,1)+e(:,1);
    y(:,1)=lamda*f(1,1)+e(:,1);
    for t=2:T
        x1(:,t)=a_x*x1(:,t-1)+lamda_x*f(t,1)+v(:,t);
%         y(:,t)=a*y(:,t-1)+beta*x1(:,t)+beta*x2(:,t)+lamda*f(t,1)+e(:,t);
    y(:,t)=a*y(:,t-1)+lamda*f(t,1)+e(:,t);
    end

    data=[reshape(y',N*T,1), reshape(x1',N*T,1), reshape(x2',N*T,1) ];