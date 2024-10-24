%TEXT_CELL2STR

%% Test 1
cel = {};
str = cell2str(cel);
assert(isequal(str, sprintf('')), ...
	[BRAPH2.STR ':cell2str:' BRAPH2.FAIL_TEST], ...
	'Error in cell2str().')

cel = {'uno' 'due' 'tre'};
str = cell2str(cel);
assert(isequal(str, sprintf('uno\ndue\ntre')), ...
	[BRAPH2.STR ':cell2str:' BRAPH2.FAIL_TEST], ...
	'Error in cell2str().')

cel = {' uno '; ' due '; ' tre '};
str = cell2str(cel);
assert(isequal(str, sprintf(' uno \n due \n tre ')), ...
	[BRAPH2.STR ':cell2str:' BRAPH2.FAIL_TEST], ...
	'Error in cell2str().')

cel = {' ' '  ' '   '};
str = cell2str(cel);
assert(isequal(str, sprintf(' \n  \n   ')), ...
	[BRAPH2.STR ':cell2str:' BRAPH2.FAIL_TEST], ...
	'Error in cell2str().')