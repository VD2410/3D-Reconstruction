% A test script using templeCoords.mat
%
% Write your code here
%

path1 = '../data/im1.png';
path2 = '../data/im2.png';
path_correspondance = '../data/someCorresp.mat';
correspondance = load(path_correspondance);
path_intrinsics = '../data/intrinsics.mat';
intrinsics = load(path_intrinsics);
path_coords = '../data/templeCoords.mat';
coordinates = load(path_coords);

% disp(correspondance);
% disp(intrinsics);
% disp(coords);

image_1 = imread(path1);
image_2 = imread(path2);

Fmatrix = eightpoint(correspondance.pts1, correspondance.pts2, correspondance.M);
% disp("Fundamental Metrix")
% disp(Fmatrix)

% displayEpipolarF(image_1,image_2,Fmatrix)

corr_points = epipolarCorrespondence(image_1,image_2,Fmatrix,coordinates.pts1);


% epipolarMatchGUI(image_1,image_2,Fmatrix)

% Ematrix = essentialMatrix(Fmatrix, intrinsics.K1, intrinsics.K2);
% disp("Essential Metrix")
% disp(Ematrix)

Cam_P1 = camera2(Ematrix);

R = Cam_P1(:,1:3,2);

t = Cam_P1(:,4,2);

R_cam = [R t];

Candidate_P2 = intrinsics.K2 * R_cam;

Candidate_P1 = intrinsics.K1 * [eye(3) zeros(3,1)];

tringulate_points = triangulate(Candidate_P1, coordinates.pts1, Candidate_P2, corr_points);

%%% depth test to be done

% Plot 3D points
% plot3(tringulate_points(:,1), tringulate_points(:,2), tringulate_points(:,3), '.', 'MarkerSize', 8)
% figure;
% plot3(tringulate_points(:,2), tringulate_points(:,1), tringulate_points(:,3), '.', 'MarkerSize', 8)
% figure;
% plot3(tringulate_points(:,2), tringulate_points(:,3), tringulate_points(:,1), '.', 'MarkerSize', 8)
R1 = eye(3);
t1 = zeros(3,1);
R2 = R;
t2=t;
% save extrinsic parameters for dense reconstruction
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
