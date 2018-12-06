%为了方便处理，所有的数据均已+1
load('data_training');
load('data_test');
[x,y]=random(x,y);
a=zeros(100,1);
h=0;
for i=1:100
h=h+100;
%训练
[fxy,fy]=train(x(1:h,:),y(1:h,:),5,5);
%[fxy,fy]=train(x,y,5,5);
%测试
yy=test(fxy,fy,testdata);
%求准确度
%disp(['training set size=',num2str(h)]);
a(i)=accuracy(testdata(:,9),yy);
end

plot(1:100:10000,a)

function [acc]=accuracy(y,yy)
%计算模型准确度,y为真实数据,yy为预测数据
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
%对测试数据集做出预测
[m,n]=size(testdata);
y=zeros(m,1);
v=size(fy,1);
for i=1:m
    p=zeros(v,1);%y=1,2,3,4,5时的概率
    for j=1:v
        p(j)=p(j)+fy(j);%f(y|x)=fy*∑fxy
        for k=1:n-1
            p(j)=p(j)*fxy(testdata(i,k),k,j);
        end
    end
    findy=find(p==max(p));%取最大概率
    y(i)=findy(1);
end
end

function [fxy,fy]=train(x,y,u,v)
%求f(x|y),f(y),u为特征取值的最大范围,v为标签数
[m,n]=size(x);%m为数据个数,n为特征个数
fxy=zeros(u,n,v);
fy=zeros(v,1);%计算fy=1,2,3,4,5的个数
lambda=1;
L=[3;5;4;4;3;2;3;3];
for i=1:m%扫描每一条数据
    yi=y(i);%当前数据对应的y
    fy(yi)=fy(yi)+1;%标签数+1
    for j=1:n%扫描每一个特征
        xi=x(i,j);%第i个数据的第j个特征对应的值
        fxy(xi,j,yi)=fxy(xi,j,yi)+1;%当y=yi,xj=xi时的标签数+1
    end
end
for i=1:v%除以分母,进行拉普拉斯平滑
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



