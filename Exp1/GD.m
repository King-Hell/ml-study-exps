%�ݶ��½�����
function theta = GD(x,y,alpha,k)
%alphaѧϰ����,k��������
theta=zeros(size(x,2),1);
for i=1:k
    theta=theta-alpha/size(x,1)*x'*(x*theta-y);
end