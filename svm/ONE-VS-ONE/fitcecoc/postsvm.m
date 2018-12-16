%使用MATlab自带的fitecoc预测结果并计算后验概率
train=train1(1:2000,:);
testdata=test1(1:500,:);
[m1,n1]=size(train);
[m2,n2]=size(testdata);
traindata=train(:,1:n1-1);%训练集
trainlabel=train(:,n1);%测试集
%t = templateSVM('Standardize',1,'KernelFunction','gaussian');%rbf核函数
t = templateSVM('Standardize',1);%线性核函数
svmmodel1=fitcecoc(traindata,trainlabel,'Learners',t);%训练SVM模型
testlabel=predict(svmmodel1,testdata);%预测测试集的分类结果

svmmodel = fitcecoc(testdata,testlabel,'Learners',t,'FitPosterior',1);
[label,~,~,Posterior] = resubPredict(svmmodel);%预测后验概率
for i=1:m2
    P(i,1)=i;
end%列号
P1=[P,Posterior];%结果
 csvwrite('postsvm.csv',P1);