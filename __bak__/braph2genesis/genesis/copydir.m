function copydir(source_dir, target_dir, iterate)
%COPYDIR copies a directory contents.
%
% COPYDIR(SOURCE_DIR, TARGET_DIR) copies the files of directory SOURCE_DIR
%  into directory TARGET_DIR. It does not copy files starticn with "." or "_".
%
% COPYDIR(SOURCE_DIR, TARGET_DIR, ITERATE) copes also the subdirectories up
%  to level ITERATE.
%
% See also genesis.

if nargin < 3
    iterate = 0;
end

fp = filesep();

files = dir(source_dir); % retrieves all contents inside directory
files = files([files(:).isdir] == 0);  % keeps only files (isdir property is 0)

for j = 1:1:length(files) % selects all files NOT *.gen.m
    file_name = files(j).name;
    if length(file_name) > 1 && all(~strcmp(file_name(1), {'.', '_'}))
        copyfile([source_dir fp file_name], [target_dir fp file_name])
    end
end

if iterate
    source_dir_contents = dir(source_dir);  % get the folder contents
    source_dir_list = source_dir_contents([source_dir_contents(:).isdir] == 1);  % remove all files (isdir property is 0)
    source_dir_list = source_dir_list(~ismember({source_dir_list(:).name}, {'.', '..'}));  % remove '.' and '..'
    for i = 1:1:length(source_dir_list)
        mkdir([target_dir fp source_dir_list(i).name])
        copydir([source_dir fp source_dir_list(i).name], [target_dir fp source_dir_list(i).name], iterate - 1)
    end
end

end