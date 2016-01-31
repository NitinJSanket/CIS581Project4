%% Average Face Creation Code for Face Detection Training
%% Code Written by Nitin J. Sanket (nitinsan@seas.upenn.edu) (1)
%%              and Adarsh Vakkaleri Sateesh (adarshv@seas.upenn.edu) (2)
%% (1) MSE in Robotics Student, University of Pennsylvania
%% (2) MSE in Computer and Information Science Student, University of Pennsylvania 
%% This code is a part of
%% Project 4: CIS581 Computer Vision - Face Replacement

function [AvgFace] = createAvgFace(NSub, NImag)
I = imread([pwd,'\s1\1.pgm']);
I = im2double(I);
AvgFace = zeros(size(I));
AvgFace = im2double(AvgFace);
for j = 1:NSub
    for i = 1:NImag
        AvgFace = AvgFace + im2double(imread([pwd,'\s',num2str(j),'\',num2str(i),'.pgm']));
    end
end

AvgFace = AvgFace./(NSub.*NImag);
save('AvgFace.mat');
end