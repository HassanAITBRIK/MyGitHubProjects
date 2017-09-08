function s = sumnsqr(a)
%
%
% SUMNSQR
%
% SYNTAXE :
%
%  s = SUMNSQR(a)
%
% Norme au carr� normalis�e du vecteur a. Utilis� par les algorithmes
% d'apprentissage des r�seaux MLP pour calculer l'erreur quadratique   
%
%
% ARGUMENTS :
%
% a  : le vecteur ou la matrice de vecteurs
%
% VALEURS DE RETOUR :
%
% s  : norme au carr� nortmalis�e de a ou des vecteurs composant a
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
% Cr�ation : janvier 2013
% version : 1.0
% Derniere r�vision : -

nex = size(a, 2);
dimex = size(a, 1);
s = sum(sum(a.*a))/nex/dimex;
