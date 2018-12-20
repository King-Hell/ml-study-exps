sampleMount=40;%分类数
imageMount=10;%每个分类的样本数
n=112*92;%特征数

y=zeros(sampleMount*imageMount,1);
x=zeros(sampleMount*imageMount,n);
for i=1:sampleMount
    for j=1:imageMount
        x((i-1)*10+j,:)=double(reshape(imread(['orl_faces/s',num2str(i),'/',num2str(j),'.pgm']),1,n));
        y((i-1)*10+j,1)=i;
    end
end
x=pca(x,6);
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
model=svmtrain(train_y,train_x,'-t 0');
toc;
predict_y=svmpredict(test_y,test_x,model);
err=find(predict_y-test_y~=0);
%imshow(uint8(reshape(test_x(1,:),112,92)));
