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

CALLBACKS - These are callback functions:

    pl.<strong>cb_bring_to_front</strong>() - brings to the front the figure with the panel
    pl.<strong>cb_hide</strong>() - hides the figure containing the panel
    pl.<strong>cb_close</strong>() - closes the figure containing the panel

%%% ¡seealso!
uipanel, GUI, PanelElement, PanelProp

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
if check_graphics(pn.p, 'uipanel') && ~isequal(get(pn.p, 'Color'), pn.get('BKGCOLOR'))
    set(pn.p, 'Color', pn.get('BKGCOLOR'))
end

%% ¡methods!
function p_out = draw(pl, varargin)
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
            'BackgroundColor', pl.get('BKGCOLOR'), ...
            'BorderType', 'none' ...
            );
% % %             'BorderType', 'none', ...
    end
    if ~isempty(varargin)
        set(pn.p, varargin{:})
    end
    
    if nargout > 0
        p_out = pn.p;
    end
end
function cb_bring_to_front(pn)
    %CB_BRING_TO_FRONT brings to the front the figure with the panel.
    %
    % CB_BRING_TO_FRONT(PL) brings to the front the figure with the panel.
    %
    % See also cb_hide, cb_close.

    if check_graphics(pn.p, 'uipanel')
        fig = ancestor(pn.p, 'figure');
        figure(fig)
        set(fig, ...
            'Visible', 'on', ...
            'WindowState', 'normal' ...
            )        
    end
end
function cb_hide(pn)
    %CB_HIDE hides the figure containing the panel.
    %
    % CB_HIDE(PL) hides the figure containing the panel.
    %
    % See also cb_bring_to_front, cb_close.
    
    if check_graphics(pn.p, 'uipanel')
        fig = ancestor(pn.p, 'figure');
        set(fig, 'Visible', 'off')
    end
end
function cb_close(pn)
    %CB_CLOSE closes the figure containing the panel.
    % 
    % CB_CLOSE(PN) closes the figure containing the panel.
    %
    % See also cb_bring_to_front, cb_hide.

    if check_graphics(pn.p, 'uipanel')
        close(ancestor(pn.p, 'figure'))
    end
end

% % % %% ¡tests!
% % % 
% % % %%% ¡test!
% % % %%%% ¡name!
% % % Example
% % % %%%% ¡code!
% % % % figures occupying 4 quadrants of the screen
% % % f_NW = figure( ...
% % %     'Name', 'NW', ...
% % %     'OuterPosition', [Plot.x0(0)+Plot.w(0)/4 Plot.h(0)/2 Plot.w(0)/4 Plot.h(0)/4] ...
% % %     );
% % % f_NE = figure( ...
% % %     'Name', 'NE', ...
% % %     'OuterPosition', [Plot.w(0)/2 Plot.h(0)/2 Plot.w(0)/4 Plot.h(0)/4] ...
% % %     );
% % % f_SW = figure( ...
% % %     'Name', 'SW', ...
% % %     'OuterPosition', [Plot.x0(0)+Plot.w(0)/4 Plot.y0(0)+Plot.h(0)/4 Plot.w(0)/4 Plot.h(0)/4] ...
% % %     );
% % % f_SE = figure( ...
% % %     'Name', 'SE', ...
% % %     'OuterPosition', [Plot.w(0)/2 Plot.y0(0)+Plot.h(0)/4 Plot.w(0)/4 Plot.h(0)/4] ...
% % %     );
% % % 
% % % % panel in center of figure NW
% % % pl_NW = Plot();
% % % pl_NW.draw( ...
% % %     'Parent', f_NW, ...
% % %     'Units', 'normalized', ...
% % %     'Position', [.25 .25 .50 .50], ...
% % %     'BackgroundColor', [1 0 0] ...
% % %     )
% % % pl_NW.settings( ...
% % %     'Color', [1 0 0] ...
% % %     )
% % % 
% % % % panel in center of figure NE
% % % % retrieving the panel and settings figure handles
% % % pl_NE = Plot();
% % % hp_NE = pl_NE.draw( ...
% % %     'Parent', f_NE, ...
% % %     'Units', 'normalized', ...
% % %     'Position', [.25 .25 .50 .50], ...
% % %     'BackgroundColor', [0 1 0] ...
% % %     );
% % % fs_NE = pl_NE.settings( ...
% % %     'Color', [0 1 0], ...
% % %     'Name', 'Renamed this settings figure', ...
% % %     'Units', get(f_NE, 'Units'), ...
% % %     'Position', [Plot.x0(f_NE) Plot.y0(f_NE) Plot.w(f_NE) Plot.h(f_NE)] ...
% % %     );
% % % 
% % % % panel in center of figure SW
% % % % note the misalignement of the settings figure
% % % pl_SW = Plot();
% % % pl_SW.draw( ...
% % %     'Parent', f_SW, ...
% % %     'Units', 'normalized', ...
% % %     'Position', [.25 .25 .50 .50], ...
% % %     'BackgroundColor', [0 0 1] ...
% % %     );
% % % pl_SW.settings( ...
% % %     'Color', [0 0 1], ...
% % %     'Position', [Plot.x0(f_SW, 'normalized')+Plot.w(f_SW, 'normalized')/4 Plot.y0(f_SW, 'normalized')+Plot.h(f_SW, 'normalized')/4 Plot.w(f_SW, 'normalized')/2 Plot.h(f_SW, 'normalized')/2] ...
% % %     )
% % % 
% % % % panel in on top of figure SE
% % % % note the alignement of the settings figure
% % % pl_SE = Plot();
% % % pl_SE.draw( ...
% % %     'Parent', f_SE, ...
% % %     'Units', 'normalized', ...
% % %     'Position', [.25 .25 .50 .50], ...
% % %     'BackgroundColor', 'w' ...
% % %     );
% % % pl_SE.settings( ...
% % %     'Color', 'w', ...
% % %     'OuterPosition', [Plot.x0(f_SE, 'normalized') Plot.y0(f_SE, 'normalized') Plot.w(f_SE, 'normalized') Plot.h(f_SE, 'normalized')] ...
% % %     )
% % % 
% % % % close SE settings figure
% % % pl_SE.cb_close_fs()
% % % 
% % % % bring to from NW settings figure
% % % pl_NW.cb_bring_to_front()
% % % 
% % % % close SE
% % % close(f_SW)
% % % 
% % % % replot SW inside NW settings figure
% % % pl_SW.draw( ...
% % %     'Parent', pl_NW.settings(), ...
% % %     'BackgroundColor', [0 0 1] ...
% % %     )
% % % pl_SW.settings()
% % % 
% % % close(f_NW)
% % % close(f_NE)
% % % close(f_SE)
% % % 
% % % %%% ¡test!
% % % %%%% ¡name!
% % % Callbacks
% % % %%%% ¡code!
% % % pl = Plot();
% % % pl.draw()
% % % 
% % % pl.settings()
% % % pl.cb_close_fs()
% % % 
% % % pl.settings()
% % % pl.cb_hide()
% % % pl.cb_bring_to_front()
% % % 
% % % pl.settings()
% % % pl.cb_close()
