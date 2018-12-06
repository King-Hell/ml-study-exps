pos = find (y == 1); 
neg = find (y == 0);
plot(x(pos,2),x(pos,3),'+'); 
hold on; 
plot(x(neg,2),x(neg,3),'o');
xlabel('Exam 1 score');
ylabel('Exam 2 score');