function is_testing = is_braph_testing()
    % IS_BRAPH_TESTING checks if BRAPH2 is in test mode
    %
    % IS_BRAPH_TESTING checks if BRAPH2 is in test mode by using the
    %   function tes_braph2, which uses the global variable BRAPH2ISTESTING.
    %
    % see also test_braph2, braph2
    
    global BRAPH2ISTESTING 
    
    is_testing = true;    
    if ~isempty(BRAPH2ISTESTING) && ~BRAPH2ISTESTING
        % if its not empty and its not in test mode
        is_testing = false;
    elseif isempty(BRAPH2ISTESTING)
        % if its empty then test_braph2 is not being used.
        BRAPH2ISTESTING = false;
        is_testing = false;
    end
end