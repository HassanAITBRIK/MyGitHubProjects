close all;clear all;

load('DATA_SET.mat')


M = length(DATA_SET);
N = size(DATA_SET{1},1);
M_prime = 10;
%%
%AVERAGE FACE
Sum_Faces = 0;
for i = 1:M
    Sum_Faces = Sum_Faces + DATA_SET{i};
end
AVERAGE_FACE = (1/M)*Sum_Faces;
figure(1);imagesc(AVERAGE_FACE);colormap(gray);
%%
%DIFFERENCE FROM THE AVERAGE FACE

DIFF_FROM_AVERAGE = [];
for i = 1:M
    DIFF_FROM_AVERAGE(:,i) = reshape(DATA_SET{i},N^2,1) - reshape(AVERAGE_FACE,N^2,1);
end
%%
%CREATION VISAGE PROPRES
A = DIFF_FROM_AVERAGE;
L = A'*A;
%C = A*A';
[vecteurs_propres,valeurs_propres] = eig(L);
max_Col = max(valeurs_propres);
[~,idx] = sort(max_Col,'descend');
EIGEN_VECTORS = vecteurs_propres(:,idx(1:M));

EIGEN_FACES = zeros(N^2,M);
for l = 1:M
    EF = 0;
    for k = 1:M
        EF = EIGEN_VECTORS(k,l)*DIFF_FROM_AVERAGE(:,k);
        EIGEN_FACES(:,l) = EIGEN_FACES(:,l) + EF;
    end
end
%EIGEN_FACES = reshape(EIGEN_FACES',N^2,M);
EIGEN_FACES = EIGEN_FACES(:,1:M);

figure(2);
for i = 1:M
    imagesc(reshape(EIGEN_FACES(:,i),N,N));colormap(gray);
    pause();
end

%%
%PROJECTION "FACE SPACE"
EFP = cell(M,1);
for i = 1:M
    wk = [];
    w = [];
    for j = 1:M_prime
        wk = reshape(EIGEN_FACES(:,j),N,N)'.*(DATA_SET{i} - AVERAGE_FACE);
        w = [w ; wk];
    end
    EFP{i} = w;
end

CLASS_VECTOR = cell(10,1);
k = 1;
for i = 1:4:40
    CLASS_VECTOR{k} = (EFP{i} + EFP{i+1} + EFP{i+2} + EFP{i+3})/4;
    k = k + 1;
end
