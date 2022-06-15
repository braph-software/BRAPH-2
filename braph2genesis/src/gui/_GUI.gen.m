%% ¡header!
GUI < Element (gui, graphical user interface) renders a GUI figure.

%%% ¡description!
GUI renders a figure with its basic functionalities.

CONSTRUCTOR - To construct a GUI use the constructor:

    gui = GUI()
    
DRAW - To create the element figure, call gui.draw():

    f = gui.<strong>draw</strong>();
 
 Here, f is the figure.
 It is also possible to use gui.draw() to get the figure handle and to set its properties.
 
X_DRAW - Undocumented funciton for internal use only, to be used to draw the contents of a GUI before showing it.
  
CALLBACK - These are the callback functions:

    gui.<strong>cb_bring_to_front</strong>() - brings to the front the figure and its dependent figures
    gui.<strong>cb_hide</strong>() - hides the figure and its dependent figures
    gui.<strong>cb_close</strong>() - closes the figure and its dependent figures

%%% ¡seealso!
GUIElement, GUIPlot, GUISettings, uifigure

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the GUI.

%%% ¡prop!
WAITBAR (gui, logical) detemines whether to show the waitbar.

%%% ¡prop!
NAME (gui, string) is the name of the GUI.
%%%% ¡default!
BRAPH2.STR

%%% ¡prop!
POSITION (gui, rvector) is the normalized position of the GUI on the screen.
%%%% ¡check_prop!
check = (length(value) == 4) && all(value(3:4) >= 0);
%%%% ¡default!
[.00 .00 .20 1.00]

%%% ¡prop!
BKGCOLOR (gui, color) is the GUI background color.
%%%% ¡default!
BRAPH2.COL_FIG

%%% ¡prop!
MENUBAR (gui, logical) determines whether to show the menubar.
%%%% ¡default!
false

%%% ¡prop!
MENU_ABOUT (gui, logical) determines whether to show the menu about.
%%%% ¡default!
false

%%% ¡prop!
TOOLBAR (gui, logical) determines whether to show the toolbar.
%%%% ¡default!
false

%%% ¡prop!
TOOL_ABOUT (gui, logical) determines whether to show the toolbar about buttons.
%%%% ¡default!
false

%%% ¡prop!
CLOSEREQ (gui, logical) determines whether to confirm close.
%%%% ¡default!
true

%% ¡properties!
f % handle for figure 

menu_tmp
menu_about

toolbar

wb % waitbar

%% ¡methods!
function f_out = draw(gui, varargin)
    %DRAW displays a GUI figure.
    %
    % DRAW() displays a GUI figure with its basic functionalities.
    %
    % F = DRAW(GUI) returns a handle to the GUI figure.
    %
    % DRAW(GUI, 'Property', VALUE, ...) sets the properties of the parent
    %  panel with custom Name-Value pairs.
    %  All standard plot properties of figure can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle F of the GUI figure.
    %
    % The GUI can be retrieved as 
    %  GUI = get(F, 'UserData')
    %
    % See also cb_bring_to_front, cb_hide, cb_close, uifigure.

    % draw figure
    if ~check_graphics(gui.f, 'figure')
        gui.f = uifigure( ...
            'Visible', 'off', ...
            'Tag', 'f', ...
            'UserData', gui, ... % handle to retrieve gui
            'Icon', 'braph2icon.png', ...
            'AutoResizeChildren', false, ...
            'CloseRequestFcn', {@cb_close} ...
            );
        if gui.get('MENUBAR')
            gui.menu_tmp = uimenu(gui.f, 'Tag', 'MenuBar'); % empty menu for spacing to be eraseed
        end
        if gui.get('TOOLBAR')
            gui.toolbar = uitoolbar(gui.f, 'Tag', 'ToolBar');
        end
        drawnow() % crucial to ensure the correct sizing of the 
    end
    set(gui.f, ...
        'Name', gui.get('NAME'), ...
        'Units', 'normalized', ...
        'Position', gui.get('POSITION'), ...
        'Color', gui.get('BKGCOLOR'), ...
        varargin{:} ...
        )
    
    % callback on close request
    function cb_close(~, ~)
        gui.cb_close()
    end

    % specialized draw
    gui.x_draw(gui.f)
    
    % menu about
    if gui.get('MENUBAR') && gui.get('MENU_ABOUT') && check_graphics(gui.f, 'figure') && ~check_graphics(gui.menu_about, 'uimenu') 
        gui.menu_about = BRAPH2.add_menu_about(gui.f);
    elseif (~gui.get('MENUBAR') || ~gui.get('MENU_ABOUT'))
        delete(gui.menu_about)
    end
    if check_graphics(gui.menu_tmp, 'uimenu')
        delete(gui.menu_tmp)
    end

    % toolbar about
    if gui.get('TOOLBAR') && check_graphics(gui.f, 'figure')
        gui.toolbar = findall(gui.f, 'Tag', 'ToolBar');
        
        if gui.get('TOOL_ABOUT') && check_graphics(gui.toolbar, 'uitoolbar')
            BRAPH2.add_tool_about(gui.toolbar)
        end
    end
    
    % ensure correct rendering of GUI
    set(gui.f, 'Position', get(gui.f, 'Position') + [0 0 .01 0])
    drawnow()
    set(gui.f, 'Position', get(gui.f, 'Position') - [0 0 .01 0])
    drawnow()

    % show figure
    set(gui.f, 'Visible', 'on')

    % output
    if nargout > 0
        f_out = gui.f;
    end
end
function x_draw(gui, f)
    %X_DRAW undocumented function for internal use only.
    
    % X_DRAW is used to draw the contents of a GUI before showing it.
    
    drawnow() % to ensure that the figure is correctly sized    
end
function cb_bring_to_front(gui)
    %CB_BRING_TO_FRONT brings to front the figure and its dependent figures.
    %
    % CB_BRING_TO_FRONT(GUI) brings to front the figure and its dependent figures.
    %
    % See also cb_hide, cb_close.

    if check_graphics(gui.f, 'figure')
        figure(gui.f) 
        set(gui.f, ...
            'Visible', 'on', ...
            'WindowState', 'normal' ...
            )
    end
end
function cb_hide(gui)
    %CB_HIDE hides the figure and its dependent figures.
    %
    % CB_HIDE(GUI) hides the figure and its dependent figures.
    %
    % See also cb_bring_to_front, cb_close.

    if check_graphics(gui.f, 'figure')
        set(gui.f, 'Visible', 'off')
    end
end
function cb_close(gui)
    %CB_CLOSE closes the figure and its dependent figures.
    %
    % CB_CLOSE(GUI) closes the figure and its dependent figures.
    %  
    % See also cb_bring_to_front, cb_hide.
    
    if check_graphics(gui.f, 'figure')

        name = gui.get('NAME');

        if gui.get('CLOSEREQ')
            selection = uiconfirm(gui.f, ...
                ['Do you want to close ' name '?'], ...
                ['Close ' name], ...
                'Options', {'Yes', 'No'}, ...
                'DefaultOption', 2 ...
                );
        else
            selection = 'Yes';
        end

        switch selection
            case 'Yes'
                delete(gui.f)
            case 'No'
                return
        end
    end
end
