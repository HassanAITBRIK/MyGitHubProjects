function [ DISTANCE_FROM_CLASS ] = distanceFromFaceClass(Face,CLASS_VECTOR,AVERAGE_FACE,EIGEN_FACES)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
N = size(Face,1);

PATTERN_VECTOR = [];
for j = 1:size(EIGEN_FACES,2)
    PATTERN_VECTOR = [PATTERN_VECTOR;reshape(EIGEN_FACES(:,j),N,N)'.*(Face - AVERAGE_FACE)];
end

DISTANCE_FROM_CLASS = sqrt(sum(sum(sqrt((PATTERN_VECTOR - CLASS_VECTOR).^2))));


end

