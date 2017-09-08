function [BaseApp, labelsApp, BaseTst, labelsTst,ClassNbr] = splitbase2(Base, labels, split_ratio);
%
% AFFBASE
%
% SYNTAXE :
%
% [BaseApp, labelsApp, BaseTst, labelsTst] = SPLITBASE(Base, labels, split_ratio);
%
% D�composition d'une base en deux sous-bases:
%       - BaseApp, labelsApp: Apprentissage
%       - BaseTst, labelsTst: Test (g�n�ralisation)
%    D�composition selon split_ratio   
%        split_ratio compris entre 0 et 1
%                   0: Aucun exemple en base d'apprentissage
%                   1: 100% des exemples font partis de la base d'apprentissage
%
%
% ARGUMENTS :
%
% Base       : la base des protoptypes (rang�s en colonne, sans les labels)
% labels     : vecteur ligne des labels des prototypes
%
% VALEURS DE RETOUR :
% BaseApp    : Base d'apprentissage
% labelsApp  : Vecteur ligne des labels des prototypes d'apprentissage
% BaseTst    : Base de test 
% labelsTst  : Vecteur ligne des labels des prototypes de test
%
%
% VOIR AUSSI :
%
%   BASE2TARGET  BASE2LABEL LABEL2TARGET GENBASE SHOWBASE
% 

% SPLITBASE
% Mohamed Chetounai - LISIF/PARC UPMC
% Cr�ation : 24/10/2004
% Version : 1.1
% Derniere r�vision : - Bug sur l'extraction des exemples (permutation des
% exemples avant extraction)
%                     - La permutation ne modifie pas la place des exemples
%  

% controle des arguments :
if nargin ~= 3
   error('Usage : [BaseApp, labelsApp, BaseTst, labelsTst]= splitbase (Base, labels, split_ratio)');
end;

if split_ratio<0 | split_ratio >1,
    error('[SPLITBASE]: 0 < split_ratio < 1');
end;

[ExSize ExNbr] =size(Base);
%**************************************************************************
%% Cette partie du code calcul le nombre de classe et extrait les classes.
%%% Calcule du nb de classes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
ClassNbr=0;
ind_class=[];
lab=labels;
while length(lab)~=0
    ind=find(lab==lab(1));
    ind_class=[ind_class lab(1)];
    ClassNbr=ClassNbr+1;
    lab=lab(length(ind)+1:length(lab));
end
%**************************************************************************
%%
if split_ratio==1,
    BaseApp = Base;
    labelsApp = labels;
    BaseTst = [];
    labelsTst = [];
else
    
    [ExSize, ExNbr] = size(Base);
    BaseApp = [];
    labelsApp = [];
    BaseTst = [];
    labelsTst = [];
    
    for k=1:ClassNbr
        cl=ind_class(k);
        ind = find(labels==cl);
        count = sum(sign(diff(ind))~=0)+1;
        taux  = round(count * split_ratio);
        
        indices = randperm(count)+min(ind)-1;
        B = Base(:,indices);  

        
        BaseApp = [BaseApp Base(:,indices(1:taux))];
        labelsApp = [labelsApp labels(indices(1:taux))];

        BaseTst = [BaseTst Base(:,indices(taux+1:count))];
        labelsTst = [labelsTst labels(indices(taux+1:count))];
    end;
end;





