%% ¡header!
PlotGlobalMeasure < PlotPropString (pr, plot global measure) represents the nodal measure.
% FIXME: < PlotPropScalar

%%% ¡description!
PlotGlobalMeasure represents the global measure.

%%% ¡seealso!
GUI, PlotElement, PlotPropString, PPMeasure_M.

%% ¡properties!
p
edit_value

% FIXME: PL > PR, pl > pr

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws a table with the global measure.
    %
    % DRAW(PL) draws the property panel a table with the structural data of 
    %  a subject.
    %
    % H = DRAW(PL) returns a handle to the property panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the panel 
    %  with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H of the panel.
    %
    % See also update, redraw, settings, uipanel.
    
    pr.p = draw@PlotPropString(pr, varargin{:});

    % retrieves the handle of the table
    children = get(pr.p, 'Children');
    for i = 1:1:length(children)
        if check_graphics(children(i), 'edit')
            pr.edit_value = children(i);
        end
    end

    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr, layer)
    %UPDATE updates the content of the property panel and its graphical objects.
    %
    % UPDATE(PL) updates the content of the property panel and its graphical objects.
    %
    % Important note:
    % 1. UPDATE() is typically called internally by PlotElement and does not need 
    %  to be explicitly called in children of PlotProp.
    %
    % See also draw, redraw, PlotElement.

    update@PlotProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    value = el.getr(prop);

    set(pr.edit_value, ...
        'String', value{layer}, ...
        'Enable', pr.get('ENABLE') ...
        )
end
function redraw(pr, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PL) resizes the property panel and repositions its
    %   graphical objects. 
    % 
    % Important notes:
    % 1. REDRAW() sets the units 'characters' for panel and all its graphical objects. 
    % 2. REDRAW() is typically called internally by PlotElement and does not need 
    %  to be explicitly called in children of PlotProp.
    %
    % REDRAW(PL, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT=1.4 characters.
    %
    % See also draw, update, PlotElement.
    
    pr.redraw@PlotPropString(varargin{:});
end