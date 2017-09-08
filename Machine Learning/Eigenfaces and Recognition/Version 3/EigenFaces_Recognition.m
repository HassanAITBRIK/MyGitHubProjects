clear all; close all;
%% CHARGEMENT ET SPLIT DE LA BASE DE DONNEES
load('Base.mat');
[Base,Label] = base2label(Base);
split_ratio60 = 0.6;
[BaseApp, LabelsApp, BaseTest, LabelsTest] = splitbase(Base, Label, split_ratio60);
numClasses = size(unique(LabelsApp),2);

%% ANALYSE EN COMPOSANTES PRINCIPALES (ACP)
[EIGEN_FACES,AVERAGE_FACE,K_OPT] = Creation_Model(BaseApp);
%% CLASSIFICATION
Prediction = zeros(1,size(BaseTest,2));
DISTANCE_FROM_FACE_SPACE = zeros(1,size(BaseTest,2));
DISTANCE_FROM_CLASS = zeros(1,numClasses);

CLASS = Projection_Class(BaseApp,EIGEN_FACES,AVERAGE_FACE,K_OPT,LabelsApp,numClasses);

for j = 1:size(BaseTest,2)
    FACE_PROJECTION = Projection_FaceSpace(BaseTest(:,j),EIGEN_FACES,AVERAGE_FACE,K_OPT);
    
    % Distance par rapport à l'espace de visage
    DISTANCE_FROM_FACE_SPACE(j) = sqrt(sum((BaseTest(:,j) - FACE_PROJECTION).^2));
    
    % Distance par rapport à chaque classe et prédiction
    for i = 1:size(CLASS,1)
        DISTANCE_FROM_CLASS(i) = sqrt(sum((CLASS{i} - FACE_PROJECTION).^2));
    end
    idx = find(DISTANCE_FROM_CLASS == min(DISTANCE_FROM_CLASS));
    Prediction(j) = CLASS{numClasses+idx};
end


%% MATRICE DE CONFUSION
conf = confusionmat(LabelsTest,Prediction);
%normalisation de la matrice de confusion
for c = 1:numClasses
    conf(c,:)=conf(c,:)/sum(conf(c,:));
end

figure(1);
imagesc(conf);colorbar;title(['Taux de reconnaissance: ' num2str(100*trace(conf/numClasses)) '%']);

