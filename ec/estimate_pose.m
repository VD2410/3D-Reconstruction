function P = estimate_pose(x, X)
% ESTIMATE_POSE computes the pose matrix (camera matrix) P given 2D and 3D
% points.
%   Args:
%       x: 2D points with shape [2, N]
%       X: 3D points with shape [3, N]

A = [];
for i=1:size(X, 2)
    
    Ai = [X(1, i)',X(2, i)',X(3, i)', 1, 0, 0, 0, 0, -x(1,i)*(X(1, i)'), -x(1,i)*(X(2, i)'), -x(1,i)*(X(3, i)'), -x(1,i); 
        0, 0, 0, 0, X(1, i)',X(2, i)',X(3, i)', 1, -x(2,i)*(X(1, i)'), -x(2,i)*(X(2, i)'), -x(2,i)*(X(3, i)'), -x(2,i)];
    
    A = [A; Ai];
end

[U, S, V] =  svd(A);

p = V(:, end);

P = reshape(p, [4, 3])';

end