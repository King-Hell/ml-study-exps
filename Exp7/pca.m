function [Z]=pca(X,k)
    [m,~]=size(X);
    X=X-mean(X,1);%数据归一化
    tic;
    S=X'*X./m;%计算协方差矩阵
    toc;
    [U,~]=eigs(S,k);%计算特征值
    Z=X*U;
end