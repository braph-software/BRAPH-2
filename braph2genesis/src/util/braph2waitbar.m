function wb_out = braph2waitbar(wb, x, msg)
%BRAPH2WAITBAR manages a waitbar.
%
% WB = BRAPH2WAITBAR(SWITCH, X, MESSAGE) creates the waitbar WB, if SWITCH = true.
%  If SWITCH = false, it retuns WB = false.
%
% BRAPH2WAITBAR(WB, X, MESSAGE) updates the waitbar WB to X percentage and MESSAGE.
%
% BRAPH2WAITBAR(WB, 'close') closes the waitbar WB.
%
% See also waitbar.

if nargin == 2 && strcmpi(x, 'close') && check_graphics(wb, 'figure')
    close(wb)
end

if islogical(wb) && wb
    wb = waitbar(x, msg, ...
        'Name', BRAPH2.NAME, ...
        'Color', BRAPH2.COL_FIG);
% % %     set_braph2icon(wb)
elseif check_graphics(wb, 'figure')
    waitbar(x, wb, msg)
end

if nargout > 0
    wb_out = wb;
end

end