%二维线性回归
figure;
plot(x1(:,2),y1,'.');
ylabel('Height in meters');
xlabel('Age in years');
hold on;
theta=GD(x1,y1,0.07,1500);
plot(x1(:,2),x1*theta);
legend('Training data','Linear regression');