%% Binary Particle Swarm Optimization Code for Face Detection Training Stage 1
%% Code Written by Nitin J. Sanket (nitinsan@seas.upenn.edu) (1)
%%              and Adarsh Vakkaleri Sateesh (adarshv@seas.upenn.edu) (2)
%% (1) MSE in Robotics Student, University of Pennsylvania
%% (2) MSE in Computer and Information Science Student, University of Pennsylvania 
%% This code is a part of
%% Project 4: CIS581 Computer Vision - Face Replacement
function [gbest,FIT] = BPSO(IG,sub, NSub, NImag, NBlock, iterations, inertia, c1, c2, N, Window)

Extractr = NBlock(1); %Row Extractor
Extractc = NBlock(2); %Column Extractor
dimensions = Extractr*Extractc;
q = 1;
FITMAX = [];
%Initialization of the particles

for i = 1:N                         % no of particles
    for d = 1:dimensions                   % Extractr*Extractc dimensions
        x(i,d) = (rand > 0.5); % to obtain random string of 1s and 0s
        vel(i,d) = 0;               % initial velocity = 0
        pbest(i,d) = x(i,d);       % pbest is the only known position
    end
    x1 = x(i,:);
    x1 = x1';
    fitpbest(i) = CalcFitness(x1,IG,sub, NSub, NImag, NBlock); % store fitness values of all 30 pbests
    
end

[fitgbest,index] = max(fitpbest);
gbest = pbest(index,:);

for iter = 1:iterations
    for i=1:N
        x1 = x(i,:);
        x1 = x1';
        fitval = CalcFitness(x1,IG,sub, NSub, NImag, NBlock); % CalcFitness(x,IG,sub, NSub, NImag, NBlock)
        FIT(q) = fitval;
        q = q+1;
        if (fitval > fitpbest(i))
            fitpbest(i) = fitval;
            pbest(i,:) = x(i,:);
        end
        [fitgbest,index] = max(fitpbest);
        gbest = pbest(index,:);
        
        for d=1:dimensions
            vel(i,d) = (inertia)*(vel(i,d)) + ...
                c1 * (pbest(i,d) - x(i,d))* rand +...
                c2 * (gbest(1,d) - x(i,d))* rand;
            x(i,d) = (rand) < (1/(1 + exp(-vel(i,d))));
            % Sigmod Function is used to update 1 dimention of
            % position vartiable out of Extractr*Extractc dimentions
            V(i,d, iter) = vel(i,d);
            X(i,d, iter) = x(i,d);
        end
    end
    FITMAX = [FITMAX fitgbest];
    if (iter>Window+2) % Greater than Window+2 iterations
        Checker = FITMAX(end-Window:end);
        if (range(Checker)==0) % Solution Reached
            break;
        end
    end
end
disp(strcat(['Reached Optimal Solution in ' , num2str(iter), ' iterations']));
%%
% for q = 1:iterations
%     FITMEAN(q) = mean(FIT(q:q+N));
% end
% for q = 1:iterations
%     FITMAX(q) = max(FIT(q:q+N));
% end
gbest = reshape(gbest,Extractr,Extractc);
end