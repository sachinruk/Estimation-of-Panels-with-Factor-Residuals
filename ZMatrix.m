function [Z Sel]=ZMatrix(S,W,lags,T,N)

%preallocate for speed
%l=ones(T-lags+1,1);
%%%%%%%%%%%%%%%%%
%j=1;
%for i=1:T-lags+1
%    if ~isempty(S{i})
%        j=j+1;
%        l(j)=size(S{i},1);
%    end
%end
%Z=zeros(sum(l(2:end)),T-lags,N);
%
%l=cumsum(l);
%for i=1:N
%    k=1;
%    for j=1:T-lags+1
%        if ~isempty(S{j})
%            Wi=S{j}*W(:,i);
%            Z(l(k):l(k+1)-1,k,i)=Wi;
%            k=k+1;
%        end
%    end
%end

Sel=blkdiag(S{lags+1:T});
Z=zeros(size(Sel,1),T-lags,N);
for i=1:N
    IWi=kron(eye(T-lags),W(:,i));
    Z(:,:,i)=Sel*IWi;
end