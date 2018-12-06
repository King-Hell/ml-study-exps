%Ϊ�˷��㴦�����е����ݾ���+1
load('data_training');
load('data_test');
[x,y]=random(x,y);
a=zeros(100,1);
h=0;
for i=1:100
h=h+100;
%ѵ��
[fxy,fy]=train(x(1:h,:),y(1:h,:),5,5);
%[fxy,fy]=train(x,y,5,5);
%����
yy=test(fxy,fy,testdata);
%��׼ȷ��
%disp(['training set size=',num2str(h)]);
a(i)=accuracy(testdata(:,9),yy);
end

plot(1:100:10000,a)

function [acc]=accuracy(y,yy)
%����ģ��׼ȷ��,yΪ��ʵ����,yyΪԤ������
count=0;
m=size(y,1);
for i=1:m
    if y(i)==yy(i)
        count=count+1;
    end
end
acc=count/m*100;
%fprintf('total=%d,right=%d,accuracy=%f%%\n',m,count,acc);
end

function y=test(fxy,fy,testdata)
%�Բ������ݼ�����Ԥ��
[m,n]=size(testdata);
y=zeros(m,1);
v=size(fy,1);
for i=1:m
    p=zeros(v,1);%y=1,2,3,4,5ʱ�ĸ���
    for j=1:v
        p(j)=p(j)+fy(j);%f(y|x)=fy*��fxy
        for k=1:n-1
            p(j)=p(j)*fxy(testdata(i,k),k,j);
        end
    end
    findy=find(p==max(p));%ȡ������
    y(i)=findy(1);
end
end

function [fxy,fy]=train(x,y,u,v)
%��f(x|y),f(y),uΪ����ȡֵ�����Χ,vΪ��ǩ��
[m,n]=size(x);%mΪ���ݸ���,nΪ��������
fxy=zeros(u,n,v);
fy=zeros(v,1);%����fy=1,2,3,4,5�ĸ���
lambda=1;
L=[3;5;4;4;3;2;3;3];
for i=1:m%ɨ��ÿһ������
    yi=y(i);%��ǰ���ݶ�Ӧ��y
    fy(yi)=fy(yi)+1;%��ǩ��+1
    for j=1:n%ɨ��ÿһ������
        xi=x(i,j);%��i�����ݵĵ�j��������Ӧ��ֵ
        fxy(xi,j,yi)=fxy(xi,j,yi)+1;%��y=yi,xj=xiʱ�ı�ǩ��+1
    end
end
for i=1:v%���Է�ĸ,����������˹ƽ��
    for j=1:n
    fxy(:,j,i)=(fxy(:,j,i)+lambda)./(fy(i,1)+L(j)*lambda);
    end
end
fy=(fy+lambda)./(m+v*lambda);
end

function [x,y]=random(x,y)
rand=randperm(10000);
yy=y;
xx=x;
for i=1:10000
    yy(i)=y(rand(i));
    xx(i,:)=x(rand(i),:);
end
x=xx;
y=yy;
end



