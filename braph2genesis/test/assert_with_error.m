function assert_with_error(code, error_identifier, varargin)
%ASSERTWITHERROR checks if the error is correctly thrown by the code.
%
% ASSERTWITHERROR(CODE, ERRORIDENTIFIER) checks if the correct
%  error with ERRORIDENTIFIER is thrown by the CODE.
%
% ASSERTWITHERROR(CODE, ERRORIDENTIFIER, VARARGIN) checks if the correct
%  error with ERRORIDENTIFIER is thrown by the CODE which uses the variables 
%  in VARARGIN. In the code, the variables are referred to as varargin{1}, 
%  varargin{2}, ...
%
% See also TESTBRAPH2.

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