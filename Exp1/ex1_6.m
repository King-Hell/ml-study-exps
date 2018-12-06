%预测房价
x=x2;
y=y2;
%标准化x
sigma=std(x); 
mu=mean(x); 
x(:,2)=(x(:,2)-mu(2))./sigma(2); 
x(:,3)=(x(:,3)-mu(3))./sigma(3);
theta=GD(x,y,0.1,100);
x0=[1,1650,3];
x0(2)=(x0(2)-mu(2))/sigma(2);
x0(3)=(x0(3)-mu(3))/sigma(3);
y0=x0*theta
plot3(x(:,2),x(:,3),y,'.');
