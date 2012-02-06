function [exog wexog]= getx(columnName, numvars)
%get the indices of the strictly and weakly exogenous variables

%get the strictly exogenous variables
fprintf('----------------------------------------------------------------------------\n');
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

%get the weakly exog variables
fprintf('----------------------------------------------------------------------------\n');
disp(columnName);
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