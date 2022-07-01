%% ¡header!
PP_BrainRegion < PanelProp (pr, panel property brain region) plots the panel of a brain region option.

%%% ¡description!
PP_BrainRegion plots the panel for a brain region option with a drop-down list.
It works only for the category figure and elements derived 
from PFMeasure (PFMeasureNU, PFMeasureGU) and PFComparison.

%%% ¡seealso!
BrainRegion, uidropdown, PFMeasureNU, PFMeasureGU

%% ¡properties!
p
dropdown

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

    bas = el.get('M').get('G').get('BAS');
    ba = bas{1};
    
    if ~ba.get('BR_DICT').contains(el.get(prop))
        el.set(prop, ba.get('BR_DICT').getItem(1).get('ID'))
    end
    
    set(pr.dropdown, ...
        'Items', ba.get('BR_DICT').getKeys(), ...
        'Value', el.get(prop) ...
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

% % %     pr.update()
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PanelPropOption and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PanelElement() and GUI()
fig1 = uifigure();
et1 = ETA();
props = [et1.PROP_OPTION_M et1.PROP_OPTION_P et1.PROP_OPTION_D et1.PROP_OPTION_F et1.PROP_OPTION_G et1.PROP_OPTION_R et1.PROP_OPTION_R_CALC];
for i = 1:1:length(props)
    pr{i} = PanelPropOption('EL', et1, 'PROP', props(i));
    pr{i}.draw( ...
        'Parent', fig1, ...
        'BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)] ...
        )
    pr{i}.update()
    pr{i}.redraw('Y0', (length(props) - i)/length(props) * h(fig1, 'pixels'))
end
close(fig1)