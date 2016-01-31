%% Face Detection Training Code
%% Code Written by Nitin J. Sanket (nitinsan@seas.upenn.edu) (1)
%%              and Adarsh Vakkaleri Sateesh (adarshv@seas.upenn.edu) (2)
%% (1) MSE in Robotics Student, University of Pennsylvania
%% (2) MSE in Computer and Information Science Student, University of Pennsylvania 
%% This code is a part of
%% Project 4: CIS581 Computer Vision - Face Replacement
function [gbestFinal, FITFinal] = FDTrain(NSub, NImag, NBlock, iterations, inertia, c1, c2, N, Window);
%% Face Detector Training Stage 1
tic
disp('Training Module Execution Started....');
disp(['Training with ', num2str(NSub*NImag), ' Images....']);
if(nargin<3)
    NSub = 40;
    NImag = 10;
    NBlock = [90 74]; 
end
warning off;
k = 1;
DG = zeros(NBlock(1)*NBlock(2),NSub*NImag);

for jo = 1:NSub
    for io = 1:NImag
        I = imread(strcat(pwd,'/s',num2str(jo),'/',num2str(io),'.pgm'));
        I = im2double(I);
        I = I(12:101,10:83);
        D = I;
        D = reshape(D,numel(D),1);
        DG(:,k) = D;
        k = k + 1;
    end
end
toc
disp('Image Reading done....');

%% IG has all the face images
disp('Stage 1 of 2 Execution Started....');
gbest = zeros(NSub,NBlock(1),NBlock(2));
tic
% Calculate gbest for each subject
for sub = 1:NSub
    [gbest(sub,:,:),FIT] = BPSO(DG,sub, NSub, NImag, NBlock, iterations, inertia, c1, c2, N, Window); % BPSO(IG,sub, NSub, NImag, NBlock, iterations, inertia, c1, c2)
    disp(['Subject ',num2str(sub),' done....']);
end
toc
% Convert gbest to 1D array
for i = 1:NSub
    gbest1(:,i) = squeeze(reshape(gbest(i,:,:),numel(gbest(i,:,:)),1));
end
disp('Stage 1 of 2 Execution Done....');

%% Face Detector Training Stage 2
disp('Stage 2 of 2 Execution Started....');
[gbestFinal, FITFinal] = BPSOStage2(gbest1, NSub, NImag, NBlock, iterations, inertia, c1, c2, N, Window);
disp('Stage 2 of 2 Execution Done....');
save('gbestFinal.mat');
end
