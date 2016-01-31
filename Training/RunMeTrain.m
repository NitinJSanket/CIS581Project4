%% Wrapper Function for Face Detection Training
%% Code Written by Nitin J. Sanket (nitinsan@seas.upenn.edu) (1)
%%              and Adarsh Vakkaleri Sateesh (adarshv@seas.upenn.edu) (2)
%% (1) MSE in Robotics Student, University of Pennsylvania
%% (2) MSE in Computer and Information Science Student, University of Pennsylvania 
%% This code is a part of
%% Project 4: CIS581 Computer Vision - Face Replacement

clc
clear all
close all

NSub = 40;
NImag = 10;
NTest = 21;
NBlock = [90 74]; % Size of Feature Selection Block
iterations = 100;
inertia = 0.6; % Intertial weight
c1 = 2; % Cognitive Parameter
c2 = 2; % Social Parameter
N = 30; % Number of Particles
Window = 10; % Window size to say if PSO has achieved convergence

disp('PSO Parameters set to:');
disp(['Max. Iterations : ', num2str(iterations)]);
disp(['Intertial Weight : ', num2str(inertia)]);
disp(['Cognitive Parameter (c1) : ', num2str(c1)]);
disp(['Social Parameter (c2) : ', num2str(c2)]);
disp(['Window size to determine convergence condition : ', num2str(Window)]);
%% Training
tic
[gbestFinal, FITFinal] = FDTrain(NSub, NImag, NBlock, iterations, inertia, c1, c2, N, Window);
toc
figure,
imshow(gbestFinal);
title('Selected Features');

%% Creation of Average Face
tic
AvgFace = createAvgFace(NSub, NImag);
AvgFace = AvgFace(12:101,10:83); % Crop the Avg Face
disp('Average Face Created....');
toc
figure,
imagesc(AvgFace);
title('Average Face');
figure,
imagesc(AvgFace.*gbestFinal);
title('Selected Features in Average Face');

