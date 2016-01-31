%% Face Parts Detection Code
%% Code Written by Nitin J. Sanket (nitinsan@seas.upenn.edu) (1)
%%              and Adarsh Vakkaleri Sateesh (adarshv@seas.upenn.edu) (2)
%% (1) MSE in Robotics Student, University of Pennsylvania
%% (2) MSE in Computer and Information Science Student, University of Pennsylvania
%% This code is a part of
%% Project 4: CIS581 Computer Vision - Face Replacement
%% Uses MATLAB's CV Toolbox
function [BBoxLE, BBoxRE, BBoxN, BBoxM, Parts, OutputImg] = FindFaceParts(I, verbose)
if(nargin<2)
    verbose = 0;
end
LeftEyeDetector = vision.CascadeObjectDetector('LeftEye');
BBoxLE = step(LeftEyeDetector, I);

RightEyeDetector = vision.CascadeObjectDetector('RightEye');
BBoxRE = step(RightEyeDetector, I);

NoseDetector = vision.CascadeObjectDetector('Nose');
BBoxN = step(NoseDetector, I);

MouthDetector = vision.CascadeObjectDetector('Mouth');
BBoxM = step(MouthDetector, I);

Parts(1) = numel(BBoxLE)>0;
Parts(2) = numel(BBoxRE)>0;
Parts(3) = numel(BBoxN)>0;
Parts(4) = numel(BBoxM)>0;

% Draw the returned bounding box around the detected face.
OutputImg = insertObjectAnnotation(I,'rectangle',BBoxLE,'LE');
OutputImg = insertObjectAnnotation(OutputImg,'rectangle',BBoxRE,'RE');
OutputImg = insertObjectAnnotation(OutputImg,'rectangle',BBoxN,'N');
OutputImg = insertObjectAnnotation(OutputImg,'rectangle',BBoxM,'M');

if(verbose)
    imshow(OutputImg),
    title('Detected Face Parts');
end
end