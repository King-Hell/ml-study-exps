clear;
sampleMount=40;%������
imageMount=10;%ÿ�������������
n=112*92;%������
%��������
y=zeros(sampleMount*imageMount,1);
x=zeros(sampleMount*imageMount,n);
for i=1:sampleMount
    for j=1:imageMount
        x((i-1)*10+j,:)=double(reshape(imread(['orl_faces/s',num2str(i),'/',num2str(j),'.pgm']),1,n));
        y((i-1)*10+j,1)=i;
    end
end
clear i j;
save('data.mat');