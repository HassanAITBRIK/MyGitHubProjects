function Output = grid2(N)
%
% SYNTAXE :
%
% Output = grid2(N);
%
%
% ARGUMENTS :
%
% N = Nombre de points sur un côté (nombre total = NxN)
%
% GRID2 génère une grille de points 2D dans l'intervalle [-1, +1]^2.
%
% VALEURS DE RETOUR :
%
% Output   : les données de la grille rangées en colonnes.
%
%

% GRID2
% Bruno Gas - ISIR UPMC <Bruno.Gas@upmc.fr>
% Création : janvier 2013
% Version 1.0
% Derniere révision : -

% Ctrl:
if nargin~=1
   error('[GRID2] Usage : Output = grid2(N)');
end;

t = -1:2/(N-1):1;

Output = zeros(2,N^2);
val = t' * ones(1,N);
Output(2,:) = val(:);
val = val';
Output(1,:) = val(:);        





