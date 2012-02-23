clear all
close all
clc

rng default;
seed=33;
rng(seed);

N=100; T=10; corr_lamda=0.0; a_x=0.5; a=0.5; nf=1;
y_index=1; exog=[]; wexog=[]; lags=1; nreps=500;
Beta=zeros(1,nreps);
S=selectorMatrix(exog,wexog,T,lags);
regressors=length(lags)+length(exog)+length(wexog);
for i=1:nreps
    data=generateData(N,T,corr_lamda,nf,a,a_x);
    % [data columnName numvars]=readFile(file,isOctave);	%Read file in
    % [y_index lags] =gety(columnName, numvars);		%get y and lags
    % T=input('What is the time frame (T) the data is taken from:');
    % [y x N]=stackData(data, numvars, T, y_index);			%pre process al the data
    % [exog wexog]= getx(columnName, numvars);			%get the exogenous indices

    %get all required matrices
    
    [W X]=WMatrix(data,y_index,exog,wexog,T,N,lags);
    [ZT Sel]=ZMatrix(S,W,lags,T,N);
    M=MMatrix(ZT, X, N);
    [Sel2 S2 W2]=readjust(data,T,N, y_index, exog, wexog,lags);	%readjust S and W

    [c q]=size(M);
    
    d=size(W2,1);
    [Beta(i)]=convergeFG2(M,Sel2,T,nf,d,lags,regressors,2,ZT,X,seed, N);
end
hist(Beta,100);

