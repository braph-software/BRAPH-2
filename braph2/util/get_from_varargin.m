function value = get_from_varargin(value, handle, varargin)
% GET_FROM_VARARGIN clean varargin
%
% VALUE = GET_FROM_VARARGIN(DEFAULT, HANDLE, VARARGIN) returns the property
% corresponding to HANDLE. If HANDLE does not exist, it returns DEFAULT.
% VARARGIN is passed as a cell array.
%
% VALUE = GET_FROM_VARARGIN(DEFAULT, HANDLE, 'PropertyName', PROPERTY, ...
% ) VARARGIN can also be passed as a list of couples including a
% 'PropertyName' and a PROPERTY.
%
% See also COPY_VARARGIN, CLEAN_VARARGIN.

if length(varargin) == 1
    varargin = varargin{:};
end

if nargin > 2
    for n = 1:1:length(varargin)-1
        if strcmpi(varargin{n}, handle)
            value = varargin{n+1};
        end
    end
end

end