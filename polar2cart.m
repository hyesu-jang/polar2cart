%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MulRan Copyright 2020 IRAP
%% 201229 hs: First Commit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all;

% Mulran Data Directory
data_dir = 'sensor_data/radar/polar/';

% Directory to save Cartesian image
cart_dir = 'sensor_data/radar/cart_img/';

dir_load = dir(fullfile(data_dir,'*.png'));
for i = 1:numel(dir_load)
    files = fullfile(data_dir,dir_load(i).name);
    polar_img = imread(files);
    [range, theta] = size(polar_img);

    % polar image plot
    figure(1)
    imshow(polar_img)
    
    cart_img = zeros(2*range+1,2*range+1);
    for r = 1:range
        for t = 1:theta
            x = range-r*cos(t *2*pi/theta)+1;
            y = range+r*sin(t *2*pi/theta)+1;
            cart_img(floor(x),floor(y))=polar_img(r,t);
        end
    end
    
    % Give manual image size & colormap intensity value (default = 0.1, 5)
    img_size_ratio = 0.1
    inv_intensity = 5
    cart_img = imresize(cart_img,img_size_ratio)/inv_intensity;

    % Cartesian image plot
    figure(2)
    imshow(cart_img)
    imwrite(cart_img,strcat(cart_dir,dir_load(i).name));

end
