function svdbootstrapptst()
% sdvbootstrapptst
%
% test calcul SVD bootstrapping sur deux op�rateurs lin�aires
%
close all;
clear all;

global sem;
global A;
sem = 0;

f.op = @func2;      % test op�rateur (func1 ou func2)
f.M = 0;            % non utilis�
[ans f.dimx f.dimy] = func2;    % extraction dimensions op�rateur
iter = 5;           % Nombre d'it�rations de boostrapp

[dy, df, dx] = svdbootstrapp(f, iter);

disp(df);           % op�rateur diagonal obtenu
disp(dy);           % directions perceptives principales
disp(dx);           % mouvements g�n�rateurs

% calcul de la dimension :
v = diag(df); der = log(v(1:end-1)./v(2:end));
[v,dim_m] = max(der);

% Extraction des mouvements g�n�rateurs :
dM = dx(:,1:dim_m);

% obtention des perceptions li�es aux mouvements g�n�rateurs (espace tangent) :
TS_M = dy'*feval(f.op, dM);



% Fonction op�rateur matriciel lin�aire
% =====================================
function [y, dimx, dimy] = func1(x)
A = [1 0 0 0 2 ; 0 0 3 0 0 ; 0 0 0 0 0 ; 0 4 0 0 0];
[nlig ncol] = size(A);
dimx = ncol; dimy = nlig; y = 0;

if nargin == 0
    return;
end;

if size(x,1) ~= ncol
       error('[SVDBOOTSTRAPPTST] : probl�me de dimension dans y=Ax;');   
end;

y = A*x;


% Fonction op�rateur matriciel lin�aire
% =====================================
function [y, dimx, dimy] = func2(x)
global sem;
global A;
% G�n�ration d'une premi�re matrice diagonale :
if sem==0
    nlig = 10; ncol = 8;
    S = zeros(nlig, ncol);
    S(1:4,1:4) = [4 0 0 0 ; 0 3 0 0 ; 0 0 2.236 0 ; 0 0 0 0];

% Changement de base al�atoire : 
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

