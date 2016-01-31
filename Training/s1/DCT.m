
for i=1:10
I = imread(strcat(num2str(i),'.pgm'));
D = dct2(I);
figure, imshow(I);
figure, imshow(log(abs(D)),[]), colormap(jet), colorbar;
end