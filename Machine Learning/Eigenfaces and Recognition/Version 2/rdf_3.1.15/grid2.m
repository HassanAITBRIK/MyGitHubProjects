function Output = grid2(N)
%
% SYNTAXE :
%
% Output = grid2(N);
%
%
% ARGUMENTS :
%
% N = Nombre de points sur un c�t� (nombre total = NxN)
%
% GRID2 g�n�re une grille de points 2D dans l'intervalle [-1, +1]^2.
%
% VALEURS DE RETOUR :
%
% Output   : les donn�es de la grille rang�es en colonnes.
%
%

% GRID2
% Bruno Gas - ISIR UPMC <Bruno.Gas@upmc.fr>
% Cr�ation : janvier 2013
% Version 1.0
% Derniere r�vision : -

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





