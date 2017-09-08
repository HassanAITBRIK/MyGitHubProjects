function Output = rotation3(Input,theta1, theta2, theta3)
%
% SYNTAXE :
%
% Output = rotation3(Input, theta1, theta2, theta3);
%
%
% ARGUMENTS :
%
% Input = matrice des échantillons 3D
% Theta1, theta2, theta3 = angles de rotations autour des axes x, y et z exprimés en radians 
%
% ROTATION3 réalise une rotation en trois dimensions des pôinst 3D donnés 
% en entrée. Les exemples sont rangés en colonnes.
%
% VALEURS DE RETOUR :
%
% Output   : les données après rotation.
%
%

% ROTATION3
% Bruno Gas - ISIR UPMC <Bruno.Gas@upmc.fr>
% Création : janvier 2013
% Version 1.0
% Derniere révision : -

% Ctrl:
if nargin~=4
   error('[ROTATION3] Usage : Output = rotation3(Input, theta1, theta2, theta3)');
end;

% nb. total d'exemples :
[dim ex_nbr] = size(Input);
if dim~=3
    error('[ROTATION3] Dimension incorrecte des échantillons');
end;

R = [1 0 0; 0 cos(theta1) -sin(theta1); 0 sin(theta1) cos(theta1)]...
    * [cos(theta2) 0 sin(theta2); 0 1 0; -sin(theta2) 0 cos(theta2)]...
    * [cos(theta3) -sin(theta3) 0; sin(theta3) cos(theta3) 0; 0 0 1];

Output = R*Input;
disp(['[ROTATION3]: ' num2str(ex_nbr) ' échantillons traités.']);



