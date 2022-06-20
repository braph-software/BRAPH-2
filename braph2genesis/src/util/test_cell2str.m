%TEXT_CELL2STR

%% Test 1: 
cel = {'uno' 'due' 'tre'};
str = cell2str(cel);
assert(isequal(str, sprintf('uno\ndue\ntre')), ...
	[BRAPH2.STR ':cell2str:' BRAPH2.BUG_FUNC], ...
	'Error in cell2str().')

cel = {' uno ' ' due ' ' tre '};
str = cell2str(cel);
assert(isequal(str, sprintf(' uno \n due \n tre ')), ...
	[BRAPH2.STR ':cell2str:' BRAPH2.BUG_FUNC], ...
	'Error in cell2str().')

cel = {' ' '  ' '   '};
str = cell2str(cel);
assert(isequal(str, sprintf(' \n  \n   ')), ...
	[BRAPH2.STR ':cell2str:' BRAPH2.BUG_FUNC], ...
	'Error in cell2str().')