function varargin_copy = copy_varargin(varargin)
% COPY_VARARGIN deep copy of varargin
%
% COPY = COPY_VARARGIN(VARARGIN) deep copy of VARARGIN, where VARARGIN is
% passed as a cell array. All copiable objects will be deep-copied (i.e.,
% the method copy() is called for all objects that have it).
%
% COPY = COPY_VARARGIN('PropertyName', PROPERTY, ... ) VARARGIN can also be
% passed as a list of couples including a 'PropertyName' and a PROPERTY.
%
% See also GET_FROM_VARARGIN, CLEAN_VARARGIN.

if length(varargin) == 1
    varargin = varargin{:};
end

varargin_copy = varargin;

for n = 1:1:length(varargin)
    item = varargin{n};
    if isobject(item) && ismethod(item, 'copy')
        varargin_copy{n} = copy(item);
    end
end

end