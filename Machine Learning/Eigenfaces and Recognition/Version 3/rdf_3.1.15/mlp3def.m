function [W1, B1, W2, B2, W3, B3, InputNbr, H1cellNbr, H2cellNbr, OutputNbr] = mlp3def (InputNbr, H1cellNbr, H2cellNbr, OutputNbr, seed)

% usage: [W1, B1, W2, B2, W3, B3 [, InputNbr, H1cellNbr, H2cellNbr, OutputNbr]] 
%               = mlp3def ([InputNbr, H1cellNbr, H2cellNbr, OutputNbr] [, seed])
%
% D�finition de la structure d'un r�seau MLP 3 couches (2 couches cach�es).
%
% MLP3DEF permet de d�finir la structure d'un r�seau de neurones
% MLP � trois couches cach�es (Multi Layer Perceptron) en fonction des
% param�tres souhait�s : nombre d''entr�es, de cellules cach�es et
% nombre de sorties.
% Les poids sont g�n�r�s avec des valeurs al�atoires.
%
%
% ARGUMENTS : [requis mais optionnels]
%
% InputNbr 	= nombre d'entr�es
% H1cellNbr  = nombre de cellules sur la premiere couche cach�e
% H2cellNbr  = nombre de cellules sur la deuxi�me couche cach�e
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
% W3      	: matrice des poids troisi�me couche
% B3      	: vecteur des seuils troisi�me couche
%
% VALEURS DE RETOUR [optionnelles] :
%
% InputNbr 	= nombre d'entr�es
% H1cellNbr  = nombre de cellules sur la premi�re couche cach�e
% H2cellNbr  = nombre de cellules sur la deuxi�me couche cach�e
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
% MLP3DEF utilise la fonction RANDWEIGHTS pour g�n�rer les poids.
%
% VOIR AUSSI :
%
% RANDWEIGHTS MLP3ATRAIN  MLP3RUN
%


% MLP3DEF
% Bruno Gas - ISIR UPMC <Bruno.Gas@upmc.fr>
% Cr�ation : d�cembre 2012
% Version : 1.0
% Dernieres r�visions : 
%


% controle des arguments :

if nargin==3 || nargin >5
   error('[MLP3DEF] Usage : [W1, B1, W2, B2, W3, B3] = mlp2def ([InputNbr, H1cellNbr, H2cellNbr, OutputNbr] [, seed]);');   
end;

if nargin==1, seed = InputNbr;
elseif nargin==0 || nargin==4, seed = -1; end;

if nargin==0 || nargin==1
   disp('Architecture du r�seau MLP 3 couches : ');
   InputNbr  = input('Nombre d''entr�es du r�seau = ');
   H1cellNbr  = input('Nombre de cellules de la premi�re couche cach�e = ');
   H2cellNbr  = input('Nombre de cellules de la deuxi�me couche cach�e = ');
   OutputNbr = input('Nombre de sorties = ');
end;

if seed==-1	
	[W1,B1] = randweights(H1cellNbr,InputNbr);
	[W2,B2] = randweights(H2cellNbr,H1cellNbr);	
	[W3,B3] = randweights(OutputNbr,H2cellNbr);	    
else
    [W1,B1] = randweights(H1cellNbr,InputNbr,seed);
	[W2,B2] = randweights(H2cellNbr,H1cellNbr);	   
    [W3,B3] = randweights(OutputNbr,H2cellNbr);	   
end;
	
disp(['Classifieur MLP 3 couches g�n�r� : [' num2str(InputNbr) ' x ' num2str(H1cellNbr) ' x ' num2str(H2cellNbr) ' x ' num2str(OutputNbr) ']']);	

