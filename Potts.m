% Code written by Aniket Ravan
% First attempt at Cellular Potts model
% Last modified 6/15/2016
% A lattice-cell is defined by a 3x3 square
v = VideoWriter('POTTS_Circle1.avi');
open(v);
theta = 0:0.01:2*pi-0.01;
side = 60; % Radius of the circle
im = zeros(100,100);
x = 50 - 25 : 50 + 25;
y = 50 - 25 : 50 + 25;
% for i = 1:length(x)
%     im(y(i),x(i)) = 1;
% end
im(y(:),x(:)) = 1;
Temperature = 1000;
im = imfill(im,'holes');
imshow(im);
eq = regionprops(im,'Area');
Aeq = eq.Area;
rad = sqrt(Aeq/pi);
iterations = 1000000;
im = bwperim(im);
imshow(im);
%[x, y] = find(im == 1);
idx = 1;
for j = 1:iterations
    j;
    y = 5:3:5+3*floor(size(im,2)/3 - 5);
    x = 5:3:5+3*floor(size(im,1)/3 - 5);
    L = length(y);
    im = imfill(im,'holes');
    r = regionprops(im, 'Area','MajorAxisLength','MinorAxisLength');
    %ratio = max(r.MajorAxisLength)/min(r.MinorAxisLength);
    xrand = x(randi(length(x)));
    yrand = y(randi(length(y)));
    vector = [-3,0,3];
    nrandx = vector(randi([1 3]));
    nrandy = vector(randi([1 3]));
    while (nrandx == 0 && nrandy == 0)
        nrandx = vector(randi([1 3]));
        nrandy = vector(randi([1 3]));
    end
    j;
    n1 = bwconncomp(im); % To find the number of blobs
    im1 = im;
    im1((yrand + nrandy) - 1:(yrand + nrandy) + 1, (xrand + nrandx) - 1:...
        (xrand + nrandx) + 1) = im1((yrand), (xrand));
    [y1,x1] = find(bwperim(im1) == 1);
    L2 = length(x1);
    r1 = regionprops(bwareaopen(im1,100), 'Area','MajorAxisLength','MinorAxisLength');
    %ratio1 = max(r1.MajorAxisLength)/min(r1.MinorAxisLength);
    n2 = bwconncomp(im1); % To find the number of connected blobs
    A1 = r1.Area;
    A = r.Area;
    k1 = 1;
    k2 = 1;
    H = k1*(A - Aeq)^2 + k2*(L - 2*pi*rad);
    H1 = k1*(A1 - Aeq)^2 + k2*(L2 - 2*pi*rad);
    delH = H1 - H;
    if (n1.NumObjects ~= n2.NumObjects)
        delH = Temperature*1e20;
    end
    p = exp(-delH/Temperature);
    rd = rand;
    if (p > 1 || rand < p)
        im = im1;
        imshow(im);
        %title(ratio);
        drawnow;
    end
    %rat(j) = ratio;
    j;
    p;
    'K';
    Hamiltonian = [0];
    
    if (j > 1)
        if (Hamiltonian(length(Hamiltonian)) ~= H)
            Hamiltonian(idx) = H;
            Area(idx) = A;
            Length(idx) = L;
            idx = idx + 1;
        end
    end
end
close(v);
figure, plot(1:Hamiltonian);