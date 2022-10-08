clear
%% ���庯��f, �����������n, �������Ҷ˵�a, b.
f = @(x) 0.2 + 25 * x - 200 * x.^2 + 675 * x.^3 - 900 * x.^4 + 400 * x.^5;
global a
global b
global n
a=0;
b=0.8;
true_int_f = 4.9216/3; %��ʵ����ֵ
n=10;
%% ���λ��ַ����

integral_points = (a:(b-a)/n:b);

trapf(integral_points,f) %% �������λ��ֺ�������һ������Ϊ���ֽڵ㣬�ڶ���Ϊ���ֺ������

error_trap = zeros(1, 10);
% ���㲻ͬn=1...10�µ����ѻ��ֹ�ʽ���
for n=1:10
    integral_points = (a:(b-a)/n:b);
    error_trap(n) = abs(true_int_f - trapf(integral_points,f));
end
% ��ͼ
figure 
plot((1:10), error_trap);
xlabel('������������');
ylabel('�������');
title('���λ��ַ����');
legend('���λ��ַ����')
%% ����ɭ1/3�����
assert(mod(n,2)==0, 'integral interval number n of simpson must be even' ) % simposon 1/3��������������Ϊż��

simposon(integral_points,f) %% ��������ɭ1/3���ֺ�������һ������Ϊ���ֽڵ㣬�ڶ���Ϊ���ֺ������

error_simposon = zeros(1, 5);
% ���㲻ͬn =2...10�µĻ������
for k=1:5
    n=2*k;
    integral_points = (a:(b-a)/n:b);
    error_simposon(k) = abs(true_int_f - simposon(integral_points,f));
end
% ��ͼ
figure 
plot((1:5), error_simposon);
xlabel('������������');
ylabel('�������');
title('Simposon���ַ����');
legend('Simposon���ַ����')
%% �Ƚ��������ֻ��ַ�ʽ��������������Ϊsimposon��ʽ����Ϊż����
figure 
hold on
plot((2:2:10), error_simposon);
plot((2:2:10), error_trap(2:2:10));
hold
xlabel('������������');
ylabel('�������');
%title('Simposon���ַ����Ƚ�');
set(gca,'xtick',(2:2:10))
legend('Simposon���ַ����', '���λ������')