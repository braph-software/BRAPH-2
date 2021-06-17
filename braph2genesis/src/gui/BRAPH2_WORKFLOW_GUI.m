function BRAPH2_WORKFLOW_GUI(varargin)
% constants
f_position = get_from_varargin([.02 .1 .6 .80], 'Position', varargin);
name = 'Main Window'; % could be workflow window
BKGCOLOR = get_from_varargin([.98 .95 .95], 'BackgroundColor', varargin);
close_request = 1; % true

% init
f = init();
    function f = init()
        f = figure(...
            'Visible', 'off', ...
            'NumberTitle', 'off', ...
            'Name', [name ' - ' BRAPH2.STR], ...
            'Units', 'normalized', ...
            'Position', f_position, ...
            'Units', 'character', ...
            'DockControls', 'off', ...
            'Color', BKGCOLOR ...
            );
        set_icon(f)
        
        if close_request
            set(f, 'CloseRequestFcn', {@cb_close})
        end
    end
    function cb_close(~, ~)
        selection = questdlg(['Do you want to close ' name '?'], ...
            ['Close ' name], ...
            'Yes', 'No', 'Yes');
        switch selection
            case 'Yes'
                delete(f)
            case 'No'
                return
        end
    end
% sections
s1 = section1();
    function s1 = section1()
        if nargout > 0 
            s1 = panel_ba;
        end
    end
s2 = section2();
    function s2 = section2()
    end
s3 = section2();
    function s3 = section3()
    end

% menu
menu()
    function menu()
    end
% toolbar
toolbar()
    function toolbar()
    end
% auxiliary
set(f, 'Visible', 'on')
end