clear
%% 定义函数f, 积分区间个数n, 区间左右端点a, b.
f = @(x) 0.2 + 25 * x - 200 * x.^2 + 675 * x.^3 - 900 * x.^4 + 400 * x.^5;
global a
global b
global n
a=0;
b=0.8;
true_int_f = 4.9216/3; %真实积分值
n=10;
%% 梯形积分法误差

integral_points = (a:(b-a)/n:b);

trapf(integral_points,f) %% 调用梯形积分函数。第一个变量为积分节点，第二个为积分函数句柄

error_trap = zeros(1, 10);
% 计算不同n=1...10下的提醒积分公式误差
for n=1:10
    integral_points = (a:(b-a)/n:b);
    error_trap(n) = abs(true_int_f - trapf(integral_points,f));
end
% 绘图
figure 
plot((1:10), error_trap);
xlabel('积分区间数量');
ylabel('积分误差');
title('梯形积分法误差');
legend('梯形积分法误差')
%% 辛普森1/3法误差
assert(mod(n,2)==0, 'integral interval number n of simpson must be even' ) % simposon 1/3积分区间数必须为偶数

simposon(integral_points,f) %% 调用辛普森1/3积分函数。第一个变量为积分节点，第二个为积分函数句柄

error_simposon = zeros(1, 5);
% 计算不同n =2...10下的积分误差
for k=1:5
    n=2*k;
    integral_points = (a:(b-a)/n:b);
    error_simposon(k) = abs(true_int_f - simposon(integral_points,f));
end
% 绘图
figure 
plot((1:5), error_simposon);
xlabel('积分区间数量');
ylabel('积分误差');
title('Simposon积分法误差');
legend('Simposon积分法误差')
%% 比较两个积分积分方式的误差，积分区间因为simposon公式限制为偶数点
figure 
hold on
plot((2:2:10), error_simposon);
plot((2:2:10), error_trap(2:2:10));
hold
xlabel('积分区间数量');
ylabel('积分误差');
%title('Simposon积分法误差比较');
set(gca,'xtick',(2:2:10))
legend('Simposon积分法误差', '梯形积分误差')