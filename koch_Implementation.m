% Written by Aniket Ravan
% Generates Koch's snowflake starting with any arbitrary configuration of
% points 
% Last modified : 4/26/2016
init = [0, 1, 0];   % initial configuration of points. To be written in cyclic
% order for a closed figure
len = length(init);
% Limits of axes for plotting later
arg = abs(init(2) - init(1))*0.86;
lowX = min(real(init)) - arg;
highX = max(real(init)) + arg;
lowY = min(imag(init)) - arg;
highY = max(imag(init)) + arg;
for i = 1:5
    if (i == 1)
        plot(real(init), imag(init));
        axis([min(lowX,lowY) max(highX,highY) min(lowX,lowY) max(highX,highY)]);
        axis('equal');
        pause(2);
    end
    clear kochtemp
    % kochtemp is a matrix where each row is the collection of five points 
    % of the next iteration given two points of the current iteration
    for j = 1: len - 1
        kochtemp(j,:) = koch([init(j), init(j + 1)]); 
    end
    if len > 2
        temp = kochtemp(2:size(kochtemp,1),2:5)'; % to open the matrix for 
        % concatenation in the next step
        temp = temp(:)';        % to open the matrix
        iter{i} = [kochtemp(1,:), temp]; % all sets of co-ordinates in the 
        %'i'th iteration
    else
        iter{i} = kochtemp;   % if len <= 2
    end
    len = length(iter{i});    
    init = iter{i};
    plot(real(iter{i}),imag(iter{i})); % plots at every iteration
    axis([min(lowX,lowY) max(highX,highY) min(lowX,lowY) max(highX,highY)]);
    axis('equal');
    pause(2); % pauses for 2 seconds
end