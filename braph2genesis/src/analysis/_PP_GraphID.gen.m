%% ¡header!
PP_GraphID < PanelProp (pr, panel property subject id) plots the panel of a subject id option.

%%% ¡description!
PP_GraphID plots the panel for a subject id option with a drop-down list.
It works only for the category figure and elements derived 
from PFGraphEnsemble.

%%% ¡seealso!
Graph, uidropdown, PFGraphEnsemble

%% ¡properties!
p
dropdown

%% ¡props!

%%% ¡prop!
G (metadata, item) is the graph dictionary.
%%%% ¡settings!
'IndexedDictionary'


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
    
    if el.isLocked(prop)
        set(pr.dropdown, 'Enable', pr.get('ENABLE'))
    end
    
    if ~strcmp(el.get(prop), 'Mean Graph') && ~pr.get('G').contains(el.get(prop))
        el.set(prop, pr.get('G').getItem(1).get('ID'))
    end
    
    full_item_vector = [{'Mean Graph'} pr.get('G').getKeys()];
    inner_value = el.get(prop);
    
    if (isa(inner_value, 'numeric') && inner_value == 1) || strcmp(inner_value, 'Mean Graph')
        val_tmp = 'Mean Graph';
    else
        val_tmp = pr.get('G').getItem(inner_value).get('ID');
    end
    
    set(pr.dropdown, ...
        'Items', full_item_vector, ...
        'Value', val_tmp ...
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
    
    el.set(prop, get(pr.dropdown, 'Value'))
    el.plotAdjacency()
end