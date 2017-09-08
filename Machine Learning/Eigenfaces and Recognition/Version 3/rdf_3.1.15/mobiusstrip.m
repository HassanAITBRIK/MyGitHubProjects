function [Base, N] = mobiusstrip(k, N)
%
% GENSIG
%
% SYNTAXE :
%
% Base = mobiusstrip(k, N)
%
% The k-Mö?bius strip is a submanifold in R3 which can be created by 
% taking a rectangle, twisting it k-times and then identifying the ends. 
% If k is odd one gets a non-orientable manifold with surprising properties. 
% It is obvious that this manifold has high extrinsic cur- vature, 
% increasing with the number of twists k. 
% An example considered in "Intrinsic Dimensionality Estimation of 
% Submanifolds in Rd", Matthias Hein, 2005, is the 10-Mobius strip.
%
% Le nombre d'échantilons générés est égal au nombre demandé si ce dernier 
% est une puissance de 2. Dans le cas contraire le nombre d'échantillons 
% calculés est la puissance de 2 la plus proche inférieurement au nombre demandé
% 
% ARGUMENTS :
%
% k   : paramètre du ruban de Mobius.
% N   : nombre de points d'échantillonnage demandés.
%
%
% VALEURS DE RETOUR :
%
% Base   : matrice des signaux rangés en ligne
% N      : Nombre d'échantillons réellement calculés
% 
% COMPATIBILITE :
%
%   Matlab 4.3+, Octave 2.0+
%

% Bruno Gas - ISIR/UPMC Bruno.Gas@upmc.fr
% Création : janvier 2012
% Version : 1.0
% Derniere révision : 


if nargin~=2
  error('[MOBIUSSTRIP] usage : Base = mobiusstrip(k, N)');
end;

Ninit = N;
N_2 = floor( sqrt(Ninit) );
N = N_2*N_2;

if N_2 == 0
  error('[MOBIUSSTRIP] N insuffisant');
end;

i = 1;
k2 = k/2;
Base = zeros(3,N);
for u = -1:2/(N_2-1):1
    u2 = u/2;
    for v = 0:2*pi/(N_2-1):2*pi
        k2v = k2*v;
        temp = 1+u2*cos(k2v);
        Base(1, i) = temp*cos(v);
        Base(2, i) = temp*sin(v);
        Base(3, i) = u2*sin(k2v);
        i = i + 1;
    end;
end;

disp(['[MOBIUSSTRIP]: ' num2str(N) ' échantillons générés (' num2str(Ninit) ' demandés).' ]);

