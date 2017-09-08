function s = sumnsqr(a)
%
%
% SUMNSQR
%
% SYNTAXE :
%
%  s = SUMNSQR(a)
%
% Norme au carré normalisée du vecteur a. Utilisé par les algorithmes
% d'apprentissage des réseaux MLP pour calculer l'erreur quadratique   
%
%
% ARGUMENTS :
%
% a  : le vecteur ou la matrice de vecteurs
%
% VALEURS DE RETOUR :
%
% s  : norme au carré nortmalisée de a ou des vecteurs composant a
%
%
% VOIR AUSSI :
%
%  mlpXXtrain  
%
% COMPATIBILITE : 
%   >= matlab 5.1
%

% Bruno Gas - ISIR/UPMC Bruno.Gas@upmc.fr
% Création : janvier 2013
% version : 1.0
% Derniere révision : -

nex = size(a, 2);
dimex = size(a, 1);
s = sum(sum(a.*a))/nex/dimex;
