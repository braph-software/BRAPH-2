function clean_list = excludeSuffix(suffix, superclass, varargin)
clean_list = varargin{:};
element_to_exclude = strcat(superclass, suffix);
clean_list = setdiff(clean_list, {element_to_exclude});
end