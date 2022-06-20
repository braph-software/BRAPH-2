%TEST_STR2CELL

%% Test 1
str = sprintf('uno\ndue\ntre');
cel = str2cell(str);
assert(isequal(cel', {'uno' 'due' 'tre'}), ...
	[BRAPH2.STR ':cell2str:' BRAPH2.BUG_FUNC], ...
	'Error in str2cell().')

str = sprintf(' uno \n due \n tre ');
cel = str2cell(str);
assert(isequal(cel', {' uno ' ' due ' ' tre '}), ...
	[BRAPH2.STR ':cell2str:' BRAPH2.BUG_FUNC], ...
	'Error in str2cell().')

str = sprintf(' \n  \n   ');
cel = str2cell(str);
assert(isequal(cel', {' ' '  ' '   '}), ...
	[BRAPH2.STR ':cell2str:' BRAPH2.BUG_FUNC], ...
	'Error in str2cell().')