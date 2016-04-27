% fileScrambler
% 
% Scrambles file names, then stores the originals in a separate _ORIG.txt
% file.
% Run within a directory.
%
% Use textscan(fid, '%*s %*s %s','HeaderLines',1) to extract results column
%
% WARNING: this file has no checks, it will ruthlessly rename files. Only
% run within safe directories.
%
% Version 1
% Author: im500

%% VARIABLES
ST_LENGTH = 10; % name length
SYMBOLS = ['a':'z' 'A':'Z' '0':'9'];
OUTPUT_FILE = '_fs_output.txt';

userPrompt = 0;

%% Check if script has been run before
if ( exist(OUTPUT_FILE, 'file') == 2 )
    error('This script has been run before. Please revert any changes and run again.');
    return
end

%% Generate file list
fileList = visDir;

%% Ask user and wait for input
warnMsg = ['WARNING: This script will rename ' num2str(length(fileList)) ' files:'];
disp(warnMsg);

for i = 1:length(fileList)
    disp(fileList(i).name);
end

warnInput = input('Are you sure you want to continue? Y/N	', 's');

if ( strcmpi(warnInput, 'y') || strcmpi(warnInput, 'yes') )
    userPrompt = 1;
else
   disp('Exiting');
   return;
end

%% Main loop
while(userPrompt)
    warnMsg2 = ['Renaming ' num2str(length(fileList)) ' files.'];
    disp(' ');
    disp(warnMsg2);
    
    % Open output file
    outFile = fopen(OUTPUT_FILE,'w');
    fprintf(outFile, '%% File Generated %s by %s\n', datestr(datetime), getenv('USERNAME'));

    % Generate random names
    st= cell(10, 1);
    for i = 1:length(fileList)
        %stLength = randi(MAX_ST_LENGTH);
        nums = randi(numel(SYMBOLS),[1 ST_LENGTH]);
        st{i} = SYMBOLS (nums);
    end
    
    % Rename files in order
    for i = 1:length(fileList)
        file = fileList(i).name;
        [fpath, fname, fext] = fileparts(file);
        fileNew = [st{i} fext];
        
        movefile(file, fileNew);
        
        fprintf(outFile, '%i\t%s\t%s\n', i, file, fileNew);
    end
    
    % Generate output file
    fclose(outFile);
    successMsg = ['Renamed ' num2str(length(fileList)) ' files.'];
    type(OUTPUT_FILE);
    disp(successMsg);
    userPrompt = 0;
    break;
end
