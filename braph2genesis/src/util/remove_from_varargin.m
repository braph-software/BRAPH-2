function varargin = remove_from_varargin(handle, varargin)
%REMOVE_FROM_VARARGIN removes the first occurrence of a property from varargin
%
% NEW_VARARGIN = REMOVE_FROM_VARARGIN(HANDLE, VARARGIN) removes the first occurrence 
%  of the property corresponding to HANDLE, if it exists.
%  VARARGIN is passed as a cell array.
%
% NEW_VARARGIN = REMOVE_FROM_VARARGIN(HANDLE, 'PropertyName', PROPERTY, ... ) 
%  VARARGIN can also be passed as a list of couples, each including a
%  'PropertyName' and a PROPERTY.
%
% See also GET_FROM_VARARGIN, COPY_VARARGIN, CLEAN_VARARGIN, GET_AND_REMOVE_FROM_VARARGIN.

if length(varargin) == 1
    varargin = varargin{:};
end

for n = 1:1:length(varargin)-1
    if strcmpi(varargin{n}, handle)
        varargin = varargin([1:n-1, n+2:end]);
        break
    end
end

end