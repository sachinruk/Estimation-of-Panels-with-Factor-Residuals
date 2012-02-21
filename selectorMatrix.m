function S=selectorMatrix(exog,wexog,T,lags)
%get number of instruments
if isempty(lags)
    lags=0;
end
    
strict=length(exog);
weak=length(wexog);
instruments=strict+weak;

S=cell(T,1);

%if lags(1)~=0
for t=lags(1):T-1
    S{t+1}=zeros(t+T*strict+t*weak,T+T*instruments);
    S{t+1}(1:t,1:t)=eye(t);
    for i=1:strict
        S{t+1}(t+(i-1)*T+1:t+i*T,i*T+1:(i+1)*T)=eye(T);
    end
    for i=strict+1:strict+weak
        S{t+1}(t+(i-1)*T+1:t+(i-1)*T+t,T+(i-1)*T+1:T+(i-1)*T+t)=eye(t);
    end
end
%elseif sum(exog==y_index)>0 %i.e. if one of the strictly exogenous variables is y
    
    
%end