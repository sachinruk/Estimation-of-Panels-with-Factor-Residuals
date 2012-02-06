function [phi F G Hansen_stat Cov]=convergeFG2(B,M,S,T,nf,d,lags,regressors,method,ZT,X,seed)
global isOctave;
isOctave
T=T-lags;
C=B;
switch method

    case 1
        iter=500;
%         parameters=zeros(regressors+(d*nf)+(T*nf),iter);
%         Hansen_stat=zeros(iter);
        %if isOctave
        %	rand("seed",seed);
       %else
       	rng(seed);
       %end
        F=rand(T,nf);       %starting value of F
        for j=1:2
            for i=1:iter
                %if isOctave
                [~, G]=concentrateG(B, M, F, S, d, T, nf, regressors);
                %else
                 %[~, G]=concentrateG(B, M, F, S, d, T, nf, regressors);
                %end
                [phi F]=concentrateF(B, M, G, S, d, T, nf, regressors);
%                 parameters(:,i)=[phi; G(:); F(:)];
                GFT=G*F';
                b=M*[1; -phi]-S*GFT(:);
%                 Hansen_stat(i)=b'*b;
            end
%             grad_u=SD(M,G,F,phi,p,t)

            b=B*(M*[1; -phi]-S*GFT(:));
            Hansen_stat=b'*b;
            [Delta Delta_inv]=DeltaMatrix(ZT,X,phi,S,GFT);
            Cov=SD(M,G,F, S, B, C, Delta, phi,T);            
            C=Delta_inv;
            B=chol(C);
            
            phi
            Hansen_stat
        end
%         D=diff(parameters,1,2);
%         dist=sum(abs(D),1);
%         figure; plot(dist); title('Convergence'); xlabel('Iteration'); ylabel('Distance');
%         figure; plot(Hansen_stat); title('Hansen_stat');
        %Q_last=Hansen_stat(iter);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Method 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 2
        for j=1:10     
            f=@minfunc;
            opts=optimset('MaxIter',10000000); %'Display','iter',
            F=rand(T,nf);       %starting value of F
            F_=fminsearch(@(F) f(B, M, F, S, d, T, nf, regressors), F,opts);
            F=F_; [phi, G]=concentrateG(B, M, F, S, d, T, nf, regressors);
            GFT=G*F';
            b=M*[1; -phi]-S*GFT(:);
            Hansen_stat=b'*b;
            phi
            [B Delta Delta_inv]=CMatrix(ZT,X,phi,S,G*F');
        end

    otherwise
        error('invalid');
end

% function Hansen_stat=minfunc(params, S, M)
% 
% phi=params(1); GFT=params(2:end);
% b=M*[1; -phi]-S*GFT;
% Hansen_stat=b'*b;
        
function Hansen_stat=minfunc(B, M, F, S, d, T, nf, regressors)

[phi, G]=concentrateG(B, M, F, S, d, T, nf, regressors);
GFT=G*F';
b=M*[1; -phi]-S*GFT(:);
Hansen_stat=b'*b;

