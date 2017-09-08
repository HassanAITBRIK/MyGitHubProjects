function Output = mlp3run(Input,W1,B1,W2,B2,W3,B3)
%
% SYNTAXE :
%
% Output = mlp3run(Input,W1,B1,W2,B2,W3,B3);
%
%
% ARGUMENTS :
%
% Input = matrice des exemples à tester (ex_size X ex_nbr)
% W1,B1 = poids et biais de la première couche cachée
% W2,B2 = poids et biais de la deuxième couche cachée
% W3,B3 = poids et biais couche de sortie
%
% MLP3RUN calcule les sorties d'un réseau de neurones pour chacun des
% exemples dans 'Input'.
% Les exemples sont rangés en colonnes.
%
%
% VALEURS DE RETOUR :
%
% Output   : le vecteur des sorties du réseau.
%
%
% Voir aussi MLP3DEF MLP3ATRAIN MLPCLASS
%

% MLP3RUN
% Bruno Gas - ISIR UPMC <Bruno.Gas@upmc.fr>
% Création : décembre 2012
% Version 1.0
% Derniere révision : -

% nb. total d'exemples à tester :
[input_nbr ex_nbr] = size(Input);

[n1_cell n_in] = size(W1); 
if input_nbr~=n_in
  error('[MLP3RUN] Défaut de cohérence dans les arguments : W1 et Input');
end;
if size(B1)~=[n1_cell 1]
  error('[MLP3RUN] Défaut de cohérence dans les arguments : W1 et B1');
end;
[n2_cell ans] = size(W2);
if ans~=n1_cell
  error('[MLP3RUN] Défaut de cohérence dans les arguments : W2 et W1');
end;
if size(B2)~=[n2_cell 1]
  error('[MLP3RUN] Défaut de cohérence dans les arguments : W2 et B2');
end; 
[n_out ans] = size(W3);
if ans~=n2_cell
  error('[MLP3RUN] Défaut de cohérence dans les arguments : W3 et W2');
end; 
if size(B3)~=[n_out 1]
  error('[MLP3RUN] Défaut de cohérence dans les arguments : W3 et B3');
end; 


%Sortie première couche cachée :
  V1 = W1*Input+B1*ones(1,ex_nbr);
  S1 = sigmo(V1);

%Sortie deuxième couche cachée :
  V2 = W2*S1+B2*ones(1,ex_nbr);
  S2 = sigmo(V2);
  
%Sortie couche de sortie : 
  V3 = W3*S2+B3*ones(1,ex_nbr); 
  Output = sigmo(V3);




