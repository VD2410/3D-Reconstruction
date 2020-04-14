function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%

p = zeros(size(pts1,1),4);

for i=1:size(pts1,1)
    x = pts1(i,1);
    y = pts1(i,2);
    X = pts2(i,1);
    Y = pts2(i,2);

    
%     disp(y(i))
    
    A = [y*P1(3,:) - P1(2,:); P1(1,:) - x*P1(3,:); Y*P2(3,:) - P2(2,:);P2(1,:) - X*P2(3,:)];
    
    [U,S,V] = svd(A);
    
    p(i,:) = V(:,4)';
    
    p(i,:) = p(i,:)./p(i,4);
    
end

pts3d = p(:,1:3);


% Calculate Errors after reprojection
error1 = zeros(1, size(pts3d, 1));
error2 = zeros(1, size(pts3d, 1));
for i = 1:size(pts3d, 1)
    pt = [pts3d(i, :) 1];
    
    pt1 = P1 * pt';
    pt2 = P2 * pt';
    
    pt1 = pt1 ./ pt1(3);
    pt2 = pt2 ./ pt2(3);
    
    error1(i) = sqrt((pt1(1) - pts1(i, 1))^2 + (pt1(2) - pts1(i, 2))^2);
    error2(i) = sqrt((pt2(1) - pts2(i, 1))^2 + (pt2(2) - pts2(i, 2))^2);
end

error1 = mean(error1);
error2 = mean(error2);
% 
disp("Error")
disp(error1)
disp(error2)



