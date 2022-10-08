clear;
clc;
% Generate uniform distribution random variable in [-1,1]
x = rand(10,1)*2-1;
% Generate random noise with derivaitive of 0.2
epsilon = 0.2*randn(10,1);
% Precision patameter
beta = 25;
% Observation
t = lin_model(x)+epsilon;
% prior
% covariance parameter 
a = 2;
% Initial regression coefficients
plot_prior(a);
% mean and covariance matrix for posterior
% matrix of polynomials
for N = 3:3:9
    Phi = [ones(N,1),x(1:N,1)];
    S = a*eye(2,2)+beta*(Phi'*Phi);
    S = inv(S);
    m = beta*S'*Phi'*t(1:N,1);
    plot_posterior(m,S)
end

% Linear Model
function [y] = lin_model(x)
w0 = -0.3;
w1 = 0.5;
y = w0+w1*x;
end

% compute pdf of prior
function [y] = prior(w,a)
% Convariance Matrix
cov = eye(2,2)/a;
% pdf function
y = exp(-0.5*(w'* inv(cov)* w))/ sqrt(((2*pi)^2)*det(cov));
end

% compute pdf of posterior
function [y] = posterior(w,m,S)
% m mean
% S covariance
% pdf function
y = exp(-0.5*((w-m)'* inv(S)* (w-m)))/ sqrt(((2*pi)^2)*det(S));
end

% plot 2D hot figure for prior distribution
function plot_prior(a)
w0 = -1:0.05:1;
w1 = -1:0.05:1;
[W0,W1] = meshgrid(w0,w1);
l = length(w1);
P = zeros(l,l);
for i = 1:l
    for j = 1:l
        W = [W0(i,j);W1(i,j)];
        P(i,j) = prior(W,a);
    end
end
fig = figure();
s = surf(W0,W1,P);,view(2);
s.EdgeColor = 'flat';
s.FaceColor = 'flat';
colormap(fig,parula(5));
colorbar;
ax = gca();
ax.LineWidth = 1;
ax.FontSize = 20;
ax.XLabel.String = '$w_{0}$';
ax.YLabel.String = '$w_{1}$';
ax.ZLabel.String = '$p(w|t)$';
ax.XLabel.Interpreter = 'latex';
ax.YLabel.Interpreter = 'latex';
ax.ZLabel.Interpreter = 'latex';
f = title('Prior');
f.LineWidth = 10;
end

% plot 2D hot figure for posterior distribution
function plot_posterior(m,S)
w0 = -1:0.05:1;
w1 = -1:0.05:1;
[W0,W1] = meshgrid(w0,w1);
l = length(w1);
P = zeros(l,l);
for i = 1:l
    for j = 1:l
        W = [W0(i,j);W1(i,j)];
        P(i,j) = posterior(W,m,S);
    end
end
fig = figure();
s = surf(W0,W1,P);,view(2);
s.EdgeColor = 'flat';
s.FaceColor = 'flat';
colormap(fig,parula(5));
colorbar;
ax = gca();
ax.LineWidth = 1;
ax.FontSize = 20;
ax.XLabel.String = '$w_{0}$';
ax.YLabel.String = '$w_{1}$';
ax.ZLabel.String = '$p(w|t)$';
ax.XLabel.Interpreter = 'latex';
ax.YLabel.Interpreter = 'latex';
ax.ZLabel.Interpreter = 'latex';
f = title('Posterior');
f.LineWidth = 10;
end

