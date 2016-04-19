% Extracts images from a mov file and crops every frame into two parts,
% saving each of the two parts into two distinct folders
% Written by Aniket Ravan
% Last modified: 4/19/2016
vobj = VideoReader('eb1-1.mp4');
k = 1;
while hasFrame(vobj)
    k
    imrgb = readFrame(vobj);
    im(:,:,k) = rgb2gray(imrgb);
    imflsnc(:,:,k) = im(:,1:450,k);
    imDIC(:,:,k) = im(:,456:size(im,2),k);
    imwrite(imflsnc(:,:,k),['D:\Aniket\Images\eb1-1-Fluorescence\im',int2str(k),'.tif']);
    imwrite(imDIC(:,:,k),['D:\Aniket\Images\eb1-1-DIC\im',int2str(k),'.tif']);
    k = k + 1;
end
