function varargin_clean = clean_varargin(handles, varargin)
% CLEAN_VARARGIN clean varargin
%
% CLEANED = CLEAN_VARARGIN(HANDLES, VARARGIN) shallow copy of VARARGIN
% including only the properties in HANDLES. HANDLES is a cell array with a
% list of property names, i.e. HANDLES = {'PropertyName1', 'PropertyName2', ...}.
% VARARGIN is passed as a cell array.
%
% COPY = CLEAN_VARARGIN(HANDLES, 'PropertyName', PROPERTY, ... ) VARARGIN
% can also be passed as a list of couples including a 'PropertyName' and a
% PROPERTY.
%
% See also GET_FROM_VARARGIN, COPY_VARARGIN.

if length(varargin) == 1
    varargin = varargin{:};
end

varargin_clean = varargin;

for n = 1:2:length(varargin)-1
    if ~any(strcmpi(varargin{n}, handles))
        varargin_clean{n} = [];
        varargin_clean{n+1} = [];
    end
end
varargin_clean(cellfun('isempty', varargin_clean)) = [];

end