%�ı�label ���һ��Ϊlabel t��ǰ���
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