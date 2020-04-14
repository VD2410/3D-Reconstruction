function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%


pts1_new = transpose(pts1);
pts1_new = [pts1_new; ones(1,size(pts1_new,2))];

line = F * pts1_new;

pts2 = [];

for i = 1:size(pts1,1)
    line_N = line(:,i);
    similarity = sqrt(line_N(1)^2 + line_N(2)^2);

    epi_line = line_N/similarity;
    

    epi_line2 = [-epi_line(2) epi_line(1) epi_line(2)*pts1(i, 1) - epi_line(1)*pts1(i, 2)]';
    
    corres_point = round(cross(epi_line,epi_line2));
    
%     disp(corres_point)
    
    % Search parameters
    window_size = 2;
    
    image1_window = double(im1((pts1(i, 2) - window_size):(pts1(i, 2) + window_size), (pts1(i, 1) - window_size):(pts1(i, 1) + window_size), :));
    
    s = 10000;

    for win_x=corres_point(1)-window_size:1:corres_point(1)+window_size
        for win_y=corres_point(2)-window_size:1:corres_point(2)+window_size
            image2_window = double(im1((win_y - window_size):(win_y + window_size), (win_x - window_size):(win_x + window_size), :));
            new_s = image2_window - image1_window;
            
            if new_s < s
                s = new_s;
                x = win_x;
                y = win_y;
            end
        end
    end
    pts2 = [pts2; x, y];
end


