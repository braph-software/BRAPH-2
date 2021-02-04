%% ¡header!
Plot < Element (pl, plot) is a plot.

%%% ¡description!
Plot is the basic element to manage graphical representations of elements.
It is an empty graphical panel, which should be filled by derived element.

%%% ¡seealso!
uipanel, ishandle, isgraphics

%% ¡properties!
h_panel % panel graphical handle
f_settings % setting figure handle 

%% ¡props!

%%% ¡prop!
BKGCOLOR (metadata, rvector) is background color of the setting interface.
%%%% ¡check_prop!
check = (length(value) == 3) && all(value >= 0 & value <= 1);
%%%% ¡default!
[.95 .95 .95]

%%% ¡prop!
SETVIS (metadata, logical) determines whether the settings are visible.
%%%% ¡default!
true

%%% ¡prop!
SETPOS (metadata, rvector) is the normalized position of the setting interface on the screen.
%%%% ¡check_prop!
check = (length(value) == 4) && all(value >= 0 & value <= 1);
%%%% ¡default!
[.70 .50 .40 .20]

%%% ¡prop!
SETNAME (metadata, string) is the name of the setting interface.
%%%% ¡default!
'Plot Settings'

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the graphical panel.
    %
    % DRAW(PL) draws the graphical panel.
    %
    % H = DRAW(PL) returns a handle to the graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % see also uipanel, ishandle, isgraphics.

    if isempty(pl.h_panel) || ~isgraphics(pl.h_panel, 'uipanel')
        pl.h_panel = uipanel(varargin{:});
    end
    
    if nargout > 0
        h_panel = pl.h_panel;
    end
end
function f_settings = settings(pl, varargin)
%     % BRAIN_SETTINGS opens the GUI property editor
%     %
%     % BRAIN_SETTINGS(BS) allows the user to specify the properties
%     % of the brain surf by opening a GUI property editor.
%     %
%     % BRAIN_SETTINGS(BS, 'Property', VALUE, ...) allows the user to specify the 
%     % properties of the brain surf by opening a GUI property editor.
%     % sets the property of the user interface's Property to VALUE.
%     % Admissible properties are:
%     % FigPosition   -  position of the user interface on the screen
%     % FigColor      -  background color of the user interface
%     % FigName       -  name of the user interface
%     %
%     % See also brain, trisurf.

    % create a figure
    if isempty(pl.f_settings) || ~isgraphics(pl.f_settings, 'figure')
        pl.f_settings = figure('Visible', 'off');
    end
    f = pl.f_settings;
    set(f, 'units', 'normalized')
    set(f, 'Position', pl.get('SETPOS'))
    set(f, 'Color', pl.get('BKGCOLOR'))
    set(f, 'Name', pl.get('SETNAME'))
    set(f, 'MenuBar', 'none')
    set(f, 'Toolbar', 'none')
    set(f, 'NumberTitle', 'off')
    set(f, 'DockControls', 'off')

    set(f, 'Visible', pl.get('SETVIS'))
    
    if nargout > 0
        f_settings = pl.f_settings;
    end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Basics
%%%% ¡code!
fig = figure();

pl1 = Plot();
pl1.draw()
pl1.settings()

pl2 = Plot();
h2 = pl2.draw('Units', 'normalized', 'Position', [.25 .25 .50 .50]);
f2 = pl2.settings();

close(pl1.settings())
close(pl2.settings())
close(fig)