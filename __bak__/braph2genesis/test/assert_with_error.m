function assert_with_error(code, error_identifier, varargin)
%ASSERT_WITH_ERROR checks whether an error is correctly thrown by the code.
%
% ASSERT_WITH_ERROR(CODE, ERRID) checks whether the correct error with the
%  error identifier ERRID is thrown by the CODE (a string).
%
% ASSERT_WITH_ERROR(CODE, ERRID, VAR1, VAR2, ...) executes the CODE using the
%  variables VAR1, VAR2, ... which are referred to in the code string as 'varargin{1}', 
%  'varargin{2}', ...
%
% See also TEST_BRAPH2.

try % tries the code, it is expected to throw an error    
    clear e
    eval(code)
catch e  % catches the thrown error e, it compares the identifier with the expected error_identifier
    assert(isequal(e.identifier, error_identifier), ...
        [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
        [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR ' ' ...
        'Expected error: ' error_identifier '. Instead, thrown error ' e.identifier])    
end
% checks that the variable e exists in the workspace 
assert(exist('e', 'var') == 1, ...
    [BRAPH2.STR ':Format:' BRAPH2.BUG_ERR], ...
	[BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR ' ' ...
	'Error not thrown. Expected error: ' error_identifier])
end