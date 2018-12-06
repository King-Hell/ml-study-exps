%ÏßÐÔ»Ø¹é*************************************
load('data_1.mat');

fun(x,y,0);
fun(x,y,1);
fun(x,y,10);
%h=x*theta;
%J=1/(2*m)*[(h-y)'*(h-y)+lambda*theta'*theta];
function []=fun(x,y,lambda)
    [m,n]=size(x);
    theta=(x'*x+lambda*[0,zeros(1,n-1);zeros(n-1,1),eye(n-1)])\x'*y;
    xx=(-1:0.1:1)';
    xx=[ones(size(xx,1),1),xx,xx.^2,xx.^3,xx.^4,xx.^5];
    yy=xx*theta;
    figure;
    plot(x(:,2),y,'.');
    hold on;
    plot(xx(:,2),yy,'--');
    title(['\lambda=',num2str(lambda)]);
end