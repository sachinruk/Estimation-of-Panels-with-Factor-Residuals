function [A deleteColumn]=ridDependency(A)
%this function finds all the dependent columns and gets rid of them
if min(size(A))==rank(A)    %if full rank
    deleteColumn=[];
    return;                   %return original A
else                        %else
    k=1;
    numCols=size(A,2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
    %This section finds all the indexes that needs to be deleted
    %%%%%%%%%%%%%%%%%%%%%%%%%
    deleteColumn=[];
    for i=1:numCols
        for j=i+1:numCols
            if rank([A(:,i) A(:,j)])==1     %if two columns are dependent
                if rem(k,2)==1              
                    deleteColumn(k)=i;
                    break;                  %goto next i (i already deleted)
                else
                    deleteColumn(k)=j;
                end
                k=k+1;                  
            end
        end
    end
    if ~isempty(deleteColumn)
        deleteColumn=unique(sort(deleteColumn));    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %This section gets the submatrices of the INdependent columns
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ind=1:numCols;
        start=1;
        appendSet=cell(length(deleteColumn)+1,1);
        for i=1:length(deleteColumn)
            if deleteColumn(i)~=numCols
                appendSet{i}= A(:,start:(deleteColumn(i)-1));
                start=deleteColumn(i)+1;
            else
                break;
            end
            if i==length(deleteColumn)
                appendSet{i+1}=A(:,start:numCols);
            end
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %This section puts the Independe columns together
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
        A=[];
        for i=1:length(appendSet)
            A=[A appendSet{i}];
        end
    end
end
            
    