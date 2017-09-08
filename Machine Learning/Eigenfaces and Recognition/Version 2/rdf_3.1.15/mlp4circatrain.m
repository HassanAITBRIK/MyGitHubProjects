function [W1,B1,W2,B2,WC2,BC2,W3,B3,W4,B4,L,LR,HLayer] = mlp4circatrain(Base, Target, W1, B1, W2, B2, WC2, BC2, W3, B3, W4, B4, lr, n, err_glob, freqplot)
%
% MLP4ATRAIN
%
% SYNTAXE :
%
% [W1,B1,W2,B2,WC2,BC2,W3,B3,W4,B4,L,LR,HLayer]=mlp4atrain(Base, Target, W1, B1, W2, B2, WC2, BC2, W3, B3, W4, B4 [, lr, n, err_glob] [, freqplot]);
%
% Apprentissage des poids d'un Perceptron MultiCouche à cellules circulaires par
% l'algorithme de rétropropagation (gradient total) et pas
% d'apprentissage adaptatif.
%
% ARGUMENTS :
%
% Base   		: matrice des échantillons de la base d'apprentissage
% Target 		: matrice des vecteurs sorties désirées
% W1, B1 		: poids et seuils de la première couche
% W2, B2 		: poids et seuils de la deuxième couche
% WC2, BC2 		: poids et seuils des neurones circulaires de la deuxième couche
% W3, B3 		: poids et seuils de la troisième couche
% W4, B4 		: poids et seuils de la quatrième couche
% lr     		: [optionnel] vecteur pas d'apprentissage adaptatif :
%					 		lr = [lr0 lr_dec, lr_inc, delta]
%          		lr0    : pas d'apprentissage initial
%          		lr_dec : valeur d'incrément du pas
%          		lr_inc : valeur de décrément du pas
%          		err_ratio : seuil de déclenchement du décrément
%
% n      		: [optionnel] nombre maximum d'itérations d'apprentissage
% err_glob 		: [optionnel] critère d'arret - seuil erreur quadratique minimum
% freqplot		: [optionnel] fréquence d'affichage, par défaut : pas d'affichage
%
%
% VALEURS DE RETOUR :
%
% W1,B1,...W4,B4    : les poids calculés à l'issue de l'apprentissage
% L              	: coût quadratique
% LR				: valeurs du pas adaptatif
% HLayer            : la matrice des sorties des cellules de la couche cachée
%                       médiane (2ème couche cachée) pour tous les exemples
%
% DESCRIPTION :
%
% L'argument 'freqplot' est optionnel : s'il n'est pas donné, il n'y a pas
% d'affichage. S'il est donné, sa valeur donne le fréquence d'affichage
% de l'erreur quadratique et du pas adaptatif.
% Les arguments lr, n, et err_glob sont également optionnels en bloc. S'ils ne sont
% pas donnés, la fonction interroge l'utilisateur (interface graphique avec uimlp3atrain).
%
% COMPATIBILITE :
%
%  Matlab 5.3+
%

% Bruno Gas - ISIR UPMC
% Création : janvier 2013
% Version : 1.0
% Derniere révision : 


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
%			 		décrémenter lr
%			 		W <- Wtmp;
%		 			W <- W + lr*modif
%	     	sinon	
%					si L(k) < TL
%	  	 				incrémenter lr		
%                   fin si
%					Wtmp <- W
%   				rétropropager sur W (calculer modif)
%		 			W <- W + lr*modif
%					TL <- L(k)
%   		fin si
%    sinon
%   		rétropropager sur W (calculer modif)
%           Wtmp <- W
%			W <- W + lr*modif
% 	    	TL <- L(k)
%    fin si
%
% 	calculer l'erreur de sortie  avec W
% 	calculer L
% 	aller en a:
%

%            for (i=1:2:n2_circcell)
%                circp(i,:) = (R2(i,:).^2 - VC2(i,:).^2)./(R2(i,:).^3);
%                
%                R2(i,:) = sqrt(VC2(i,:).^2 + VC2(i+1,:).^2); 
%                R2(i+1,:) = R2(i,:);
%            end;


% controle des arguments :
%-------------------------

if (nargin<15 || nargin>16) && nargin~=12 && nargin ~=13
   error('[MLP4CIRCATRAIN] Usage : [W1,B1,W2,B2,WC2,BC2,W3,B3,W4,B4,L,LR] = mlp4circatrain(Base, Target, W1, B1, W2, B2, WC2, BC2, W3, B3, W4, B4 [, lr, n, err_glob] [, freqplot])');
end;

if nargin==12 || nargin==15, graph_mode = 0; freqplot = n+1; % pas d'affichage par défaut
else graph_mode = 1;
   if nargin==13, freqplot = lr; end;                        % arg N. 13 = freq. d'affichage   
end;

if nargin<15
   disp('MLP4CIRCATRAIN : Paramètres de l''apprentissage');
   n         = input('Nombre d''itérations d''apprentissage (1000) = ');
   err_glob  = input('Erreur minimale (critère d''arrêt) (0.001) = ');
   lr0       = input('Pas initial d''apprentissage (1) = ');
   lr_dec    = input('Décrément du pas (0.9) = ');
   lr_inc    = input('Incrément du pas (1.1) = ');
   err_ratio = input('Plage de stabilité du pas (1) = ');
      
   lr = [lr0 lr_dec, lr_inc, err_ratio];
elseif length(lr) ~= 4
   error('[MLP4CIRCATRAIN] Arguments <lr> incorrecte (lr=[lr0, lr_dec, lr_inc, delta]'); 
end;

% Initialisation graphique :
%---------------------------
if graph_mode==1, clf; hold off;	end;


% nb. total d'exemples à apprendre :
%---------------------------------------
[input_nbr ex_nbr] = size(Base);


% --- cohérence des arguments :

[output_nbr ans] = size(Target);
if ans~=ex_nbr
  error(['[MLP4CIRCATRAIN] Défaut de cohérence dans les échantillons : ' num2str(ex_nbr) ' en entrée, ' num2str(ans) ' en sortie']); end;
[n1_cell ans] = size(W1);
if ans~=input_nbr
  error('[MLP4CIRCATRAIN] Défaut de cohérence dans les arguments : W1 et Data'); end;
if size(B1)~=n1_cell
  error('[MLP4CIRCATRAIN] Défaut de cohérence dans les arguments : W1 et B1'); end;
[n2_cell ans] = size(W2);
if ans~=n1_cell
  error('[MLP4CIRCATRAIN] Défaut de cohérence dans les arguments : W2 et W1');
end;
[n2_circcell ans] = size(WC2);
if ans~=n1_cell
  error('[MLP4CIRCATRAIN] Défaut de cohérence dans les arguments : WC2 et W1');
end;
if size(B2)~=n2_cell
  error('[MLP4CIRCATRAIN] Défaut de cohérence dans les arguments : W2 et B2');
end; 
if size(BC2)~=n2_circcell
  error('[MLP4CIRCATRAIN] Défaut de cohérence dans les arguments : WC2 et BC2');
end;
[n3_cell ans] = size(W3);
if ans~=n2_cell+n2_circcell
  error('[MLP4CIRCATRAIN] Défaut de cohérence dans les arguments : W3, W2 et WC2');
end;
if size(B3)~=[n3_cell 1]
  error('[MLP4CIRCATRAIN] Défaut de cohérence dans les arguments : W3 et B3');
end;
if size(W4)~=[output_nbr n3_cell]
  error('[MLP4CIRCATRAIN] Défaut de cohérence dans les arguments : W3, W4 et les cibles'); 
end;
if size(B4)~=output_nbr
  error('[MLP4CIRCATRAIN] Défaut de cohérence dans les arguments : W4 et les cibles'); 
end;
if size(WC2, 1)==0 && size(W2, 1)==0
  error('[MLP4CIRCATRAIN] Pas de cellules circulaires ni de cellules linéaires dans la deuxième couche du réseau.' );
end;


% pas adaptatif :
%----------------
lr0 = lr(1);			% valeur initiale du pas
lr_dec = lr(2);			% décrément du pas
lr_inc = lr(3);			% incrément du pas
err_ratio = lr(4);		% seuil de déclenchement du décrément

% --- fonction cout quadratique :
L = zeros(1,n);
MaxL = ex_nbr*output_nbr;

% Normalisations :
%-----------------
lr0 =lr0/MaxL;

% --- initialisation du pas :
lr = lr0;					
LR = zeros(1,n);

R2 = zeros(n2_circcell, ex_nbr);
DeltaC2 = zeros(n2_circcell, ex_nbr);

% --- Erreur en sortie :

%Sortie première couche cachée :
V1 = W1*Base+B1*ones(1,ex_nbr);
S1 = sigmo(V1);

%Sortie deuxième couche cachée :
if n2_cell ~= 0
    V2 = W2*S1+B2*ones(1,ex_nbr);
    S2 = sigmo(V2);
end;
  
%Sortie deuxième couche cachée circulaire :
if n2_circcell ~= 0
    VC2 = WC2*S1+BC2*ones(1,ex_nbr);
    for i=1:2:n2_circcell
        R2(i,:) = sqrt(VC2(i,:).^2 + VC2(i+1,:).^2); 
        R2(i+1,:) = R2(i,:);
    end;
    SC2 = VC2./R2;
end;

%Sortie troisième couche cachée :
if n2_cell ~= 0 && n2_circcell ~= 0
    V3 = W3*[S2;SC2]+B3*ones(1,ex_nbr);
elseif n2_cell ~= 0
    V3 = W3*S2+B3*ones(1,ex_nbr);
else
    V3 = W3*SC2+B3*ones(1,ex_nbr);    
end;
S3 = sigmo(V3);  
  
%Sortie couche de sortie : 
V4 = W4*S3+B4*ones(1,ex_nbr); 
S4 = sigmo(V4);

E = Target - S4;

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
   	xlabel('Itérations d''apprentissage');
	   ylabel('Erreur quadratique');
   	title('MLP 2 couches : Coût quadratique');
	   subplot(212);
   	semilogy(0:it-1, LR(1:it));
        grid;
	   xlabel('Itérations d''apprentissage');
   	ylabel('Valeur du pas adaptatif');   

		drawnow;
	end;

% --- Critère d'arret :
	if err_glob~=0 && L(it) <= err_glob
		L = L(1:it);
		LR = LR(1:it);
		return;
	end;	


% --- Adaptation du pas d'apprentissage :
  if it>1

 		if L(it) > TL*err_ratio

% --- Fonction Coût croissante au dela du seuil :

% --- Récupération des poids :
			W1 = TW1; B1 = TB1;
            if n2_cell ~= 0
                W2 = TW2; B2 = TB2;
            end;
            if n2_circcell ~= 0
                WC2 = TWC2; BC2 = TBC2;
            end;            
            W3 = TW3; B3 = TB3; W4 = TW4; B4 = TB4;
            
% --- décrémentation du pas et modif. des poids :
			lr = lr*lr_dec;

			W1 = W1 - lr*D1;
	 		B1 = B1 - lr*Delta1*ones(ex_nbr,1);
            if n2_cell ~= 0
    		  	W2 = W2 - lr*D2;
        	 	B2 = B2 - lr*Delta2*ones(ex_nbr,1);
            end;
            if n2_circcell ~= 0
                WC2 = WC2 - lr*DC2;
                BC2 = BC2 - lr*DeltaC2*ones(ex_nbr,1);
            end;
		  	W3 = W3 - lr*D3;
		 	B3 = B3 - lr*Delta3*ones(ex_nbr,1);
		  	W4 = W4 - lr*D4;
		 	B4 = B4 - lr*Delta4*ones(ex_nbr,1);	            
        else

% --- Fonction Coût décroissante :
			if L(it) < TL

% --- incrémentation du lr :
				lr = lr*lr_inc;
	  		end

% --- rétropropagation :
			Delta4 = -2*E.*sigmop(V4);
%			Delta4 = -2*E;
            D4 = Delta4*S3';

			Delta3 = (W4'*Delta4).*sigmop(V3);
            if n2_cell ~= 0 && n2_circcell ~= 0
                D3 = Delta3*[S2; SC2]';
            elseif n2_cell ~= 0
                D3 = Delta3*S2';
            else
                D3 = Delta3*SC2';            
            end;

            if n2_cell ~= 0
                Delta2 = (W3(:,1:n2_cell)'*Delta3).*sigmop(V2);
                D2 = Delta2*S1';
            end;
           
            if n2_circcell ~= 0
                R2_3 = R2.^3;
                VC2_2 = VC2.^2;
                DeltaC2_buff = (W3(:, n2_cell+1:n2_cell+n2_circcell)'*Delta3);
                for i=1:2:n2_circcell
                    DeltaC2(i,:) = ( VC2_2(i+1,:)./R2_3(i,:) ) .* DeltaC2_buff(i,:) - ( (VC2(i,:).*VC2(i+1,:))./R2_3(i,:) ) .* DeltaC2_buff(i+1,:);
                    DeltaC2(i+1,:) = ( VC2_2(i,:)./R2_3(i,:) ) .* DeltaC2_buff(i+1,:) - ( (VC2(i,:).*VC2(i+1,:))./R2_3(i,:) ) .* DeltaC2_buff(i,:);
                end;
%                circp = (R2.^2 - VC2.^2)./(R2.^3);
%                DeltaC2 = (W3(:, n2_cell+1:n2_cell+n2_circcell)'*Delta3).*circp;
                DC2 = DeltaC2*S1';            
            end;
%            Delta1 = (W2'*Delta2).*sigmop(V1);
%            D1 = Delta1*Base';

            if n2_cell ~= 0 && n2_circcell ~= 0
                Delta1 = ([W2' WC2']*[Delta2;DeltaC2]).*sigmop(V1);
            elseif n2_cell ~= 0
                Delta1 = (W2'*Delta2).*sigmop(V1);
            else
                Delta1 = (WC2'*DeltaC2).*sigmop(V1);  
            end;
            D1 = Delta1*Base';        

% --- Sauvegarde des poids courants et modif. des poids :
			TW1 = W1; TB1 = B1;
            if n2_cell ~= 0
                TW2 = W2; TB2 = B2;
            end;
            if n2_circcell ~= 0
                TWC2 = WC2; TBC2 = BC2;
            end;            
            TW3 = W3; TB3 = B3; TW4 = W4; TB4 = B4;
            
			TL = L(it);

	  		W1 = W1 - lr*D1;
		 	B1 = B1 - lr*Delta1*ones(ex_nbr,1);
            if n2_cell ~= 0
    		  	W2 = W2 - lr*D2;
        	 	B2 = B2 - lr*Delta2*ones(ex_nbr,1);
            end;
            if n2_circcell ~= 0
                WC2 = WC2 - lr*DC2;
                BC2 = BC2 - lr*DeltaC2*ones(ex_nbr,1);
            end;
		  	W3 = W3 - lr*D3;
	 		B3 = B3 - lr*Delta3*ones(ex_nbr,1);    
		  	W4 = W4 - lr*D4;
	 		B4 = B4 - lr*Delta4*ones(ex_nbr,1);             
		end
	else

% --- 1ere itération : pas de modification du lr :

% --- rétropropagation :
		Delta4 = -2*E.*sigmop(V4);
%		Delta4 = -2*E;
        D4 = Delta4*S3';

		Delta3 = (W4'*Delta4).*sigmop(V3);
        if n2_cell ~= 0 && n2_circcell ~= 0
            D3 = Delta3*[S2; SC2]';
        elseif n2_cell ~= 0
            D3 = Delta3*S2';
        else
            D3 = Delta3*SC2';            
        end;

        if n2_cell ~= 0
            Delta2 = (W3(:,1:n2_cell)'*Delta3).*sigmop(V2);
            D2 = Delta2*S1';
        end;
           
        if n2_circcell ~= 0
            R2_3 = R2.^3;
            VC2_2 = VC2.^2;
            DeltaC2_buff = (W3(:, n2_cell+1:n2_cell+n2_circcell)'*Delta3);
            for i=1:2:n2_circcell
                DeltaC2(i,:) = ( VC2_2(i+1,:)./R2_3(i,:) ) .* DeltaC2_buff(i,:) - ( (VC2(i,:).*VC2(i+1,:))./R2_3(i,:) ) .* DeltaC2_buff(i+1,:);
                DeltaC2(i+1,:) = ( VC2_2(i,:)./R2_3(i,:) ) .* DeltaC2_buff(i+1,:) - ( (VC2(i,:).*VC2(i+1,:))./R2_3(i,:) ) .* DeltaC2_buff(i,:);
            end;
                          
%            circp = (R2.^2 - VC2.^2)./(R2.^3);
%            DeltaC2 = (W3(:, n2_cell+1:n2_cell+n2_circcell)'*Delta3).*circp;
            DC2 = DeltaC2*S1';            
        end;

        if n2_cell ~= 0 && n2_circcell ~= 0
            Delta1 = ([W2' WC2']*[Delta2;DeltaC2]).*sigmop(V1);
        elseif n2_cell ~= 0
            Delta1 = (W2'*Delta2).*sigmop(V1);
        else
            Delta1 = (WC2'*DeltaC2).*sigmop(V1);  
        end;
        D1 = Delta1*Base';            
                
% --- Sauvegarde des poids courants :
		TW1 = W1; TB1 = B1;
        if n2_cell ~= 0
            TW2 = W2; TB2 = B2;
        end;
        if n2_circcell ~= 0
            TWC2 = WC2; TBC2 = BC2;
        end;            
        TW3 = W3; TB3 = B3; TW4 = W4; TB4 = B4;

        TL = L(it);

% --- Modif. des poids :
	  	W1 = W1 - lr*D1;
	 	B1 = B1 - lr*Delta1*ones(ex_nbr,1);
        if n2_cell ~= 0
    		W2 = W2 - lr*D2;
         	B2 = B2 - lr*Delta2*ones(ex_nbr,1);
        end;
        if n2_circcell ~= 0
            WC2 = WC2 - lr*DC2;
            BC2 = BC2 - lr*DeltaC2*ones(ex_nbr,1);
        end;
		W3 = W3 - lr*D3;
	 	B3 = B3 - lr*Delta3*ones(ex_nbr,1);
		W4 = W4 - lr*D4;
	 	B4 = B4 - lr*Delta4*ones(ex_nbr,1);        
	end

% --- erreur en sortie :

    %Sortie première couche cachée :
    V1 = W1*Base+B1*ones(1,ex_nbr);
    S1 = sigmo(V1);

    %Sortie deuxième couche cachée :
    if n2_cell ~= 0
        V2 = W2*S1+B2*ones(1,ex_nbr);
        S2 = sigmo(V2);
    end;
  
    %Sortie deuxième couche cachée circulaire :
    if n2_circcell ~= 0
        VC2 = WC2*S1+BC2*ones(1,ex_nbr);
        for i=1:2:n2_circcell
            R2(i,:) = sqrt(VC2(i,:).^2 + VC2(i+1,:).^2); 
            R2(i+1,:) = R2(i,:);
        end;
        SC2 = VC2./R2;
    end;

    %Sortie troisième couche cachée :
    if n2_cell ~= 0 && n2_circcell ~= 0
        V3 = W3*[S2;SC2]+B3*ones(1,ex_nbr);
    elseif n2_cell ~= 0
        V3 = W3*S2+B3*ones(1,ex_nbr);
    else
        V3 = W3*SC2+B3*ones(1,ex_nbr);    
    end;
    S3 = sigmo(V3);  
  
    %Sortie couche de sortie : 
    V4 = W4*S3+B4*ones(1,ex_nbr); 
    S4 = sigmo(V4);

    E = Target - S4;
		
end; %it


% Dénormalisation :
%------------------
LR = LR*MaxL;

%Sortie couche cachée :
if nargout==13
    %Sortie première couche cachée :
    V1 = W1*Base+B1*ones(1,ex_nbr);
    S1 = sigmo(V1);

    %Sortie deuxième couche cachée :
    if n2_cell ~= 0
        V2 = W2*S1+B2*ones(1,ex_nbr);
        S2 = sigmo(V2);
    end;
  
    %Sortie deuxième couche cachée circulaire :
    if n2_circcell ~= 0
        VC2 = WC2*S1+BC2*ones(1,ex_nbr);
        for (i=1:2:n2_circcell)
            R2(i,:) = sqrt(VC2(i,:).^2 + VC2(i+1,:).^2); 
            R2(i+1,:) = R2(i,:);
        end;
        SC2 = VC2./R2;
    end;

    % sortie couche cachée:
    if n2_cell ~= 0 && n2_circcell ~= 0
        HLayer = [S2;SC2];
    elseif n2_cell ~= 0
        HLayer = S2;
    else
        HLayer = SC2;    
    end;
end;


