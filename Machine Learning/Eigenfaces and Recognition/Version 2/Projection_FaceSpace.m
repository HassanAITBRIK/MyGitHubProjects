function [FACE_PROJECTION] = Projection_FaceSpace(face,EIGEN_FACES,Imoy,K)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
N1 = size(face,1);
N2 = size(face,2);

if N1 == 1
    FACE = face';
elseif N1~=1 && N2~=1
    FACE = reshape(face,N1*N2,1);
else 
    FACE = face;
end


C = EIGEN_FACES'*(FACE - Imoy);


FACE_PROJECTION = 0;
for i = 1:K
    FACE_PROJECTION = FACE_PROJECTION + C(i)*EIGEN_FACES(:,i);
end

FACE_PROJECTION = FACE_PROJECTION + Imoy;

end

