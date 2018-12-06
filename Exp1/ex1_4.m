%J()·Ö²¼
x=x1;
y=y1;

J_vals=zeros(100,100);
theta0_vals=linspace(-3,3,100);
theta1_vals=linspace(-1,1,100);
m=size(x,1);
for i=1:length(theta0_vals)
    for j=1:length(theta1_vals)
    theta=[theta0_vals(i);theta1_vals(j)];
    J_vals(i,j)=(x*theta-y)'*(x*theta-y)/(2*m);
    end
end
J_vals=J_vals';
figure;
surf(theta0_vals,theta1_vals,J_vals);
xlabel('\theta_0');
ylabel('\theta_1');
zlabel('J(\theta)');
colorbar;