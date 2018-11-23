% %This function creates a dataset from the AT&T Database created by AT&T Laboratories Cambridge
% 
% USAGE EXAMPLE
%     create_database()

% GENERAL DESCRIPTION
% Download Link of AT&T Database: https://www.cl.cam.ac.uk/research/dtg/attarchive/facedatabase.html
% Steps to create face dataset
% 1. Download the database
% 2. store the extracted directory (att_faces) in currect directory
% 3. run create_datbase() function

% Output: A dataset named ORLDB_data will be created
% ORLDB_data propertise
% db.data: m*n*400 matrix, conatining 400 images from AT&T database
% db.gnd: 400 ground truths of 400 images of 40 classes

function db = create_database( )

nSub=40; % number of subjects (classes) in the database
nImg=10; % number of samples of each subject (class) in the database

% The dimesion(n,m) of the images are given in the description of the
% database
n=92; 
m=112;

%initialize data
db.data=zeros(m,n,nSub*nImg);


inc=1;

current_dir = pwd; 

%Create Dataset with ground truth
for i=1:nSub
    for j=1:nImg
        %read jth image sample of ith subject
        fn=[current_dir '\att_faces\s' num2str(i) '\' num2str(j) '.pgm' ];
        I=imread(fn);
        %convert color image to grayscale
        if size(I,3)==3
            I=rgb2gray(I);
        end
        Ir=I;
        db.data(:,:,inc)=Ir;
        db.gnd(inc)=i;
        inc=inc+1;
    end
    disp('.')
end

save ORLDB_data.mat db;

end

