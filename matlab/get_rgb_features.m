function [x,visualise] = get_rgb_features(im,blocks)
%=======================================================================
%get_rgb_features Returns a set of RGB features extracted from an image
%   x = get_rgb_features(im,blocks) 
%
%   Input -----
%      'im': RGB input image
%      'blocks': number of blocks to split the image into, e.g., 1, 4, 9
%                (should be a square number)
%
%   Output -----
%      'x': vector-row with the extracted features, e.g., [mr1,sr1, ...
%           ... mg1,sg1,... ... ... mb9,sb9]
%      'visualise': image to show
%========================================================================

% Author: L. Kuncheva                                               ^--^
% 20.07.2022 -----------------------------------------------------  \oo/
% -------------------------------------------------------------------\/-%

%#ok<*AGROW>

blocksize = round(sqrt(blocks));
visualise = zeros(blocksize,blocksize,3);
ims = size(im);
ims = ims(1:2);

ro = round(linspace(1,ims(1),blocksize+1));
co = round(linspace(1,ims(2),blocksize+1));
x = [];
for si = 1:blocksize
    endpixelr = ro(si+1)-1;
    if si == blocksize, endpixelr = ro(si+1); end
    for sj = 1:blocksize
        endpixelc = co(sj+1)-1;
        if sj == blocksize, endpixelc = co(sj+1); end
        partFrame = im(ro(si):endpixelr,co(sj):endpixelc,:);
        for k = 1:3
            t = double(partFrame(:,:,k));
            visualise(si,sj,k) = mean(t(:));
            x = [x, mean(t(:)), std(t(:))];
        end
    end
end
visualise = uint8(visualise);

