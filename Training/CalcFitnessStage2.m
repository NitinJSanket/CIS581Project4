%% BPSO Fitness Function Code for Face Detection Training Stage 2
%% Code Written by Nitin J. Sanket (nitinsan@seas.upenn.edu) (1)
%%              and Adarsh Vakkaleri Sateesh (adarshv@seas.upenn.edu) (2)
%% (1) MSE in Robotics Student, University of Pennsylvania
%% (2) MSE in Computer and Information Science Student, University of Pennsylvania 
%% This code is a part of
%% Project 4: CIS581 Computer Vision - Face Replacement

function [y] = CalcFitnessStage2(x,IG, NSub, NImag, NBlock)
% CalcFitness(x,IG,sub, NSub, NImag, NBlock)
Extractr = NBlock(1); %Row Extractor
Extractc = NBlock(2); %Column Extractor
IGtemp = zeros(Extractr*Extractc,NSub);
for subjects = 1:NSub
    IGtemp1 = IG(:,subjects).*x;
    IGtemp(:,subjects) = IGtemp1;
    %Here x = xi
end
y = 0;
for imagi = 1:NSub-1
    for imagj = imagi+1:NSub
        y = y + corr2(reshape(IGtemp(:,imagi),Extractr,Extractc),reshape(IGtemp(:,imagj),Extractr,Extractc));
    end
end
return