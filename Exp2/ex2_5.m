%牛顿法
pos = find (y == 1); 
neg = find (y == 0);
plot(x(pos,2),x(pos,3),'+'); 
hold on; 
plot(x(neg,2),x(neg,3),'o');
xlabel('Exam 1 score');
ylabel('Exam 2 score');

[theta,k,Larr]=NM(x,y);
yy=theta(2)/-theta(3)*x(:,2)+theta(1)/-theta(3);
plot(x(:,2),yy);

figure;
plot(1:size(Larr,1),Larr);
z=[1,20,80]*theta;
p=1-1.0./(1.0+exp(-z));
disp(theta);
disp(['k=',num2str(k),',z=',num2str(z),',p=',num2str(p)]);
if(z<0)
    disp('不接受');
elseif(z>0)
        disp('接受');
end

function [theta,k,Larr]=NM(x,y)
m=size(x,1);%x行数
n=size(x,2);%x列数，维度
theta=zeros(n,1);
L0=0;
k=0;
Larr=zeros(10,1);
while(true)
    k=k+1;
    h=1.0./(1.0+exp(-x*theta));
    nabla=x'*(h-y)/m;
    L=(-y'*log(h)-(1-y)'*log(1-h))/m;
    Larr(k)=L;
    H=zeros(n,n);
    for i=1:m
        H=H+h(i)*(1-h(i))*x(i,:)'*x(i,:);
    end
    H=H/m;
    theta=theta-H\nabla;
    if(abs(L-L0)<=1e-6)
        break;
    end
    L0=L;
end
L
end