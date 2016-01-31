%% Face Detection Code
%% Code Written by Nitin J. Sanket (nitinsan@seas.upenn.edu) (1)
%%              and Adarsh Vakkaleri Sateesh (adarshv@seas.upenn.edu) (2)
%% (1) MSE in Robotics Student, University of Pennsylvania
%% (2) MSE in Computer and Information Science Student, University of Pennsylvania
%% This code is a part of
%% Project 4: CIS581 Computer Vision - Face Replacement

function [FDOut, BBox] = FaceDetect(im2, NBlock, NScales, Thld, AvgFace, gbestFinal, NParts, SkipFactor)
tic
disp('Testing Sequence Started....');
if(nargin<8)
    NBlock = [90 74];
    NScales = 7;
    disp([num2str(NScales), ' scales....']);
    Thld = repmat(0.85, 1, NScales);
    disp('Thresholds set as: ');
    disp(num2str(Thld));
    load('AvgFace.mat');
    load('gbestFinal.mat');
    SkipFactor = 1;
else
    disp([num2str(NScales), ' scales....']);
    disp('Thresholds set as: ');
    disp(num2str(Thld));
end
%% Testing
IT1 = AvgFace;
IT1 = adapthisteq(IT1);
gbest = im2double(gbestFinal);
im1 = im2double(IT1);
Centroid = [];
n = 1;
IColorOrg = im2double(im2);
im2 = rgb2gray(im2double(im2));
im3Org = im2;
im2 = adapthisteq(im2);
num_iter = 15;
delta_t = 1/7;
kappa = 30;
option = 2;
im2Org = anisodiff2D(im2,num_iter,delta_t,kappa,option);

ScaleRatio = [1.25^4 1.25^3 1.25^2 1.25 1 1/1.25 1/1.25^2 1/1.25^3 1/1.25^4];
disp('Using Following Scale Ratioes:');
disp(num2str(ScaleRatio(1:NScales)));
for Scale = 1:NScales
    im2 = imresize(im2Org, ScaleRatio(Scale), 'bicubic');
    im3 = imresize(im3Org, ScaleRatio(Scale), 'bicubic');
    disp(['Scale ', num2str(Scale)]);
    
    disp('Template Matching Started....');
    % Apply templete matching using power of the image
    [~, M, BW] = tmpRect(im1,im2,im3,gbest, Thld(Scale), SkipFactor);
    
    [L, num] = bwlabel(BW);
    disp(['Possible ', num2str(num), ' clusters found....']);
    s = regionprops(L, 'Centroid');
    
    for w = 1:size(s,1)
        s(w).Centroid = round(s(w).Centroid);
    end
    
    try
        for k = 1:size(s,1)
            disp(['Cluster ',num2str(k), ' of ', num2str(size(s,1))]);
            Crop = im3(s(k).Centroid(2):s(k).Centroid(2)+NBlock(1)-1, s(k).Centroid(1):s(k).Centroid(1)+NBlock(2)-1);
            [~, ~, ~, ~, Parts, ~] = FindFaceParts(Crop, 0);
            if(NParts<4)
                if(sum(Parts)>=NParts) % 3 or 4 parts found then tag it as a face
                    FaceFound(k) = 1;
                else
                    FaceFound(k) = 0;
                end
            else
                if(sum(Parts)==NParts) % 4 parts found then tag it as a face
                    FaceFound(k) = 1;
                else
                    FaceFound(k) = 0;
                end
            end
        end
        
        FaceFoundIdx = find(FaceFound);
        FinalOut = IColorOrg;
        
        for e = 1:size(FaceFoundIdx,2)
            FinalOut = insertObjectAnnotation(FinalOut,'rectangle',[s(FaceFoundIdx(e)).Centroid(1), s(FaceFoundIdx(e)).Centroid(2), NBlock(2)-1, NBlock(1)-1] ,'Face');
        end
        
        if(size(FaceFoundIdx)>0)
            for e = 1:size(FaceFoundIdx,2)
                % x,y,width,height
                Centroid(n, 1) = round(s(FaceFoundIdx(e)).Centroid(1)./ScaleRatio(Scale));
                Centroid(n, 2) = round(s(FaceFoundIdx(e)).Centroid(2)./ScaleRatio(Scale));
                Centroid(n, 3) = round((NBlock(2)-1)./ScaleRatio(Scale));
                Centroid(n, 4) = round((NBlock(1)-1)./ScaleRatio(Scale));
                Centroid(n, 5) = ScaleRatio(Scale);
                n = n+1;
            end
        end
        
        for q = 1:numel(FaceFoundIdx)
            MVal{Scale} = M(s(FaceFoundIdx(q)).Centroid(2), s(FaceFoundIdx(q)).Centroid(1));
        end
        disp(MVal);
        clear FaceFoundIdx FaceFound s k
    catch
        continue;
    end
end

try
    BW = zeros(size(im3Org));
    for a = 1:size(Centroid,1)
        BW(Centroid(a,2):Centroid(a,2)+Centroid(a,4),Centroid(a,1):Centroid(a,1)+Centroid(a,3)) = 1;
    end
    
    [L, ~] = bwlabel(BW);
    s = regionprops(L, 'BoundingBox');
    
    for w = 1:size(s,1)
        BBox(w, :) = round(s(w).BoundingBox);
    end
    
    FDOut = IColorOrg;
    for e = 1:size(BBox,1)
        % [x y width height]
        FDOut = insertObjectAnnotation(FDOut,'rectangle',[BBox(e,1), BBox(e,2), BBox(e,3), BBox(e,4)],'Face');
    end
catch
    % NO FACE FOUND IF HERE
    FDOut = IColorOrg;
    BBox = [];
end
Time = toc;
disp(['Time taken to process current image was ', num2str(Time), 's']);
end

