%% ¡header!
Plot < Element (pl, plot) is a plot.

%%% ¡description!
Plot is the basic element to manage graphical representations of elements.
It is an empty graphical panel, which should be filled by derived element.

%%% ¡seealso!
uipanel, ishandle, isgraphics

%% ¡properties!
h_panel % panel graphical handle

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

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Basics
%%%% ¡code!
fig = figure();

pl1 = Plot();
pl1.draw()

pl2 = Plot();
h2 = pl2.draw('Units', 'normalized', 'Position', [.25 .25 .50 .50]);

close(fig)