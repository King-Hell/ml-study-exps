% function strimage(n)
%   fidin = fopen('train-01-images.svm'); % ��test2.txt�ļ�
%   i = 1;
%   apres = [];
% 
% while ~feof(fidin)
%   tline = fgetl(fidin); % ���ļ�����
%   apres{i} = tline;
%   i = i+1;
% end
%   %x=zeros(i-1,28)
%   a = char(apres(n));
% 
%   lena = size(a,2);
%   xy = sscanf(a(4:lena), '%d:%d');
% 
%   lenxy = size(xy,1);
% 
%   grid = [];
%   grid(784) = 0;
%   for i=2:2:lenxy  %% ��һ����
%       if(xy(i)<=0)
%           break;
%       end
%     grid(xy(i-1)) = xy(i) * 100/255;
%   end
%   grid1 = reshape(grid,28,28);
%   grid1 = fliplr(diag(ones(28,1)))*grid1;
%   grid1 = rot90(grid1,3);
%   image(grid1);
%   hold on;
% end
function strimage(n)
load('test-01-images');
grid = x(n,:);
grid = reshape(grid,28,28);
grid = fliplr(diag(ones(28,1)))*grid;
grid = rot90(grid,3);
image(grid);
end
