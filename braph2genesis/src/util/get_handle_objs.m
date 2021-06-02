function [single_obj, list_objs] = get_handle_objs(type, label, superclass)
%GET_HANDLE_OBJS returns the handle of objects.
%
% SINGLE_OBJ = GET_HANDLE_OBJS(TYPE, LABEL) returns the handle of a object of
%  type TYPE.
%
% [~, LIST_OBJS] = GET_HANDLE_OBJS(TYPE, [], SUPERCLASS) returns the handle of a objects of
%  type TYPE who are subclass of SUPERCLASS or share name with SUPERCLASS.
%
% See also COPY_VARARGIN, CLEAN_VARARGIN, GET_FROM_VARARGIN.

figHandles = findobj('Type', type);
single_obj = [];
list_objs = cell(1, length(figHandles));
for i = 1:1:length(figHandles)
    fig_h = figHandles(i);
    fig_h_array = split(fig_h.Name, ' ');
    if  nargin < 3  &&  contains(fig_h.Name, label)
        single_obj = fig_h;
    elseif nargin == 3 && (ismember(fig_h_array{1}, subclasses(superclass)) || isequal(fig_h_array{1}, superclass))
        list_objs{i} = fig_h;
    end
end
list_objs = list_objs(~cellfun(@isempty, list_objs));
end