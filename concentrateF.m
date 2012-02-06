function [phi F]=concentrateF(B, M, G, S, d, T, nf, regressors)
%Concentrates out F
%inputs:
%B, M, 	-....
%G	-... matrix
%S	-Selector matrix
%d	-number of parameters in regression
%T	-time frame
%nf	- number of factors
%
%outputs
%phi- regression coefficients
%F	- F matrix
%G=[G; [0 0]];
%[A del]=ridDependency(-B*S*kron(eye(T),G));
m=[B*M -B*S*kron(eye(T),G)];
y=m(:,1); x=m(:,2:end);
%z=regress(y,x);
z=pinv(x'*x)*(x'*y);
phi=z(1:regressors);
% f=z(regressors+1:end);
% 
% numCols=length(f)+length(del);
% start=1; new_f=[];
% if (length(del)>0)
% for i=1:length(del)
%     if del(i)==1
%         new_f=[new_f 0];
%     else
%         new_f=[new_f; f(start:(del(i)-1)); 0];
%         start=del(i);        
%     end
% end
% new_f=[new_f; f(del(end):end)];

new_f=z(regressors+1:end);
F=reshape(new_f,T,nf);
% else
%     F=reshape(f,T,nf);
% end
