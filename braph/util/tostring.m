function str = tostring(value)

str = '...';

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