function [omega,b,alpha]=train(x,y,tol,C,gamma)
%训练数据集
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
% A=-1.*eye(m);
% b=zeros(m,1);
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

