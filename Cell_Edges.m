% Written by Aniket Ravan 
% Github link: https://github.com/AniketRavan/IISER-Pune
% Last modified: 4/7/16
% Edge Detection using Otsu's Algorithm
figure,
for i = 6
    if i < 10
        fname = ['40x-dic-egfp-pc12-ngfxy0',num2str(i),'c2.tif'];
    end
    if i >= 10
        fname = ['40x-dic-egfp-pc12-ngfxy',num2str(i),'c2.tif'];
    end
    info = imfinfo(fname);
    number_of_images = numel(info);
    imfull = imread(fname,1);
    imshow(mat2gray(imfull));
    [x,y] = ginput(1);
    x = round(x); y = round(y);
    %Read TIF Stack
    for k = 1:number_of_images
        imfull = imread(fname,k);
        im = imfull(y-120:y+120,x-120:x+120);
        im = mat2gray(im);
        im = medfilt2(im,[10,10]);
        % Edge detection
        thresh = graythresh(im);
        bw = im2bw(im,thresh);
        rprop = regionprops(bw,'Area','MajorAxisLength','MinorAxisLength','Perimeter');
        majax(k) = rprop.MajorAxisLength;
        minax(k) = rprop.MinorAxisLength;
        area(k) = rprop.Area;
        perim(k) = rprop.Perimeter;
        edg = bwperim(bw);
        imrgb = repmat(im,[1,1,3]);
        [i,j] = find(edg == 1);
        for l = 1:length(i)
            imrgb(i(l),j(l),1) = 1;
        end
        subplot(4,2,k), imshow(imrgb);
        title(num2str(k));
    end
end