%Âß¼­»Ø¹é**************************************
load('data_2');
[theta,lambda]=fun(x,y,0);
draw(x,y,theta,lambda);
norm(theta)

[theta,lambda]=fun(x,y,1);
draw(x,y,theta,lambda);
norm(theta)

[theta,lambda]=fun(x,y,10);
draw(x,y,theta,lambda);
norm(theta)
function [theta,lambda]=fun(x,y,lambda)
%H=1/m*h*(1-h)*x'*x+lambda/m*[0,zeros(1,n-1);zeros(n-1,1),eye(n-1)];
[m,n]=size(x);
theta=zeros(n,1);
J0=0;
k=0;
while true
    k=k+1;
    h=1./(1+exp(-x*theta));
    nebla=1/m*x'*(h-y)+lambda/m*[0;theta(2:28,1)];
    H=zeros(n,n);
    for i=1:m
        H=H+h(i)*(1-h(i))*x(i,:)'*x(i,:);
    end
    H=H/m;
    H=H+lambda/m*[0,zeros(1,n-1);zeros(n-1,1),eye(n-1)];
    theta=theta-H\nebla;
    J=-1/m*(y'*log(h)+(1-y)'*log(1-h))+lambda/(2*m)*(theta'*theta);
    if(abs(J-J0)<1e-6)
        break;
    end
    J0=J;
end
disp(['k=',num2str(k)]);
end

function []=draw(x,y,theta,lambda)
figure;
pos=find(y);
neg=find(y==0);
plot(x(pos,2),x(pos,3),'+');
hold on;
plot(x(neg,2),x(neg,3),'o');
u=linspace(-1,1.5,200);
v=linspace(-1,1.5,200);
z=zeros(length(u),length(v));
for i=1:length(u)
    for j=1:length(v)
        z(i,j)=map_feature(u(i),v(j))*theta;
    end
end
z=z';
contour(u,v,z,[0,0],'LineWidth',2);
title(['\lambda=',num2str(lambda)]);
end
