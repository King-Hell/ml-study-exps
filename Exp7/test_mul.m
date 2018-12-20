function [acc,errs]=test_mul(x,y,svms)
%�������ݼ�
class=size(unique(y),1);%�ܷ�����
svmMount=class*(class-1)/2;%SVM����Ϊn(n-1)/2
m=size(y,1);
pre_y=zeros(m,1);
for i=1:m
    vote=zeros(class,1);%�ñ�������ͳ��ÿ�ַ����ͶƱ��
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