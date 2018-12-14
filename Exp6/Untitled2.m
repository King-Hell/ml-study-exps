tic;
clear;
clc;
A = double(imread('bird_small.tiff'));
%A(:,:,1)red
%A(:,:,2)green
%A(:,:,3)blue
k = 16;
dim = size(A,1);
means = zeros(k,3);
%随机选择集群中心点
rand_x = round(dim*rand(k,1));
rand_y = round(dim*rand(k,1));
for i=1:k
    means(i,:) = A(rand_x(i),rand_y(i),:);
end
MAX_ITER = 100;%最大迭代次数
nearest_mean = zeros(dim);%每个点最靠近的集群中心
for iter = 1:MAX_ITER
    new_means = zeros(size(means));%本次迭代的means
    numofMean = zeros(k,1);%每一个集群的数目
    
    for i=1:dim
        
        for j=1:dim
            tic;
            %提取像素值
            r = A(i,j,1);
            g = A(i,j,2);
            b = A(i,j,3); 
            %获得与该点最近的中心点
            diff = ones(k,1)*[r,g,b]-means;
            distance = sum(diff.^2,2);
            [val index] = min(distance);
            nearest_mean(i,j) = index;
            
            new_means(index,1) = new_means(index,1)+r;
            new_means(index,2) = new_means(index,2)+g;
            new_means(index,3) = new_means(index,3)+b;
            numofMean(index) = numofMean(index)+1;
             toc;
        end
        
    end
   
    %更新means
    for i=1:k
        if numofMean(i)>0
            new_means(i,:) = new_means(i,:)./numofMean(i);
        end
    end
    %是否拟合
    d = sum(sqrt(sum((new_means-means).^2,2)));
    if d< 1e-5
        break;
    end
    means = new_means;
    toc;
end
%像素值取整
means = round(means);

%压缩bird_big
large_bird = double(imread('bird_large.tiff'));
large_dim = size(large_bird,1)

for i=1:large_dim
    for j=1:large_dim
        r = large_bird(i,j,1);
        g = large_bird(i,j,2);
        b = large_bird(i,j,3);
        diff = ones(k,1)*[r,g,b]-means;
        distance = sum(diff.^2,2);
        [val, index] = min(distance);
        large_bird(i,j,:) = means(index,:);
    end
end
round(large_bird);
imshow(uint8(large_bird));
%imwrite(uint8(large_bird),'bird_kmeans.tiff');
hold on;
figure;
hold on;
for i=1:k
    col = (1/255).*means(i,:);
    rectangle('Position',[i,0,1,1],'FaceColor',col,'EdgeColor',col);
end
axis off
toc
