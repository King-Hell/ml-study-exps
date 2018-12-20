tic;
load('train-01-images');
model=svmtrain(y,x,'-t 0');
load('test-01-images');
svmpredict(y,x,model)
toc;