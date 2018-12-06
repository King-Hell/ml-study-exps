load('training_3');
%训练数据集
figure;
subplot(2,2,1);
gamma=1;
[~,b,alpha]=train(x,y,0.1,[],gamma);
draw(x,y,alpha,gamma,b);
subplot(2,2,2);
gamma=10;
[~,b,alpha]=train(x,y,0.1,[],gamma);
draw(x,y,alpha,gamma,b);
subplot(2,2,3);
gamma=100;
[~,b,alpha]=train(x,y,0.1,[],gamma);
draw(x,y,alpha,gamma,b);
subplot(2,2,4);
gamma=1000;
[~,b,alpha]=train(x,y,0.1,[],gamma);
draw(x,y,alpha,gamma,b);

function []=draw(x,y,alpha,gamma,b)
xplot=linspace(min(x(:,1)),max(x(:,1)),100);
yplot=linspace(min(x(:,2)),max(x(:,2)),100);
[X,Y]=meshgrid(xplot,yplot);
vals=zeros(size(X));
S=find(alpha>0.1);
for j=1:size(vals,1)
    for k=1:size(vals,2)
        yy=0;
        for i=S'
            yy=yy+alpha(i)*y(i)*exp(-gamma*(norm(x(i,:)-[xplot(j),yplot(k)])).^2);
        end
        vals(k,j)=yy+b;
    end
end
colormap bone;
contour(X,Y, vals , [0 0] ,'LineWidth', 2);
hold on;
pos=find(y==1);
neg=find(y==-1);
plot(x(pos,1),x(pos,2),'.');
plot(x(neg,1),x(neg,2),'.');
%测试正确率
vals=zeros(size(y,1),1);
for j=1:size(y,1)
    yy=0;
    for i=S'
        yy=yy+alpha(i)*y(i)*exp(-gamma*(norm(x(i,:)-x(j,:))).^2);
    end
    if yy>0
        vals(j)=1;
    elseif yy<0
        vals(j)=-1;
    end
end
acc=sum(y-vals==0)/size(y,1);
title(['\gamma=',num2str(gamma),',accuracy=',num2str(acc)]);
end
