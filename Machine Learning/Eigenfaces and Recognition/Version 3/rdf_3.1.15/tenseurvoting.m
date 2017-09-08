function [ Dim ] = tenseurvoting ( Base, scale )
%TENSEURVOTING help
%   Base: matrice des exemples rangés en colonnes
%
%   Dim: vecteur des dimensions estimées
%

[DimEx NbEx] = size(Base);

N = DimEx;
M = NbEx;
Tensors = zeros(N, N, M);
Accus = zeros(N, N, M);
EigVect = zeros(N, N, M);

% Valeurs propres initiales (ball tensor) :
EigVal = ones(M, N);

% Calcul des tenseurs initiaux :
for i=1:M
    Tensors(:, :, i) = diag( EigVal(:, i) );
end;

% Calcul des vecteurs propres initiaux :
for i=1:M
    [EigVect(:, :, i) ans] = eig ( Tensors(:, :, i) );
end;

% Recherche des K-PPV :
sigma = scale;
PPV = zeros(sigma, M);
for i=1:M
    dist = Base - Base(:,i)*ones(1,M);
    dist = sum(dist.^2);        % distances aux autres points
    [val ind] = sort(dist);		% ordonnancement croissant des distances
    PPV(:,i) = ind(2:sigma+1);  % on conserve les sigma plus proches points
end;

% Vote :
% Pour tous les exemples :
for i=1:M
    % pour tous les voisins :
    for k=1:sigma
        j = PPV(k,i);
        v = Base(:,j) - Base(:,i);
        if ( (EigVal(1,j) - EigVal(2,j)) > 0 )
            % stick vote
            normv = somsqr(v);
            pscal_v_e1 = v'*EigVect(:,1,i);
            theta = asin(pscal_v_e1/normv);
            s = theta*normv/sin(theta);
            rho = 2*sin(theta)/normv;
            c = -16*log(0.1)*(sigma-1)/(pi^2);
            ponder = exp(-(s^2+c*rho^2)/sigma^2);
            m1 = EigVect(:,1,i)/norm(EigVect(:,1,i));
            m2 = v/normv/cos(theta) - m1*tan(theta);
            w = ponder*(cos(2*theta)*m2 - sin(2*theta)*m1);
            S = w*w';
        end;
        
        if ( EigVal(N,j) > 0 )
            % ball vote
            v = Base(:,j) - Base(:,i);
            ponder = exp(-(s^2)/sigma^2);
            B = ponder*(eye(n) - v*v'/(v'*v));
        end;
        
        for d=2:N-1
            V = zeros(N,N);          
            if ( (EigVal(d,j) - EigVal(d+1,j)) > 0 )
                % compute vote
            end;           
        end;
        
        Accus(:, :, j) = Accus(:, :, j) + (EigVal(1,j) - EigVal(2,j)) * S + EigVal(N,j)*B + V;       
    end;
end;




end


