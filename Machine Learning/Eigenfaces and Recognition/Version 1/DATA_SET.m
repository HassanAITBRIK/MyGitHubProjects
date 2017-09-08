clear all;close all;

load('Yale_64x64.mat');

idd = [ 1 2 3 5 12 13 14 16 23 24 25 27 34 35 36 38 45 46 47 49 56 57 58 60 ...
    67 68 69 71 89 90 91 93 100 101 102 104 111 112 113 115];

figure(1);
DATA_SET = cell(40,1);
for k = 1:40
    DATA_SET{k} = reshape(fea(idd(k),1:end),64,64);
    subplot(10,4,k);imagesc(DATA_SET{k});colormap(gray);
    pause();
end

save('DATA_SET.mat','DATA_SET');

