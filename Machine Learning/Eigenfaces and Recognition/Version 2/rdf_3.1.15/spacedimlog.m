function [Eigv, EigvRel] = spacedimlog(data, neigv, plotflag)

% usage: [Eigv EigvRel] = spacedimlog(data, neigv, plotflag)
%
% Estimation de la dimension intrins�que de donn�es dans un espace
% Echelle logarithmique des valeurs propres
%
% ARGUMENTS : 
%
% data      : tableau des vecteurs (vecteurs colonnes)
% opt       : option : 'ratio', 'diff'
%
% ARGUMENTS : [optionnels]
%
% neigv = nombre de vazleurs propres demand�es (nombre maximum de dimensions estim�)
% plotflag = affichage �ventuel
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
% Cr�ation : 27 octobre 2008
% Version : 1.0
% Dernieres r�visions : 
%  - 
%

% Controle des arguments :
if nargin<1 || nargin >3
   error('[SPACEDIM] Usage: [Eigv EigvRel] = spacedimlog(data [, neigv [, plotflag]]);');   
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
Eigv = valp/max(valp);          % normalisation � 1
Eigv = log10(1+Eigv+1e-3);      % �chelle logarithmique
Eigv = Eigv/max(Eigv);           % re-normalisation � 1            
EigvRel = [0;Eigv(1:neigv-1)]./Eigv(1:neigv);
EigvRel = EigvRel/max(EigvRel); % normalisation � 1

% Affichage �ventuel
if plotflag==true || plotflag==1
    figure
    subplot(211);
    bar(Eigv);
    xlabel(['valeurs propres de la matrice de covariance (�chelle logarithmique)']);
    subplot(212);
    plot(0:neigv-1, EigvRel);
    xlabel(['estimation de la dimension']);
end;

