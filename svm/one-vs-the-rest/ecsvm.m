%ÿ�����������ѵ��
function [pr,svmmodel]=ecsvm(A,B,t)%Aѵ����B��֤,tĿǰ�����
[m1,n]=size(A);
[m2,n]=size(B);
A=changelabel(A,t);%��label��Ϊ1��-1
B=changelabel(B,t);
trainlabel=A(:,end);%ѵ����label
traindata=A(:,1:n-1);%ѵ����data
testdata=B(:,1:n-1);%��֤��
testlabel=B(:,end);%��֤��label
svmmodel=fitcsvm(traindata,trainlabel,'Standardize',true);%ѵ��ģ��
predictlabel=predict(svmmodel,testdata);%Ԥ��label
count=0;
for i=1:m2
    if predictlabel(i) == testlabel(i)
        count=count+1;
    end
end

pr=count/m2;%�����֤������ȷ����
