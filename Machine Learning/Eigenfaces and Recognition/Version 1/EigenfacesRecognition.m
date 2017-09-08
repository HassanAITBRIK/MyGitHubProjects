clear all; close all;

load('DATA_SET.mat')
load('Yale_64x64.mat');

M = length(DATA_SET);
N = size(DATA_SET{1},1);
M_prime = 10;
FACE = DATA_SET{20};

[CLASS_VECTOR,AVERAGE_FACE,EIGEN_FACES] = CreationModel(DATA_SET);


DISTANCE_FROM_CLASS = zeros(10,1);
for i = 1:M_prime
    DISTANCE_FROM_CLASS(i) = distanceFromFaceClass(FACE,CLASS_VECTOR{i},AVERAGE_FACE,EIGEN_FACES);
    DISTANCE_FROM_FACE_SPACE = distanceFromFaceSpace(FACE,AVERAGE_FACE,EIGEN_FACES);
end


figure(1);
Projection = 0;
for i = 1:M_prime
    subplot(2,5,i);imagesc(reshape(EIGEN_FACES(:,i),N,N));colormap(gray);
end


%figure(2);
FACE_PROJECTION = 0;
for i = 1:40
    FACE_PROJECTION = FACE_PROJECTION + reshape(EIGEN_FACES(:,i)',N,N).*(FACE - AVERAGE_FACE);
    %subplot(2,5,i);imagesc(reshape(EIGEN_FACES(:,i),N,N).*(FACE - AVERAGE_FACE));colormap(gray);
end


figure(3);
iem_projection = reshape(EIGEN_FACES(:,1)',N,N).*(FACE - AVERAGE_FACE);
subplot(1,4,2);imagesc(iem_projection);colormap(gray);
subplot(1,4,1);imagesc(FACE);colormap(gray);
subplot(1,4,3);imagesc(FACE_PROJECTION);colormap(gray);
subplot(1,4,4);imagesc(FACE_PROJECTION+AVERAGE_FACE);colormap(gray);









