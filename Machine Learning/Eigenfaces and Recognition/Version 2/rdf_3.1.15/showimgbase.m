function showimgbase(Base, Labels, DimX, DimY, numfig)
%
% SHOWIMGBASE
%
% SYNTAXE :
%
% SHOWIMGBASE(Base, labels);
%
% Affichage des éléments d'une base en tant qu'images DimX x DimY
%
% ARGUMENTS :
%
% Base       : la base des protoptypes (rangés en colonne, sans les labels)
% DimX       : nombre de pixels en x
% DimY       : nombre de pixels en y
% numfig     : [optionnel] numéro de la figureà utiliser
%
% VALEURS DE RETOUR :
%
%
% VOIR AUSSI :
%
% 
% 

% SHOWIMGBASE
% Bruno Gas - ISIR/UPMC
% Création : 1/12/2011
% Version : 1
% Derniere révision : 
% 
%   

% controle des arguments :
if nargin ~= 4 && nargin ~= 5
   error('Usage : showimgbase (Base, DimX, DimY [, numfig]');
end;

% affichage :
if nargin == 4
    figure;
else
    figure(numfig);
end;

[DimEx ExNbr] = size(Base);

if DimX*DimY ~= DimEx
   error('[SHOWIMGBASE] dimension des images non concordante avec DimX et DimY)');
end;

Max = max(max(Base));
Min = min(min(Base));
dynamique = Max-Min;
Base = (Base - Min)*255/dynamique;
Base = fix(Base);

Map = gray(255);
colormap(Map);

for i=1:ExNbr
    Img = reshape(Base(:,i),DimX,DimY);
    image(Img);
    title(['Classe image ' num2str(Labels(i))]);
    pause;
end;

       