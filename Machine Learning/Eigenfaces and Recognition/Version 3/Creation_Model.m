function [EIGEN_FACES,Imoy,K_opt] = Creation_Model(BaseApp)
% Réalise une ACP pour determiner les EIGEN-FACES la visage moyen et le
% facteur K optimal

N1 = 64;
N2 = 64;

%% VISAGE MOYEN
Imoy = mean(BaseApp')';
%% CONSTRUCTION DES VECTEUR D'EIGENFACES
A = (BaseApp' - repmat(Imoy',size(BaseApp,2),1))';
[U,S] = eig(A*A');
%% FORMALISATION
EIGEN_FACES = U(:,end:-1:1);
%% INERTIE 
% K representant 95% de la variance totale
eigval = diag(S);
eigval = eigval(end:-1:1);
eigsum = sum(eigval);
csum = 0;
for i = 1:N1*N2
    csum = csum + eigval(i);
    tv = csum/eigsum;
    if tv > 0.95
        K_opt = i;
        break;
    end 
end
end


