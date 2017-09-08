function [ NewTensors ] = tensorvot ( Base, Tensors, scale )
%TENSEURVOTING help
%   Base: matrice des exemples rangés en colonnes
%
%   Dim: vecteur des dimensions estimées
%

[DimEx NbEx] = size(Base);

N = DimEx;
M = NbEx;
RTensors = zeros(size(Tensors));

% Recherche des K-PPV :
sigma = scale;
PPV = t_kppv(Base, sigma);

% Valeurs propres et vecteurs propres initiaux :
[EigVect EigVal] = t_eig(Tensors);

% Vote :
Nvotes = zeros(M,1);
% Pour tous les exemples :
for i=1:M
    % pour tous les voisins :
    for k=1:sigma
msg = '';
        j = PPV(k,i);
        v = Base(:,j) - Base(:,i);
        normv = norm(v);
        S = zeros(N);
        B = zeros(N);
        if ( (EigVal(1,j) - EigVal(2,j)) > 0 )
            % stick vote
            pscal_v_e1 = v'*EigVect(:,1,i);
            theta = asin(pscal_v_e1/normv);            
            if (theta>pi/4 || theta<-pi/4)
                % contrainte de continuité violée
msg = [msg ' + contrainte de continuité violée'];
disp([num2str(i) '->' num2str(j) ': ' msg]);  
                break;
            end;
            m1 = EigVect(:,1,i)/norm(EigVect(:,1,i));   
            if (theta==0 || normv==0)
                % emetteur et cible alignés ou confondus
                ponder = exp(-(normv^2)/sigma^2);
                w = ponder * m1; 
msg = [msg ' + emetteur et cible alignés ou confondus'];
%msg = ['psacl=' num2str(pscal_v_e1) ', theta=' num2str(theta) ', ponder=' num2str(ponder)];
                S = w*w';
             else
                s = theta*normv/sin(theta);
                rho = 2*sin(theta)/normv;
                c = -16*log(0.1)*(sigma-1)/(pi^2);
                ponder = exp(-(s^2+c*rho^2)/sigma^2);
                m2 = v/normv/cos(theta) - m1*tan(theta);
                w = ponder*(cos(2*theta)*m1 + sin(2*theta)*m2);

%disp(m1'*w);  
%disp(m2'*w); 
%msg = ['psacl=' num2str(pscal_v_e1) ', theta=' num2str(theta) ', s=' num2str(s) ', rho=' num2str(rho) ', c=' num2str(c) ', ponder=' num2str(ponder)];
msg = [msg ' + Theta=' num2str(theta) ];
%                S = ponder*[-sin(2*theta) cos(2*theta)]'*[-sin(2*theta) cos(2*theta)];
                S = w*w';
            end;            
          %  S = w*w';
%EigVect(:,1,i)
%v'
        end;
        
        if ( EigVal(N,j) > 0 )
%if ( (EigVal(1,j) - EigVal(2,j)) <= 0 )
            % ball vote
            ponder = exp(-(normv^2)/sigma^2);
            B = ponder*(eye(N) - v*v'/abs((v'*v)));
msg = [msg ' + Tensor Ball'];            
%end;
        end;
        
        V = zeros(N);          
        for d=2:N-1
            % plate vote
            V = zeros(N);          
            if ( (EigVal(d,j) - EigVal(d+1,j)) > 0 )
                % calculer la projection de v sur le sous espace normal :
                vn = zeros(N,1);
                for k=1:d
                    vn = vn + v*EigVect(:,k,j)'*EigVect(:,k,j);
                end;
                % 1er vecteur de base :
                b1 = vn/norm(vn);
                pscal_v_b1 = v'*b1;
                theta = asin(pscal_v_b1/normv);           
                if (theta>pi/4 || theta<-pi/4)
                    % contrainte de continuité violée
msg = [msg ' + contrainte de continuité violée'];
%disp([num2str(i) '->' num2str(j) ': ' msg]);  
                    break;
                end;  
                if (theta==0 || normv==0)
                    % emetteur et cible alignés ou confondus
                    ponder = exp(-(normv^2)/sigma^2);
                    w = ponder * b1; 
msg = [msg ' + emetteur et cible alignés ou confondus'];
%msg = ['psacl=' num2str(pscal_v_e1) ', theta=' num2str(theta) ', ponder=' num2str(ponder)];
                    V =  V + w*w';
                else
                    s = theta*normv/sin(theta);
                    rho = 2*sin(theta)/normv;
                    c = -16*log(0.1)*(sigma-1)/(pi^2);
                    ponder = exp(-(s^2+c*rho^2)/sigma^2);
                    vt = v/normv/cos(theta) - b1*tan(theta); % VRAI ??
                    w = ponder*(cos(2*theta)*b1 + sin(2*theta)*vt);
                    V = V + w*w';
                end;
                
                % Calcul des composantes suivantes :
                ponder = exp(-(normv^2)/sigma^2);
                % base :
                bi(1) = b1;
                for k=2:d
                    v = EigVect(:,k,j);
                    bi(k) = v - (bi(k-1)*v')*v; 
                end;
                % calcul des tenseurs 
                for k=2:d 
                    w = ponder * bi(k);
                    V =  V + w*w';
                end;
            end;           
        end;
disp([num2str(i) '->' num2str(j) ': ' msg]);        
%        NewTensors(:, :, j) = NewTensors(:, :, j) + (EigVal(1,j) - EigVal(2,j)) * S + EigVal(N,j)*B + V;       
        RTensors(:, :, j) = RTensors(:, :, j) + (EigVal(1,j) - EigVal(2,j)) * S + EigVal(N,j)*B + V;   
        Nvotes(j,1) = Nvotes(j,1) + 1;
    end;
end;

for j=1:M
    if (Nvotes(j,1)==0)
        NewTensors(:,:,j) = Tensors(:,:,j);
    else
        NewTensors(:,:,j) = RTensors(:,:,j);
    end;
end;

end

% Recherche des k plus proches voisins pour tous les ex de la base
% 
function KPPV = t_kppv(Base, k)

    NbEx = size(Base,2);

    KPPV = zeros(k, NbEx);
    for i=1:NbEx
        dist = Base - Base(:,i)*ones(1,NbEx);
        dist = sum(dist.^2);        % distances aux autres points
        [ans ind] = sort(dist);		% ordonnancement croissant des distances
        KPPV(:,i) = ind(2:k+1);     % on conserve les k plus proches points
    end;
end

% Calcul des valeurs et vecteurs propres d'une base de tenseurs :
% valeurs propres et vecteurs propres rangés en ordre décroissant
function [EigVect, EigVal] = t_eig(Tensors)

    [ans DimEx, NbEx] = size(Tensors);

    EigVect = zeros(DimEx, DimEx, NbEx);    % matrices des vect p.
    EigVal = zeros(DimEx, NbEx);            % vecteurs des val p.

    for i=1:NbEx
        [EigVect(:, :, i), vp] = eig ( Tensors(:, :, i) );
        [EigVal(:, i) ind] = sort(diag(vp), 'descend');
        EigVect(:, :, i) = EigVect(:, ind, i);
    end;

end


