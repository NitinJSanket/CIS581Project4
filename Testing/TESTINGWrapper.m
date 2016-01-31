%% Face Detection Wrapper Code
%% Code Written by Nitin J. Sanket (nitinsan@seas.upenn.edu) (1)
%%              and Adarsh Vakkaleri Sateesh (adarshv@seas.upenn.edu) (2)
%% (1) MSE in Robotics Student, University of Pennsylvania
%% (2) MSE in Computer and Information Science Student, University of Pennsylvania
%% This code is a part of
%% Project 4: CIS581 Computer Vision - Face Replacement

clc
clear all
close all

NBlock = [90 74];
NScales =7;
Thld = repmat(0.85, 1, NScales);
NParts = 3;
SkipFactor = 1;
load('AvgFace.mat');
load('gbestFinal.mat');

I = imread('1.jpg');
[FDOut, BBox] = FaceDetect(I, NBlock, NScales, Thld, AvgFace, gbestFinal, NParts, SkipFactor);
figure,
imshow(FDOut);