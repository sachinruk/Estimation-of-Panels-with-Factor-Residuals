function report_stats(Phi, Cov, parameters, Hansen)

fprintf('\nPhi\n\n');
for i=1: parameters
    fprintf('%.2f\t',Phi(i));
end
fprintf('\n');
for i=1: parameters
    fprintf('(%.2f)\t',sqrt(Cov(i,i)));
end
fprintf('\n');
for i=1: parameters
    fprintf('[%.2f]\t',2*(1-normcdf(Phi(i),0,sqrt(Cov(i,i)))));
end
fprintf('\n\n');
fprintf('Hansen Statistic: %.2f\n', Hansen);