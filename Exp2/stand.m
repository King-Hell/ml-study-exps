%��׼������
function stdx = stand(x)
%STAND �����ݽ��б�׼��
%   xΪҪ��׼�����ݣ�stdxΪ��׼��������ݣ�x�ĵ�һ��ӦȫΪ1
m=size(x,1);
n=size(x,2);
stdx=(x-mean(x))./std(x); 
stdx=[ones(m,1),stdx(:,2:n)];
end

