function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

Norm = zeros(3,3);
% disp(M);
Norm(1,1) = 1/M;
Norm(2,2) = 1/M;
Norm(3,3) = 1;

norm_points1 = zeros(size(pts1));
norm_points2 = zeros(size(pts2));

pts1 = [pts1, ones(size(pts1,1), 1)] * Norm;
pts2 = [pts2, ones(size(pts2,1), 1)] * Norm;


for i = 1 : size(pts1,1)
    norm_points1(i,1) = pts1(i,1)/pts1(i,3);
    norm_points1(i,2) = pts1(i,2)/pts1(i,3);
    
    norm_points2(i,1) = pts2(i,1)/pts2(i,3);
    norm_points2(i,2) = pts2(i,2)/pts2(i,3);
end

% disp(norm_points2)
x = norm_points1(:,1);
y = norm_points1(:,2);
X = norm_points2(:,1);
Y = norm_points2(:,2);

Matrix = [ x.* X, x.*Y, x, y.*X, y.*Y, y, X, Y, ones(size(pts1,1), 1) ];

[U,S,V ] = svd(Matrix);

F = reshape(V(:,9),3,3);

[U,S,V] = svd(F);
S(3,3) = 0;
F = U*S*transpose(V);

F_refine = refineF(F,norm_points1,norm_points2);

F = (Norm' * F_refine * Norm);




