% visDir
% 
% Like matlab's native dir() command, but removes invisibles ('.*') before
% outputting file struct.
%
% NOTE: Matlab's list directory is oddly designed, with Windows'-like inputs for `dir` and unix `ls` outputs.
% Don't blame me if something breaks.
%
% Version 1
% Author: im500

function listing = visDir(varargin)

if nargin == 0
    name = '.';
elseif nargin == 1
    name = varargin{1};
else
    error('Use only one or no input args.')
end

listing = dir(name);

inds = [];
n    = 0;
k    = 1;

while n < 2 && k <= length(listing)
    if any(strcmp(listing(k).name, {'.', '..'}))
        inds(end + 1) = k;
        n = n + 1;
    end
    k = k + 1;
end

listing(inds) = [];
