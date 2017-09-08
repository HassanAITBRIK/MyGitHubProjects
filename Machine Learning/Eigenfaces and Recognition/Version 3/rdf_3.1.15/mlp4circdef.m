function [W1, B1, W2, B2, WC2, BC2, W3, B3, W4, B4, InputNbr, H1cellNbr, H2cellNbr, H2circcellNbr, H3cellNbr, OutputNbr] = mlp4circdef (InputNbr, H1cellNbr, H2cellNbr, H2circcellNbr, H3cellNbr, OutputNbr, seed)

% usage: [W1, B1, W2, B2, WC2, BC2, W3, B3, W4, B4 [, InputNbr, H1cellNbr, H2cellNbr, H2circcellNbr, H3cellNbr, OutputNbr]] 
%               = mlp4circdef ([InputNbr, H1cellNbr, H2cellNbr, H2circcellNbr, H3cellNbr,
%               OutputNbr] [, seed])
%
% D�finition de la structure d'un r�seau MLP � 4 couches (3 couches cach�es) et neurones circulaires.
%
% MLP4CIRCDEF permet de d�finir la structure d'un r�seau de neurones
% MLP � quatre couches cach�es (Multi Layer Perceptron) en fonction des
% param�tres souhait�s : nombre d''entr�es, de cellules cach�es et
% nombre de sorties. La couche cach�e centrale (couche 2) peut �galement
% comporter des cellules circulaires.
% Les poids sont g�n�r�s avec des valeurs al�atoires.
%
%
% ARGUMENTS : [requis mais optionnels]
%
% InputNbr 	= nombre d'entr�es
% H1cellNbr  = nombre de cellules sur la premiere couche cach�e
% H2cellNbr  = nombre de cellules sur la deuxi�me couche cach�e
% H2circcellNbr  = nombre de cellules circulaires sur la deuxi�me couche cach�e
% H3cellNbr  = nombre de cellules sur la troisi�me couche cach�e
% OutputNbr = nombre de sorties
%
% ARGUMENTS : [optionnels]
% seed      = valeur d'initialisation du g�n�rateur al�atoire
%
% VALEURS DE RETOUR :
%
% W1      	: matrice des poids premi�re couche
% B1      	: vecteur des seuils premi�re couche
% W2      	: matrice des poids deuxi�me couche
% B2      	: vecteur des seuils deuxi�me couche
% WC2      	: matrice des poids des neurones circulaires deuxi�me couche
% BC2      	: vecteur des seuils des neurones circulaires deuxi�me couche
% W3      	: matrice des poids troisi�me couche
% B3      	: vecteur des seuils troisi�me couche
% W4      	: matrice des poids quatri�me couche
% B4      	: vecteur des seuils quatri�me couche
%
% VALEURS DE RETOUR [optionnelles] :
%
% InputNbr 	= nombre d'entr�es
% H1cellNbr  = nombre de cellules sur la premi�re couche cach�e
% H2cellNbr  = nombre de cellules sur la deuxi�me couche cach�e
% H2circcellNbr  = nombre de cellules circulaires sur la deuxi�me couche cach�e
% H3cellNbr  = nombre de cellules sur la troisi�me couche cach�e
% OutputNbr = nombre de sorties
%
% DESCRIPTION :
%
%
% Lorsqu'aucun argument n'est sp�cifi� ou que seul l'argument 'seed' l'est,
% l'utilisateur est sollicit� par la fonction pour donner les arguments
% optionnels mais requis.
% Les matrices de poids sont initialis�es al�atoirement. Si l'argument 'seed'
% est donn�, le g�n�rateur al�atoire est r�initialis� � cette valeur, sinon
% il n'est r�initialis�.
% MLP4CIRCDEF utilise la fonction RANDWEIGHTS pour g�n�rer les poids.
%
% VOIR AUSSI :
%
% RANDWEIGHTS MLP4CIRCATRAIN  MLP4CIRCRUN
%

% MLP4CIRCDEF
% Bruno Gas - ISIR UPMC <Bruno.Gas@upmc.fr>
% Cr�ation : janvier 2013
% Version : 1.0
% Dernieres r�visions : 
%


% controle des arguments :

if nargin==5 || nargin >7
   error('[MLP4CIRCDEF] Usage : [W1, B1, W2, B2, WC2, BC2, W3, B3, W4, B4] = mlp4def ([InputNbr, H1cellNbr, H2cellNbr, H2circcellNbr, H3cellNbr, OutputNbr] [, seed]);');   
end;

if nargin==1, seed = InputNbr;
elseif nargin==0 || nargin==6, seed = -1; end;

if nargin==0 || nargin==1
   disp('Architecture du r�seau MLP 4 couches : ');
   InputNbr  = input('Nombre d''entr�es du r�seau = ');
   H1cellNbr  = input('Nombre de cellules de la premi�re couche cach�e = ');
   H2cellNbr  = input('Nombre de cellules de la deuxi�me couche cach�e = ');
   H2circcellNbr  = input('Nombre de cellules circulaires de la deuxi�me couche cach�e = ');
   H3cellNbr  = input('Nombre de cellules de la troisi�me couche cach�e = ');
   OutputNbr = input('Nombre de sorties = ');
end;

if H2circcellNbr==0 && H2cellNbr==0
  error('[MLP4CIRCDEF] Pas de cellules circulaires ni de cellules lin�aires dans la deuxi�me couche du r�seau.' );
end;    

if seed==-1	
	[W1,B1] = randweights(H1cellNbr,InputNbr);
	[W2,B2] = randweights(H2cellNbr,H1cellNbr);	
	[WC2,BC2] = randweights(2*H2circcellNbr,H1cellNbr);	
	[W3,B3] = randweights(H3cellNbr,H2cellNbr+2*H2circcellNbr);	    
	[W4,B4] = randweights(OutputNbr,H3cellNbr);	    
else
    [W1,B1] = randweights(H1cellNbr,InputNbr,seed);
	[W2,B2] = randweights(H2cellNbr,H1cellNbr);	   
	[WC2,BC2] = randweights(2*H2circcellNbr,H1cellNbr);	
    [W3,B3] = randweights(H3cellNbr,H2cellNbr+2*H2circcellNbr);	   
    [W4,B4] = randweights(OutputNbr,H3cellNbr);	   
end;
	
disp(['Classifieur MLP 4 couches g�n�r� : [' num2str(InputNbr) ' x ' num2str(H1cellNbr) ' x (' num2str(H2cellNbr) '+' num2str(H2circcellNbr) ') x ' num2str(H3cellNbr) ' x ' num2str(OutputNbr) ']']);	

