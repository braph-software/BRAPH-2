function list_subclasses = subclasses(class_name, dir)

    if nargin < 2
        dir = fileparts(which(class_name));
    end

    list_subclasses = {};
        
    struc = what(dir);
    for i = 1:1:length(struc.m)  % selects all files *.m

        file = struc.m{i};
        [~, name] = fileparts(file);

        is_class = exist(name, 'class')==8;  % true is file is a class
        if is_class && any(strcmp(superclasses(name), class_name))
            list_subclasses{end+1} = name;
        end

    end
    
end