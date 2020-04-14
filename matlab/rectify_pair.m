function [M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = ...
                        rectify_pair(K1, K2, R1, R2, t1, t2)
% RECTIFY_PAIR takes left and right camera paramters (K, R, T) and returns left
%   and right rectification matrices (M1, M2) and updated camera parameters. You
%   can test your function using the provided script q4rectify.m


oc_image1 = -(inv(K1*R1) * (K1 * t1));
oc_image2 = -(inv(K2*R2) * (K2 * t2));

rot1 = (oc_image1 - oc_image2)/norm((oc_image1 - oc_image2));
rot2 = cross(R1(3,:),rot1);
rot2 = rot2';
rot3 = cross(rot2,rot1);

R = [rot1 rot2 rot3]';
R1n = R;
R2n = R;
K1n = K2;
K2n = K2;
t1n = -R*oc_image1;
t2n = -R*oc_image2;
M1 = (K1n*R1n) / (K1*R1);
M2 = (K2n*R2n) / (K2*R2);

