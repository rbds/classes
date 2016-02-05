%% MAE 6258 HW7
%Randy Schur
%3/18/15
clear 
clf(1)
clf(2)
clf(3)
clf(4)

n = 1000;
meanx = 0; varx = 1;
x = meanx + varx*randn(1,n);

N =  [10 20 50 100];
avg = zeros(100,4);

%a
for j = 1:length(N)
   for i= 1:(n/N(j))
       avg(i, j) = mean( x((i-1)*N(j)+1 : i*N(j)) ); 
   end
   mofm(j) = mean(avg(:,j));
   vofm(j) = var(avg(:,j));
end
figure(1)
plot(N, mofm, N, [0 0 0 0])
axis([0, 100, min(mofm)-0.1, max(mofm)+0.1 ])
title('Mean Values')
xlabel('Sample Size')
ylabel('mean value of sample mean')
legend('calculated', 'theoretical')
figure(2)
var_theory = varx.^2./N;
plot(N,vofm, N, var_theory)
axis([0, 100, min(vofm)-0.1, max(vofm)+0.1 ])
title('Mean Values - variances')
xlabel('Sample Size')
ylabel('variance of sample mean')
legend('calculated', 'theoretical')

%b

vars = zeros(100,4);
for j = 1:length(N)
   for i= 1:(n/N(j))
       vars(i, j) = var( x((i-1)*N(j)+1 : i*N(j)) ); 
   end
   mofv(j) = mean(vars(:,j));
   vofv(j) = var(vars(:,j));
end

figure(3)
plot(N, mofv, N, [1 1 1 1])
axis([0, 100, min(mofv)-0.1, max(mofv)+0.1 ])
title('Variance Values')
xlabel('Sample Size')
ylabel('mean value of sample variance')
legend('calculated', 'theoretical')
figure(4)
varv_theory = 1./N.*(3*varx - (N-3)./(N-1)*(varx^2)^2);
plot(N,vofv, N, varv_theory)
axis([0, 100, min(vofv)-0.1, max(vofv)+0.1 ])
title('Variance Values - variances')
xlabel('Sample Size')
ylabel('variance of sample variance')
legend('calculated', 'theoretical')