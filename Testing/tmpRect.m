%% Template Matching Code
%% Code Written by Nitin J. Sanket (nitinsan@seas.upenn.edu) (1)
%%              and Adarsh Vakkaleri Sateesh (adarshv@seas.upenn.edu) (2)
%% Adapted from: Alaa Eleyan Nov,2005
%% (1) MSE in Robotics Student, University of Pennsylvania
%% (2) MSE in Computer and Information Science Student, University of Pennsylvania 
%% This code is a part of
%% Project 4: CIS581 Computer Vision - Face Replacement
function [result, M, BW] = tmp(image1,image2,image3,gbest, Thld, SkipFactor);
% im1 is template
% im2 is big image
if size(image1,3)==3
    image1=rgb2gray(image1);
end
if size(image2,3)==3
    image2=rgb2gray(image2);
end

% check which one is target and which one is template using their size
if size(image1)>size(image2)
    Target=image1;
    Template=image2;
else
    Target=image2;
    Template=image1;
end

% find both images sizes
[r1,c1]=size(Target);
[r2,c2]=size(Template);
% mean of the template
image22=Template-mean(mean(Template));

%corrolate both images
M=[];
k = 1;
for i=1:SkipFactor:(r1-r2+1)
    for j=1:SkipFactor:(c1-c2+1)
%         disp([num2str(i), ' of ', num2str(r1-r2+1), ' and ',  num2str(j), ' of ', num2str(c1-c2+1)]);
        D = Target(i:i+r2-1,j:j+c2-1);
        Nimage=D.*gbest;
        Nimage=Nimage-mean(mean(Nimage));  % mean of image part under mask
        corr=sum(sum(Nimage.*image22.*gbest));
        warning off
        M(i,j)=corr/sqrt(sum(sum(Nimage.^2)));
    end
end
M = M - min(min(M));
M = M./max(max(M));
% figure,
% imagesc(M);
BW = zeros(size(Target));
for i = 1:size(M,1)
    for j = 1:size(M,2)
        if M(i,j) >= Thld
%             IJ(k,1) = i;
%             IJ(k,2) = j;
%             IJ(k,3) = M(i,j);
            k = k + 1;
            BW(i,j) = 1;
        end
    end
end

% plot box on the target image
result = plotboxRect(image3,Template,M);