function [Sel S W]=readjust(data,T,N, y_index, exog, wexog,lags)

if isempty(lags)
    lags=0;
end
T_eff=T-lags;

%Wdata=data(:,[y_index exog wexog]);
inst_index={y_index exog wexog};
W=zeros((lags+length(wexog))*(T_eff)+length(exog)*T,N);

for i=1:N
    e=0;
    for j=1:length(inst_index)
        for k=1:length(inst_index{j})
            s=e+1;
            if j==2             %if strictly exogenous variable save all T
                e=s+T-1;
                s_data_row=(i-1)*T+1; e_data_row=s_data_row+T-1;
                W(s:e,i)=data(s_data_row:e_data_row,inst_index{j}(k));
            else                %else save T_eff of data
                e=s+T_eff-1;
                s_data_row=(i-1)*T+1; e_data_row=s_data_row+T_eff-1;
                W(s:e,i)=data(s_data_row:e_data_row,inst_index{j}(k));
            end
        end
    end
end

    
strict=length(exog);
weak=length(wexog);
%instruments=strict+weak;

S=cell(T,1);
%if lags(1)~=0
for t=lags(1):T-1
    S{t+1}=zeros(t+T*strict+t*weak,T*strict+(T_eff)*(length(y_index)+weak));
    S{t+1}(1:t,1:t)=eye(t);    
    for i=1:strict
        %get the indices
        s_col=T_eff+(i-1)*T+1;  e_col=s_col+T-1;
        s_row=t+(i-1)*T+1;      e_row=s_row+T-1;
        
        S{t+1}(s_row:e_row,s_col:e_col)=eye(T);
    end
    for i=strict+1:strict+weak
        %get the indices
        s_col=e_col+1;          e_col=s_col+t-1;
        s_row=e_row+1;          e_row=s_row+t-1; 
        
        S{t+1}(s_row:e_row,s_col:e_col)=eye(t);
    end
end

Sel=blkdiag(S{lags+1:T});