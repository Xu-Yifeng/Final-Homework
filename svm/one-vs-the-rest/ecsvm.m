%每个二分类机的训练
function [pr,svmmodel]=ecsvm(A,B,t)%A训练，B验证,t目前类别数
[m1,n]=size(A);
[m2,n]=size(B);
A=changelabel(A,t);%将label改为1，-1
B=changelabel(B,t);
trainlabel=A(:,end);%训练集label
traindata=A(:,1:n-1);%训练集data
testdata=B(:,1:n-1);%验证集
testlabel=B(:,end);%验证集label
svmmodel=fitcsvm(traindata,trainlabel,'Standardize',true);%训练模型
predictlabel=predict(svmmodel,testdata);%预测label
count=0;
for i=1:m2
    if predictlabel(i) == testlabel(i)
        count=count+1;
    end
end

pr=count/m2;%输出验证集的正确概率
