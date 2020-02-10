function list_subclasses = subclasses(class_name, dir)

    if nargin < 2
        dir = fileparts(which(class_name));
    end
        
    struc = what(dir);
    list_subclasses = cell(1, length(struc.m));
    for i = 1:1:length(struc.m)  % selects all files *.m
        file = struc.m{i};
        [~, name] = fileparts(file);

        is_class = exist(name, 'class')==8;  % true is file is a class
        if is_class && any(strcmp(superclasses(name), class_name))
            list_subclasses{i} = name;
        end
    end
	list_subclasses(cellfun('isempty', list_subclasses)) = [];
    
end