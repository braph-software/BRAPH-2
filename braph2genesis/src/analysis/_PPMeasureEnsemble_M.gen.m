%% ¡header!
PPMeasureEnsemble_M < PlotProp (pr, plot property M of measure ensemble) is a plot of property M of measure ensemble.

%%% ¡description!
PPMeasureEnsemble_M plots a Measure ensemble result.

%%% ¡seealso!
GUI, PlotElement, PlotProp, MultigraphBUD, MultigraphBUT, MeasureEnsemble.

%% ¡properties!
p

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the idict for group ensemble property graphical panel.
    %
    % DRAW(PR) draws the idict property graphical panel.
    %
    % H = DRAW(PR) returns a handle to the idict property graphical panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain surface graphical panel H.
    %
    % see also update, redraw, refresh, settings, uipanel, isgraphics.

    % create panel with slider
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if Measure.is_global(el)
        pr.p = PlotPropMeasureEnsembleGlobal( ...
            'EL', el, ...
            'PROP', prop, ...
            'ID', 'm', ...
            'TITLE', 'M', ...
            'BKGCOLOR', [0.8 0.5 0.2]).draw(varargin{:});
    elseif Measure.is_nodal(el)
        pr.p = PlotPropMeasureEnsembleNodal( ...
            'EL', el, ...
            'PROP', prop, ...
            'ID', 'm', ...
            'TITLE', 'M', ...
            'BKGCOLOR', [0.8 0.5 0.2]).draw(varargin{:});
    else % binodal
        pr.p = PlotPropMeasureEnsembleBinodal( ...
            'EL', el, ...
            'PROP', prop, ...
            'ID', 'm', ...
            'TITLE', 'M', ...
            'BKGCOLOR', [0.8 0.5 0.2]).draw(varargin{:});
    end

    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content of the property graphical panel.
    %
    % UPDATE(PR) updates the content of the property graphical panel.
    %
    % See also draw, redraw, refresh.
    
    get(pr.p, 'UserData').update()
end
function redraw(pr, varargin)
    %REDRAW redraws the element graphical panel.
    %
    % REDRAW(PR) redraws the plot PR.
    %
    % REDRAW(PR, 'Height', HEIGHT) sets the height of PR (by default HEIGHT=3.3).
    %
    % See also draw, update, refresh.

    get(pr.p, 'UserData').redraw(varargin{:})    
end