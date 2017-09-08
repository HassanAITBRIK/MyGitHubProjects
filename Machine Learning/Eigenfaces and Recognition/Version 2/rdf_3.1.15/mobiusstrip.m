function [Base, N] = mobiusstrip(k, N)
%
% GENSIG
%
% SYNTAXE :
%
% Base = mobiusstrip(k, N)
%
% The k-M�?bius strip is a submanifold in R3 which can be created by 
% taking a rectangle, twisting it k-times and then identifying the ends. 
% If k is odd one gets a non-orientable manifold with surprising properties. 
% It is obvious that this manifold has high extrinsic cur- vature, 
% increasing with the number of twists k. 
% An example considered in "Intrinsic Dimensionality Estimation of 
% Submanifolds in Rd", Matthias Hein, 2005, is the 10-Mobius strip.
%
% Le nombre d'�chantilons g�n�r�s est �gal au nombre demand� si ce dernier 
% est une puissance de 2. Dans le cas contraire le nombre d'�chantillons 
% calcul�s est la puissance de 2 la plus proche inf�rieurement au nombre demand�
% 
% ARGUMENTS :
%
% k   : param�tre du ruban de Mobius.
% N   : nombre de points d'�chantillonnage demand�s.
%
%
% VALEURS DE RETOUR :
%
% Base   : matrice des signaux rang�s en ligne
% N      : Nombre d'�chantillons r�ellement calcul�s
% 
% COMPATIBILITE :
%
%   Matlab 4.3+, Octave 2.0+
%

% Bruno Gas - ISIR/UPMC Bruno.Gas@upmc.fr
% Cr�ation : janvier 2012
% Version : 1.0
% Derniere r�vision : 


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

disp(['[MOBIUSSTRIP]: ' num2str(N) ' �chantillons g�n�r�s (' num2str(Ninit) ' demand�s).' ]);

