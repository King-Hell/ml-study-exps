load('train-01-images');
alpha=alpha1;
% S=find(alpha>1e-11 & alpha<10);
S=find(alpha>1e-11);
omega=(alpha(S)'*(y(S).*x(S,:)))';
b=sum((y(S)-x(S,:)*omega))./size(S,1);
yy=x*omega+b;
yy(yy>0)=1;
yy(yy<0)=-1;
find(yy-y~=0)
sum(yy-y~=0)
% load('test-01-images');
% yy=x*omega+b;
% yy(yy>0)=1;
% yy(yy<0)=-1;
% find(yy-y~=0)
% sum(yy-y~=0)