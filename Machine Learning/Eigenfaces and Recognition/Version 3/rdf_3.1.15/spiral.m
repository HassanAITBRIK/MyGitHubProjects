function points = spiral(N) 

% SPIRAL
%
% SYNTAXE :
%
% points = spiral(N);
%
% Génération d'un colimaçon en 3 dimensions (coupe du swiss-roll)
%
% ARGUMENTS :
%
% N                 : nombre de points à génerer
%
% VALEURS DE RETOUR :
%
% points            : matrice 3D des points rangés en colonnes
%
% DESCRIPTION :
%
%
% COMPATIBILITE :
%
%  Matlab 5.3+
%

% Bruno Gas - ISIR UPMC
% Création : janvier 2013
% Version : 1.0
% Derniere révision : 


X = 4:(14-4)/(N-1):14;
Y = 9*ones(1,N);
points = [X.*cos(X); Y; X.*sin(X)];
disp(['COLIM: ' num2str(N) ' points générés.']);