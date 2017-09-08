
% Tensor voting test

clear all;
close all;


% Test: courbe 1D dans space 2D

Base = [[-1:0.1:+1]; [-1:0.1:+1].^2];
%Base = [[-1:+1]; [-1:+1]];
[DimEx NbEx] = size(Base);
Noise = rand(DimEx, NbEx)-0.5;
Base = Base + Noise*0;

% Tenseurs initiaux :
for i=1:NbEx
    Tensors(:,:,i) = eye(DimEx, DimEx);
end;
EigVect = zeros(DimEx, DimEx, NbEx);
EigVal = zeros(DimEx, NbEx);

% voisinage :
scale = 3;
Niter = 2;

NewTensors = Tensors;

plot(Base(1,:), Base(2,:), '*');
hold on;

for i=1:NbEx
    [EigVect(:,:,i) eigval] = eig( NewTensors(:, :, i) );
    [EigVal(:, i) ind] = sort( diag(eigval),'descend');
    EigVect(:,:, i) = EigVect(:, ind, i);
    if (EigVal(DimEx, i) == 0)
        plot([Base(1,i) Base(1,i) + EigVect(1,1, i)], [Base(2,i) Base(2,i)+EigVect(2,1, i)]);
    end;
end;
pause;

for i=1:Niter
    NewTensors = tensorvot ( Base, NewTensors, scale );
end;

hold off;
plot(Base(1,:), Base(2,:), '*');
hold on;
for i=1:NbEx
    [EigVect(:,:,i) eigval] = eig( NewTensors(:, :, i) );
    [EigVal(:, i) ind] = sort( diag(eigval),'descend');
    EigVect(:,:, i) = EigVect(:, ind, i);
    if (EigVal(DimEx, i) == 0)
        plot([Base(1,i) - EigVect(1,1, i)/2 Base(1,i) + EigVect(1,1, i)/2], [Base(2,i) - EigVect(2,1, i)/2 Base(2,i) + EigVect(2,1, i)/2]);
    else
        plot([Base(1,i) - EigVect(1,1, i)/2 Base(1,i) + EigVect(1,1, i)/2], [Base(2,i) - EigVect(2,1, i)/2 Base(2,i) + EigVect(2,1, i)/2],'r');           
    end;
end;

% Analyse des dimensions :

analyse = zeros(DimEx,1);
D_EigVal = zeros(DimEx, 1);
D_Estim = zeros(DimEx);
for i=1:NbEx
    for j=1:DimEx-1
        D_EigVal(j) = EigVal(j,i)-EigVal(j+1,i);
        analyse(j) = analyse(j) + D_EigVal(j);
    end;
    D_EigVal(DimEx) = EigVal(DimEx, i);
    analyse(DimEx) = analyse(DimEx) + D_EigVal(DimEx);
    [ans dim] = max(D_EigVal);
    D_Estim(dim) = D_Estim(dim) + 1;
end;

analyse = analyse/NbEx;
figure;
plot(analyse);
disp(['Dimension: 1=' num2str(D_Estim(1)*100/NbEx) '%']);
disp(['Dimension: 2=' num2str(D_Estim(2)*100/NbEx) '%']);



% Valeurs propres initiales (ball tensor) :
%EigVal = ones(M, N);

% Calcul des tenseurs initiaux :
%for i=1:M
%    Tensors(:, :, i) = diag( EigVal(:, i) );
%end;