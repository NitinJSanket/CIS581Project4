%% FD Plotting Function Wrapper Code
%% Code Written by Nitin J. Sanket (nitinsan@seas.upenn.edu) (1)
%%              and Adarsh Vakkaleri Sateesh (adarshv@seas.upenn.edu) (2)
%% Code adapted from: Alaa Eleyan May,2008
%% (1) MSE in Robotics Student, University of Pennsylvania
%% (2) MSE in Computer and Information Science Student, University of Pennsylvania
%% This code is a part of
%% Project 4: CIS581 Computer Vision - Face Replacement

function result = plotboxRect(Target,Template,M);
[r1,c1]=size(Target);
[r2,c2]=size(Template);

[r,c]=max(M);
[r3,c3]=max(max(M));
i=c(c3);
j=c3;
result=Target;
for x=ceil(i):floor((i+r2-1))
   for y=j
       result(x,y)=255;
   end
end
for x=ceil(i):floor((i+r2-1))
   for y=j+c2-1
       result(x,y)=255;
   end
end
for x=ceil(i)
   for y=j:j+c2-1
       result(x,y)=255;
   end
end
for x=floor((i+r2-1))
   for y=j:j+c2-1
       result(x,y)=255;
   end
end