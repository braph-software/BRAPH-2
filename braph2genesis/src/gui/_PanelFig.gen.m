%% ¡header!
PanelFig < Panel (pf, panel figure) plots the panel of a figure.

%%% ¡description!
PanelFig plots a figure.

CONSTRUCTOR - To construct a PanelFig use the constructor:

    pf = PanelFig()
    
DRAW - To create the element panel, call pf.draw():

    p = pf.<strong>draw</strong>();
    p = pf.<strong>draw</strong>(''Parent'', f);
 
 Typically, f is a figure where the panel is plotted.
 It is also possible to use pf.draw() to get the parent panel handle
  and to set its properties (as in the case of Panel).

CALLBACK - These are the callback functions:

    pe.<strong>cb_bring_to_front</strong>() - brings to the front the figure with the element panel and its dependent figures
    pe.<strong>cb_hide</strong>() - hides the figure with the element panel and its dependent figures
    pe.<strong>cb_close</strong>() - closes the figure with the element panel and its dependent figures

%%% ¡seealso!
GUI, GUIFig, uipanel

%% ¡props!

%%% ¡prop!
ST_POSITION (figure, item) determines the panel position.
%%%% ¡settings!
'SettingsPosition'
%%%% ¡gui!
pr = SettingsPositionPP('EL', pf, 'PROP', PanelFig.ST_POSITION, varargin{:});

%% ¡props_update!

%%% ¡prop!
BKGCOLOR (figure, color) is the panel background color.
%%%% ¡default!
[1 1 1]
%%%% ¡postprocessing!
if check_graphics(pf.p, 'uipanel') && ~isequal(get(pf.p, 'BackgroundColor'), pf.get('BKGCOLOR'))
    set(pf.p, 'BackgroundColor', pf.get('BKGCOLOR'))
end

%% ¡properties!
p % handle for panel figure

%% ¡methods!
function p_out = draw(pf, varargin)
    %DRAW draws the figure panel.
    %
    % DRAW(PF) draws the figure panel.
    %
    % P = DRAW(PF) returns a handle to the parent panel.
    %
    % DRAW(PF, 'Property', VALUE, ...) sets the properties of the parent
    %  panel with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle P of the parent panel.
    %
    % See also uipanel.

    pf.p = draw@Panel(pf, ...
        varargin{:}, ...
        'AutoResizeChildren', 'off' ...
        );
    
    if isa(pf.getr('ST_POSITION'), 'NoValue')
        pf.memorize('ST_POSITION').set('PANEL', pf, 'UITAG', 'p')
    end
        
    % output
    if nargout > 0
        p_out = pf.p;
    end
end