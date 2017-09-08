function [dy, df, dx] = svdbootstrapp(f, iter)

% usage: [dy, df, dx] = svdbootstrapp(f, M, iter)
%
% Estimation de la dimension et extraction des g�n�rateurs d'un op�rateur f(M) lin�aire
%
%
% ARGUMENTS : 
%
% f        : la fonction, op�rateur lin�aire :
%   f.M    : param�tre vecteoriel de f = f(M)
%   f.dimx : dimension des entr�es
%   f.dimy : dimension des sorties
%   f.op   : adresse de l'op�rateur
% iter     : nombre d'it�rations de bootstrapp � r�aliser
%
% VALEURS DE RETOUR :
%
% dx     : vecteurs singuliers d'entr�e
% dy     : vecteur singuliers de sortie
% df     : matrice des valeurs singuli�res
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
% Cr�ation : 2 d�cembre 2008
% Source: D. Philipona
% Version : 1.0
% Dernieres r�visions : 
%  - 
%

% Controle des arguments :
if nargin~=2
   error('[SVDBOOTSTRAPP] Usage: [dy, df, dx] = svdbootstrapp(f, iter);');   
end;

DimX = f.dimx;
DimY = f.dimy;

% Bases initiales d'entr�e et de sortie (bases canoniques)
dx = eye(DimX);
dy = eye(DimY);

% bootstrapp :
for i=1:iter
    df = dy'*feval(f.op, dx);   % extraction op�rateur
    [U,S,V] = svd(df);          % calcul SVD
    dx = dx*V;                  % changement de base d'entr�e
    dy = dy*U;                  % changement de base de sortie
    d = diag(S)';
    v(i,:) = d;
end
df = dy'*feval(f.op, dx);       % extraction dernier op�rateur dans derni�re base

for i=1:iter
    [val,I] = max(find(v(i,:)>0));
    maxi(i) = I;
end
m = min(maxi);
for i=1:iter
    b(i,:) = log(v(i,1:m-2)./v(i,2:m-1));
end
bar3(b');
