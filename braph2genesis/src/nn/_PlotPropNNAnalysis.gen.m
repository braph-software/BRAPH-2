%% ¡header!
PlotPropNNAnalysis < PlotProp (pl, plot property NN Analysis) is a plot of a property neural network analysis.

%%% ¡description!
PlotProp plots a property neural network analysis of an element in a panel.

%%% ¡seealso!
GUI, PlotElement, PlotProp, BaseNN

%% ¡properties!
pp

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the NN Analysis property graphical panel.
    %
    % DRAW(PL) draws the NN Analysis property graphical panel.
    %
    % H = DRAW(PL) returns a handle to the NN Analysis property graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain surface graphical panel H.
    %
    % see also update, redraw, refresh, settings, uipanel, isgraphics.

    pl.pp = draw@PlotProp(pl, varargin{:});

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
    % See also draw, redraw, refresh.

    update@PlotProp(pl)
    
    el = pl.get('EL');
    prop = pl.get('PROP');    
    value = el.getr(prop);
    
    % do nothing
end
function redraw(pl, varargin)
    %REDRAW redraws the element graphical panel.
    %
    % REDRAW(PL) redraws the plot PL.
    %
    % REDRAW(PL, 'Height', HEIGHT) sets the height of PL (by default HEIGHT=3.3).
    %
    % See also draw, update, refresh.
    
    pl.redraw@PlotProp('Height', 1.8, varargin{:})

end