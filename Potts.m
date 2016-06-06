% Code written by Aniket Ravan
% First attempt at Cellular Potts model
% Last modified 6/6/2016

theta = 0:0.01:2*pi-0.01;
r = 20;
im = zeros(400,400);
x = round(200 + r*cos(theta));
y = round(200 + r*sin(theta));
for i = 1:length(x)
    im(y(i),x(i)) = 1;
end
% im(y(:),x(:)) = 1;
Temperature = 1e3;
im = imfill(im,'holes');
imshow(im);
iteration = 1000;
im = bwperim(im);
imshow(im);
%[x, y] = find(im == 1);
for j = 1
    [x, y] = find(im == 1);
    im = imfill(im,'holes');
    r = regionprops(im, 'Area');
    r_idx = randi(length(x));
    xrand = x(r_idx);
    yrand = y(r_idx);
    nrandx = randi([-1 1]);
    while nrandx == 0
        nrandx = randi([-1 1]);
    end
    nrandy = randi([-1 1]);
    while nrandy == 0
        nrandy = randi([-1 1]);
    end 
    im1 = im;
    im1(yrand + nrandy, xrand + nrandx) = ~im1(yrand + nrandy, xrand + nrandx);
    yrand + nrandy
    xrand + nrandx
    r1 = regionprops(im1, 'Area');
    [x1, y1] = find(bwperim(im1) == 1);
    A1 = r1.Area;
    A = r.Area;
    H = 300*((A1)^2 - (A)^2) + (length(x1))^2 - (length(x1))^2;
    p = exp(-H/Temperature);
    rd = rand;
    if (p > 1 || p < rand)
        im = im1;
        imshow(im);
        drawnow;
    end
    j
end
