sampleMount=40;%分类数
imageMount=10;%每个分类的样本数
n=112*92;%特征数
%读入数据
load('data.mat');
% exp_y=zeros(100,1);
% for k=1:100
%     xk=pca(x,k);
%     exp_y(k)=exp(xk,y);
%     disp(['第',num2str(k),'次迭代完成']);
% end
% plot(1:100,exp_y);

% function [acc]=exp(x,y)
x=pca(x,10);
train_y=zeros(size(y));
train_x=zeros(size(x));
test_y=zeros(size(y));
test_x=zeros(size(x));
train_it=0;
test_it=0;

for i=1:sampleMount
    trainSize=4+randperm(3,1);
    testSize=imageMount-trainSize;
    trainIndex=randperm(imageMount,trainSize);
    testIndex=setdiff(1:imageMount,trainIndex);
    for j=1:trainSize
        train_it=train_it+1;
        train_y(train_it,:)=y(trainIndex(j)+(i-1)*imageMount,:);
        train_x(train_it,:)=x(trainIndex(j)+(i-1)*imageMount,:);
    end
    for j=1:testSize
        test_it=test_it+1;
        test_y(test_it,:)=y(testIndex(j)+(i-1)*imageMount,:);
        test_x(test_it,:)=x(testIndex(j)+(i-1)*imageMount,:);
    end
end

train_y=train_y(1:train_it,1);
train_x=train_x(1:train_it,:);
test_y=test_y(1:test_it,1);
test_x=test_x(1:test_it,:);
tic
svms=train_mul(train_x,train_y);
toc;
[acc,errs]=test_mul(test_x,test_y,svms);
disp(['Acc=',num2str(acc)]);
% [~,acc,~]=svmpredict(test_y,test_x,model);
% acc=acc(1);
%err=find(predict_y-test_y~=0);
% end


%imshow(uint8(reshape(test_x(1,:),112,92)));
