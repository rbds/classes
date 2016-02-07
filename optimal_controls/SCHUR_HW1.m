%Randy Schur
%MAE 6292
%1/27/15

clear all
close

Q = [3 1 1; 1 2 0; 1 0 1];
R = eye(2);
B= [1 1; 1 0; 0 1];
c=[1 -1 0]';

x1 = linspace(-10,10, 1000);
x2=linspace(-10,10, 1000);
l = linspace(-10, 10, 1000);

u= [10, 10];

for i=1:100
    for j=1:100
        %for =1:100
            J(i,j) = 0.5* x1(i)'*Q*x1(i) + 0.5*x2(j)'*R*x2(j); 
        %end
    end
end

while norm(Hu)> eps
    
    
end