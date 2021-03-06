function Output = mlp4run(Input,W1,B1,W2,B2,W3,B3,W4,B4)
%
% SYNTAXE :
%
% Output = mlp4run(Input,W1,B1,W2,B2,W3,B3,W4,B4);
%
%
% ARGUMENTS :
%
% Input = matrice des exemples � tester (ex_size X ex_nbr)
% W1,B1 = poids et biais de la premi�re couche cach�e
% W2,B2 = poids et biais de la deuxi�me couche cach�e
% W3,B3 = poids et biais de la troisi�me couche cach�e
% W4,B4 = poids et biais couche de sortie
%
% MLP4RUN calcule les sorties d'un r�seau de neurones pour chacun des
% exemples dans 'Input'.
% Les exemples sont rang�s en colonnes.
%
%
% VALEURS DE RETOUR :
%
% Output   : le vecteur des sorties du r�seau.
%
%
% Voir aussi MLP4DEF MLP4ATRAIN MLPCLASS
%

% MLP4RUN
% Bruno Gas - ISIR UPMC <Bruno.Gas@upmc.fr>
% Cr�ation : janvier 2013
% Version 1.0
% Derniere r�vision : -

% nb. total d'exemples � tester :
[input_nbr ex_nbr] = size(Input);

[n1_cell n_in] = size(W1); 
if input_nbr~=n_in
  error('[MLP4RUN] D�faut de coh�rence dans les arguments : W1 et Input');
end;
if size(B1)~=[n1_cell 1]
  error('[MLP4RUN] D�faut de coh�rence dans les arguments : W1 et B1');
end;
[n2_cell ans] = size(W2);
if ans~=n1_cell
  error('[MLP4RUN] D�faut de coh�rence dans les arguments : W2 et W1');
end;
if size(B2)~=[n2_cell 1]
  error('[MLP4RUN] D�faut de coh�rence dans les arguments : W2 et B2');
end; 
[n3_cell ans] = size(W3);
if ans~=n2_cell
  error('[MLP4RUN] D�faut de coh�rence dans les arguments : W3 et W2');
end;
if size(B3)~=[n3_cell 1]
  error('[MLP4RUN] D�faut de coh�rence dans les arguments : W3 et B3');
end;
[n_out ans] = size(W4);
if ans~=n3_cell
  error('[MLP4RUN] D�faut de coh�rence dans les arguments : W4 et W3');
end; 
if size(B4)~=[n_out 1]
  error('[MLP4RUN] D�faut de coh�rence dans les arguments : W4 et B4');
end; 


%Sortie premi�re couche cach�e :
  V1 = W1*Input+B1*ones(1,ex_nbr);
  S1 = sigmo(V1);

%Sortie deuxi�me couche cach�e :
  V2 = W2*S1+B2*ones(1,ex_nbr);
  S2 = sigmo(V2);
  
%Sortie troisi�me couche cach�e :
  V3 = W3*S2+B3*ones(1,ex_nbr);
  S3 = sigmo(V3);  
  
%Sortie couche de sortie : 
  V4 = W4*S3+B4*ones(1,ex_nbr); 
  Output = sigmo(V4);




