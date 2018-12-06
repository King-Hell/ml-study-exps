%梯度下降法
load('ex2');
stdx=stand(x);
sigma=std(x);
mu=mean(x);
pos = find (y == 1); 
neg = find (y == 0);
plot(x(pos,2),x(pos,3),'+'); 
hold on; 
plot(x(neg,2),x(neg,3),'o');
xlabel('Exam 1 score');
ylabel('Exam 2 score');
[theta,k,Larr]=GD(stdx,y,10);
yy=x;

yy(:,3)=theta(2)/-theta(3)*stdx(:,2)+theta(1)/-theta(3);
yy(:,3)=yy(:,3)*sigma(3)+mu(3);
plot(x(:,2),yy(:,3));

figure;
plot(1:size(Larr,1),Larr);
z=[1,(20-mu(2))/sigma(2),(80-mu(3))/sigma(3)]*theta;
p=1-1.0./(1.0+exp(-z));
disp(theta);
disp(['k=',num2str(k),',z=',num2str(z),',p=',num2str(p)]);
if(z<0)
    disp('不接受');
elseif(z>0)
        disp('接受');
end
    

%梯度下降函数
function [theta,k,Larr] = GD(x,y,alpha)
%h函数,alpha学习速率
m=size(x,1);
n=size(x,2);
theta=zeros(n,1);
k=0;
L0=0;
Larr=zeros(10,1);
while(true)
    k=k+1;
    h=1.0./(1.0+exp(-x*theta));
    nabla=x'*(h-y)/m;
    L=(-y'*log(h)-(1-y)'*log(1-h))/m;
    Larr(k,1)=L;
    %L=(y'*log(h)+(1-y)'*log(1-h))/m;
    theta=theta-alpha*nabla;
    if(abs(L-L0)<=1e-6)
        break;
    end
    L0=L;
end
L
end
