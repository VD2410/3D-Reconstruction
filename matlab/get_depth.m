function depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2)
% GET_DEPTH creates a depth map from a disparity map (DISPM).

oc_image1 = -(inv(K1*R1) * (K1 * t1));
oc_image2 = -(inv(K2*R2) * (K2 * t2));

oc = norm(oc_image1 - oc_image2);

f = K1(1,1);

depthM = zeros(size(dispM));

for i = 1: size(dispM,1)
    for j = 1:size(dispM,2)
        depthM(i,j) = (dispM(i,j)~=0)*(oc*f)/dispM(i,j);
    end
end

