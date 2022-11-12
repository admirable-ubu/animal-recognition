clear, clc, close all

Videos = {'Pigs_49651_960_540_500f','Koi_5652_952_540',...
    'Pigeons_8234_1280_720','Pigeons_4927_960_540_600f',...
    'Pigeons_29033_960_540_300f'};


for i = 1:numel(Videos)
    video = Videos{i};
    disp(video)
    imds = imageDatastore(['../GenericCode/',video,'_clips'],...
        'IncludeSubfolders',true,...
        'ReadFcn',@rfn, 'LabelSource','foldernames');
    Data = cell2mat(readall(imds))';

    autoenc = trainAutoencoder(Data);
    ofn = ['AutoEncoders/AE_',video];
    save(ofn,"autoenc")
    ofn_Data = ['AutoEncoders/AE_Data_',video];
    DataAE = encode(autoenc,Data)';
    Data = Data';
    save(ofn_Data,'Data','DataAE','imds') % Labels are included here
end


function data = rfn(x) % read function ------------------------------------
rs = 28; % image resize constant
hsvim = rgb2hsv(imresize(imread(x),[rs,rs])); 
h = hsvim(:,:,1); % hue value
data = h(:)'; % flatten
end