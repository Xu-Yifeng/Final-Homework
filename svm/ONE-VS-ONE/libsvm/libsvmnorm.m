%一次完成
dim=9;%类别数
trainall=train1(1:25000,:);
[m,n]=size(trainall);
train=Normalization(trainall(:,1:n-1));
train_label=trainall(:,n);
%参数c
cmin=5;
cmax=10;
cstep=1;
%参数g
gmin=-13;
gmax=-8;
gstep=1;
accstep=1;
v=3;
[bestacc,bestc,bestg] = SVMcg(train_label,train,cmin,cmax,gmin,gmax,v,cstep,gstep,accstep)
cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -t ' ,num2str(2) ,' -b ', num2str(1) ];
train=train1;
[m2,n2]=size(train);
traindata=Normalization(train1(:,1:n2-1));
trainlabel=train1(:,n2);
svmmodel = svmtrain(trainlabel,traindata,cmd);

testdata=Normalization(test1);
[m1,n1]=size(testdata);
testlabel=ones(m1,1);

%libsvm会对输出概率的顺序进行重排，存储与model的label中，这里进行顺序重新排列
[predictedlabel,acc,p]=svmpredict(testlabel, testdata, svmmodel,'-b 1');
[m3,n3]=size(p);
P(:,1)=p(:,6);
P(:,2)=p(:,5);
P(:,3)=p(:,4);
P(:,4)=p(:,1);
P(:,5)=p(:,7);
P(:,6)=p(:,3);
P(:,7)=p(:,9);
P(:,8)=p(:,2);
P(:,9)=p(:,8);
for i=1:m3
    P1(i,1)=i;
end
SUB=[P1,P];
 csvwrite('libsvmpro.csv',SUB);

