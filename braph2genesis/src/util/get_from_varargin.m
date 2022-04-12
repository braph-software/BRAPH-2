function value = get_from_varargin(value, handle, varargin)
%GET_FROM_VARARGIN returns the first occurrence of a property from varargin
%
% VALUE = GET_FROM_VARARGIN(DEFAULT, HANDLE, VARARGIN) returns the first occurence 
%  of the property corresponding to HANDLE. If HANDLE does not exist, it returns DEFAULT.
%  VARARGIN is passed as a cell array.
%
% VALUE = GET_FROM_VARARGIN(DEFAULT, HANDLE, 'PropertyName', PROPERTY, ... ) 
%  VARARGIN can also be passed as a list of couples, each including a
%  'PropertyName' and a PROPERTY.
%
% See also COPY_VARARGIN, CLEAN_VARARGIN, REMOVE_FROM_VARARGIN, GET_AND_REMOVE_FROM_VARARGIN.

if length(varargin) == 1
    varargin = varargin{:};
end

if nargin > 2
    for n = 1:2:length(varargin)-1
        if strcmpi(varargin{n}, handle)
            value = varargin{n+1};
            break
        end
    end
end

end