%% ¡header!
Plot < Element (pl, plot) is a plot.

%%% ¡description!
Plot is the basic element to manage graphical representations of elements.
 It is an empty graphical panel. It is filled with the graphical content representing 
 an element (typically, PlotElement) or property (typically, PlopProp and derived classes).
 It is then placed within another container; for example, a figure (e.g., PlotElement into GUI) 
 or another panel (e.g., PlotProp into PlotElement).

CONSTRUCTOR - To construct a Plot use the constructor:

    pl = Plot();
    pl = Plot(''ID'', ''id string'');

DRAW - To draw the panel call pl.draw():
    
    h = pl.<strong>draw</strong>();
    h = pl.<strong>draw</strong>(''Parent'', f);

 where h is the handle of the generated panel and f is the handle of 
 the parent container (a figure or another panel).
It is also possible to have additional Name-Value pairs accepted by uipanel:

    h = pl.<strong>draw</strong>(''Name'', <value>, ... );
 
The first time that it is called it generates a new panel. The subsequent times, 
 it updates the Name-Value pairs of the uipanel and/or returns the uipanel handle,
 but it does not redraw it (unless it has been deleted).
By default, the ''DeleteFcn'' calls the method pl.<strong>cb_close_fs</strong>(), 
 which closes the settings figure, when the panel is deleted.
 This can be easily overwritten calling 
 
    pl.<strong>draw</strong>(''DeleteFcn'', <new callback>)

SETTINGS FIGURE - To open the settings figure:

    fs = pl.<strong>settings</strong>();
 
 where fs is the handle of the generated settings figure.
It is also possible to have additional Name-Value pairs accepted by uipanel:

    fs = pl.<strong>settings</strong>(''Name'', <value>, ... );
 
The first time that it is called it generates a new settings figure. The subsequent times, 
 it updates the Name-Value pairs of the settings figure and/or returns the settings figure handle,
 but it does not regenerates it (unless it has been deleted).

CALLBACKS - These are callback functions:

    pl.<strong>cb_close_fs</strong>() - closes the settings figure
    pl.<strong>cb_bring_fs_to_front</strong>() - brings to the front the settings figure

%%% ¡seealso!
uipanel, GUI, PlotElement, PlotProp

%% ¡properties!
h_panel % panel graphical handle
f_settings % settings figure handle 

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the plot.

%%% ¡prop!
BKGCOLOR (metadata, rvector) is background color.
%%%% ¡check_prop!
check = (length(value) == 3) && all(value >= 0 & value <= 1);
%%%% ¡default!
BRAPH2.COL_FIG

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the graphical panel.
    %
    % DRAW(PL) draws the graphical panel.
    %
    % H = DRAW(PL) returns a handle to the graphical panel.
    %
    % DRAW(PL, 'Name', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard Name-Value pairs of uipanel can be used.
    %
    % See also settings, uipanel.

    if ~check_graphics(pl.h_panel, 'uipanel')
        pl.h_panel = uipanel( ...
            'Tag', 'h_panel', ...
            'UserData', pl, ...
            'DeleteFcn', {@cb_close_fs}, ...
            'BorderType', 'none', ...
            'BackgroundColor', pl.get('BKGCOLOR'), ...
            varargin{:} ...
            );
    else
        if ~isempty(varargin)
            set(pl.h_panel, varargin{:})
        end
    end
    h = pl.h_panel;

    function cb_close_fs(~, ~) % (src, event)
        pl.cb_close_fs()
    end
    
    if nargout > 0
        h_panel = h;
    end
end
function f_settings = settings(pl, varargin)
    %SETTINGS opens the settings figure.
    %
    % SETTINGS(PL) allows the user to edit the properties of the plot
    %  by opening a settings figure.
    %
    % FS = SETTINGS(PL) returns a handle to the settings figure.
    %
    % SETTINGS(PL, 'Name', VALUE, ...) sets the properties of the
    %  settings figure with custom Name-Value pairs. 
    %  All standard plot Name-Value pairs of figure can be used.
    %
    % See also draw, figure.

    % create a figure
    if ~check_graphics(pl.f_settings, 'figure')
        pl.f_settings = figure();
        set(pl.f_settings, ...
            'units', 'normalized', ...
            'Position', [.70 .50 .40 .20], ... 
            'Name', strtrim([pl.get('ID') ' Settings']), ...
            'Color', pl.get('BKGCOLOR'), ...
            'MenuBar', 'none', ...
            'Toolbar', 'none', ...
            'NumberTitle', 'off', ...
            'DockControls', 'off', ...
            varargin{:} ...
            )
    else
        if ~isempty(varargin)
            set(pl.f_settings, varargin{:})
        end
    end
    
    if nargout > 0
        f_settings = pl.f_settings;
    end
end
function cb_close_fs(pl)
    %CB_CLOSE_FS closes the settings figure if it exists.
    %
    % CB_CLOSE_FS(PL) closes the settings figure if it exists by calling the
    %  function close().
    %
    % See also close.

    if check_graphics(pl.f_settings, 'figure')
        close(pl.f_settings)
    end
end
function cb_bring_fs_to_front(pl)
    %CB_BRING_FS_TO_FRONT brings the settings figure to the front.
    %
    % CB_BRING_FS_TO_FRONT(PL) brings the settings figure to the front.
    %
    % See also settings.

    if check_graphics(pl.f_settings, 'figure')
        figure(pl.f_settings)
    end    
end

%% ¡staticmethods!
function r = x0(h, units, position)
    %X0 returns the position of the left edge of a graphical element.
    %
    % R = X0(H) is the distance from the inner left edge of the parent
    %  container to the outer left edge of the graphical element H 
    %  in the units of H.
    %
    % R = X0(H, UNITS) is in UNITS. All valid units for H can be used
    %  (e.g., 'normalized', 'pixels', 'characters').
    %
    % R = X0(H, [], POSITION) returns POSITION = 'Position' (default),
    %  'InnerPosition' or 'OuterPosition' in the units of H.
    %
    % R = X0(H, UNITS, POSITION) returns the selected POSITION in UNITS.
    %
    % R = X0(0, UNITS) applies to the screen (0 is the root graphical
    %  element) in UNITS. POSITION is automatically set to 'ScreenSize'.
    % 
    % See also y0, w, h.

    if nargin < 3
        position = 'Position';
    end
    if nargin < 2
        units = [];
    end
    
    if h == 0 % screen (root graphical element)
        position = 'ScreenSize';
    end

    if isempty(units)
        r = get(h, position);
    else
        backup_units = get(h, 'Units');
        set(h, 'Units', units)
        r = get(h, position);
        set(h, 'Units', backup_units);
    end
    r = r(1);
end
function r = y0(h, units, position)
    %Y0 returns the position of the bottom edge of a graphical element.
    %
    % R = Y0(H) is the distance from the inner bottom edge of the parent 
    %  container to the outer bottom edge of the graphical element H.
    %  in the units of H.
    %
    % R = Y0(H, UNITS) is in UNITS. All valid units for H can be used
    %  (e.g., 'normalized', 'pixels', 'characters').
    %
    % R = Y0(H, [], POSITION) returns POSITION = 'Position' (default),
    %  'InnerPosition' or 'OuterPosition' in the units of H.
    %
    % R = Y0(H, UNITS, POSITION) returns the selected POSITION in UNITS.
    %
    % R = Y0(0, UNITS) applies to the screen (0 is the root graphical
    %  element) in UNITS. POSITION is automatically set to 'ScreenSize'.
    %
    % See also x0, w, h.

    if nargin < 3
        position = 'Position';
    end
    if nargin < 2
        units = [];
    end
    
    if h == 0 % screen (root graphical element)
        position = 'ScreenSize';
    end

    if isempty(units)
        r = get(h, position);
    else
        backup_units = get(h, 'Units');
        set(h, 'Units', units)
        r = get(h, position);
        set(h, 'Units', backup_units);
    end
    r = r(2);
end
function r = w(h, units, position)
    %W returns the width of a graphical element.
    %
    % R = W(H) is the distance between the right and left outer edges of the
    %   graphical element H.
    %  in the units of H.
    %
    % R = W(H, UNITS) is in UNITS. All valid units for H can be used
    %  (e.g., 'normalized', 'pixels', 'characters').
    %
    % R = W(H, [], POSITION) returns POSITION = 'Position' (default),
    %  'InnerPosition' or 'OuterPosition' in the units of H.
    %
    % R = W(H, UNITS, POSITION) returns the selected POSITION in UNITS.
    %
    % R = W(0, UNITS) applies to the screen (0 is the root graphical
    %  element) in UNITS. POSITION is automatically set to 'ScreenSize'.
    %
    % See also x0, y0, h.

    if nargin < 3
        position = 'Position';
    end
    if nargin < 2
        units = [];
    end
    
    if h == 0 % screen (root graphical element)
        position = 'ScreenSize';
    end

    if isempty(units)
        r = get(h, position);
    else
        backup_units = get(h, 'Units');
        set(h, 'Units', units)
        r = get(h, position);
        set(h, 'Units', backup_units);
    end
    r = r(3);
end
function r = h(h, units, position)
    %H returns the height of a graphical element.
    %
    % R = H(H) is the distance between the top and bottom outer edges of the
    %  graphical element H.
    %  in the units of H.
    %
    % R = H(H, UNITS) is in UNITS. All valid units for H can be used
    %  (e.g., 'normalized', 'pixels', 'characters').
    %
    % R = H(H, [], POSITION) returns POSITION = 'Position' (default),
    %  'InnerPosition' or 'OuterPosition' in the units of H.
    %
    % R = H(H, UNITS, POSITION) returns the selected POSITION in UNITS.
    %
    % R = H(0, UNITS) applies to the screen (0 is the root graphical
    %  element) in UNITS. POSITION is automatically set to 'ScreenSize'.
    %
    % See also x0, y0, w.

    if nargin < 3
        position = 'Position';
    end
    if nargin < 2
        units = [];
    end
    
    if h == 0 % screen (root graphical element)
        position = 'ScreenSize';
    end

    if isempty(units)
        r = get(h, position);
    else
        backup_units = get(h, 'Units');
        set(h, 'Units', units)
        r = get(h, position);
        set(h, 'Units', backup_units);
    end
    r = r(4);
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% figures occupying 4 quadrants of the screen
f_NW = figure( ...
    'Name', 'NW', ...
    'OuterPosition', [Plot.x0(0)+Plot.w(0)/4 Plot.h(0)/2 Plot.w(0)/4 Plot.h(0)/4] ...
    );
f_NE = figure( ...
    'Name', 'NE', ...
    'OuterPosition', [Plot.w(0)/2 Plot.h(0)/2 Plot.w(0)/4 Plot.h(0)/4] ...
    );
f_SW = figure( ...
    'Name', 'SW', ...
    'OuterPosition', [Plot.x0(0)+Plot.w(0)/4 Plot.y0(0)+Plot.h(0)/4 Plot.w(0)/4 Plot.h(0)/4] ...
    );
f_SE = figure( ...
    'Name', 'SE', ...
    'OuterPosition', [Plot.w(0)/2 Plot.y0(0)+Plot.h(0)/4 Plot.w(0)/4 Plot.h(0)/4] ...
    );

% panel in center of figure NW
pl_NW = Plot();
pl_NW.draw( ...
    'Parent', f_NW, ...
    'Units', 'normalized', ...
    'Position', [.25 .25 .50 .50], ...
    'BackgroundColor', [1 0 0] ...
    )
pl_NW.settings( ...
    'Color', [1 0 0] ...
    )

% panel in center of figure NE
% retrieving the panel and settings figure handles
pl_NE = Plot();
hp_NE = pl_NE.draw( ...
    'Parent', f_NE, ...
    'Units', 'normalized', ...
    'Position', [.25 .25 .50 .50], ...
    'BackgroundColor', [0 1 0] ...
    );
fs_NE = pl_NE.settings( ...
    'Color', [0 1 0], ...
    'Name', 'Renamed this settings figure', ...
    'Units', get(f_NE, 'Units'), ...
    'Position', [Plot.x0(f_NE) Plot.y0(f_NE) Plot.w(f_NE) Plot.h(f_NE)] ...
    );

% panel in center of figure SW
% note the misalignement of the settings figure
pl_SW = Plot();
pl_SW.draw( ...
    'Parent', f_SW, ...
    'Units', 'normalized', ...
    'Position', [.25 .25 .50 .50], ...
    'BackgroundColor', [0 0 1] ...
    );
pl_SW.settings( ...
    'Color', [0 0 1], ...
    'Position', [Plot.x0(f_SW, 'normalized')+Plot.w(f_SW, 'normalized')/4 Plot.y0(f_SW, 'normalized')+Plot.h(f_SW, 'normalized')/4 Plot.w(f_SW, 'normalized')/2 Plot.h(f_SW, 'normalized')/2] ...
    )

% panel in on top of figure SE
% note the alignement of the settings figure
pl_SE = Plot();
pl_SE.draw( ...
    'Parent', f_SE, ...
    'Units', 'normalized', ...
    'Position', [.25 .25 .50 .50], ...
    'BackgroundColor', 'w' ...
    );
pl_SE.settings( ...
    'Color', 'w', ...
    'OuterPosition', [Plot.x0(f_SE, 'normalized') Plot.y0(f_SE, 'normalized') Plot.w(f_SE, 'normalized') Plot.h(f_SE, 'normalized')] ...
    )

% close SE settings figure
pl_SE.cb_close_fs()

% bring to from NW settings figure
pl_NW.cb_bring_fs_to_front()

% close SE
close(f_SW)

% replot SW inside NW settings figure
pl_SW.draw( ...
    'Parent', pl_NW.settings(), ...
    'BackgroundColor', [0 0 1] ...
    )
pl_SW.settings()

close(f_NW)
close(f_NE)
close(f_SE)