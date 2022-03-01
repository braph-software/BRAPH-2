%% ¡header!
PPAnalyzeGroup_USE_COVARIATES < PlotPropLogical (pr, plot property logical) is a plot of a property logical.

%%% ¡description!
PPAnalyzeGroup_USE_COVARIATES plots a LOGICAL property USE_COVARIATES in a checkbox.

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
p
checkbox_value

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the panel of the logical property.
    %
    % DRAW(PR) draws the panel of the logical property.
    %
    % H = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H of the panel.
    %
    % See also update, redraw, refresh, uipanel.
    
    pr.p = draw@PlotPropLogical(pr, varargin{:});
    children = get(pr.p, 'Children');
    for i = 1:1:length(children)
        if check_graphics(children(i), 'checkbox')
            pr.checkbox_value = children(i);
        end
    end

    set(pr.checkbox_value, 'Callback', {@checkbox_value_mode})

    function checkbox_value_mode(src, ~)
        cb_checkbox_value(pr);
        f = ancestor(pr.p, 'figure');
        for i = 1:1:get(f, 'UserData').get('pe').get('pr_dict').length
            pp = get(f, 'UserData').get('pe').get('pr_dict').getItem(i);
            if isequal(pp.get('ID'), 'correlation_rule')
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

    update@PlotPropLogical(pr)
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
    %  - HEIGHT=2.5 characters.
    %
    % See also draw, update, refresh, PlotElement.
    
    [h, varargin] = get_and_remove_from_varargin(2.5, 'Height', varargin);

    pr.redraw@PlotPropLogical('Height', h, varargin{:})
end
function cb_checkbox_value(pr)
    %CB_CHECKBOX_VALUE executes callback for the checkbox value.
    %
    % CB_CHECKBOX_VALUE(PR) executes callback for the checkbox value.

    cb_checkbox_value@PlotPropLogical(pr)
end