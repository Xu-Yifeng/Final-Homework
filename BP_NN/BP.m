datetime('now')
%�趨���������������Ԫ����
Nw=200;
Nout=9;
%�趨ѧϰ��
a=0.035;
%��������
DATA=train(:,2:end-1)';
T1=train(:,end);
TEST=test(:,2:end)';
%������ĳɷ�����ʽ
T=zeros(Nout,length(T1(:,1)));
for i=1:length(T1)
    for j=1:Nout
        if(T1(i)==j)
            T(j,i)=1;
            break;
        end
    end
end

%�����һ��
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

%�����ʼ��
Nin=length(DATA(:,1));
X=zeros(Nin,1);                     %�����
X=[X;1];
W1=0.001*rand(Nw,Nin+1);            %�����-������Ȩֵ
W2=0.001*rand(Nout,Nw+1);           %������-�����Ȩֵ
Z1=zeros(Nw,1);                     %���������Ԫ�����
% Yw=Z1;
% Yw=[Yw;1];
Z2=zeros(Nout,1);                   %��������Ԫ�����
Y=Z2;                               %���
OUTPUT=[];                          %�������
ls=[];                              %��ʧ�������
%ѵ��
for j=1:20 %��������
    for i=1:length(DATA(1,:))       %��һ������ѭ��
        %�������
        X=DATA(:,i);                %ƴ����������
        X=[X;1];                    %ƴ����ֵ
        Z1=W1*X;                    %�����������
        Yw=delta(Z1);               %�������������
        Yw=[Yw;1];                  %ƴ����ֵ
        Z2=W2*Yw;                   %����������
        Y(:,i)=delta(Z2);           %�������
        %���򴫲�
        D2=-(T(:,i)-Y(:,i)).*delta(Z2).*(1-delta(Z2));  %����d2
        W2=W2-a*D2*Yw';               %����������-�����Ȩֵ
        D1=D1F(D2,W2,Z1);           %����d1
        W1=W1-a*D1*X';              %���������-������Ȩֵ
    end
    ls(j)=loss(T1,Y);               %������ʧ����
    J(j)=0.5*sum((T(:,i)-Y(:,i)).^2);
end
%����
for i=1:length(TEST(1,:))
    X=TEST(:,i);
    X=[X;1];
    Z1=W1*X;
    Yw=delta(Z1);
    Yw=[Yw;1];
    Z2=W2*Yw;
    OUTPUT(:,i)=delta(Z2); %������
end

%��һ����
% OUTPUT1=OUTPUT.*(TMAX-TMIN)+TMIN;

% softmax����һ
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

OUTPUT=[test(:,1) OUTPUT'];             %ƴ�ӽ��
datetime('now')