function y=loss(T,Y)
% ��ʧ��������
y=0;
for i=1:length(Y(1,:))
    y=y+log(Y(T(i),i));
end
y=-1/length(T)*y;