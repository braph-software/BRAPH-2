function list_subclasses = subclasses(class_name, dir)
% SUBCLASSES search for all the children classes of a class.
%
% B = SUBCLASSES(A) searches for all the children of a class A inside
% the parent class PATH folder as default.
%
% B = SUBCLASSES(A,  PATH) searches for all the children of a class A
% inside PATH value folder.
%
% See also SUPERCLASSES.

% Author: Giovanni Volpe
% Date: 2020/02/11

if nargin < 2
    dir = fileparts(which(class_name));  %  retrieves a default PATH
end

struc = what(dir);  % retrieves all files inside dir PATH
list_subclasses = cell(1, length(struc.m));  % creates a cell
for i = 1:1:length(struc.m)  % selects all files *.m
    file = struc.m{i};  % assigns the i name to file variable
    [~, name] = fileparts(file);

    is_class = exist(name, 'class')==8;  % true is file is a class
    if is_class && any(strcmp(superclasses(name), class_name))  % compares any name relation
        list_subclasses{i} = name;  % fills cell with names of subclasses
    end
end
list_subclasses(cellfun('isempty', list_subclasses)) = [];

end