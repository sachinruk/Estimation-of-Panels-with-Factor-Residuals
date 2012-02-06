function [y_index lags] =gety(columnName, numvars)

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