tic;
load('data');
x=reshape(A,size(A,1)*size(A,2),3);
[m,n]=size(x);
k=16;
while true
    %随机u使u的每一行均不重复
    u=x(randperm(m,k),:);
    if size(unique(u,'row'),1)==size(u,1)
        break;
    end
end

loss1=0;
iteration=zeros(200,1);
it=0;
while true  
    c=zeros(m,1);
    it=it+1;
    disp(['Iteration:',num2str(it)]);
    Z=zeros(m,k);
    for i=1:m 
        t=sum((x(i,:)-u).^2,2);
        [~,index]=min(t);
        c(i)=index;
        Z(i,index)=1;   
    end
    u=Z'*x./sum(Z,1)';
    loss2=norm(x-Z*u)
    iteration(it)=loss2;
    if abs(loss1-loss2)<1e-3
        break;
    else
        loss1=loss2;
    end
end
x=Z*u;
A=reshape(x,size(A,1),size(A,2),3);
imshow(uint8(round(A)));
figure;
iteration=iteration(1:it,1);
plot(1:it,iteration);
x=reshape(B,size(B,1)*size(B,2),3);
[m,n]=size(x);
for i=1:m
    temp=sum((x(i,:)-u).^2,2);
    [~,index]=min(temp);
    x(i,:)=u(index,:);
end
B=reshape(x,size(B,1),size(B,2),3);
figure;
imshow(uint8(round(B)));
toc;

