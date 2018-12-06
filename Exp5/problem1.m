clc,clear
m = load('training_1.txt');
col = length(m(1,:));               %�õ�x��ά��
row = length(m(:,1));               %�õ�������

%�滮ʹ�õ���min=1/2 * xTHx + fx
H = zeros(row,row);
for i =1:row
    for j = 1:row
        H(i,j) = m(i,col)*m(j,col)*m(i,1:(col-1))*m(j,1:(col-1))';
    end
end
f = ones(1,row);
f = -f;

%lb <= x <=ub
lb = zeros(row,1);
C = 100;
ub = ones(row,1)*C;

%Aeq *x = beq
Aeq = m(:,col)';
beq = [0];

 %x�������ǽ����fval���������Сֵ��exiflag�ǽ���Ƿ�Ϊ���Ž�
 options=optimoptions('quadprog','Display','iter-detailed');
[x,fval,exitflag,output,lambda] = quadprog(H,f,[],[],Aeq,beq,lb,[],[],options); 

%����ͼ
figure
pos = find(m(:,col)==1);
neg = find(m(:,col)==-1);
plot(m(pos,1),m(pos,2),'+')
hold on 
plot(m(neg,1),m(neg,2),'o')

%wT*x+b=0
w = sum (x' * m(:,col) * m(:,1:(col-1)));




