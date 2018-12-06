clc,clear
n = 0;
fid1 = fopen('training_data.txt','rt');   %读入训练集
fid2 = fopen('test_data.txt','rt');
res =[];
ranper = randperm(10000);
for number = 1:10
    n = n+ 1000;
                  %生成随机数
    ran = ranper(1:1:n);
    mm = 1;
    frewind(fid1);
    pxy = zeros(5,8,5);                             %存储每个评价的个数
    yy=zeros(1,5);
    while feof(fid1) ~=1                            %逐行进行读取
        line = fgetl(fid1);
        ismember(mm,ran);
        if ismember(mm,ran)
            cell = strsplit(line,' ');
            data = str2num(char(cell));                 %读入的是cell需要做强制转换
            y = uint8(data(9));                         %强制转换
            for i=1:1:8                                 %逐个计数
                k = uint8(data(i))+1;
                pxy(y+1,i,k)=pxy(y+1,i,k)+1;
            end
            yy(1,y+1)=yy(1,y+1)+1;                      %记录下每个y的总数 
        end
        mm = mm+1;
    end
    pxy(1,:,:)=pxy(1,:,:)./yy(1,1);
    pxy(2,:,:)=pxy(2,:,:)./yy(1,2);
    pxy(3,:,:)=pxy(3,:,:)./yy(1,3);
    pxy(4,:,:)=pxy(4,:,:)./yy(1,4);
    pxy(5,:,:)=pxy(5,:,:)./yy(1,5);
    %读入测试集
    py=yy./n;
    frewind(fid2);
    num = 0;
    total=0;
    while feof(fid2) ~=1
        p = ones(1,5);
        total=total+1;
        line = fgetl(fid2);
        cell = strsplit(line,' ');
        data = str2num(char(cell));                 %读入的是cell需要做强制转换
        for i=1:1:8
            k = uint8(data(i))+1;
            for j=1:1:5
                p(j) = p(j)*pxy(j,i,k);
            end
        end
        p = p.*py;
        [m,location]=max(p);
        location = location-1;
        if location == uint8(data(9))
            num = num+1;
        end
    end
    res=[res,num/total];
end
fclose(fid2);
fclose(fid1);
xx = [1000:1000:n];
plot(xx,res,'-')
% ranper =randperm(10000);                        %生成随机数
% n = 5000;
% ran = ranper(1:1:n);
% mm = 1;
% while feof(fid1) ~=1                            %逐行进行读取
%     line = fgetl(fid1);
%     if ismember(mm,ran)
%         cell = strsplit(line,' ');
%         data = str2num(char(cell));                 %读入的是cell需要做强制转换
%         y = uint8(data(9));                         %强制转换
%         for i=1:1:8                                 %读个计数
%             k = uint8(data(i))+1;
%             pxy(y+1,i,k)=pxy(y+1,i,k)+1;
%         end
%         yy(1,y+1)=yy(1,y+1)+1;                      %记录下每个y的总数 
%     end
%     mm = mm+1;
% end
% mm
% fclose(fid1);
% 
% pxy(1,:,:)=pxy(1,:,:)./yy(1,1);
% pxy(2,:,:)=pxy(2,:,:)./yy(1,2);
% pxy(3,:,:)=pxy(3,:,:)./yy(1,3);
% pxy(4,:,:)=pxy(4,:,:)./yy(1,4);
% pxy(5,:,:)=pxy(5,:,:)./yy(1,5);
% %读入测试集
% py=yy./10000;
% fid2 = fopen('data4/test_data.txt','rt');
% num = 0;
% total=0;
% while feof(fid2) ~=1
%     p = ones(1,5);
%     total=total+1;
%     line = fgetl(fid2);
%     cell = strsplit(line,' ');
%     data = str2num(char(cell));                 %读入的是cell需要做强制转换
%     for i=1:1:8
%         k = uint8(data(i))+1;
%         for j=1:1:5
%             p(j) = p(j)*pxy(j,i,k);
%         end
%     end
%     p = p.*py;
%     [m,location]=max(p);
%     location = location-1;
%     if location == uint8(data(9))
%         num = num+1;
%     end
% end
% fclose(fid2);
% num/total
