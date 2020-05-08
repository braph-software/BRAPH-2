function str = tostring(value)
% TOSTRING returns a string respresnting the input value
%
% STRING = TOSTRING(VALUE) returns a string representing VALUE.
% The string depends on the type of VALUE. In particular, if VALUE is an
% object with a method tostring(), it will call this method.

if isobject(value) && ismethod(value, 'tostring')  % objects with .tostring()
    str = value.tostring();
elseif isobject(value)  % other objects
    str = class(value);
elseif isnumeric(value) && size(value, 1) > 1  % matrices
    str = mat2str(value);
else  % numbers, vectors, strings
    str = num2str(value);
end

end