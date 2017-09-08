% Toolbox RdF 3.1.15 (08/01/2013)
% ISIR - UPMC
% ----------------------------
% Help RdF
%
% ----------- BUGS -------------
%
%  SPEECHGET 1.7 : plantage pour des valeurs de trames et entrelacement :
%                  ex : 129,128
%
%
% --------- MODIFS -------------
%
% Nouveautés / version 3.1.14
%
%  SUMNSQR          - nouvelle fonction
%  MLP3DEF          - nouvelle fonction
%  MLP3ATRAIN       - nouvelle fonction
%  MLP3RUN          - nouvelle fonction
%  MLP4DEF          - nouvelle fonction
%  MLP4ATRAIN       - nouvelle fonction
%  MLP4RUN          - nouvelle fonction
%  MOBIUSSTRIP      - nouvelle fonction
%  MAKEGAUSSMIXND   - nouvelle fonction
%  SWISSROLL        - nouvelle fonction
%  MLP4CIRCDEF      - nouvelle fonction
%  MLP4CIRCATRAIN   - nouvelle fonction
%  MLP4CIRCRUN      - nouvelle fonction
%  SPIRAL           - nouvelle fonction
%  TENNISBALL       - nouvelle fonction
%  SVDBOOTSTRAPP    - import toolbox_pam -> rdf
%  SPACEDIM         - import toolbox_pam -> rdf
%
% Nouveautés / version 3.1.13
%
%  MLP2TRAIN        - Correction BUG
%  AFFICHEMLP2      - Affichage d'un réŽseau MLP une couche cachŽe
%
% Nouveautés / version 3.1.12
%
%  SHOWIMGBASE      - Affichage d'une base d'images
%  KHN2DGRID        - Affichage d'une carte de Kohonen 2D et prototypes 2D
%  KHN2TRAIN        - amélioration adaptation du pas et du voisinage
%  KHN2LABEL        - Labellisation d'une carte de Kohonen 2D
%
% Nouveautés / version 3.1.11
%
%  SHOWCHARACTERS   - nouvelle fonction
%
% Nouveautés / version 3.1.8 et 3.1.9
%
%  SPLITBASE        - correction
%  PROBMLPCLASS     - import specrdf-> rdf 
%  PROBMLP2DEF      - import specrdf-> rdf
%  PROBMLP2RUN      - import specrdf-> rdf
%  PROBMLP2ACRVTRAIN- import specrdf-> rdf
%  PROBMLP2TRAIN    - import specrdf-> rdf
%  SOFTMAX          - import specrdf-> rdf
%  SOFTMAXP         - import specrdf-> rdf
%  LVQIFRONT        - nouvelle fonction
%  MLP2ACRVTRAIN 1.3- correction
%
% Nouveautés / version 3.1.6 et 3.1.7 :
%
%  AUDIOGET         - modification 
%  ZEROSIG          - nouvelle fonction
%  VARSIG           - nouvelle fonction
%  SPLITBASE        - nouvelle fonction
%  SHOWBASE         - nouvelle fonction
%  SIGHAMMING       - nouvelle fonction
%  CODFFT           - nouvelle fonction
%  CODLPC           - modification
%
% Nouveautés / version 3.1.4 :
%
%  GENBASE          - nouvelle fonction
%  MLP2TRAIN        - modification
%  MLP2FRONT        - nouvell fonction
%  MLP1FRONT        - nouvelle fonction
%
% Liste des fonctions disponibles :
%
%  ACPN 1.2         - analyse en composantes principales normée
%  AD 1.4           - analyse discriminante
%  AUDIOGET 1.1     - acquisition en ligne de signaux audio (nécessite la tbx data acquisition) 
%  BASE2TARGET 1.0  - Formatage d'une base pour la RdF : génération des vecteurs cible
%  BASE2LABEL 1.1   - Formatage d'une base pour la RdF : extraction des labels
%  BASENORM 1.4     - normalisation des exemples d'une base RdF
%  BASESIZE 1.1     - Dimension d'une base RdF d'exemples 
%  BASEUNIT 1.1     - norme les exemples d'une base RdF qui deviennent vecteurs unitaires
%  BELDIST 1.5      - Distance de Bellman : algorithme de comparaison dynamique
%  CHARBASEDRAW 1.4 - Construction d'une base de formes (RdF caractères dynamiques - online)
%  CHIFGET 1.4      - Extraction d'une base RdF de chiffres à partir du fichier 'basechif'
%  CODFFT 1.0       - codage FFT (Fast Fourier Transform) d'une trame de parole
%  CODFREEMAN 1.2   - codage de Fremann d'une base RdF de caractères dynamiques
%  CODLPC 1.3       - codage LPC (Linear Predictive Coding) d'une base de trames de parole 
%  CODLPCC 1.5      - codage LPCC (Linear Predictiv Cepstrum Coding) d'une base de trames de parole 
%  CODMFCC 1.4      - codage MFCC (Mel Frequency Cepstrum Coding) d'une trame de parole
%  CODPLP 1.0       - codage PLP (Perceptual Linear Predictiv coding) d'une base de trames de parole
%  CODPROJ 1.0      - codage d'images binaires par projection vectorielle
%  CODRET 1.0       - codage rétinien d'images binaires
%  COMP_CODEUR 1.0  - comparaison par analyse discriminante des codages LPC et MFCC sur des signaux de parole
%  CONFUSION 1.1    - Calcul de la matrice de confusion pour une classification donnée
%  DISTEDIT 1.2     - Distance d'édition (algorithme de Wagner et Fisher)
%  DISTEDITNUM 1.2  - Distance d'édition avec attributs numériques
%  DTW 1.3          - Algorithme DTW (algo. de comparaison dynamique de deux chaînes vectorielles)
%  GCADRE 1.2       - Recadrage d'une image binaire sur son centre de gravité
%  GENBASE 1.1      - Génération automatique d'une base de prototypes 2D (distribution multi-gaussiennes)
%  GENSIG 1.1       - génération d'une base de signaux 1D
%  IMBGET 1.5       - Extraction d'une classe d'images à partir de fichiers images Kangourou (.imb)
%  IMBSIZE 1.1      - Nombre d'images dans un fichier Kangourou .imb 
%  IMGVIEW          - affichage rapide d'une image (appartient à la toolbox Image)
%  IS_MATRIX 1.1    - booléen, pour compatibilité avec octave
%  IS_OCTAVE 1.0    - retourne 1 si octave, 0 sinon
%  IS_SCALAR 1.1    - booléen, pour compatibilité avec octave
%  IS_VECTOR 1.1    - booléen, pour compatibilité avec octave
%  KHNCLASS 1.1     - Classification des données issues d'une carte de Kohonen 1D ou 2D
%  KHN1DEF 1.1      - définition d'une carte de Kohonen 1D
%  KHN1RUN 1.2      - utilisation d'une carte de Kohonen 1D 
%  KHN1TRAIN 1.1    - apprentissage d'une carte de Kohonen 1D
%  KHN2DEF 1.1      - définition d'une carte de Kohonen 2D 
%  KHN2RUN 1.1      - utilisation d'une carte de Kohonen 2D 
%  KHN2TRAIN 1.1    - apprentissage d'une carte de Kohonen 2D
%  KPPV 1.5         - Classification par la méthode des kppv
%  LABEL2TARGET 1.2 - Transformation de labels scalaires en vecteurs cibles pour classifieur 
%  LIDARGET 1.1     - Extraction de signaux Lidar
%  LPCFILTER 1.0    - Filtre LPC
%  LVQIDEF 1.3      - définition de la structure d'un réseau LVQ de type I
%  LVQIFRONT 1.0    - visualisation des frontières de décision pour des problèmes 2D
%  LVQITRAIN 1.4    - apprentissage d'un LVQ de type I
%  LVQIRUN 1.3      - utilisation d'un réseau LVQ de type I
%  MAHALANOBIS (en cours) - distance de Mahalanobis 
%  MAKEGAUSSMIXND   - Génération d'une mixture de gaussiennes 2D
%  MAKEYGLASS 1.0   - génération de signaux process. non linéaire : série de Mackey-Glass
%  MAT2VEC 1.0      - transformation d'une matrice en vecteur
%  MKIMBBASE 1.2    - Extraction d'une base RdF à partir de fichiers images Kangourou (.imb)
%  MLP1DEF 1.1      - définition de la structure d'un réseau neuronal MLP à une couche
%  MLP1FRONT 1.0    - Tracé des frontières de décision sur des problèmes 2D 
%  MLP1RUN 1.1      - utilisation d'un réseau MLP à 1 couche
%  MLP1TRAIN 1.3    - apprentissage d'un réseau MLP 1 couche
%  MLP1ATRAIN 1.2   - apprentissage avec pas adaptatif d'un réseau MLP 1 couche
%  MLP2DEF 1.1      - définition de la structure d'un réseau neuronal MLP à deux couches
%  MLP2FRONT 1.0    - Tracé des frontières de décision sur des problèmes 2D 
%  MLP2TRAIN 1.5    - apprentissage d'un réseau MLP 2 couches
%  MLP2ATRAIN 1.6   - apprentissage avec pas adaptatif d'un réseau MLP 2 couches
%  MLP2ACRVTRAIN 1.3- apprentissage avec pas adaptatif et cross-validation d'un MLP 2 couches
%  MLP2FIT 1.0      - regression par réseau MLP 2 couches
%  MLP2MTRAIN 1.0 (en cours) - apprentissage avec momentum d'un réseau MLP 2 couches
%  MLP2RUN 1.1      - utilisation d'un réseau MLP à 2 couches
%  MLP3DEF          - définition de la structure d'un réseau neuronal MLP à trois couches
%  MLP3ATRAIN       - apprentissage avec pas adaptatif d'un réseau MLP 3 couches
%  MLP3RUN          - utilisation d'un réseau MLP à 3 couches
%  MLP4DEF          - définition de la structure d'un réseau neuronal MLP à quatre couches
%  MLP4ATRAIN       - apprentissage avec pas adaptatif d'un réseau MLP 4 couches
%  MLP4RUN          - utilisation d'un réseau MLP à 4 couches
%  MLP4CIRCATRAIN   - apprentissage avec pas adaptatif d'un réseau MLP à neurones circulaires et 4 couches 
%  MLP4CIRCDEF 1.0  - Définition d'un réseau à cellules circulaires à 4 couches
%  MLP4CIRCRUN 1.0  - utilisation d'un réseau MLP  circulaire à 4 couches
%  MLPCLASS 1.1     - classification des données issues d'un réseau MLP
%  MOBIUSSTRIP 1.0  - Génère le ruban de Moebius en 3D
%  PROBMLPCLASS 1.1 - classification des données issues d'un réseau MLP à sorties probabilités
%  PROBMLP2DEF 1.0  - définition d'un réseau MLP 2 couches à sorties probablités à postériori
%  PROBMLP2RUN 1.0  - utilisation d'un réseau MLP 2 couches à sorties probabilités
%  PROBMLP2ACRVTRAIN 1.3- apprentissage adaptatif avec cross-validation d'un réseau MLP 2 à sorties probabilités  
%  PROBMLP2TRAIN 1.0- apprentissage d'un réseau MLP 2 à sorties probabilités
%  RANDWEIGHTS 1.2  - génération aléatoire d'une couche de poids (réseaux MLP)
%  RDF              - Liste des fonctions RdF	
%  REDUC 1.4        - Réduction de la taille d'une image
%  REVERB 1.1       - Filtre réverbération pour signal audio mono ou stéréo
%  ROWS 1.1         - nombre de lignes d'une matrice (pour compatibilité avec octave) 
%  SCANMOUSE 1.2    - saisie d'une liste de points tracés avec la souris
%  SCORE 1.3        - calcul du taux de reconnaissance et de rejet sur une classification
%  SHOWBASE 1.0     - Affiche des bases de formes 2D
%  SHOWCHARACTERS 1.- Affichage de certains exemples de la base de caractères
%  SIGMO 1.2        - fonction sigmoïde
%  SIGMOP 1.2       - fonction sigmoïde dérivée
%  SIGMOS 1.0       - fonction sigmoide dérivée seconde
%  SIGNORM 1.1      - normalisation d'un signal
%  SIGPREACC 1.2    - préaccentuation d'un signal (rehaussement des hautes fréquences)
%  SIGHAMMING 1.0   - fenêtrage de Hamming d'un signal ou d'une matrice de signaux
%  SPACEDIM 1.0     - estime la dimension intrinsèque d'un nuage de points par la méthode linéaire PCA
%  SPATIAL 1.0      - spatialisation stéréo 2D d'un son mono
%  SPEECHDETECT 1.0 - Detection signal de parole / bruit à partir d'un fichier parole
%  SPEECHGET 1.7    - Extraction d'une base de trames parole à partir d'un fichier parole
%  SPEECHGET2 1.0   - Extraction d'une base de mots à partir d'un fichier parole
%  SPIRAL 1.0       - Génère la courbe de la spirale en 3D
%  SPLITBASE 1.1    - Décompose une base en 2 bases (test et apprentissage) 
%  SUMNSQR 1.1      - Comme SUMSQR après normalisation des données
%  SUMSQR 1.0       - Somme des composantes au carré d'un vecteur ou d'une matrice de vecteurs
%  SVDBOOTSTRAPP    - Estimation de la dimension et extraction des générateurs d'un opérateur f(M) linéaire
%  SWISSROLL 1.0    - Génère la surface du "gateau suisse" dans l'espace 3D
%  TARGET2LABEL 1.2 - Transformation de vecteurs cibles pour classifieurs en labels scalaires 
%  TAB2VEC 1.3      - construit un tracé on line isometrique dense de N points
%  TENNISBALL 1.0   - Génère la courbe de la couture de la balle de tennis en 3D
%  TIMIT2BASE 1.1   - Conversion Base Timit - Base compatible à la ToolBox 
%  UICHARBASEDRAW 1.0 - GUI de la fonction charbasedraw
%  UICHIFGET 1.0    - GUI de la fonction chifget
%  UIIMBGET 1.0     - GUI de la fonction imbget
%  UIKHN1TRAIN      - GUI de la fonction khn1train
%  UIKHN2TRAIN      - GUI de la fonction khn2train
%  UIMKIMBBASE 1.2  - GUI de la fonction mkimbbase
%  UIMLP1DEF 1.0    - GUI de la fonction mlp1def
%  UIMLP1ATRAIN 1.0 - GUI de la fonction mlp1atrain
%  UIMLP2DEF 1.0    - GUI de la fonction mlp2def
%  UIMLP2ATRAIN 1.0 (à faire)
%  UISPEECHDETECT 1.0 GUI de la fonction speechdetect
%  UISPEECHGET 1.0  - GUI de la fonction speechget
%  UITIMIT2BASE 1.3 - construction d'une base de phonèmes TIMIT 
%  VARSIG 1.0       - Estimation de la variance et de son évolution sur un signal
%  VISUSTROKE       - tracé de points 
%  WARPDTW 1.0      - estimation des distances cumulées. Utilisé par DTW.
%  ZEROSIG 1.0      - estimation du nombre moyen de passages par zéro et de son évolution sur un signal
%  
%
%
