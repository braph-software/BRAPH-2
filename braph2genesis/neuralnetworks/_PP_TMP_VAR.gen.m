%% ¡header!
PP_TMP_VAR < PanelProp (pr, panel property nn id) plots the panel of a nn id option.

%%% ¡description!
PP_TMP_VAR plots the panel for a density or threshold id option with a drop-down list.
It works only for the category figure and elements derived 
from PFGraphEnsemble.

%%% ¡seealso!
Graph, uidropdown, PFMultigraph

%% ¡properties!
p
dropdown

%% ¡props!

%%% ¡prop!
TMP_VAR (metadata, cell) is the graph.

%% ¡methods!
function p_out = draw(pr, varargin)

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    pr.p = draw@PanelProp(pr, varargin{:});
    
    if ~check_graphics(pr.dropdown, 'uidropdown')
        pr.dropdown = uidropdown( ...
            'Parent', pr.p, ...
            'Tag', 'dropdown', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_dropdown} ...
            );
    end

    function cb_dropdown(~, ~) % (src, event)
        pr.cb_dropdown()
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    tmp_Var = pr.get('TMP_VAR');
    
    if el.isLocked(prop)
        set(pr.dropdown, 'Enable', pr.get('ENABLE'))
    end 
    
    n_layers = [1:size(tmp_Var, 2)];
    labels = cellfun(@(x) ['Layer : ' num2str(x)],num2cell(n_layers), 'UniformOutput', false);
    default_value = el.get(prop);
    
    set(pr.dropdown, ...
        'Items', labels, ...
        'Value', labels(str2double(default_value)) ...
        )

    value = el.getr(prop);
    if isa(value, 'Callback')
        set(pr.dropdown, ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
    end
end
function redraw(pr, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PR) resizes the property panel and repositions its graphical objects. 
    % 
    % Important notes:
    % 1. REDRAW() sets the units 'pixels' for panel. 
    % 2. REDRAW() is typically called internally by PanelElement and does not need 
    %  to be explicitly called in children of PanelProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT = s(3.5)
    %
    % See also draw, update, PanelElement, s.
    
    [h_p, varargin] = get_and_remove_from_varargin(s(3.5), 'Height', varargin);

    pr.redraw@PanelProp('Height', h_p, varargin{:})
    
    set(pr.dropdown, 'Position', [s(.3) s(.3) w(pr.p, 'pixels')*.7 s(1.7)])    
end
function cb_dropdown(pr)
    %CB_DROPDOWN executes callback for the drop down.
    %
    % CB_DROPDOWN(PR) executes callback for the drop down.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    val = get(pr.dropdown, 'Value');
    tmp_Var = pr.get('TMP_VAR');
    n_layers = [1:size(tmp_Var, 2)];
    labels = cellfun(@(x) ['Layer : ' num2str(x)],num2cell(n_layers), 'UniformOutput', false);
    index = find(contains(labels, val), 1, 'last');
    
    el.set(prop, num2str(index))
    el.plot_TMP_VAR()
end