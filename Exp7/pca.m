function [Z]=pca(X,k)
    [m,~]=size(X);
    X=X-mean(X,1);%���ݹ�һ��
    tic;
    S=X'*X./m;%����Э�������
    toc;
    [U,~]=eigs(S,k);%��������ֵ
    Z=X*U;
end