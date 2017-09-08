function [W1, B1, W2, B2, W3, B3, W4, B4, InputNbr, H1cellNbr, H2cellNbr, H3cellNbr, OutputNbr] = mlp4def (InputNbr, H1cellNbr, H2cellNbr, H3cellNbr, OutputNbr, seed)

% usage: [W1, B1, W2, B2, W3, B3, W4, B4 [, InputNbr, H1cellNbr, H2cellNbr, H3cellNbr, OutputNbr]] 
%               = mlp3def ([InputNbr, H1cellNbr, H2cellNbr, H3cellNbr, OutputNbr] [, seed])
%
% Définition de la structure d'un réseau MLP 4 couches (3 couches cachées).
%
% MLP4DEF permet de définir la structure d'un réseau de neurones
% MLP à quatre couches cachées (Multi Layer Perceptron) en fonction des
% paramètres souhaités : nombre d''entrées, de cellules cachées et
% nombre de sorties.
% Les poids sont générés avec des valeurs aléatoires.
%
%
% ARGUMENTS : [requis mais optionnels]
%
% InputNbr 	= nombre d'entrées
% H1cellNbr  = nombre de cellules sur la premiere couche cachée
% H2cellNbr  = nombre de cellules sur la deuxième couche cachée
% H3cellNbr  = nombre de cellules sur la troisième couche cachée
% OutputNbr = nombre de sorties
%
% ARGUMENTS : [optionnels]
% seed      = valeur d'initialisation du générateur aléatoire
%
% VALEURS DE RETOUR :
%
% W1      	: matrice des poids première couche
% B1      	: vecteur des seuils première couche
% W2      	: matrice des poids deuxième couche
% B2      	: vecteur des seuils deuxième couche
% W3      	: matrice des poids troisième couche
% B3      	: vecteur des seuils troisième couche
% W4      	: matrice des poids quatrième couche
% B4      	: vecteur des seuils quatrième couche
%
% VALEURS DE RETOUR [optionnelles] :
%
% InputNbr 	= nombre d'entrées
% H1cellNbr  = nombre de cellules sur la première couche cachée
% H2cellNbr  = nombre de cellules sur la deuxième couche cachée
% H3cellNbr  = nombre de cellules sur la troisième couche cachée
% OutputNbr = nombre de sorties
%
% DESCRIPTION :
%
%
% Lorsqu'aucun argument n'est spécifié ou que seul l'argument 'seed' l'est,
% l'utilisateur est sollicité par la fonction pour donner les arguments
% optionnels mais requis.
% Les matrices de poids sont initialisées aléatoirement. Si l'argument 'seed'
% est donné, le générateur aléatoire est réinitialisé à cette valeur, sinon
% il n'est réinitialisé.
% MLP4DEF utilise la fonction RANDWEIGHTS pour générer les poids.
%
% VOIR AUSSI :
%
% RANDWEIGHTS MLP4ATRAIN  MLP4RUN
%


% MLP4DEF
% Bruno Gas - ISIR UPMC <Bruno.Gas@upmc.fr>
% Création : janvier 2013
% Version : 1.0
% Dernieres révisions : 
%


% controle des arguments :

if nargin==4 || nargin >6
   error('[MLP4DEF] Usage : [W1, B1, W2, B2, W3, B3, W4, B4] = mlp4def ([InputNbr, H1cellNbr, H2cellNbr, H3cellNbr, OutputNbr] [, seed]);');   
end;

if nargin==1, seed = InputNbr;
elseif nargin==0 || nargin==5, seed = -1; end;

if nargin==0 || nargin==1
   disp('Architecture du réseau MLP 4 couches : ');
   InputNbr  = input('Nombre d''entrées du réseau = ');
   H1cellNbr  = input('Nombre de cellules de la première couche cachée = ');
   H2cellNbr  = input('Nombre de cellules de la deuxième couche cachée = ');
   H3cellNbr  = input('Nombre de cellules de la troisième couche cachée = ');
   OutputNbr = input('Nombre de sorties = ');
end;

if seed==-1	
	[W1,B1] = randweights(H1cellNbr,InputNbr);
	[W2,B2] = randweights(H2cellNbr,H1cellNbr);	
	[W3,B3] = randweights(H3cellNbr,H2cellNbr);	    
	[W4,B4] = randweights(OutputNbr,H3cellNbr);	    
else
    [W1,B1] = randweights(H1cellNbr,InputNbr,seed);
	[W2,B2] = randweights(H2cellNbr,H1cellNbr);	   
    [W3,B3] = randweights(H3cellNbr,H2cellNbr);	   
    [W4,B4] = randweights(OutputNbr,H3cellNbr);	   
end;
	
disp(['Classifieur MLP 4 couches généré : [' num2str(InputNbr) ' x ' num2str(H1cellNbr) ' x ' num2str(H2cellNbr) ' x ' num2str(H3cellNbr) ' x ' num2str(OutputNbr) ']']);	

