function [W X]=WMatrix(data,y_index,exog,wexog,T,N, lags)
%get number of instruments

Wdata=data(:,[y_index exog wexog]);
instruments=length(y_index)+length(exog)+length(wexog);
W=zeros(instruments*T,N);

for i=1:N
    for j=1:instruments
        W((j-1)*T+1:j*T,i)=Wdata((i-1)*T+1:i*T,j);
    end
end

T_lag=T-lags;
X=zeros(T_lag,instruments+lags,N);

for i=1:N
    X(:,1,i)=Wdata(i*T-T_lag+1:i*T,1);
    for j=1:lags
        lag=i*T-j;
        startlag=lag-T_lag;
        X(:,j+1,i)=Wdata(startlag+1:lag,1);
    end
    X(:,lags+2:end,i)=Wdata(i*T-T_lag+1:i*T,2:end);
end