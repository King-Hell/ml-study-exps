%选择学习率
figure;
plot(0:49,getJ(x2,y2,0.01));
hold on;
plot(0:49,getJ(x2,y2,0.03));
plot(0:49,getJ(x2,y2,0.1));
plot(0:49,getJ(x2,y2,0.3));
plot(0:49,getJ(x2,y2,4));
xlabel('Number of iterations');
ylabel('Cost J');
legend('0.01','0.03','0.1','0.3','4');

function J=getJ(x,y,alpha)
sigma=std(x); 
mu=mean(x); 
x(:,2)=(x(:,2)-mu(2))./sigma(2); 
x(:,3)=(x(:,3)-mu(3))./sigma(3);
theta=zeros(size(x,2),1); %初始化theta 
J=zeros(50,1);
m=size(x,1);
for num_iterations=1:50
    J(num_iterations)=(x*theta-y)'*(x*theta-y)/(2*m);
     theta=theta-alpha/size(x,1)*((x*theta-y)'*x)';
end
end