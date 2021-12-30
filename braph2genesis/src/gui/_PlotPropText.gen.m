%% ¡header!
PlotPropText < PlotPropString (pl, multiline plot property string) is a multiline plot of a property string.

%%% ¡description!
PlotPropText plots a property string of an element in a panel.
For singleline text it is more compact to use PlotPropString instead.

%%% ¡seealso!
GUI, PlotElement, PlotProp, PlotPropString

%% ¡properties!
pp

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the string property graphical panel.
    %
    % DRAW(PL) draws the string property graphical panel.
    %
    % H = DRAW(PL) returns a handle to the string property graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H.
    %
    % see also update, resize, refresh, settings, uipanel, isgraphics.

    pl.pp = draw@PlotPropString(pl, 'Position', [.01 .03 .98 .85], varargin{:});

    % output
    if nargout > 0
        h_panel = pl.pp;
    end
end
function update(pl)
    %UPDATE updates the content of the property graphical panel.
    %
    % UPDATE(PL) updates the content of the property graphical panel.
    %
    % See also draw, resize, refresh.

    update@PlotPropString(pl)
end
function redraw(pl, varargin)
    %REDRAW resizes the element graphical panel.
    %
    % REDRAW(PL) resizes the plot PL.
    %
    % REDRAW(PL, 'Height', HEIGHT) sets the height of PL (by default HEIGHT=8).
    %
    % See also draw, update, refresh.
    
    pl.redraw@PlotPropString('Height', 8, varargin{:})
end