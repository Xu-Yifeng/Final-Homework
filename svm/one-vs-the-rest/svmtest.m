%goods-svm-test
tic;
classnum=9;%类别数目
testdata=test1;%测试集
[n1,m1]=size(testdata);
Sub=zeros(n1,classnum);%输出类别编码矩阵
flag=zeros(n1,2);%判断类别标识
for i=1:classnum
    svmmdl=bestmdl{1,i};%使用各类别最优模型
    predictlabel=predict(svmmdl,testdata);
    for j=1:n1
        if predictlabel(j,1) == 1 && flag(j,1)==0
            Sub(j,i)=1;
            flag(j,1)=1;
        elseif  predictlabel(j,1) == 1 && flag(j,1)==1
            flag(j,2)=flag(j,2)+1;
        end
    end
end

for i=1:n1
    P1(i,:)=i;
end
S=[P1,Sub];

k=0;
K=[];
 for i=1:n1
     a=~any(Sub(i,:));
     if a == 1
         k=k+1;
         K(k,1)=P1(i,:);
         S(i,2)=3;
     end
 end
 csvwrite('ovrsvm.csv',S);
 toc;
         
     
            
            
    
    