clear all;close all;

load('DATA_SET.mat')
load('Yale_64x64.mat');

M = length(DATA_SET);
N = size(DATA_SET{1},1);
M_prime = 10;


%%
%//DE L'IMAGE AU VECTEURS DE FLOTTANTS
I = zeros(N^2,M);
Sum_Faces = 0;
for i = 1:M
    I(:,i) = reshape(DATA_SET{i},N^2,1);
    Sum_Faces = Sum_Faces + I(:,i);
end
Imoy = (1/M)*Sum_Faces;

%%
%//CONSTRUIRE LE VECTEUR D'EIGENFACES
A = zeros(N^2,M);
for i = 1:M
    A(:,i) = I(:,i) - Imoy;
end

[U,S] = eig(A*A');

% figure(2);
% for i = 1:M_prime
%     subplot(2,5,i);imagesc(reshape(W(:,i),N,N));colormap(gray);
% end

%%
%//FORMALISATION


max_Col = max(S);
[~,idx] = sort(max_Col,'descend');
W = U(:,idx(1:M));

C = W'*A;


FACE_PROJECTION = 0;
%figure(3);
for i = 1:M
    FACE_PROJECTION = FACE_PROJECTION + C(i,1)*W(:,i);
   % subplot(2,5,i);imagesc(reshape(C(i,1)*W(:,i),N,N));colormap(gray);
end

figure(4);imagesc(reshape(FACE_PROJECTION+Imoy,N,N));colormap(gray);




FACE_test = fea(5,:)';
C_test = W'*(FACE_test - Imoy);


FACE_test_PROJECTION = 0;
for i = 1:M_prime
    FACE_test_PROJECTION = FACE_test_PROJECTION + C_test(i)*W(:,i);
   % subplot(2,5,i);imagesc(reshape(C(i,1)*W(:,i),N,N));colormap(gray);
end

figure(5);
subplot(1,2,1);imagesc(reshape(FACE_test,N,N));colormap(gray);
subplot(1,2,2);imagesc(reshape(FACE_test_PROJECTION+Imoy,N,N));colormap(gray);










