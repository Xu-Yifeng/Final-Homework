%SVM-one vs rest
tic;
data=train1;%训练集
classnum=9;%类别数目
[m,n]=size(data);%m样本数量,n特征数量
%%交叉验证
k=3;%折数
indices=crossvalind('Kfold',m,k);%随机分K折
data2=cell(1,k);%分k个单元
for i=1:k
    data2{1,i}=[];
end

for i=1:m  %遍历indices，分配数据
    data2{1,indices(i)}=[data2{1,indices(i)};data(i,:)];
end
P2=cell(k,classnum);%分配模型元胞矩阵
for q=1:classnum
    for k1=1:k%每折计算成功率
        train=[];
        test=[];
        for j=1:k%分配训练、测试集
            if j == k1
                test=[test;data2{1,j}];
            else
                train=[train;data2{1,j}];
            end
        end
        [pr,svmmodel]=ecsvm(train,test,q);%调用函数训练模型以及验证模型
        P1(k1,q)=pr;%存储分类正确率
        P2{k1,q}=svmmodel;%存储分类模型
        
    end
end
bestmdl=cell(1,classnum);
for i=1:classnum%找到对于每个类别最好的模型并保存
    [x,i]=find(P1==max(max(P1(:,i))));
    bestmdl{1,i}=P2{x,i};
end
toc;

    
    
