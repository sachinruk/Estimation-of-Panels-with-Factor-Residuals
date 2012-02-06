clear all
close all
clc

isOctave = (exist('OCTAVE_VERSION', 'builtin') == 5);
file='AR(1), T=4, nf=1.csv';
%file='AR(1), T=10, nf=1, a=0.8_factor loadings mean zero.csv';
if isOctave
	data=csvread(file);
    [fid fmsg]=fopen(file);
    if (isempty(fmsg)==false)
        error('Could not read file');
    end
    columnName=strsplit(fgetl(fid),',');
else
	A=importdata(file);
    data=A.data;
    columnName=A.textdata;
end
		
numvars=length(columnName);
nf=1;

disp(columnName);
y_index=0;
while y_index<1 || y_index>numvars
fprintf ('Please enter which variable from above is the y variable:\n (Choose from 1-%d)\n',numvars);
y_index=input('');
end

lags=-1;
while lags<0
    lags=input('Enter how many lags of the y variable there are\n (Press 0 for none):');
end

T=input('What is the time frame (T) the data is taken from:');
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
x=reshape(x,T,length(x_index),N);
%get rid of mean

disp(columnName);
exog=[];
while isempty(exog)
    fprintf ('Please enter which variable from above are strictly exogenous:\n (Choose from 1-%d). Press "0" for no exogenous variables\n',numvars);
    exog=str2num(input('','s'));
    if isempty(exog)
        fprintf('Invalid input\n');
    end
end
if exog==0
    exog=[];
end

wexog=[];
while isempty(wexog)
    fprintf ('Please enter which variable from above are weakly exogenous:\n (Choose from 1-%d). Press "0" for no weakly exogenous variables\n',numvars);
    wexog=str2num(input('','s'));
    if isempty(wexog)
        fprintf('Invalid input\n');
    end
end
if wexog==0
    wexog=[];
end

S=selectorMatrix(exog,wexog,T,lags);
[W X]=WMatrix(data,y_index,exog,wexog,T,N,lags);
[ZT Sel]=ZMatrix(S,W,lags,T,N);

M=zeros(size(ZT(:,:,1),1),size(X(:,:,1),2));
for i=1:N
    M=M+ZT(:,:,i)*X(:,:,i);
end
M=M/N;
[c q]=size(M);
%readjust S and W
[Sel2 S2 W2]=readjust(data,T,N, y_index, exog, wexog,lags);
s=size(Sel2);
B=eye(s(1));
regressors=length(lags)+length(exog)+length(wexog);
d=size(W2,1);
close all;
method=input('Press 1 for vasilis method or 3 for random search');
[Beta F G]=convergeFG2(B,M,Sel2,T,nf,d,lags,regressors,1);
beta
F
G
