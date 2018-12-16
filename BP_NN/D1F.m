function y=D1F(D2,W2,Z1)
%º∆À„d1
y=0;
for k=1:length(W2(:,1))
    y=y+D2(k)*W2(k,1:end-1).*delta(Z1)'.*(1-delta(Z1))';
end
y=y';