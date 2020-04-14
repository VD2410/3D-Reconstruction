function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.

w = round(windowSize/2);
im1 = im2double(im1);
im2 = im2double(im2);

dispM = zeros(size(im1));
disparity = 0;
for i = w+1:size(im1,1)-w
    for j = w+1:size(im1,2)-w-maxDisp
        checkdist = 10000;
        
        temp = im1(i-w:i+w,j-w:j+w);
        
        for d = 1:maxDisp
            tempim2 = im2(i-w:i+w,j+d-w:j+d+w);
            
            dist = (tempim2 - temp)^2;
            
            tot_dist = sum(dist(:));
            
            if(checkdist>tot_dist)
                checkdist = tot_dist;
                disparity = d;
            end
        end
%         disp(i);
%         disp(j);
        dispM(i,j) = disparity;
    end
end
