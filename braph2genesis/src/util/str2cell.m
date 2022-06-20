function cel = str2cell(str)
%STR2CELL transforms a string into a cell array of strings
%
% CEL = STR2CELL(STR) transforms the string STR into a column cell array 
%  with each line (separator \n) on a different cell element.
%
% See also CELL2STR.

cel = splitlines(str);

end