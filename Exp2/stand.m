%标准化方法
function stdx = stand(x)
%STAND 将数据进行标准化
%   x为要标准化数据，stdx为标准化后的数据，x的第一列应全为1
m=size(x,1);
n=size(x,2);
stdx=(x-mean(x))./std(x); 
stdx=[ones(m,1),stdx(:,2:n)];
end

