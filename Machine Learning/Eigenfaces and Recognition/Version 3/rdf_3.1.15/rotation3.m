function Output = rotation3(Input,theta1, theta2, theta3)
%
% SYNTAXE :
%
% Output = rotation3(Input, theta1, theta2, theta3);
%
%
% ARGUMENTS :
%
% Input = matrice des �chantillons 3D
% Theta1, theta2, theta3 = angles de rotations autour des axes x, y et z exprim�s en radians 
%
% ROTATION3 r�alise une rotation en trois dimensions des p�inst 3D donn�s 
% en entr�e. Les exemples sont rang�s en colonnes.
%
% VALEURS DE RETOUR :
%
% Output   : les donn�es apr�s rotation.
%
%

% ROTATION3
% Bruno Gas - ISIR UPMC <Bruno.Gas@upmc.fr>
% Cr�ation : janvier 2013
% Version 1.0
% Derniere r�vision : -

% Ctrl:
if nargin~=4
   error('[ROTATION3] Usage : Output = rotation3(Input, theta1, theta2, theta3)');
end;

% nb. total d'exemples :
[dim ex_nbr] = size(Input);
if dim~=3
    error('[ROTATION3] Dimension incorrecte des �chantillons');
end;

R = [1 0 0; 0 cos(theta1) -sin(theta1); 0 sin(theta1) cos(theta1)]...
    * [cos(theta2) 0 sin(theta2); 0 1 0; -sin(theta2) 0 cos(theta2)]...
    * [cos(theta3) -sin(theta3) 0; sin(theta3) cos(theta3) 0; 0 0 1];

Output = R*Input;
disp(['[ROTATION3]: ' num2str(ex_nbr) ' �chantillons trait�s.']);



