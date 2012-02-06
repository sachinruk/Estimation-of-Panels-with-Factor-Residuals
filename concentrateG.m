function [phi G]=concentrateG(B, M, F, S, d, T, nf,regressors)
%Concentrates out G
%inputs:
%B, M, 	-....
%F	-factor matrix
%S	-Selector matrix
%d	-number of parameters in regression
%T	-time frame
%nf	- number of factors
%
%outputs
%phi- regression coefficients
%G	- G matrix
%[A del]=ridDependency(-B*S*kron(F,eye(d)));
m=[B*M -B*S*kron(F,eye(d))]; 
y=m(:,1); x=m(:,2:end);
%z=regress(y,x);
%z=pinv(x)*y;
z=pinv(x'*x)*(x'*y);
phi=z(1:regressors);
%add the zero back in the appropriate place
%del=del+size(M,2);
% g=z(regressors+1:end);
% if (length(del)>0)
% numCols=length(g)+length(del);
% 
%     start=1; new_g=[];
%     for i=1:length(del)
%         if del(i)==1
%             new_g=[new_g 0];
%         else        
%             new_g=[new_g; g(start:(del(i)-1)); 0];
%             start=del(i);   
%         end
%     end
%     new_g=[new_g; g(del(end):end)];
% 
new_g=z(regressors+1:end);
G=reshape(new_g,length(new_g)/nf,nf);
% else
%     G=reshape(g,length(g)/nf,nf);
% end