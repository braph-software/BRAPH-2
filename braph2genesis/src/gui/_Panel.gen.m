%% ¡header!
Panel < Element (pn, panel) is a panel.

%%% ¡description!
Panel is the basic element to manage graphical representations of elements.
 It is an empty graphical panel. It is filled with the graphical content representing 
 an element (typically, PanelElement) or property (typically, PanelProp and derived classes).
 It is then placed within another container; for example, a figure (e.g., PanelElement into GUIElement) 
 or another panel (e.g., PanelProp into PanelElement).

CONSTRUCTOR - To construct a Panel use the constructor:

    pn = Panel();
    pn = Panel(''ID'', ''id string'');

DRAW - To draw the panel call pn.draw():
    
    p = pn.<strong>draw</strong>();
    p = pn.<strong>draw</strong>(''Parent'', pp);

 where p is the handle of the generated panel and pp is the handle of 
 the parent container (a figure or another panel).
It is also possible to have additional Name-Value pairs accepted by uipanel:

    p = pn.<strong>draw</strong>(''Name'', <value>, ... );
 
The first time that it is called it generates a new panel. The subsequent times, 
 it updates the Name-Value pairs of the uipanel and/or returns the uipanel handle,
 but it does not redraw it (unless it has been deleted).

CALLBACKS - These are callback functions (to be implemented by the derived panels):

    pn.<strong>cb_bring_to_front</strong>() - brings to the front the figures dependent from the panel
    pn.<strong>cb_hide</strong>() - hides the figures depedent on the panel
    pn.<strong>cb_close</strong>() - closes the figure dependent on the panel

%%% ¡seealso!
uipanel, GUI, GUIElement, PanelElement, PanelProp

%% ¡properties!
p % panel graphical handle

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the panel.

%%% ¡prop!
BKGCOLOR (gui, color) is the panel background color.
%%%% ¡default!
BRAPH2.COL_FIG
%%%% ¡postprocessing!
if check_graphics(pn.p, 'uipanel') && ~isequal(get(pn.p, 'BackgroundColor'), pn.get('BKGCOLOR'))
    set(pn.p, 'BackgroundColor', pn.get('BKGCOLOR'))
end

%% ¡methods!
function p_out = draw(pn, varargin)
    %DRAW draws the graphical panel.
    %
    % DRAW(PN) draws the graphical panel.
    %
    % P = DRAW(PN) returns a handle to the graphical panel.
    %
    % DRAW(PN, 'Name', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard Name-Value pairs of uipanel can be used.
    %
    % See also uipanel.

    if ~check_graphics(pn.p, 'uipanel')
        pn.p = uipanel( ...
            'Tag', 'p', ...
            'UserData', pn, ... % handle to retrieve the panel
            'BackgroundColor', pn.get('BKGCOLOR'), ...
            'BorderType', 'none', ...
            varargin{:} ...
            );
    elseif ~isempty(varargin)
        set(pn.p, varargin{:})
    end
    
    if nargout > 0
        p_out = pn.p;
    end
end
function cb_bring_to_front(pn)
    %CB_BRING_TO_FRONT brings to the front the figures dependent on the panel.
    %
    % CB_BRING_TO_FRONT(PN) brings to the front the figures dependent on the panel.
    %
    % See also cb_hide, cb_close.
end
function cb_hide(pn)
    %CB_HIDE hides the figures dependent on the panel.
    %
    % CB_HIDE(PN) hides the figures dependent on the panel.
    %
    % See also cb_bring_to_front, cb_close.
end
function cb_close(pn)
    %CB_CLOSE closes the figures dependent on the panel.
    % 
    % CB_CLOSE(PN) closes the figure containing the panel.
    %
    % See also cb_bring_to_front, cb_hide.
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% figures occupying 4 quadrants of the screen
f_NW = uifigure( ...
    'Name', 'NW', ...
    'Position', [x0(0)+w(0)/4 h(0)/2 w(0)/4 h(0)/4] ...
    );
f_NE = uifigure( ...
    'Name', 'NE', ...
    'Position', [w(0)/2 h(0)/2 w(0)/4 h(0)/4] ...
    );
f_SW = uifigure( ...
    'Name', 'SW', ...
    'Position', [x0(0)+w(0)/4 y0(0)+h(0)/4 w(0)/4 h(0)/4] ...
    );
f_SE = uifigure( ...
    'Name', 'SE', ...
    'Position', [w(0)/2 y0(0)+h(0)/4 w(0)/4 h(0)/4] ...
    );

% panel in center of figure NW
pn_NW = Panel();
pn_NW.draw( ...
    'Parent', f_NW, ...
    'Units', 'normalized', ...
    'Position', [.25 .25 .50 .50], ...
    'BackgroundColor', [1 0 0] ...
    )

% panel in center of figure NE
% retrieving the panel
pn_NE = Panel();
hp_NE = pn_NE.draw( ...
    'Parent', f_NE, ...
    'Units', 'normalized', ...
    'Position', [.25 .25 .50 .50], ...
    'BackgroundColor', [0 1 0] ...
    );

% panel in center of figure SW
pn_SW = Panel();
pn_SW.draw( ...
    'Parent', f_SW, ...
    'Units', 'normalized', ...
    'Position', [.25 .25 .50 .50], ...
    'BackgroundColor', [0 0 1] ...
    );

% panel in on top of figure SE
pn_SE = Panel();
pn_SE.draw( ...
    'Parent', f_SE, ...
    'Units', 'normalized', ...
    'Position', [.25 .25 .50 .50], ...
    'BackgroundColor', 'w' ...
    );

% close SE
close(f_SW)

% replot SW inside NW settings figure
pn_SW.draw( ...
    'Parent', f_SE, ...
    'BackgroundColor', [0 0 1] ...
    )

close(f_NW)
close(f_NE)
close(f_SE)