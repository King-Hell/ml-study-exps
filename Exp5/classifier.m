figure;
load('training_1')
[omega,b]=train(x,y,1e-13,1);
subplot(2,2,1);
draw(x,y,omega,b);
title('training_1');
load('test_1');
accuracy=test(x,y,omega,b);
subplot(2,2,2);
draw(x,y,omega,b);
title(['test_1,',num2str(accuracy),'%']);

load('training_2')
[omega,b]=train(x,y,1e-12,[]);
subplot(2,2,3);
draw(x,y,omega,b);
title('training_2');
load('test_2');
accuracy=test(x,y,omega,b);
subplot(2,2,4);
draw(x,y,omega,b);
title(['test_2,',num2str(accuracy),'%']);



function [accuracy]=test(x,y,omega,b)
%²âÊÔÊı¾İ¼¯
yy=x*omega+b;
yy(yy>0)=1;
yy(yy<0)=-1;
right=sum(yy-y==0);
total=size(y,1);
accuracy=right/total*100;
fprintf('right=%d,total=%d,accuracy=%.2f%%\n',right,total,accuracy);
end

function []=draw(x,y,omega,b)
pos=find(y==1);
neg=find(y==-1);
plot(x(pos,1),x(pos,2),'.');
hold on;
plot(x(neg,1),x(neg,2),'.');
xx=20:180;
yy=(-b-omega(1)*xx)./omega(2);
plot(xx,yy);
end

