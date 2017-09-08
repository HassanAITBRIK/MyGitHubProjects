
% Tensor voting test (Swiss Roll)
% http://isomap.stanford.edu

clear all;
close all;

load swiss_roll_data;

NbEx = 3000;
Base = [X_data(1,1:NbEx); X_data(2,1:NbEx); X_data(3,1:NbEx)];
DimEx = size(Base,1);

% Bruit additif: 
Noise = rand(DimEx, NbEx)-0.5;
Base = Base + Noise*0;

% voisinage et nombre d'itérations :
scale = 3;
Niter = 2;

% Tenseurs initiaux :
for i=1:NbEx
    Tensors(:,:,i) = eye(DimEx, DimEx);
end;
EigVect = zeros(DimEx, DimEx, NbEx);
EigVal = zeros(DimEx, NbEx);

NewTensors = Tensors;

% Tracé initial de la surface :
plot3(Base(1,:), Base(2,:),  Base(3,:),'.');
hold on;
ech = 4;

for i=1:NbEx
    [EigVect(:,:,i) eigval] = eig( NewTensors(:, :, i) );
    [EigVal(:, i) ind] = sort( diag(eigval),'descend');
    EigVect(:,:, i) = EigVect(:, ind, i);
    plot3([Base(1,i) - EigVect(1,1, i)*ech/2 Base(1,i) + EigVect(1,1, i)*ech/2], [Base(2,i) - EigVect(2,1, i)*ech/2 Base(2,i) + EigVect(2,1, i)*ech/2], [Base(3,i) - EigVect(3,1, i)*ech/2 Base(3,i) + EigVect(3,1, i)*ech/2], 'r');
end;
pause;

for i=1:Niter
    NewTensors = tensorvot ( Base, NewTensors, scale );
end;

hold off;
plot3(Base(1,:), Base(2,:), Base(3,:), '.');
hold on;
for i=1:NbEx
    [EigVect(:,:,i) eigval] = eig( NewTensors(:, :, i) );
    [EigVal(:, i) ind] = sort( diag(eigval),'descend');
    EigVect(:,:, i) = EigVect(:, ind, i);
    plot3([Base(1,i) - EigVect(1,1, i)*ech/2 Base(1,i) + EigVect(1,1, i)*ech/2], [Base(2,i) - EigVect(2,1, i)*ech/2 Base(2,i) + EigVect(2,1, i)*ech/2], [Base(3,i) - EigVect(3,1, i)*ech/2 Base(3,i) + EigVect(3,1, i)*ech/2], 'r');
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
disp(['Dimension: 1=' num2str(D_Estim(2)*100/NbEx) '%']);
disp(['Dimension: 2=' num2str(D_Estim(1)*100/NbEx) '%']);
disp(['Dimension: 3=' num2str(D_Estim(3)*100/NbEx) '%']);


return;


for i=1:Niter
     
    NewTensors = tensorvot ( Base, NewTensors, scale );
   
    hold off;
    plot3(Base(1,:), Base(2,:), Base(3,:), '.');
    hold on;
    for i=1:NbEx
        [EigVect(:,:,i) eigval] = eig( NewTensors(:, :, i) );
        [EigVal(:, i) ind] = sort( diag(eigval),'descend');
        EigVect(:,:, i) = EigVect(:, ind, i);
        if (EigVal(DimEx, i) == 0)
            plot3([Base(1,i) - EigVect(1,1, i)*ech/2 Base(1,i) + EigVect(1,1, i)*ech/2], [Base(2,i) - EigVect(2,1, i)*ech/2 Base(2,i) + EigVect(2,1, i)*ech/2], [Base(3,i) - EigVect(3,1, i)*ech/2 Base(3,i) + EigVect(3,1, i)*ech/2]);
        else
            plot3([Base(1,i) - EigVect(1,1, i)*ech/2 Base(1,i) + EigVect(1,1, i)*ech/2], [Base(2,i) - EigVect(2,1, i)*ech/2 Base(2,i) + EigVect(2,1, i)*ech/2], [Base(3,i) - EigVect(3,1, i)*ech/2 Base(3,i) + EigVect(3,1, i)*ech/2], 'r');           
%            plot3([Base(1,i) - EigVect(1,2, i)*ech/2 Base(1,i) + EigVect(1,2, i)*ech/2], [Base(2,i) - EigVect(2,2, i)*ech/2 Base(2,i) + EigVect(2,2, i)*ech/2], [Base(3,i) - EigVect(3,2, i)*ech/2 Base(3,i) + EigVect(3,2, i)*ech/2], 'g');           
        end;
    end;
    pause;
   
end;

% Analyse des dimensions :

analyse = zeros(DimEx,1);
for i=1:NbEx
    for j=1:DimEx-1
        analyse(j) = analyse(j) + EigVal(j,i)-EigVal(j+1,i);
    end;
    analyse(DimEx) = analyse(DimEx) + EigVal(DimEx, i);
end;

analyse = analyse/NbEx;
figure;
plot(analyse);
