%CSC4630 Matlab Semester Project
%MATLAB-based inspection system
%Group Member: Chengpeng Wu, Rachel Abraham, Sahba Atarodi

I = imread('4.png');
ObjectImage = rgb2gray(I);
figure;
imshow(ObjectImage);
title('Image of object');

J = imread('2.jpg');
sceneImage = rgb2gray(J);
figure;
imshow(sceneImage);
title('Image of oringal scene');

boxPoints = detectSURFFeatures(ObjectImage);
scenePoints = detectSURFFeatures(sceneImage);

figure;
imshow(ObjectImage);
title('100 Strongest Feature Points from object');
hold on;
plot(selectStrongest(boxPoints, 100));

figure;
imshow(sceneImage);
title('300 Strongest Feature Points from Scene Image');
hold on;
plot(selectStrongest(scenePoints, 300));

[boxFeatures, boxPoints] = extractFeatures(ObjectImage, boxPoints);
[sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);

boxPairs = matchFeatures(boxFeatures, sceneFeatures);

matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
matchedScenePoints = scenePoints(boxPairs(:, 2), :);
figure;
showMatchedFeatures(ObjectImage, sceneImage, matchedBoxPoints, ...
    matchedScenePoints, 'montage');
title('Putatively Matched Points (Including Outliers)');

[tform, inlierIdx] = ...
    estimateGeometricTransform2D(matchedBoxPoints, matchedScenePoints, 'affine');
inlierBoxPoints   = matchedBoxPoints(inlierIdx, :);
inlierScenePoints = matchedScenePoints(inlierIdx, :);

figure;
showMatchedFeatures(ObjectImage, sceneImage, inlierBoxPoints, ...
    inlierScenePoints, 'montage');
title('Matched Points (Inliers Only)');

boxPolygon = [1, 1;...                          
        size(ObjectImage, 2), 1;...                
        size(ObjectImage, 2), size(ObjectImage, 1);... 
        1, size(ObjectImage, 1);...                 
        1, 1];                   

newBoxPolygon = transformPointsForward(tform, boxPolygon);


figure;
imshow(sceneImage);
hold on;
line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color', 'y');
title('Detected Object');