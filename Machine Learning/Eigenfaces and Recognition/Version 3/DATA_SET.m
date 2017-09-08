clear all;close all;

load('Yale_64x64.mat');

NBClass = 15;

Base = [fea(1:11*NBClass,1:end) gnd(1:11*NBClass)];


save('Base.mat','Base');

