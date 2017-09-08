function points = tennisball(a, b, N) 

% TENNISBALL
%
% SYNTAXE :
%
% points = tennisball(N);
%
% Génération d'une courbe 3D en forme de couture de balle de tennis
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
% http://www.mathcurve.com/courbes3d/couture/couture.shtml 
%
% COMPATIBILITE :
%
%  Matlab 5.3+
%

% Bruno Gas - ISIR UPMC
% Création : janvier 2013
% Version : 1.0
% Derniere révision : 

t = 0:2*pi/(N-1):2*pi;

X = a*cos(t) + b*cos(3*t);
Y = a*sin(t) - b*sin(3*t);
Z = 2*sqrt(a*b)*sin(2*t);       % cas général: Z = 2*c*sin(2*t);

points = [X; Y; Z];
disp(['TENNISBALL: ' num2str(N) ' points générés.']);