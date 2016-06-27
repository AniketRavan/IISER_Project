function [] = Potts_fine(Temperature, k1, k2, iterations)
% Code written by Aniket Ravan
% First attempt at Cellular Potts model
% Last modified 6/24/2016
% A lattice-cell is defined by a 3x3 square
video_title = [num2str(Temperature),'_',num2str(k1),'_',num2str(k2)];
v = VideoWriter(video_title);
open(v);
theta = 0:0.01:2*pi-0.01;
im = zeros(100,100);
side = 40; % Side of the square
x = 50 - side/2 : 50 + side/2;
y = 50 - side/2 : 50 + side/2;
% for i = 1:length(x)
%     im(y(i),x(i)) = 1;
% end
im(y(:),x(:)) = 1;
im = imfill(im,'holes');
%imshow(im);
eq = regionprops(im,'Area');
rad = 4*side/2/pi ;
Aeq = pi*rad*rad;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%iterations = 80000;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
idx = 1;
Hamiltonian = [0];
frame = 1;
for j = 1:iterations
    y = 2:size(im,1) - 1;
    x = 2:size(im,2) - 1;
    im = imfill(im,'holes');
    r = regionprops(im, 'Area','MajorAxisLength','MinorAxisLength');
    A = r.Area; % Area of the (i - 1)th image
 
    % Selecting a random pixel from the image who's neighbour will undergo
    % an update
    xrand = x(randi(length(x)));
    yrand = y(randi(length(y)));
    % Selecting random pixel that has atleast one unsimilar neighbour
    % to improve efficiency
    while (im(yrand,xrand-1) == im(yrand,xrand) &&...
            im(yrand,xrand+1) == im(yrand,xrand) && ...
            im(yrand-1,xrand) == im(yrand,xrand) && ...
            im(yrand-1,xrand-1) == im(yrand,xrand) && ...
            im(yrand-1,xrand+1) == im(yrand,xrand) && ...
            im(yrand+1,xrand) == im(yrand,xrand) && ...
            im(yrand+1,xrand-1) == im(yrand,xrand) && ...
            im(yrand+1,xrand+1) == im(yrand,xrand))
        xrand = x(randi(length(x)));
        yrand = y(randi(length(y)));
    end
    vector = [-1,0,1];
    nrandx = vector(randi([1 3]));
    nrandy = vector(randi([1 3]));
    
    while ((nrandx == 0 && nrandy == 0))
        nrandx = vector(randi([1 3]));
        nrandy = vector(randi([1 3]));
    end
    [Y,X] = find(bwperim(im) == 1);
    L = length(Y);
    n1 = bwconncomp(im); % To find the number of blobs
    im1 = im;
    im1(yrand + nrandy,xrand + nrandx) = im1(yrand, xrand);
    [y1,x1] = find(bwperim(im1) == 1);
    L2 = length(x1);
    r1 = regionprops(bwareaopen(im1,100), 'Area','MajorAxisLength','MinorAxisLength');
    %ratio1 = max(r1.MajorAxisLength)/min(r1.MinorAxisLength);
    n2 = bwconncomp(im1); % To find the number of connected blobs
    A1 = r1.Area;    % Area after transition has been made
    H = k1*(A - Aeq)^2 + k2*(L - 2*pi*rad)^2;
    H1 = k1*(A1 - Aeq)^2 + k2*(L2 - 2*pi*rad)^2;
    delH = H1 - H;
    if (n1.NumObjects ~= n2.NumObjects)
        delH = Temperature*1e20;
    end
    p = exp(-delH/Temperature);
    rd = rand;
    
    if (p > 1 || (rd < p && p ~= 1))
        im = im1;
%     rat(j) = ratio;
%     if (delH ~= 0)
%         break;
%     end
    if (j > 1)
            Hamiltonian(idx) = H1;
            Area(idx) = A;
            Length(idx) = L;
            prob(idx) = p;
            Rd(idx) = rd;
            Delh(idx) = delH;
            idx = idx + 1;
            if (mod(idx,20) == 0)
                if (length(Hamiltonian) > 1)
                     imshow(im);
                     hold('on');
                     plot(xrand, yrand,'Marker', 'o', 'MarkerSize', 5, 'LineStyle', 'None','Color', 'y');
                     drawnow;
                     hold('off');
                end       
                title('Hamiltonian');
                drawnow;
                f = getframe;
                writeVideo(v, f);
                cla
            end
        end      
    end
    
end
close(v);
plot(Hamiltonian);
title('Hamiltonian');
savefig(['Ham_',video_title,'.fig']);
plot(Length);
title('Length');
savefig(['Length',video_title,'.fig']);
plot(Area);
title('Area');
savefig(['Area',video_title,'.fig']);
close all;