clear all
close all
%clc

global isOctave;
isOctave= (exist('OCTAVE_VERSION', 'builtin') == 5);
%file='AR(1), T=10, nf=2.csv';
file='AR(1), T=10, nf=1_factor loadings mean zero.csv';

[data columnName numvars]=readFile(file,isOctave);	%Read file in
 [y_index lags] =gety(columnName, numvars);		%get y and lags
T=input('What is the time frame (T) the data is taken from:');
[y x N]=stackData(data, numvars, T, y_index);			%pre process al the data
 [exog wexog]= getx(columnName, numvars);			%get the exogenous indices

%get all required matrices
S=selectorMatrix(exog,wexog,T,lags);
[W X]=WMatrix(data,y_index,exog,wexog,T,N,lags);
[ZT Sel]=ZMatrix(S,W,lags,T,N);
M=MMatrix(ZT, X, N);
[Sel2 S2 W2]=readjust(data,T,N, y_index, exog, wexog,lags);	%readjust S and W

[c q]=size(M);
nf=input('Insert how many factors there are:');
s=size(Sel2);
B=eye(s(1));
regressors=length(lags)+length(exog)+length(wexog);
d=size(W2,1);
close all;
%method=input('Press 1 for vasilis method or 3 for random search');
seed=3;
[Beta F G Hansen_stat Cov]=convergeFG2(B,M,Sel2,T,nf,d,lags,regressors,1,ZT,X,seed, N);