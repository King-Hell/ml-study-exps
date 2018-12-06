
  fidin = fopen('test-01-images.svm'); % 打开test2.txt文件 
  i = 1;
  apres = [];
while ~feof(fidin)
  tline = fgetl(fidin); % 从文件读行 
  apres{i} = tline;
  i = i+1;
end
  x=zeros(i-1,28*28);
  y=zeros(i-1,1);
  for j=1:i-1
    a = char(apres(j));
    y(j)=sscanf(a(1:2),'%d');
    xy = sscanf(a(4:size(a,2)), '%d:%d');
    for k=2:2:size(xy,1)
        x(j,xy(k-1))=xy(k);
    end
  end


