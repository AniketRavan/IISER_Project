% Written by Aniket Ravan
% Last modified on 4th April 16
% Attempt at modelling neurite growth
v = VideoWriter('Neurite_Growth.avi');
v.FrameRate = 30;
open(v);
theta = 0:0.001:2*pi-0.001;
for j = 200:2:820
    r = 2^(j/150)*((j - 820)^(2) + 3280  + 2*j*cos(ceil(j^(1/3))*theta))/((j - 820)^(2) + 3280+ 2*j); % Petals in polar co-ord
    ceil(j^(1/4))
    x = r.*cos(theta);
    y = r.*sin(theta);
    plot(x,y,'.');
    axis([-60 60 -60 60]);
    axis('equal');
    f = getframe;
    writeVideo(v,f);
end
close(v);