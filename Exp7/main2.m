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
test_x=zeros()
for i=1:40
    
end
tic
svms=train_mul(train_x,train_y);
toc;
acc=test_mul(test_x,test_y,svms);
disp(['Acc=',num2str(acc)]);
% [~,acc,~]=svmpredict(test_y,test_x,model);
% acc=acc(1);
%err=find(predict_y-test_y~=0);
% end


%imshow(uint8(reshape(test_x(1,:),112,92)));
