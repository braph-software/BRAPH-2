function testing = braph2_testing()
%BRAPH2_TESTING checks whether BRAPH2 is in test mode.
%
% TESTING = BRAPH2_TESTING checks whether BRAPH2 is in test mode by
%  checking the global variable BRAPH2_IS_TESTING. 
%
% See also test_braph2, braph2.

    global BRAPH2_IS_TESTING

    testing = ~isempty(BRAPH2_IS_TESTING) && BRAPH2_IS_TESTING;
end 