clear all;close all;

load('Yale_64x64.mat');

idd_app = [ 1 2 3 5 12 13 14 16 23 24 25 27 34 35 36 38 45 46 47 49 56 57 58 60 ...
    67 68 69 71 89 90 91 93 100 101 102 104 111 112 113 115];
idd_test = [ 6 7 17 18 28 29 39 40 50 51 61 62 ...
    72 73 94 95 105 106 116 117];

figure(1);
Base_app = cell(40,1);
for k = 1:40
    Base_app{k} = [fea(idd_app(k),1:end) gnd(idd_app(k))];
    subplot(10,4,k);imagesc(reshape(Base_app{k}(1:end-1),64,64));colormap(gray);
    pause();
end



figure(2);
Base_test = cell(20,1);
for k = 1:20
    Base_test{k} = [fea(idd_test(k),1:end) gnd(idd_test(k))];
    subplot(10,2,k);imagesc(reshape(Base_test{k}(1:end-1),64,64));colormap(gray);
    pause();
end


save('Base.mat','Base_app','Base_test');

