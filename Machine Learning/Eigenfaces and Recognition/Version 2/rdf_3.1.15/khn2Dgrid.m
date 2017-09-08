function khn2Dgrid(Base, labels, Centres, DimX, DimY, numfig)
%
% KHN2DGRID
%
% SYNTAXE :
%
% KHN2DGRID(Base, labels, centres, DimX, DimY [,numfig]);
%
% Affiche une base de prototypes 2D et la grille des centres d'une carte 2D 
% Le voisinage sur la carte est supposé défini rectangulaire
%
% ARGUMENTS :
%
% Base       : la base des protoptypes (rangés en ligne, sans les labels)
% labels     : vecteur ligne des labels des prototypes
% Centres    : centres rangés en colonnes sans labels
% DimX, DimY : dimensions de la carte
% numfig     : [optionnel] numéro de la figure à utiliser
%
% VALEURS DE RETOUR :
%
%
%
% VOIR AUSSI :
%
%   KHN2DEF KHN2TRAIN KHN2RUN KHNCLASS
% 

% KHN2DGRID
% Bruno Gas - ISIR UPMC
% Création : 30/11/2011
% Version : 1.0
% Derniere révision : 
%

% controle des arguments :
if nargin ~= 5 && nargin ~= 6
   error('Usage : showcentres (Base, labels, Centres, DimX, DimY, [, numfig])');
end;

ClassNbr = max(labels);
[DimEx ExNbr] = size(Base);
[CentreNbr DimCentre] = size(Centres);

if (DimCentre ~= DimEx) 
   error('[SHOWCENTRES] incohérence des dimensions des centres et de la base)');
end;

% affichage :
if nargin == 5
    figure;
else
    figure(numfig);
end;

hold on;
coul = ['rbgymck'];

% affichage données: 
for cl=1:ClassNbr
   ind = find(labels==cl);
   DataTstX = Base(1,ind);
   DataTstY = Base(2,ind);
   plot(DataTstX, DataTstY, [coul(cl) '+']);
end;

% placement des centres :
for ct=1:CentreNbr
   plot(Centres(:,1), Centres(:,2), 'ko');
end;

CoordX = Centres(:,1);
CoordY = Centres(:,2);

% table des indices :
Table = 1:CentreNbr;
Table = reshape(Table, DimX, DimY)';

for j=1:DimY-1
   for i=1:DimX-1
       plot( CoordX(Table(i,j)), CoordY(Table(i,j)), 'o');
       plot( [CoordX(Table(i,j)) CoordX(Table(i+1,j))], [CoordY(Table(i,j)) CoordY(Table(i+1,j))] );
       plot( [CoordX(Table(i,j)) CoordX(Table(i,j+1))], [CoordY(Table(i,j)) CoordY(Table(i,j+1))] );
   end;  
   plot( CoordX(Table(DimX,j)), CoordY(Table(DimX,j)), 'o');
   plot( [CoordX(Table(DimX,j)) CoordX(Table(DimX,j+1))], [CoordY(Table(DimX,j)) CoordY(Table(DimX,j+1))] );

end;
for i=1:DimX-1 
    plot( CoordX(Table(i,DimY)), CoordY(Table(i,DimY)), 'o');
    plot( [CoordX(Table(i,DimY)) CoordX(Table(i+1,DimY))], [CoordY(Table(i,DimY)) CoordY(Table(i+1,DimY))] );
end;

title('Grille de Kohonen et prototypes 2D');
xlabel('Dimension X'); 
ylabel('Dimension Y');



