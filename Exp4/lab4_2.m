clc,clear
n = 0;
fid1 = fopen('training_data.txt','rt');   %����ѵ����
fid2 = fopen('test_data.txt','rt');
res =[];
ranper = randperm(10000);
for number = 1:10
    n = n+ 1000;
                  %���������
    ran = ranper(1:1:n);
    mm = 1;
    frewind(fid1);
    pxy = zeros(5,8,5);                             %�洢ÿ�����۵ĸ���
    yy=zeros(1,5);
    while feof(fid1) ~=1                            %���н��ж�ȡ
        line = fgetl(fid1);
        ismember(mm,ran);
        if ismember(mm,ran)
            cell = strsplit(line,' ');
            data = str2num(char(cell));                 %�������cell��Ҫ��ǿ��ת��
            y = uint8(data(9));                         %ǿ��ת��
            for i=1:1:8                                 %�������
                k = uint8(data(i))+1;
                pxy(y+1,i,k)=pxy(y+1,i,k)+1;
            end
            yy(1,y+1)=yy(1,y+1)+1;                      %��¼��ÿ��y������ 
        end
        mm = mm+1;
    end
    pxy(1,:,:)=pxy(1,:,:)./yy(1,1);
    pxy(2,:,:)=pxy(2,:,:)./yy(1,2);
    pxy(3,:,:)=pxy(3,:,:)./yy(1,3);
    pxy(4,:,:)=pxy(4,:,:)./yy(1,4);
    pxy(5,:,:)=pxy(5,:,:)./yy(1,5);
    %������Լ�
    py=yy./n;
    frewind(fid2);
    num = 0;
    total=0;
    while feof(fid2) ~=1
        p = ones(1,5);
        total=total+1;
        line = fgetl(fid2);
        cell = strsplit(line,' ');
        data = str2num(char(cell));                 %�������cell��Ҫ��ǿ��ת��
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
% ranper =randperm(10000);                        %���������
% n = 5000;
% ran = ranper(1:1:n);
% mm = 1;
% while feof(fid1) ~=1                            %���н��ж�ȡ
%     line = fgetl(fid1);
%     if ismember(mm,ran)
%         cell = strsplit(line,' ');
%         data = str2num(char(cell));                 %�������cell��Ҫ��ǿ��ת��
%         y = uint8(data(9));                         %ǿ��ת��
%         for i=1:1:8                                 %��������
%             k = uint8(data(i))+1;
%             pxy(y+1,i,k)=pxy(y+1,i,k)+1;
%         end
%         yy(1,y+1)=yy(1,y+1)+1;                      %��¼��ÿ��y������ 
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
% %������Լ�
% py=yy./10000;
% fid2 = fopen('data4/test_data.txt','rt');
% num = 0;
% total=0;
% while feof(fid2) ~=1
%     p = ones(1,5);
%     total=total+1;
%     line = fgetl(fid2);
%     cell = strsplit(line,' ');
%     data = str2num(char(cell));                 %�������cell��Ҫ��ǿ��ת��
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
