%选择学习率
figure;
stdx=stand(x);
[J,T]=getJ(stdx,y,0.001);
plot(1:100000,J);
hold on;
% plot(0:49,getJ(x,y,0.03));
% plot(0:49,getJ(x,y,0.1));
% plot(0:49,getJ(x,y,0.3));
xlabel('Number of iterations');
ylabel('Cost J');
plot(1:100000,T(:,1));
plot(1:100000,T(:,2));
plot(1:100000,T(:,3));
legend('J','\theta0','\theta1','\theta2');

function [J,T]=getJ(x,y,alpha)
h=@(x,theta)1.0./(1.0+exp(-x*theta));
theta=zeros(size(x,2),1); %初始化theta 
J=zeros(100000,1);
T=zeros(100000,3);
m=size(x,1);
for num_iterations=1:100000
    J(num_iterations)=(h(x,theta)-y)'*(h(x,theta)-y)/(2*m);
     theta=theta-alpha/size(x,1)*((h(x,theta)-y)'*x)';
     T(num_iterations,:)=theta;
end
end