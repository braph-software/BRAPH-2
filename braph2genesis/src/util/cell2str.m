function str = cell2str(cel)
%CLEAN_VARARGIN cleans varargin
%
% CLEANED = CLEAN_VARARGIN(HANDLES, VARARGIN) shallow copy of VARARGIN
%  including only the properties in HANDLES. HANDLES is a cell array with a
%  list of property names, i.e. HANDLES = {'PropertyName1', 'PropertyName2', ...}.
%  VARARGIN is passed as a cell array.
%
% COPY = CLEAN_VARARGIN(HANDLES, 'PropertyName', PROPERTY, ... ) 
%  VARARGIN can also be passed as a list of couples each including a 
%  'PropertyName' and a PROPERTY.
%
% See also GET_FROM_VARARGIN, COPY_VARARGIN, REMOVE_FROM_VARARGIN, GET_AND_REMOVE_FROM_VARARGIN.

str = sprintf('%s\n', cel{:});
str = str(1:end-1);

end