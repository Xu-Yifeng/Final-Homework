%改变label 最后一列为label t当前类别
function [P]=changelabel(A,t)
[m,n]=size(A);
for i=1:m
    if A(i,n) == t
        A(i,n)=1;
    else
        A(i,n)=-1;
    end
end
P=A;