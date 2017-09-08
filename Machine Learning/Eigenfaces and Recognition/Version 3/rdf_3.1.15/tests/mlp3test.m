
clear all;
close all;

% Chargement base d'apprentissage :
BaseApp = chifget('basechif10.mat', 'app', 10);
[ExNbrApp, ExSizeApp, ClassNbrApp] = basesize(BaseApp);
[BaseApp, TargetApp] = base2target(BaseApp);
BaseApp = basenorm(BaseApp,-1,+1);


% Chargement base de test :
BaseTst = chifget('basechif10.mat', 'tst', 8);
[ExNbrTst, ExSizeTst, ClassNbrTst] = basesize(BaseTst); 
[BaseTst, TargetTst] = base2target(BaseTst);
BaseTst = basenorm(BaseTst,-1,+1);


% Structure du réseau :
InputNbr = ExSizeApp;			% nombre d'entrées
H1cellNbr = 10;					% nombre de cellules 1ere couche cachée
H2cellNbr = 10;					% nombre de cellules 2ème couche cachée
OutputNbr = ClassNbrApp;        % nombre de cellules de sortie

[W1, B1, W2, B2, W3, B3] = mlp3def(InputNbr, H1cellNbr, H2cellNbr, OutputNbr, 2);


% paramètres de l'apprentissage :
lr0 = 0.001;						% pas initial
lr_inc = 1.1;						% incrément du pas
lr_dec = 0.9;						% décrément du pas
err_ratio = 1.0;					% interval de pas constant
nb_it = 1000;						% nombre d'itérations d'apprentissage
err_glob = 0.01;					% Critère d'arret sur l'erreur
freqplot = 10;						% fréquence d'affichage


% Apprentissage avec pas adaptatif :
lr = [lr0 lr_dec, lr_inc, err_ratio];
[NW1,NB1,NW2,NB2,NW3,NB3,L,LR]=mlp3atrain(BaseApp, TargetApp, W1, B1, W2, B2, W3, B3, lr, nb_it, err_glob, freqplot);
 

% taux de reconnaissance en apprentissage :
Output = mlp3run(BaseApp,NW1,NB1,NW2,NB2,NW3,NB3);
AppLabels = mlpclass(Output);
AppLabelsD = target2label(TargetApp);
taux = sum(AppLabelsD==AppLabels)*100/ExNbrApp;

disp(['taux de reconnaissance en apprentissage : ' num2str(taux) ' %']);


% taux de reconnaissance en test :
Output = mlp3run(BaseTst,NW1,NB1,NW2,NB2,NW3,NB3);
TstLabels = mlpclass(Output);
TstLabelsD = target2label(TargetTst);
taux = sum(TstLabelsD==TstLabels)*100/ExNbrTst;

disp(['taux de reconnaissance en test : ' num2str(taux) ' %']);
