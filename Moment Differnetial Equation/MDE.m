x = linspace(0,pi/2,50);
mean = x - (pi/2)*sin(x);
sigma = 0.01*(mean.^2);
fig = figure;
hold on;
% plot mean solution
p1 = plot(x,mean,'linewidth',3.5,'color','b','LineStyle','-');
% plot confident area
xconf = [x,x(end:-1:1)] ;
yconf = [mean+sqrt(sigma),mean(end:-1:1)-sqrt(sigma)];
p3 = fill(xconf,yconf,'red');
p3.FaceColor = [1 0.8 0.8];
p3.EdgeColor = 'none';
p3.FaceAlpha = 0.8;

hold off;
ax = gca;
ax.FontSize = 30;
ax.YLabel.String = '$C$';
ax.YLabel.Interpreter = 'latex';
ax.YTickLabelRotation = 0;
ax.YLabel.FontSize = 40;
ax.YLabel.Rotation = 0;
ax.XLabel.String = '$x$';
ax.XLabel.FontSize = 40;
ax.XLabel.Interpreter = 'latex';
ax.Box = 'on';

lgd = legend([p1],{'MDE'});
lgd.FontSize = 20;
lgd.Box = 'off';
lgd.NumColumns = 1;
lgd.FontWeight = 'bold';
lgd.Location = 'southeast';
set(gcf,'position',[200,50,800,600]);