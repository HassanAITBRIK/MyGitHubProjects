
% Tensor voting test

clear all;
close all;


% Test: surface 2D dans espace 3D

% Génération des points :
x = [-1:0.1:1];
y = [-1:0.1:1];

Nx = length(x);
Ny = length(y);
z = zeros(Nx,Ny);
k = 1;
for j=1:Ny
    for i=1:Nx
        p(1, k) = x(i);
        p(2, k) = y(j);
        p(3, k) = x(i)+y(j);
        p(3, k) = sqrt(x(i).^2+y(j).^2);
%        p(3, k) = x(i)*y(j);
        z(i,j) = p(3, k);
        k = k + 1;
    end;
end;

% tracé de la surface 2D :
surf(x, y, z);

% Contruction de la base 2D :
Base2D = [p(1,:); p(2,:); p(3,:)];
[DimEx2D NbEx2D] = size(Base2D);
Noise = rand(DimEx2D, NbEx2D)-0.5;
Base2D = Base2D + Noise*0;

% sélection d'une courbe 1D :
N = min(Nx, Ny);
for i=1:N
    c(1,i) = p(1,i);
    c(2,i) = p(2,i);
    c(3,i) = z(i,i);
end;

% tracé de la courbe :
%plot3(c(1,:), c(2,:), c(3,:), '*');

% Contruction de la base 1D :
Base1D = [c(1,:); c(2,:); c(3,:)];
[DimEx1D NbEx1D] = size(Base1D);
Noise = rand(DimEx1D, NbEx1D)-0.5;
Base1D = Base1D + Noise*0;

% voisinage :
scale = 5;
Niter = 3;

% Surface 2D dans espace 3D :

% Tenseurs initiaux :
for i=1:NbEx2D
    Tensors(:,:,i) = eye(DimEx2D, DimEx2D);
end;
EigVect = zeros(DimEx2D, DimEx2D, NbEx2D);
EigVal = zeros(DimEx2D, NbEx2D);

NewTensors = Tensors;

plot3(Base2D(1,:), Base2D(2,:),  Base2D(3,:),'*');
hold on;

for i=1:NbEx2D
    [EigVect(:,:,i) eigval] = eig( NewTensors(:, :, i) );
    [EigVal(:, i) ind] = sort( diag(eigval),'descend');
    EigVect(:,:, i) = EigVect(:, ind, i);
    if (EigVal(DimEx2D, i) == 0)
        plot3([Base2D(1,i) - EigVect(1,1, i)/2 Base2D(1,i) + EigVect(1,1, i)/2], [Base2D(2,i) - EigVect(2,1, i)/2 Base2D(2,i) + EigVect(2,1, i)/2], [Base2D(3,i) - EigVect(3,1, i)/2 Base2D(3,i) + EigVect(3,1, i)/2]);
    else
        plot3([Base2D(1,i) - EigVect(1,1, i)/2 Base2D(1,i) + EigVect(1,1, i)/2], [Base2D(2,i) - EigVect(2,1, i)/2 Base2D(2,i) + EigVect(2,1, i)/2], [Base2D(3,i) - EigVect(3,1, i)/2 Base2D(3,i) + EigVect(3,1, i)/2], 'r');           
    end;
end;
pause;

for i=1:Niter
     
    NewTensors = tensorvot ( Base2D, NewTensors, scale );
   
    hold off;
    plot3(Base2D(1,:), Base2D(2,:), Base2D(3,:), '*');
    hold on;
    for i=1:NbEx2D
        [EigVect(:,:,i) eigval] = eig( NewTensors(:, :, i) );
        [EigVal(:, i) ind] = sort( diag(eigval),'descend');
        EigVect(:,:, i) = EigVect(:, ind, i);
        if (EigVal(DimEx2D, i) == 0)
            plot3([Base2D(1,i) - EigVect(1,1, i)/2 Base2D(1,i) + EigVect(1,1, i)/2], [Base2D(2,i) - EigVect(2,1, i)/2 Base2D(2,i) + EigVect(2,1, i)/2], [Base2D(3,i) - EigVect(3,1, i)/2 Base2D(3,i) + EigVect(3,1, i)/2]);
        else
            plot3([Base2D(1,i) - EigVect(1,1, i)/2 Base2D(1,i) + EigVect(1,1, i)/2], [Base2D(2,i) - EigVect(2,1, i)/2 Base2D(2,i) + EigVect(2,1, i)/2], [Base2D(3,i) - EigVect(3,1, i)/2 Base2D(3,i) + EigVect(3,1, i)/2], 'r');           
%            plot3([Base2D(1,i) - EigVect(1,2, i)/2 Base2D(1,i) + EigVect(1,2, i)/2], [Base2D(2,i) - EigVect(2,2, i)/2 Base2D(2,i) + EigVect(2,2, i)/2], [Base2D(3,i) - EigVect(3,2, i)/2 Base2D(3,i) + EigVect(3,2, i)/2], 'g');           
        end;
    end;
    pause;
   
end;

% Analyse des dimensions :

analyse = zeros(DimEx2D,1);
for i=1:NbEx2D
    for j=1:DimEx2D-1
        analyse(j) = analyse(j) + EigVal(j,i)-EigVal(j+1,i);
    end;
    analyse(DimEx2D) = analyse(DimEx2D) + EigVal(DimEx2D, i);
end;

analyse = analyse/NbEx2D;
figure;
plot(analyse);


return;

% Courbe 1D dans espace 3D:

Niter = 10;
% Tenseurs initiaux :
for i=1:NbEx1D
    Tensors(:,:,i) = eye(DimEx1D, DimEx1D);
end;
EigVect = zeros(DimEx1D, DimEx1D, NbEx1D);
EigVal = zeros(DimEx1D, NbEx1D);

NewTensors = Tensors;

figure;
plot3(Base1D(1,:), Base1D(2,:),  Base1D(3,:),'*');
hold on;

for i=1:NbEx1D
    [EigVect(:,:,i) eigval] = eig( NewTensors(:, :, i) );
    [EigVal(:, i) ind] = sort( diag(eigval),'descend');
    EigVect(:,:, i) = EigVect(:, ind, i);
    if (EigVal(DimEx1D, i) == 0)
        plot3([Base1D(1,i) - EigVect(1,1, i)/2 Base1D(1,i) + EigVect(1,1, i)/2], [Base1D(2,i) - EigVect(2,1, i)/2 Base1D(2,i) + EigVect(2,1, i)/2], [Base1D(3,i) - EigVect(3,1, i)/2 Base1D(3,i) + EigVect(3,1, i)/2]);
    else
        plot3([Base1D(1,i) - EigVect(1,1, i)/2 Base1D(1,i) + EigVect(1,1, i)/2], [Base1D(2,i) - EigVect(2,1, i)/2 Base1D(2,i) + EigVect(2,1, i)/2], [Base1D(3,i) - EigVect(3,1, i)/2 Base1D(3,i) + EigVect(3,1, i)/2], 'r');           
    end;
end;
pause;

for i=1:Niter
     
    NewTensors = tensorvot ( Base1D, NewTensors, scale );
   
    hold off;
    plot3(Base1D(1,:), Base1D(2,:), Base1D(3,:), '*');
    hold on;
    for i=1:NbEx1D
        [EigVect(:,:,i) eigval] = eig( NewTensors(:, :, i) );
        [EigVal(:, i) ind] = sort( diag(eigval),'descend');
        EigVect(:,:, i) = EigVect(:, ind, i);
        if (EigVal(DimEx1D, i) == 0)
            plot3([Base1D(1,i) - EigVect(1,1, i)/2 Base1D(1,i) + EigVect(1,1, i)/2], [Base1D(2,i) - EigVect(2,1, i)/2 Base1D(2,i) + EigVect(2,1, i)/2], [Base1D(3,i) - EigVect(3,1, i)/2 Base1D(3,i) + EigVect(3,1, i)/2]);
        else
            plot3([Base1D(1,i) - EigVect(1,1, i)/2 Base1D(1,i) + EigVect(1,1, i)/2], [Base1D(2,i) - EigVect(2,1, i)/2 Base1D(2,i) + EigVect(2,1, i)/2], [Base1D(3,i) - EigVect(3,1, i)/2 Base1D(3,i) + EigVect(3,1, i)/2], 'r');           
            plot3([Base1D(1,i) - EigVect(1,2, i)/2 Base1D(1,i) + EigVect(1,2, i)/2], [Base1D(2,i) - EigVect(2,2, i)/2 Base1D(2,i) + EigVect(2,2, i)/2], [Base1D(3,i) - EigVect(3,2, i)/2 Base1D(3,i) + EigVect(3,2, i)/2], 'g');           
        end;
    end;
    pause;
   
end;

% Analyse des dimensions :

analyse = zeros(DimEx1D,1);
for i=1:NbEx1D
    for j=1:DimEx1D-1
        analyse(j) = analyse(j) + EigVal(j,i)-EigVal(j+1,i);
    end;
    analyse(DimEx1D) = analyse(DimEx1D) + EigVal(DimEx1D, i);
end;

analyse = analyse/NbEx1D;
figure;
plot(analyse);

%analyse(2) = analyse(1)+analyse(2);

% Valeurs propres initiales (ball tensor) :
%EigVal = ones(M, N);

% Calcul des tenseurs initiaux :
%for i=1:M
%    Tensors(:, :, i) = diag( EigVal(:, i) );
%end;