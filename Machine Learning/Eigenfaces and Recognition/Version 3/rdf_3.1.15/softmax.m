function S = softmax(V)
%
% SYNTAXE :
%
% S = SOFTMAX(V)
%
% Fonction sigmo�de logique � sorties probabilit�s.
% Fonction de transition utilis�e dans les r�seaux
% de neurones dont les sorties sont interpr�t�es comme
% les probabilit�s conditionnelles (relativement � l'entr�e)
% � post�riori, d'appartenance � une classe.
% 
%
% ARGUMENTS :
%
% V 	: vecteur des potentiels des cellules de sortie du r�seau.
%         Si V est une matrice, le calcul est fait par colonnes, consid�rant 
%         que chaque colonne correspond � un exemple � classer.
%         Si V est une matrice ligne, le r�seau ne comporte qu'une seule
%         sortie, donc une seule classe, et la probabilit� en sortie est toujour � 1 (!)
%
% VALEURS DE RETOUR :
%
% S   : valeur de la fonction sigmo�de logique probabiliste en V dans [0,+1] 
%        
%
% COMPATIBILITE :
%
%    Matlab 4.3+, Octave 2.x+ 
%
% VOIR AUSSI :
%
%    softmaxp,  sigmobl, sigmoblp,  sigmo,  sigmop
% 

% SOFTMAX
% Cr�ation : Bruno Gas (15 mars 2001) 
% Version : 1.0
% Derniere r�vision : - 
    
ind = find(V>500);
if length(ind)>0, V(ind) = 500; end;

x = exp(V);
y = sum(x);

[l ans] = size(V); 
S = x./(ones(l,1)*y);


