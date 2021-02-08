function generator_list = getGenerators(source_dir)
%GETGENERATORS retrieves all generators within a directory.
%
% GENERATORS = GETGENERATORS(DIR) retrieves a list of all generators within
%  the directory DIR. The generators are all files with ending '.gen.m'.
%
% See also genesis.

files = dir(source_dir); % retrieves all files inside source directory

generator_list = cell(1, length(files));
for i = 1:1:length(generator_list) % selects all files *.gen.m
    file_name = files(i).name;
    if length(file_name) > 5 && strcmp(file_name(end-5:end), '.gen.m')
        generator_list{i} = file_name;
    end
end
generator_list(cellfun('isempty', generator_list)) = [];

end