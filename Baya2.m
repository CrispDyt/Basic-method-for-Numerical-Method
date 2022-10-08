% Precision patameter
beta = 25;
% Prior parameter
a = 1;
for N = [0,3,6,30]
    %% Prepare Observation Data
    x = linspace(0,1,N+1);
    x = x';
    epsilon = 0.2*randn(N+1,1);
    t = sin(2*pi*x) + epsilon;
    % degree of polynomials
    r = 13;
    %% Build Feature Matrix
    K = Phi(x,r);
    %% parameter for posterior
    S = a*eye(r+1,r+1)+beta*(K'*K);
    S = inv(S);
    m = beta*S'*K'*t;
    %% Prediction
    x_plot = 0:0.05:1;
    x_plot = x_plot';
    phi = Phi(x_plot,r);
    mean = m'* phi';
    sigma = 1/beta + diag(phi*S*phi');
    sigma = sigma';
    %% Plot part
    plot_pred(x_plot,x,t,mean,sigma)
end

% Feature Matrix \Phi
function y = Phi(x,r)
y = zeros(length(x),r+1);
for i = 0:r
    y(:,i+1) = x.^i;
end
end

% Plot function
function plot_pred(x_plot,x,t,mean,sigma)
fig = figure();
% Exact solution
y = sin(2*pi*x_plot);
hold on;

% plot data scatter
s1 = scatter(x,t,35,'r','filled');
% plot exact solution
p1 = plot(x_plot,y,'linewidth',3.5,'color','g','LineStyle','-');
% plot prediction
p2 = plot(x_plot',mean,'linewidth',3.5,'color','b','LineStyle','-');
% plot confident area
x_plot = x_plot';
xconf = [x_plot,x_plot(end:-1:1)] ;
yconf = [mean+sqrt(sigma),mean(end:-1:1)-sqrt(sigma)];
p3 = fill(xconf,yconf,'red');
p3.FaceColor = [1 0.8 0.8];
p3.EdgeColor = 'none';
p3.FaceAlpha = 0.6;

hold off;
ax = gca;
ax.FontSize = 30;
ax.YLabel.String = '$y$';
ax.YLabel.Interpreter = 'latex';
ax.YTickLabelRotation = 0;
ax.YLabel.FontSize = 40;
ax.YLabel.Rotation = 0;
ax.XLabel.String = '$x$';
ax.XLabel.FontSize = 40;
ax.XLabel.Interpreter = 'latex';
ax.Box = 'on';

lgd = legend([p1,p2],{'真实解','贝叶斯回归'});
lgd.FontSize = 15;
lgd.Box = 'off';
lgd.NumColumns = 1;
lgd.FontWeight = 'bold';
lgd.Location = 'northeast';
set(gcf,'position',[200,50,800,600]);
end