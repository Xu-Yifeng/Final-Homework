%SVM参数调节程序
%通过带入不同的c和g来寻找能使判别率达到最优的参数集合
function [bestacc,bestc,bestg] = SVMcg(train_label,train,cmin,cmax,gmin,gmax,v,cstep,gstep,accstep)
%X是c Y是g cg是acc
[X,Y] = meshgrid(cmin:cstep:cmax,gmin:gstep:gmax);
[m,n] = size(X);
PN = zeros(m,n);%初始化当前的正确率

%记录在不同cg下的acc情况，使c尽量小(过大会导致过拟合)
bestc = 0;
bestg = 0;
bestacc = 0;
basenum = 2;%通过阶次的数值来形成横纵坐标
for i = 1:m
    for j = 1:n%寻找最大的预测正确率以及对应的参数
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
%将acc和参数c、g的关系图画出来
[C,h] = contour(X,Y,PN,60:accstep:100);
clabel(C,h,'FontSize',10,'Color','r');
xlabel('log2c','FontSize',10);
ylabel('log2g','FontSize',10);
grid on;