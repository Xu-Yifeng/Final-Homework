%ʹ��MATlab�Դ���fitecocԤ����������������
train=train1(1:2000,:);
testdata=test1(1:500,:);
[m1,n1]=size(train);
[m2,n2]=size(testdata);
traindata=train(:,1:n1-1);%ѵ����
trainlabel=train(:,n1);%���Լ�
%t = templateSVM('Standardize',1,'KernelFunction','gaussian');%rbf�˺���
t = templateSVM('Standardize',1);%���Ժ˺���
svmmodel1=fitcecoc(traindata,trainlabel,'Learners',t);%ѵ��SVMģ��
testlabel=predict(svmmodel1,testdata);%Ԥ����Լ��ķ�����

svmmodel = fitcecoc(testdata,testlabel,'Learners',t,'FitPosterior',1);
[label,~,~,Posterior] = resubPredict(svmmodel);%Ԥ��������
for i=1:m2
    P(i,1)=i;
end%�к�
P1=[P,Posterior];%���
 csvwrite('postsvm.csv',P1);