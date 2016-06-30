v = VideoWriter('cells.avi');
v.FrameRate = 20;
open(v);
theta = 0:0.001:2*pi-0.001;
for j = 20:150
r = 10*(10-1.5*(j)^(1/3) + cos(floor(sqrt(j))*theta))/(10 - 1.5*(j)^(1/3));
x = r.*cos(theta);
y = r.*sin(theta);
plot(x,y,'.');
axis([-20 20 -20 20]);
axis('equal');
f = getframe;
writeVideo(v,f);
end
close(v);