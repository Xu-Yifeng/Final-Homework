%SVM�������ڳ���
%ͨ�����벻ͬ��c��g��Ѱ����ʹ�б��ʴﵽ���ŵĲ�������
function [bestacc,bestc,bestg] = SVMcg(train_label,train,cmin,cmax,gmin,gmax,v,cstep,gstep,accstep)
%X��c Y��g cg��acc
[X,Y] = meshgrid(cmin:cstep:cmax,gmin:gstep:gmax);
[m,n] = size(X);
PN = zeros(m,n);%��ʼ����ǰ����ȷ��

%��¼�ڲ�ͬcg�µ�acc�����ʹc����С(����ᵼ�¹����)
bestc = 0;
bestg = 0;
bestacc = 0;
basenum = 2;%ͨ���״ε���ֵ���γɺ�������
for i = 1:m
    for j = 1:n%Ѱ������Ԥ����ȷ���Լ���Ӧ�Ĳ���
        cmd = ['-v ',num2str(v),' -c ',num2str( basenum^X(i,j) ),' -g ',num2str( basenum^Y(i,j) )];
        PN(i,j) = svmtrain(train_label, train, cmd);
        if PN(i,j) > bestacc
            bestacc = PN(i,j);
            bestc = basenum^X(i,j);
            bestg = basenum^Y(i,j);
        end
        if ( PN(i,j) == bestacc && bestc > basenum^X(i,j) )
            bestacc = PN(i,j);
            bestc = basenum^X(i,j);
            bestg = basenum^Y(i,j);
        end
    end
end
%��acc�Ͳ���c��g�Ĺ�ϵͼ������
[C,h] = contour(X,Y,PN,60:accstep:100);
clabel(C,h,'FontSize',10,'Color','r');
xlabel('log2c','FontSize',10);
ylabel('log2g','FontSize',10);
grid on;