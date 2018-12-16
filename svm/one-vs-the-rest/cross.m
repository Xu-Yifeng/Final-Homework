%SVM-one vs rest
tic;
data=train1;%ѵ����
classnum=9;%�����Ŀ
[m,n]=size(data);%m��������,n��������
%%������֤
k=3;%����
indices=crossvalind('Kfold',m,k);%�����K��
data2=cell(1,k);%��k����Ԫ
for i=1:k
    data2{1,i}=[];
end

for i=1:m  %����indices����������
    data2{1,indices(i)}=[data2{1,indices(i)};data(i,:)];
end
P2=cell(k,classnum);%����ģ��Ԫ������
for q=1:classnum
    for k1=1:k%ÿ�ۼ���ɹ���
        train=[];
        test=[];
        for j=1:k%����ѵ�������Լ�
            if j == k1
                test=[test;data2{1,j}];
            else
                train=[train;data2{1,j}];
            end
        end
        [pr,svmmodel]=ecsvm(train,test,q);%���ú���ѵ��ģ���Լ���֤ģ��
        P1(k1,q)=pr;%�洢������ȷ��
        P2{k1,q}=svmmodel;%�洢����ģ��
        
    end
end
bestmdl=cell(1,classnum);
for i=1:classnum%�ҵ�����ÿ�������õ�ģ�Ͳ�����
    [x,i]=find(P1==max(max(P1(:,i))));
    bestmdl{1,i}=P2{x,i};
end
toc;

    
    
