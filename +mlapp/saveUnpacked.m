function saveUnpacked(filename, destination)
% EXTRACTALL Extracts code and data from Matlab App (.mlapp) into folder
if nargin < 2
    [destination, name, ext] = fileparts(filename); 
end
unzip(filename, fullfile(destination, [name ext '.src']))
end
