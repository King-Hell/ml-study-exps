%梯度下降函数
function theta = GD(x,y,alpha,k)
%alpha学习速率,k迭代次数
theta=zeros(size(x,2),1);
for i=1:k
    theta=theta-alpha/size(x,1)*x'*(x*theta-y);
end