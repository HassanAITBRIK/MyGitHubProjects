clear all; close all;

load('Base.mat');

K = 40;
numClasses = 10;

[Base_app,Label_app] = base2label(cell2mat(Base_app));
[Base_test,Label_test] = base2label(cell2mat(Base_test));


[EIGEN_FACES,AVERAGE_FACE] = Creation_Model(Base_app);
CLASS = Projection_Class(Base_app,EIGEN_FACES,AVERAGE_FACE,K,Label_app);


for j = 1:size(Base_test,2)
    FACE_PROJECTION = Projection_FaceSpace(Base_test(:,j),EIGEN_FACES,AVERAGE_FACE,K);
    for i = 1:size(CLASS,1)
        DISTANCE_FROM_CLASS(i) = sqrt(sum((CLASS{i} - FACE_PROJECTION).^2));
    end
    idx = find(DISTANCE_FROM_CLASS == min(DISTANCE_FROM_CLASS));
    label(j) = CLASS{10+idx};
end

conf = confusionmat(Label_test,label);

%normalize confusion matrix
for c = 1:numClasses
    conf(c,:)=conf(c,:)/sum(conf(c,:));
end
imagesc(conf);colorbar;
disp(['Accuracy: ' num2str(trace(conf/numClasses))]);

% figure(1);
% subplot(1,3,1);imagesc(reshape(face_test,64,64));colormap(gray);title('Visage à classifier');
% subplot(1,3,2);imagesc(reshape(AVERAGE_FACE,64,64));colormap(gray);title('Visage moyen');
% subplot(1,3,3);imagesc(reshape(FACE_PROJECTION,64,64));colormap(gray);title('Visage projeté dans espace des visage');

