% Written by Aniket Ravan 
% Github link: https://github.com/AniketRavan/IISER-Pune
% Last modified: 4/7/16
for i = 1:23
    if i < 10
        fname = ['40x-dic-egfp-pc12-ngfxy0',num2str(i),'c2.tif'];
    end
    if i >= 10
        fname = ['40x-dic-egfp-pc12-ngfxy',num2str(i),'c2.tif'];
    end
    info = imfinfo(fname);
    number_of_images = numel(info);
    %Read TIF Stack
    im = imread(fname,k);
    im = mat2gray(im);
    imshow(im);
    [x,y] = (ginput(1));   %In the order xmin,xmax,ymin,ymax
    x = round(x); y = round(y);
    rectangle('Position',[x y width width],'EdgeColor','r');
    for k = 1:number_of_images
        im = imread(fname,k);
        im = mat2gray(im);
        width = 150; height = 150;
        % Registering mean intensity of ROI
        I(k) = mean(mean(im(y:y + height, x:x + width)));
    end
    s = std(I);
    figure2 = figure;
    % Plotting deviation in I with respect to mean(I)
    plot((1:length(I))*30,(I-mean(I)),'o');
    xlabel('Time in minutes');
    ylabel('Deviation of mean intensity');
    title(['Standard deviation = ',num2str(s)]);
    saveas(figure2,[fname,'.jpg']);
    close all
end