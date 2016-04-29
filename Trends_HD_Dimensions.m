% Written by Aniket Ravan
% Last modified : 4/28/2016
% Trend of fractal dimension for varying iteration number of snowflake
f1 = figure;
f2 = figure;
f3 = figure;
for k = 1:length(iter)
    a = iter{k};
    k
    a = a + (abs(sign(min(real(a)))) - sign(min(real(a))))/2*abs(min(real(a))) + (abs(sign(min(imag(a)))) - sign(min(imag(a))))/2*1i*abs(min(imag(a))) + 1 + 1i; % Fitting plot in the first quadrant
    im = zeros(round(max(imag(a))),round(max(real(a))));
    imf = roipoly(im,real(a),imag(a));
%     for j = 1:length(a)
%         im(round(imag(a(j))),round(real(a(j)))) = 1;
%     end
    im = bwperim(imf);
    dim(k) = hausDim(im);
    dimf(k) = hausDim(imf);
    figure(f1), subplot(2,ceil(length(iter)/2),k), imshow(im);
    figure(f2), subplot(2,ceil(length(iter)/2),k), imshow(imf);
end
figure(f3); plot(1:length(dim),dim,'Marker','o','Color','k');
hold on 
plot(1:length(dimf),dimf,'Marker','x','Color','r');