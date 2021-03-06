function [W1,B1,W2,B2,L,LR,HLayer] = mlp2atrain(Base, Target, W1, B1, W2, B2, lr, n, err_glob, freqplot);
%
% MLP2ATRAIN
%
% SYNTAXE :
%
% [W1,B1,W2,B2,L,LR,HLAYER]=mlp2atrain(Base, Target, W1, B1, W2, B2 [, lr, n, err_glob] [, freqplot]);
%
% Apprentissage des poids d'un Percepteron MultiCouche par
% l'algorithme de r�tropropagation (gradient total) et pas
% d'apprentissage adaptatif.
%
% ARGUMENTS :
%
% Base   		: matrice des �chantillons de la base d'apprentissage
% Target 		: matrice des vecteurs sorties d�sir�es
% W1, B1 		: poids et seuils de la premi�re couche
% W2, B2 		: poids et seuils de la deuxi�me couche
% lr     		: [optionnel] vecteur pas d'apprentissage adaptatif :
%					 		lr = [lr0 lr_dec, lr_inc, delta]
%          		lr0    : pas d'apprentissage initial
%          		lr_dec : valeur d'incr�ment du pas
%          		lr_inc : valeur de d�cr�ment du pas
%          		err_ratio : seuil de d�clenchement du d�cr�ment
%
% n      		: [optionnel] nombre maximum d'it�rations d'apprentissage
% err_glob 		: [optionnel] crit�re d'arret - seuil erreur quadratique minimum
% freqplot		: [optionnel] fr�quence d'affichage, par d�faut : pas d'affichage
%
%
% VALEURS DE RETOUR :
%
% W1, B1, W2, B2 	: les poids calcul�s � l'issue de l'apprentissage
% L              	: co�t quadratique
% LR					: valeurs du pas adaptatif
% HLayer          : la matrice des sorties des cellules de la couche cach�e
%                  pour tous les exemples
%
% DESCRIPTION :
%
% L'argument 'freqplot' est optionnel : s'il n'est pas donn�, il n'y a pas
% d'affichage. S'il est donn�, sa valeur donne le fr�quence d'affichage
% de l'erreur quadratique et du pas adaptatif.
% Les arguments lr, n, et err_glob sont �galement optionnels en bloc. S'ils ne sont
% pas donn�s, la fonction interroge l'utilisateur (interface graphique avec uimlp2atrain).
%
% COMPATIBILITE :
%
%  Matlab 5.3+
%

% Bruno Gas - LIS/P&C UPMC
% Cr�ation : d�cembre 1999
% Version : 1.6
% Derniere r�vision : 
% - B.Gas (octobre 2000) : freqplot, GUI
% - B.Gas (26/10/2000) : semilogy
% - B.Gas (27/11/2000) : correction init. du pas
% - B.Gas (10/02/2001) : help et mise � jour tbx RdF
% - B.Gas (7/5/2001)   : modifs. mineures
% - B.Gas (15/10/2004) : ajout retour �tat des cell. cach�es


% Algorithme :
%
%	Wtmp <- W
%	calculer l'erreur de sortie avec W
%	calculer L
%
% a:  si k>1
%		  	si L < err_glob ,
%					sortir
%			fin si
%		 	si L(k) > TL*err_ratio
%			 		d�cr�menter lr
%			 		W <- Wtmp;
%		 			W <- W + lr*modif
%	     	sinon	
%					si L(k) < TL
%	  	 				incr�menter lr		
%     			fin si
%					Wtmp <- W
%   				r�tropropager sur W (calculer modif)
%		 			W <- W + lr*modif
%					TL <- L(k)
%   		fin si
%     sinon
%   		r�tropropager sur W (calculer modif)
%	      Wtmp <- W
%			W <- W + lr*modif
% 	    	TL <- L(k)
%    	fin si
%
% 		calculer l'erreur de sortie  avec W
% 		calculer L
% 		aller en a:
%


% controle des arguments :
%-------------------------

if (nargin<9 || nargin>10) && nargin~=6 && nargin ~=7
   error('[MLP2ATRAIN] Usage : [W1,B1,W2,B2,L,LR] = mlp2atrain(Base, Target, W1, B1, W2, B2 [, lr, n, err_glob] [, freqplot])');
end;

if nargin==6 || nargin==9, graph_mode = 0; freqplot = n+1;	% pas d'affichage par d�faut
else graph_mode = 1;
   if nargin==7, freqplot = lr; end;                        % arg N. 7 = freq. d'affichage   
end;

if nargin<9
   disp('MLP2ATRAIN : Param�tres de l''apprentissage');
   n         = input('Nombre d''it�rations d''apprentissage (1000) = ');
   err_glob  = input('Erreur minimale (crit�re d''arr�t) (0.001) = ');
   lr0       = input('Pas initial d''apprentissage (1) = ');
   lr_dec    = input('D�cr�ment du pas (0.9) = ');
   lr_inc    = input('Incr�ment du pas (1.1) = ');
   err_ratio = input('Plage de stabilit� du pas (1) = ');
      
   lr = [lr0 lr_dec, lr_inc, err_ratio];
elseif length(lr) ~= 4
   error('[MLP2ATRAIN] Arguments <lr> incorrecte (lr=[lr0, lr_dec, lr_inc, delta]'); 
end;

% Initialisation graphique :
%---------------------------
if graph_mode==1, clf; hold off;	end;


% nb. total d'exemples � apprendre :
%---------------------------------------
[input_nbr ex_nbr] = size(Base);


% --- coh�rence des arguments :
[n_cell n_in] = size(W1);
[output_nbr n_ex] = size(Target);

if input_nbr~=n_in
  error('[MLP2ATRAIN] D�faut de coh�rence dans les arguments : W1 et Data'); end;
if size(B1)~=[n_cell 1]
  error('[MLP2ATRAIN] D�faut de coh�rence dans les arguments : W1 et B1'); end;
if size(W2)~=[output_nbr n_cell]
  error('[MLP2ATRAIN] D�faut de coh�rence dans les arguments : W2 et Class'); end;
if size(B2)~=[output_nbr 1]
  error('[MLP2ATRAIN] D�faut de coh�rence dans les arguments : W2 et B2'); end;



% pas adaptatif :
%----------------
lr0 = lr(1);				% valeur initiale du pas
lr_dec = lr(2);			% d�cr�ment du pas
lr_inc = lr(3);			% incr�ment du pas
err_ratio = lr(4);		% seuil de d�clenchement du d�cr�ment

% --- fonction cout quadratique :
L = zeros(1,n);
MaxL = ex_nbr*output_nbr;

% Normalisations :
%-----------------
lr0 =lr0/MaxL;

% --- initialisation du pas :
lr = lr0;					
LR = zeros(1,n);

% --- Erreur en sortie :

V1 = W1*Base+B1*ones(1,ex_nbr);
S1 = sigmo(V1);

V2 = W2*S1+B2*ones(1,ex_nbr);
S2 = sigmo(V2);
%S2 = V2;

E = Target - S2;


% --- boucle d'apprentissage :
for it=1:n

% --- Cout quadratique :	
	L(it) = sumsqr(E)/MaxL;
	LR(it) = lr;
   
% --- Affichage erreur et pas adaptatif :
	if rem(it,freqplot)==0   	   
    	   subplot(211);
	   semilogy(0:it-1, L(1:it));
	   grid;
   	xlabel('It�rations d''apprentissage');
	   ylabel('Erreur quadratique');
   	title('MLP 2 couches : Co�t quadratique');
	   subplot(212);
   	semilogy(0:it-1, LR(1:it));
        grid;
	   xlabel('It�rations d''apprentissage');
   	ylabel('Valeur du pas adaptatif');   

		drawnow;
	end;

% --- Crit�re d'arret :
	if err_glob~=0 && L(it) <= err_glob
		L = L(1:it);
		LR = LR(1:it);
		return;
	end;	


% --- Adaptation du pas d'apprentissage :
  if it>1

 		if L(it) > TL*err_ratio

% --- Fonction Co�t croissante au dela du seuil :

% --- R�cup�ration des poids :
			W1 = TW1; B1 = TB1; W2 = TW2; B2 = TB2;

% --- d�cr�mentation du pas et modif. des poids :
			lr = lr*lr_dec;

			W1 = W1 - lr*D1;
	 		B1 = B1 - lr*Delta1*ones(ex_nbr,1);
		  	W2 = W2 - lr*D2;
		 	B2 = B2 - lr*Delta2*ones(ex_nbr,1);
	
   	else

% --- Fonction Co�t d�croissante :
			if L(it) < TL	

% --- incr�mentation du lr :
				lr = lr*lr_inc;
	  		end

% --- r�tropropagation :
			Delta2 = -2*E.*sigmop(V2);
%			Delta2 = -2*E;

            D2 = Delta2*S1';

			Delta1 = (W2'*Delta2).*sigmop(V1);
			D1 = Delta1*Base';

% --- Sauvegarde des poids courants et modif. des poids :
			TW1 = W1; TB1 = B1; TW2 = W2; TB2 = B2;
			TL = L(it);

	  		W1 = W1 - lr*D1;
		 	B1 = B1 - lr*Delta1*ones(ex_nbr,1);
		  	W2 = W2 - lr*D2;
	 		B2 = B2 - lr*Delta2*ones(ex_nbr,1);
		end
	else

% --- 1ere it�ration : pas de modification du lr :

% --- r�tropropagation :
		Delta2 = -2*E.*sigmop(V2);
%		Delta2 = -2*E;
		D2 = Delta2*S1';

		Delta1 = (W2'*Delta2).*sigmop(V1);
		D1 = Delta1*Base';

% --- Sauvegarde des poids courants :
		TW1 = W1; TB1 = B1; TW2 = W2; TB2 = B2;
		TL = L(it);

% --- Modif. des poids :
	  	W1 = W1 - lr*D1;
	 	B1 = B1 - lr*Delta1*ones(ex_nbr,1);
	  	W2 = W2 - lr*D2;
	 	B2 = B2 - lr*Delta2*ones(ex_nbr,1);

	end

% --- erreur en sortie :
	V1 = W1*Base+B1*ones(1,ex_nbr);
	S1 = sigmo(V1);

	V2 = W2*S1+B2*ones(1,ex_nbr);
%	S2 = V2;
	S2 = sigmo(V2);

	E = Target - S2;			

end; %it


% D�normalisation :
%------------------
LR = LR*MaxL;

%Sortie couche cach�e :
if nargout==7
	V1 = W1*Base+B1*ones(1,ex_nbr);
	HLayer = sigmo(V1);
end;


