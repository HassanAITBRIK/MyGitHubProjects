function [Eigv, EigvRel] = spacedim(data, neigv, plotflag)

% usage: [Eigv EigvRel] = spacedim(data, neigv, plotflag)
%
% Estimation de la dimension intrinsèque de données dans un espace
%
%
% ARGUMENTS : 
%
% data      : tableau des vecteurs (vecteurs colonnes)
%
% ARGUMENTS : [optionnels]
%
% neigv = nombre de vazleurs propres demandées (nombre maximum de dimensions estimé)
% plotflag = affichage éventuel
%
% VALEURS DE RETOUR :
%
% Eigv      : vecteur des valeurs propres
% EigvRel   : vecteur des dimensions
%
% DESCRIPTION :
% 
% EXEMPLE :
%
%  - voir TST/SPACEDIMTST
%
% VOIR AUSSI :
%
%


% SPACEDIM
% Bruno Gas - ISIR/SIMA UPMC <gas@ccr.jussieu.fr>
% Création : 27 octobre 2008
% Version : 1.0
% Dernieres révisions : 
%  - 
%

% Controle des arguments :
if nargin<1 | nargin >3
   error('[SPACEDIM] Usage: [Eigv EigvRel] = spacedim(data [, neigv [, plotflag]]);');   
end;

[DimData NData] = size(data);
if nargin <3
    plotflag = false;
    if nargin < 2
        neigv = DimData;
    end;
end;

% Estimation statistique de la dimension de l'espace auditif:
sigma = cov(data');             % matrice de covariance
valp = eigs(sigma,neigv);       % valeurs propres
Eigv = valp/max(valp);           % normalisation à 1
EigvRel = [0;Eigv(1:neigv-1)]./Eigv(1:neigv);    
EigvRel = EigvRel/max(EigvRel); % normalisation à 1

% Annulation des valeurs inférieures à e-4
for i=2:neigv
    if Eigv(i) < 1e-4
        EigvRel(i) = 0;
    end;
end;

% Affichage éventuel
if plotflag==true | plotflag==1
    figure
    subplot(211);
    bar(Eigv);
    xlabel(['valeurs propres de la matrice de covariance (échelle logarithmique)']);
    subplot(212);
    plot(0:neigv-1, EigvRel);
    xlabel(['estimation de la dimension']);
end;

