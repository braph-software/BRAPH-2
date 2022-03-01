%% ¡header!
PPAnalyzeGroup_CORRELATION_RULE < PlotPropOption (pr, plot property option) is a plot of an option property.

%%% ¡description!
PlotPropOption plots an OPTION property of an element in a popupmenu.
It works for all categories.

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
p
popupmenu_value

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the checkbox of the option property.
    %
    % DRAW(PR) draws the checkbox of the option property.
    %
    % H = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H.
    %
    % see also update, redraw, refresh, settings, uipanel, isgraphics.

    pr.p = draw@PlotPropOption(pr, varargin{:});
    children = get(pr.p, 'Children');
    for i = 1:1:length(children)
        if check_graphics(children(i), 'popupmenu')
            pr.popupmenu_value = children(i);
        end
    end

    set(pr.popupmenu_value, 'Callback', {@cb_popupmenu_value_mode})

    function cb_popupmenu_value_mode(src, ~)
        cb_popupmenu_value(pr);
        f = ancestor(pr.p, 'figure');
        for i = 1:1:get(f, 'UserData').get('pe').get('pr_dict').length
            pp = get(f, 'UserData').get('pe').get('pr_dict').getItem(i);
            if isequal(pp.get('ID'), 'use_covariates')
                break
            end
        end
        pp.update();
    end

    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the checkbox.
    %
    % UPDATE(PR) updates the content and permissions of the checkbox.
    %
    % See also draw, redraw, refresh, PlotElement.

    update@PlotPropOption(pr)
end
function redraw(pr, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PR) resizes the property panel and repositions its
    %   graphical objects. 
    % 
    % Important notes:
    % 1. REDRAW() sets the units 'characters' for panel and all its graphical objects. 
    % 2. REDRAW() is typically called internally by PlotElement and does not need 
    %  to be explicitly called in children of PlotProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT=3.5 characters.
    %
    % See also draw, update, refresh, PlotElement.
    
    [h, varargin] = get_and_remove_from_varargin(3.5, 'Height', varargin);

    pr.redraw@PlotProp('Height', h, varargin{:})
end
function cb_popupmenu_value(pr)
    %CB_POPUPMENU_VALUE executes callback for the popupmenu value.
    %
    % CB_POPUPMENU_VALUE(PR) executes callback for the popupmenu value.

    cb_popupmenu_value@PlotPropOption(pr)
end