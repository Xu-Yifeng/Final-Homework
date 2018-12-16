datetime('now')
%设定隐含层与输出层神经元个数
Nw=200;
Nout=9;
%设定学习率
a=0.035;
%导入数据
DATA=train(:,2:end-1)';
T1=train(:,end);
TEST=test(:,2:end)';
%将输出改成分类形式
T=zeros(Nout,length(T1(:,1)));
for i=1:length(T1)
    for j=1:Nout
        if(T1(i)==j)
            T(j,i)=1;
            break;
        end
    end
end

%输入归一化
% ND=length(DATA(1,:));
% A=[DATA,TEST];
% for i=1:length(A(:,1))
%     MIN=min(A(i,:));
%     MAX=max(A(i,:));
%     for j=1:length(A(1,:))
%         A(i,j)=(A(i,j)-MIN)/(MAX-MIN);
%     end
% end
% DATA=A(:,1:ND);
% TEST=A(:,ND+1:end);
% 
% for i=1:length(T(:,1))
%     TMIN=min(T(i,:));
%     TMAX=max(T(i,:));
%     for j=1:length(T(1,:))
%         T(i,j)=(T(i,j)-TMIN)/(TMAX-TMIN);
%     end
% end

%矩阵初始化
Nin=length(DATA(:,1));
X=zeros(Nin,1);                     %输入层
X=[X;1];
W1=0.001*rand(Nw,Nin+1);            %输入层-隐含层权值
W2=0.001*rand(Nout,Nw+1);           %隐含层-输出层权值
Z1=zeros(Nw,1);                     %隐含层各神经元输入和
% Yw=Z1;
% Yw=[Yw;1];
Z2=zeros(Nout,1);                   %输出层各神经元输入和
Y=Z2;                               %输出
OUTPUT=[];                          %分类输出
ls=[];                              %损失函数输出
%训练
for j=1:20 %迭代次数
    for i=1:length(DATA(1,:))       %对一组数据循环
        %正向输出
        X=DATA(:,i);                %拼接输入数据
        X=[X;1];                    %拼接阈值
        Z1=W1*X;                    %计算隐含层和
        Yw=delta(Z1);               %计算隐含层输出
        Yw=[Yw;1];                  %拼接阈值
        Z2=W2*Yw;                   %计算输出层和
        Y(:,i)=delta(Z2);           %计算输出
        %反向传播
        D2=-(T(:,i)-Y(:,i)).*delta(Z2).*(1-delta(Z2));  %计算d2
        W2=W2-a*D2*Yw';               %修正隐含层-输出层权值
        D1=D1F(D2,W2,Z1);           %计算d1
        W1=W1-a*D1*X';              %修正输入层-隐含层权值
    end
    ls(j)=loss(T1,Y);               %加上损失函数
    J(j)=0.5*sum((T(:,i)-Y(:,i)).^2);
end
%分类
for i=1:length(TEST(1,:))
    X=TEST(:,i);
    X=[X;1];
    Z1=W1*X;
    Yw=delta(Z1);
    Yw=[Yw;1];
    Z2=W2*Yw;
    OUTPUT(:,i)=delta(Z2); %输出结果
end

%归一化法
% OUTPUT1=OUTPUT.*(TMAX-TMIN)+TMIN;

% softmax法归一
% for j=1:length(OUTPUT(1,:))
%     y=0;
%     for i=1:length(OUTPUT(:,1))
%         y=y+exp(OUTPUT(i,j));
%     end
%     for i=1:length(OUTPUT(:,1))
%         OUTPUT(i,j)=exp( OUTPUT(i,j))/y;
%     end
% end

% [~,z]=max(OUTPUT);
% for i=1:length(OUTPUT(1,:)) 
%   OUTPUT(z(i),i)=1;
% end

OUTPUT=[test(:,1) OUTPUT'];             %拼接结果
datetime('now')