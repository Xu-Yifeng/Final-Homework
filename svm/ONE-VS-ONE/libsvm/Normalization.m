
function [P]=Normalization(P1)
[m,n]=size(P1);
for j=1:n
    max1=max(P1(:,j));
    min1=min(P1(:,j));
    for i=1:m
        P(i,j)=(P1(i,j)-min1)/(max1-min1);
    end
end
