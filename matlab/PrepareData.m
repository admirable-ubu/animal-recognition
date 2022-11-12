clear, clc, close all

Videos = {'Pigs_49651_960_540_500f','Koi_5652_952_540',...
    'Pigeons_8234_1280_720','Pigeons_4927_960_540_600f',...
    'Pigeons_29033_960_540_300f'};

VideosShort = {'Pigs','Koi fish','Pigeons (curb)','Pigeons (pavement)', ...
    'Pigeons (square)'};

for i = 1:numel(Videos)
    
    video = Videos{i};
    fprintf('\n%s\n', video)

    folder = "../GenericCode/"+video + "_clips";
    bb_file = "../GenericCode/BB_" + video + ".csv";
    T = readtable(bb_file); % Full dataset; all identities are in

    fns = T.Var6; % filenames
    extract_frame_number = @(x) str2double(x(6:10));
    Frames = cellfun(extract_frame_number, fns); % frame numbers

    DataRGB = []; DataHOG = []; DataLBP = [];
    Labels = [];
    un = unique(T.Var1); % unique names
    % Prepare the dataset
    % No scaling of the images
    for j = 1:numel(fns)
        if ~mod(j,500)
            fprintf('%5i\n',j)
        end
        z = num2str(Frames(j),'%05d'); % frame number with 5 digits
        ffo = imread(folder + '/' + T.Var1{j} + ...
            '/' + T.Var1{j} + '_frame_' + z + '.jpg');
        ff = imresize(ffo,[40,40]);
        DataRGB =[DataRGB;get_rgb_features(ffo,9)];
        DataHOG =[DataHOG;extractHOGFeatures(ff,'CellSize',[8 8])];
        DataLBP =[DataLBP;extractLBPFeatures(rgb2gray(ff),...
            'Upright',false)];
        Labels = [Labels;find(strcmp(un,T.Var1{j}))];

    end
    
    % Output filenmes
    ofnRGB = [video,'_RGB.mat'];
    ofnHOG = [video,'_HOG.mat'];
    ofnLBP = [video,'_LBP.mat'];

    save(ofnRGB, "DataRGB", "Labels","Frames")
    save(ofnHOG, "DataHOG", "Labels","Frames")
    save(ofnLBP, "DataLBP", "Labels","Frames")

    fprintf('Video %i %s done.\n\n',i,video)

end
