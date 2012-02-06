function [y x_ N]=stackData(data, numvars, T,  y_index)
%stack the variables

%get the y variable
y=data(:,y_index);
N=floor(size(y,1)/T);
y=y(1:N*T);
y=reshape(y,T,1,N);
%adjust the y to y-mean(y)
y_bar=mean(y,3);
for i=1:T
    y(i,1,:)=y(i,1,:)-y_bar(i);
end

%get the x variable
x_index=1:numvars;
x_index(y_index)=[];
x=data(:,x_index);
x=x(1:N*T,:);
x_=zeros(T,length(x_index),N);
for i=1:N
	start=(i-1)*T;
	end_=start+T;
	for j=1:length(x_index)		
		x_(:,j,i)=x((start+1):end_,j);
	end
end	
%x=reshape(x,T,length(x_index),N);
%get rid of mean
x_bar=mean(x_,3);
for i=1:N
    x_(:,:,i)=x_(:,:,i)-x_bar;
end