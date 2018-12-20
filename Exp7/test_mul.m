function [acc,errs]=test_mul(x,y,svms)
%测试数据集
class=size(unique(y),1);%总分类数
svmMount=class*(class-1)/2;%SVM数量为n(n-1)/2
m=size(y,1);
pre_y=zeros(m,1);
for i=1:m
    vote=zeros(class,1);%该变量用于统计每种分类的投票数
    for j=1:svmMount
        s=svms{j};
        yy=x(i,:)*s.omega+s.b;
        if yy>=0
            vote(s.pos)=vote(s.pos)+1;
        else
            vote(s.neg)=vote(s.neg)+1;
        end
    end
    [~,index]=max(vote);
    pre_y(i)=index;
end
errs=pre_y-y;
acc=sum(errs==0)/m;
errs=find(errs~=0);
end