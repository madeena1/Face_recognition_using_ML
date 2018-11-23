% %This is script for face recognition using naive Bayes classifier and 10 fold
% cross validation
 
clc;
close all
clear all
warning off 

%db=create_database()
load ORLDB_data.mat

N=10; % dimension of downsampling

%k fold cross validation
nFold=10;

%create indices for the 10-fold cross-validation.
indices = crossvalind('Kfold',db.gnd,nFold);

%initialze classperformance object cp using the true labels ground truth 
cp = classperf(db.gnd);
%initialize variables to calculate correct and error rate
res=zeros(nFold);
err=zeros(nFold);

% Perform classification using naive Bayes and report the correct and error rates
for i = 1:nFold
    test = (indices == i); 
    train = ~test;

    %test and train ground truths
    dbset.trngnd=db.gnd(train==1);
    dbset.tstgnd=db.gnd(test==1);
        
    % total number or training and test samples
    nTrn=length(dbset.trngnd);
    nTst=length(dbset.tstgnd);
    
    % create downsampled one dimesional feature vector for each sample in
    % traning and test set
    dbset.trn= getFeatures_1D(db.data(:,:,train), N);
    dbset.tst= getFeatures_1D(db.data(:,:,test), N);
    
    % fit naive Bayes classifier
    modl = fitcnb(dbset.trn,dbset.trngnd);
    
    %Predict classes, posterios probablity, and cost using trained model
    %on test data
    [class,Posterior,Cost]= predict(modl,dbset.tst);
  
    
    % measure corrrect classification and error rarefor each fold
    crrClass=dbset.tstgnd'-class;
    k=find(crrClass==0);
    %calculate correct rate of ith fold
    res(i)=length(k)/nTst;
    %calculate error rate of ith fold
    err(i)=(nTst-length(k))/nTst;
    % update the cp with new results of ith fold
    cp = classperf(cp, class, test);
    
end

%Display results
disp('Face Recognition using naive Bayes')
disp('=========================================================')
       
Fold=[1:10]';
CorrectRate=round(res(1:10)',2);
ErrorRate=round(err(1:10)',2);
T = table(Fold, CorrectRate,ErrorRate)

disp(['Average Correct Rate : ' num2str(cp.CorrectRate)])
disp(['Average Error Rate : ' num2str(cp.ErrorRate)]) 