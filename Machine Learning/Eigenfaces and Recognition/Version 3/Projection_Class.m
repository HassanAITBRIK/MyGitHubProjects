function [CLASS] = Projection_Class(Base_app,EIGEN_FACES,Imoy,K,label,NbClass)
%Calcule de la projection moyenne de chaque classe

CLASS = cell(NbClass,2);
k = 1;
for i = 1:NbClass
    idx = find(label == i);
    img_proj = 0;
    for j = 1:size(idx,2)
        img_proj = img_proj + Projection_FaceSpace(Base_app(:, idx(j)),EIGEN_FACES,Imoy,K);
    end
    CLASS{k} = img_proj/size(idx,2);
    CLASS{k+NbClass} = i;
    k = k + 1;
end

end

