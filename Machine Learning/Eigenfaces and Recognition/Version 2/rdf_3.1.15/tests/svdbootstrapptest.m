function svdbootstrapptst()
% sdvbootstrapptst
%
% test calcul SVD bootstrapping sur deux opérateurs linéaires
%
close all;
clear all;

global sem;
global A;
sem = 0;

f.op = @func2;      % test opérateur (func1 ou func2)
f.M = 0;            % non utilisé
[ans f.dimx f.dimy] = func2;    % extraction dimensions opérateur
iter = 5;           % Nombre d'itérations de boostrapp

[dy, df, dx] = svdbootstrapp(f, iter);

disp(df);           % opérateur diagonal obtenu
disp(dy);           % directions perceptives principales
disp(dx);           % mouvements générateurs

% calcul de la dimension :
v = diag(df); der = log(v(1:end-1)./v(2:end));
[v,dim_m] = max(der);

% Extraction des mouvements générateurs :
dM = dx(:,1:dim_m);

% obtention des perceptions liées aux mouvements générateurs (espace tangent) :
TS_M = dy'*feval(f.op, dM);



% Fonction opérateur matriciel linéaire
% =====================================
function [y, dimx, dimy] = func1(x)
A = [1 0 0 0 2 ; 0 0 3 0 0 ; 0 0 0 0 0 ; 0 4 0 0 0];
[nlig ncol] = size(A);
dimx = ncol; dimy = nlig; y = 0;

if nargin == 0
    return;
end;

if size(x,1) ~= ncol
       error('[SVDBOOTSTRAPPTST] : problème de dimension dans y=Ax;');   
end;

y = A*x;


% Fonction opérateur matriciel linéaire
% =====================================
function [y, dimx, dimy] = func2(x)
global sem;
global A;
% Génération d'une première matrice diagonale :
if sem==0
    nlig = 10; ncol = 8;
    S = zeros(nlig, ncol);
    S(1:4,1:4) = [4 0 0 0 ; 0 3 0 0 ; 0 0 2.236 0 ; 0 0 0 0];

% Changement de base aléatoire : 
    U = (rand(nlig,nlig)*2-1);
    V = (rand(ncol,ncol)*2-1);
    A = U*S*V';
    sem = 1;
else
    [nlig, ncol] = size(A);
end;
dimx = ncol; dimy = nlig; y = 0;

if nargin == 0
    return;
end;

y=A*x;

