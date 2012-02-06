function [data columnName numvars]=readFile(file,isOctave);

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