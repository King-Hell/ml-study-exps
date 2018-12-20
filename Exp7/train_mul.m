function [svms]=train_mul(x,y)
%训练数据集,多分类版,标签从1开始到n,共有n个类别
%使用多对多的分类方式
n=size(x,2);
class=size(unique(y),1);%总分类数
svmMount=class*(class-1)/2;%SVM数量为n(n-1)/2
svms=cell(svmMount,1);%采用面向对象的方式定义SVM模型
it=1;
for pos=1:class-1
    for neg=pos+1:class
        %将s分类与t分类做SVM
        index1=find(y==pos);
        index2=find(y==neg);
        y1=y(index1);
        y2=y(index2);
        y1=ones(size(y1,1),1);%将两分类标签置为1和-1
        y2=-1.*ones(size(y2,1),1);
        yy=[y1;y2];
        xx=x([index1;index2],:);
        [omega,b]=train_one(xx,yy,1e-10,10);
        svms{it}=svm(omega,b,pos,neg);
        it=it+1;
    end
end

end

function [omega,b]=train_one(x,y,tol,C,gamma)
%训练数据集,二分类版,标签为-1和1
m=size(x,1);
if nargin<=4
    H=(y*y').*(x*x');
else
    if gamma==0
        H=(y*y').*(x*x');
    else
        K=zeros(m,m);
        for i=1:m
            for j=1:m
                K(i,j)=exp(-gamma*(norm(x(i,:)-x(j,:)).^2));
            end
        end
        H=(y*y').*K;
    end
end
f=-1*ones(1,m);
A=[];
b=[];
Aeq=y';
beq=0;
lb=zeros(m,1);
if size(C)==0
    ub=[];
else
    ub=C*ones(m,1);
end
x0=[];
options=optimoptions('quadprog','Display','iter-detailed');
alpha=quadprog(H,f,A,b,Aeq,beq,lb,ub,x0,options);%使用quadprog函数求解二次优化问题
if size(C)==0
    S=find(alpha>tol);
else
    S=find(alpha>tol & alpha<C);
end
omega=(alpha(S)'*(y(S).*x(S,:)))';

if nargin==5 && gamma~=0
    b=y;
    for i=1:m
        for j=1:m
            b(i)=b(i)-alpha(j)*y(j)*exp(-gamma*(norm(x(j,:)-x(i,:))).^2);
        end
    end
    b=mean(b(alpha>0.1));
else
    b=sum((y(S)-x(S,:)*omega))./size(S,1);
end
end
