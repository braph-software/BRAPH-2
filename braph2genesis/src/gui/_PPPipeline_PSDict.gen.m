%% ¡header!
PPPipeline_PSDict < PlotProp (pl, pipeline plot) is a plot of a pipeline.

%%% ¡description!
PPPipeline_PCDict plots a pipeline allowing the user to execute it in the correct order.

%%% ¡seealso!
Pipeline, PlotProp

%% ¡properties!
pp

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the pipeline graphical panel.
    %
    % DRAW(PL) draws the pipeline graphical panel.
    %
    % H = DRAW(PL) returns a handle to the pipeline graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H.
    %
    % see also update, resize, refresh, settings, uipanel, isgraphics.
    % output

    pl.pp = draw@PlotProp(pl, varargin{:});

    pip = pl.get('EL');
    ps_dict = pip.get('PS_DICT');

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

    update@PlotProp(pl)
end
function redraw(pl, varargin)
    %REDRAW resizes the element graphical panel.
    %
    % REDRAW(PL) resizes the plot PL.
    %
    % REDRAW(PL, 'Height', HEIGHT) sets the height of PL (by default HEIGHT=2).
    %
    % See also draw, update, refresh.
    
    pl.redraw@PlotProp('Height', 2, varargin{:})
end