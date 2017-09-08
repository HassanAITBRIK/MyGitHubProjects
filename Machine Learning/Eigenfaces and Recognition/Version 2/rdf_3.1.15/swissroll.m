function points = swissroll(N) 

% SWISSROLL
%
% SYNTAXE :
%
% points = swissroll();
%
% Génération d'un gateau suisse en 3 dimensions ...
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
% L'algorithme génère 4 mixtures gaussiennes de points de N/4 points chacune 
% sur une surface plane 2D. les points sont ensuite "enroulés" en utilisant l'algorithme
% de mapping du Swiss Roll : 
%   (x,y) -> (x cos x, y, x sin x).
%
% SOURCE :
%
%  Dinoj Surendran, 16 May 2004 
%  http://people.cs.uchicago.edu/~dinoj/manifold/swissroll.html
%
% COMPATIBILITE :
%
%  Matlab 5.3+
%

% Bruno Gas - ISIR UPMC
% Création : janvier 2013
% Version : 1.0
% Derniere révision : 

% points per mixture :
Ninit = N;
N = floor(Ninit/4);
ppm = [N N N N];
stdev = 1;
centers = [7.5 7.5; 7.5 12.5; 12.5 7.5; 12.5 12.5];
data2 = makegaussmixnd(centers,stdev,ppm);

disp(['SWISSROLL: ' num2str(N*4) ' points générés sur ' num2str(Ninit) ' demandés.']);
X = data2(:,1)';
Y = data2(:,2)';
points = [X.*cos(X); Y; X.*sin(X)];
