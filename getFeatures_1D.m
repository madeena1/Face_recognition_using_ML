% %This function creates feature matrix from downsampled images
% 
% USAGE EXAMPLE
%     data_set= getFeatures_1D(db.data, N);

% GENERAL DESCRIPTION
% This function will downsample image dimesion to N*N and create a feature
% vector containing of N*N values in each row


function feature = getFeatures_1D(trnData, n)

[x y z]=size(trnData); % get the dimension of the dataset

% create 1 dimensional feature vector from the downsampled z images
for i=1:z
%downsample image
feature_small(:,:,i)=imresize(trnData(:,:,i),[n n]);
%create feature vector of size n*n for z rows
feature(i,:)=reshape(feature_small(:,:,i),[1 numel(feature_small(:,:,i))]);
end

end

