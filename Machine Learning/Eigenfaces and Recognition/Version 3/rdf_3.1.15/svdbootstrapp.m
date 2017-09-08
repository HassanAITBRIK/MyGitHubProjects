function [dy, df, dx] = svdbootstrapp(f, iter)

% usage: [dy, df, dx] = svdbootstrapp(f, M, iter)
%
% Estimation de la dimension et extraction des générateurs d'un opérateur f(M) linéaire
%
%
% ARGUMENTS : 
%
% f        : la fonction, opérateur linéaire :
%   f.M    : paramètre vecteoriel de f = f(M)
%   f.dimx : dimension des entrées
%   f.dimy : dimension des sorties
%   f.op   : adresse de l'opérateur
% iter     : nombre d'itérations de bootstrapp à réaliser
%
% VALEURS DE RETOUR :
%
% dx     : vecteurs singuliers d'entrée
% dy     : vecteur singuliers de sortie
% df     : matrice des valeurs singulières
%
% DESCRIPTION :
%
% Source: D. Philipona
% 
% EXEMPLE :
%
%  - voir TST/SVDBOOTSTRAPPTST
%
% VOIR AUSSI :
%
%


% SVDBOOTSTRAPP
% Bruno Gas - ISIR/SIMA UPMC <gas@ccr.jussieu.fr>
% Création : 2 décembre 2008
% Source: D. Philipona
% Version : 1.0
% Dernieres révisions : 
%  - 
%

% Controle des arguments :
if nargin~=2
   error('[SVDBOOTSTRAPP] Usage: [dy, df, dx] = svdbootstrapp(f, iter);');   
end;

DimX = f.dimx;
DimY = f.dimy;

% Bases initiales d'entrée et de sortie (bases canoniques)
dx = eye(DimX);
dy = eye(DimY);

% bootstrapp :
for i=1:iter
    df = dy'*feval(f.op, dx);   % extraction opérateur
    [U,S,V] = svd(df);          % calcul SVD
    dx = dx*V;                  % changement de base d'entrée
    dy = dy*U;                  % changement de base de sortie
    d = diag(S)';
    v(i,:) = d;
end
df = dy'*feval(f.op, dx);       % extraction dernier opérateur dans dernière base

for i=1:iter
    [val,I] = max(find(v(i,:)>0));
    maxi(i) = I;
end
m = min(maxi);
for i=1:iter
    b(i,:) = log(v(i,1:m-2)./v(i,2:m-1));
end
bar3(b');
