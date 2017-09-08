function points = spiral(N) 

% SPIRAL
%
% SYNTAXE :
%
% points = spiral(N);
%
% G�n�ration d'un colima�on en 3 dimensions (coupe du swiss-roll)
%
% ARGUMENTS :
%
% N                 : nombre de points � g�nerer
%
% VALEURS DE RETOUR :
%
% points            : matrice 3D des points rang�s en colonnes
%
% DESCRIPTION :
%
%
% COMPATIBILITE :
%
%  Matlab 5.3+
%

% Bruno Gas - ISIR UPMC
% Cr�ation : janvier 2013
% Version : 1.0
% Derniere r�vision : 


X = 4:(14-4)/(N-1):14;
Y = 9*ones(1,N);
points = [X.*cos(X); Y; X.*sin(X)];
disp(['COLIM: ' num2str(N) ' points g�n�r�s.']);