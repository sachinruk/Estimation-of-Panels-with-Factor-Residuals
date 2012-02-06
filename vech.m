function V=vech(A)
%This function does the vech operation
%http://en.wikipedia.org/wiki/Vectorization_(mathematics)#Half-vectorization

s=size(A);
n=s(1);
V=zeros(n*(n+1)/2,1);
end_=0;
for i=1:n
    start=end_+1;
    end_=start+(n-i);
    V(start:end_)=A(i:end,i);
end