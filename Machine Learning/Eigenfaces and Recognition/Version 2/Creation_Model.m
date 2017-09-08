function [EIGEN_FACES,Imoy] = Creation_Model(Base_app)

M = size(Base_app,2);
N1 = 64;
N2 = 64;


%%
%//DE L'IMAGE AU VECTEURS DE FLOTTANTS
Sum_Faces = 0;
for i = 1:M
    Sum_Faces = Sum_Faces + Base_app(:,i);
end
Imoy = (1/M)*Sum_Faces;

%%
%//CONSTRUIRE LE VECTEUR D'EIGENFACES
A = zeros(N1*N2,M);
for i = 1:M
    A(:,i) = Base_app(:,i) - Imoy;
end

[U,S] = eig(A*A');
%%
%//FORMALISATION
max_Col = max(S);
[~,idx] = sort(max_Col,'descend');
EIGEN_FACES = U(:,idx(1:M));
end

