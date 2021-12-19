function str = tostring(value, n, ending)
%TOSTRING returns a string representing the input value
%
% STRING = TOSTRING(VALUE) returns a string representing VALUE.
%  The string depends on the type of VALUE. In particular, if VALUE is an
%  object with a method tostring(), it will call this method.
%
% STRING = TOSTRING(VALUE, N) trims the string to the first N characters.
%
% STRING = TOSTRING(VALUE, N, ENDING) ends the string with ENDING if it has
%  been trimmed.

if nargin < 3
    ending = '';
end

if nargin < 2
    n = inf;
end

if isobject(value) && ismethod(value, 'tostring') % objects with .tostring()
    str = value.tostring();
elseif isobject(value) % other objects
    str = class(value);
elseif isnumeric(value) && isempty(value) % empty number
    str = '[]';
elseif isnumeric(value) && numel(value) == 1 % scalar number
    str = num2str(value);
elseif isnumeric(value) % other number
    str = ['num' mat2str(size(value)) ' [ ' num2str(value(:)') ' ]'];
elseif iscell(value) % cell arrays
    str = char(join(['{' cellfun(@(x) tostring(x), value(:)', 'UniformOutput', false) '}']));
    str = ['cell' mat2str(size(value)) ' ' str];
elseif ischar(value) && isempty(value) % empty string
    str = '''''';
else  % char arrays
    str = ['''' num2str(value) ''''];
end

if length(str) > n
    str = [str(1:n) ending];
end

end