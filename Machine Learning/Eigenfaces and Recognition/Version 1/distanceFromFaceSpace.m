function [DISTANCE_FROM_FACE_SPACE] = distanceFromFaceSpace(Face,AVERAGE_FACE,EIGEN_FACES)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
N = size(Face,1);

MeanAdjustedFace = Face - AVERAGE_FACE;

PHI_F = 0;
for j = 1:size(EIGEN_FACES,2)
    PHI_F = PHI_F + reshape(EIGEN_FACES(:,j),N,N)'.*MeanAdjustedFace.*reshape(EIGEN_FACES(:,j),N,N);
end

DISTANCE_FROM_FACE_SPACE = sqrt(sum(sum((MeanAdjustedFace - PHI_F)' * (MeanAdjustedFace - PHI_F))));
end

