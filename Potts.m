% Code written by Aniket Ravan
% First attempt at Cellular Potts model
% Last modified 6/24/2016
% A lattice-cell is defined by a 3x3 square
v = VideoWriter('newfile.avi');
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
Temperature = 5000;
im = imfill(im,'holes');
eq = regionprops(im,'Area');
rad = 4*side/2/pi + 2;
Aeq = pi*rad*rad;
iterations = 1000000;
% im = bwperim(im);
%imshow(im);
%[x, y] = find(im == 1);
idx = 1;
Hamiltonian = [0];
for j = 1:iterations
    j;
    y = 5:3:5+3*floor(size(im,2)/3 - 5);
    x = 5:3:5+3*floor(size(im,1)/3 - 5);
    im = imfill(im,'holes');
    r = regionprops(im, 'Area','MajorAxisLength','MinorAxisLength');
    A = r.Area; % Area of the (i - 1)th image
 
    % Selecting a random pixel from the image who's neighbour will undergo
    % an update
    xrand = x(randi(length(x)));
    yrand = y(randi(length(y)));
    % Selecting random pixel that has atleast one unsimilar neighbour
    % to improve efficiency
    while (im(yrand,xrand-3) == im(yrand,xrand) &&...
            im(yrand,xrand+3) == im(yrand,xrand) && ...
            im(yrand-3,xrand) == im(yrand,xrand) && ...
            im(yrand-3,xrand-3) == im(yrand,xrand) && ...
            im(yrand-3,xrand+3) == im(yrand,xrand) && ...
            im(yrand+3,xrand) == im(yrand,xrand) && ...
            im(yrand+3,xrand-3) == im(yrand,xrand) && ...
            im(yrand+3,xrand+3) == im(yrand,xrand))
        xrand = x(randi(length(x)));
        yrand = y(randi(length(y)));
    end
    vector = [-3,0,3];
    nrandx = vector(randi([1 3]));
    nrandy = vector(randi([1 3]));
    
    % Selecting a Neighbour for update
    while ((nrandx == 0 && nrandy == 0))
        nrandx = vector(randi([1 3]));
        nrandy = vector(randi([1 3]));
    end
    j;
    [Y,X] = find(bwperim(im) == 1);
    L = length(Y);
    n1 = bwconncomp(im); % To find the number of blobs
    im1 = im;
    im1((yrand + nrandy) - 1:(yrand + nrandy) + 1, (xrand + nrandx) - 1:...
        (xrand + nrandx) + 1) = im1((yrand), (xrand));
    [y1,x1] = find(bwperim(im1) == 1);
    L2 = length(x1);
    r1 = regionprops(bwareaopen(im1,100), 'Area','MajorAxisLength','MinorAxisLength');
    %ratio1 = max(r1.MajorAxisLength)/min(r1.MinorAxisLength);
    n2 = bwconncomp(im1); % To find the number of connected blobs
    A1 = r1.Area;    % Area after transition has been made
    k1 = 3;
    k2 = 1000;
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
            %f = getframe;
            %writeVideo(v, f);
            ax2 = subplot(2,2,2); plot(Area); 
            title('Area');
            drawnow;
            ax3 = subplot(2,2,3); plot(Length);            
            title('Length');
            drawnow;
            if (p < 1)
                ax4 = subplot(2,2,4);
                hold(ax4, 'on');
                plot(length(Hamiltonian), Hamiltonian(length(Hamiltonian)), 'Marker', 'x', 'MarkerSize', 5);
            else
                ax4 = subplot(2,2,4); plot(Hamiltonian);
            end
                        
            title('Hamiltonian');
            drawnow;
         end
    end
    if (length(Hamiltonian) > 1)
    ax1 = subplot(2,2,1); imshow(im);
    hold(ax1,'on');
    plot(ax1, xrand, yrand,'Marker', 'o', 'MarkerSize', 5, 'LineStyle', 'None','Color', 'y');
    drawnow;
    hold(ax1, 'off');
    end
end
close(v);
%figure, plot(1:Hamiltonian);