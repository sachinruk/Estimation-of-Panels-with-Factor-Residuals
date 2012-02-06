function M=MMatrix(ZT, X, N);
%get the M matrix

M=zeros(size(ZT(:,:,1),1),size(X(:,:,1),2));
%cumulate Z'*X for each i
for i=1:N
    M=M+ZT(:,:,i)*X(:,:,i);
end
M=M/N;		%average it