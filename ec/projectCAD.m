dataDir = "../data/";
PnP = load("../data/PnP.mat");

X = PnP.X;
cad = PnP.cad;
img = PnP.image;
x = PnP.x;

P = estimate_pose(x, X);

[K, R, t] = estimate_params(P); 

xProj = P * [X; ones(1, size(X,2))];
xProj(1, :) = xProj(1, :)./xProj(3, :);
xProj(2, :) = xProj(2, :)./xProj(3, :);
xProj = xProj(1:2, :);

figure; 
imshow(img);
hold on;
plot(x(1, :), x(2, :), 'o', 'MarkerSize', 10, 'LineWidth', 2);
hold on;
plot(xProj(1, :), xProj(2, :), 'o', 'MarkerFaceColor', 'red', 'MarkerSize', 5, 'LineWidth', 1);
hold off;

Rotate = (R * cad.vertices')'; 

figure;
trimesh(cad.faces, Rotate(:,1), Rotate(:, 2), Rotate(:, 3), 'FaceColor', 'green', 'FaceAlpha', 0.7);
patch('faces', cad.faces, 'vertices' ,Rotate);
drawnow;

xProj_c = P * [cad.vertices'; ones(1, size(cad.vertices',2))];
xProj_c(1, :) = xProj_c(1, :)./xProj_c(3, :);
xProj_c(2, :) = xProj_c(2, :)./xProj_c(3, :);
xProj_c = xProj_c(1:2, :);


figure; 
imshow(img); 
patch('Faces', cad.faces, 'Vertices', xProj_c', 'FaceColor', 'black', 'EdgeColor', 'blue', 'FaceAlpha', 0.7);
drawnow

