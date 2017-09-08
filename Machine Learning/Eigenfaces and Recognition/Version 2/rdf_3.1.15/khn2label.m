function LabelCentres = khn2label (Base, Labels, Centres)
%
% KHN2LABEL
% 
%   Labellisation d'une carte de Kohonen 2D  
% 
% SYNTAXE :
%
%  Labels = khn2label (Base, Labels, Centres)
%
% ARGUMENTS : 
%
%  Base 		: base d'apprentissage
%  Labels       : labels des exemples
%  Centres		: matrice des centres de la carte
%
% VALEURS DE RETOUR :
%
%  LabelCentres	: vecteur colonne des labels des centres. Si une cellule
%                   n'est pas labellisable, elle est étiquetée à 0 (rejet)
%
%
% VOIR AUSSI :
%
%  KHNCLASS  KHN2DEF  KHN2TRAIN  KHN1* 
%
%
% COMPATIBILITE : 
%
%  Matlab 5.3+

% KHN2LABEL
% Bruno Gas - ISIR/UPMC <bruno.Gas@upmc.fr>
% Création : 1er décembre 2011
% Version 1.0
% Dernieres révisions : 
%

% controle des arguments :
if nargin~=3, error('[KHN2LABEL] usage: LabelCentres = khn2run (Base, Labels, Centres)'); end;

[ExSize, ExNbr] = size(Base);       
[CentreNbr, InputNbr] = size(Centres);

if InputNbr~=ExSize
   error('[KHN2LABEL] Pbm. de dimension entre les arguments <Base> et <Centres>'); end;

Gagnants = khn2run(Base, Centres);
LabelCentres = zeros(CentreNbr, 1);
for c=1:CentreNbr
    cellules = find(Gagnants==c);
    if (length(cellules)==0)
        LabelCentres(c) = 0;
    else
        labels = Labels(cellules);
        LabelCentres(c) = mode(labels);
    end;
end;

