function [CLASS] = Projection_Class(Base_app,EIGEN_FACES,Imoy,K,label)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
CLASS = cell(10,2);
k = 1;
for i = 1:4:40
    i1 = Projection_FaceSpace(Base_app(:,i),EIGEN_FACES,Imoy,K);
    i2 = Projection_FaceSpace(Base_app(:,i+1),EIGEN_FACES,Imoy,K);
    i3 = Projection_FaceSpace(Base_app(:,i+2),EIGEN_FACES,Imoy,K);
    i4 = Projection_FaceSpace(Base_app(:,i+3),EIGEN_FACES,Imoy,K);
    CLASS{k} = (i1+i2+i3+i4)/4;
    CLASS{k+10} = label(i);
    k = k + 1;
end

end

