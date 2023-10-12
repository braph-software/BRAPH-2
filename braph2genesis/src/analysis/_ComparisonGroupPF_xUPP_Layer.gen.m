%% ¡header!
ComparisonGroupPF_xUPP_Layer < PanelProp (pr, panel property layer) plots the panel to select a layer.

%%% ¡description!
ComparisonGroupPF_xUPP_Layer plots the panel to select a layer from a multilayer graph from a drop-down list.
It is supposed to be used with the property Layer of ComparisonGroupPF_NU, ComparisonGroupPF_BU, or ComparisonGroupPF_GU.

%%% ¡seealso!
uidropdown, GUI, ComparisonGroupPF_NU, ComparisonGroupPF_BU, ComparisonGroupPF_GU

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'ComparisonGroupPF_xUPP_Layer'

%%% ¡prop!
NAME (constant, string) is the name of the panel property layer.
%%%% ¡default!
'ComparisonGroupPF_xUPP_Layer'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel property layer.
%%%% ¡default!
'ComparisonGroupPF_xUPP_Layer plots the panel to select a layer from a multilayer graph from a drop-down list. It is supposed to be used with the property LAYER of ComparisonGroupPF_NU, ComparisonGroupPF_NS, or ComparisonGroupPF_NB.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel property Layer.
%%%% ¡settings!
'ComparisonGroupPF_xUPP_Layer'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel property Layer.
%%%% ¡default!
'ComparisonGroupPF_xUPP_Layer ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel property layer.
%%%% ¡default!
'ComparisonGroupPF_xUPP_Layer label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel property layer.
%%%% ¡default!
'ComparisonGroupPF_xUPP_Layer notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡default!
ComparisonGroupPF_NU()

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
ComparisonGroupPF_NU.LAYER

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the property panel.
%%%% ¡default!
s(4)

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('DROPDOWN')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the editfield.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value
    pf = pr.get('EL');
    LAYER = pr.get('PROP');

    keys = pf.get('CP').get('C').get('A1').get('G').get('ALAYERTICKS');
    if (length(keys) <= 1)
        set(pr.get('DROPDOWN'), 'Enable', 'off')
    else
        set(pr.get('DROPDOWN'), ...
            'Items', cellfun(@(x) ['L' num2str(x)], num2cell([1:1:length(keys)]), 'uniformoutput', false), ...
            'ItemsData', [1:1:length(keys)], ...
            'Value', pf.get(LAYER) ...
            )
    end
    
    prop_value = pf.getr(LAYER);
    if pf.isLocked(LAYER) || isa(prop_value, 'Callback')
        set(pr.get('DROPDOWN'), 'Enable', 'off')
    end
end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
if value
    w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
    
    set(pr.get('DROPDOWN'), 'Position', [s(.3) s(.3) .70*w_p s(1.75)])
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('DROPDOWN', Element.getNoValue())
end

%% ¡props!

%%% ¡prop!
DROPDOWN (evanescent, handle) is the dropdown for the layer.
%%%% ¡calculate!
el = pr.get('EL');
prop = pr.get('PROP');

dropdown = uidropdown( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'DROPDOWN', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
    'ValueChangedFcn', {@cb_dropdown} ...
    );

value = dropdown;
%%%% ¡calculate_callbacks!
function cb_dropdown(~, ~)
    pr.get('EL').set(pr.get('PROP'), get(pr.get('DROPDOWN'), 'Value'))
end

%% ¡tests!

%%% ¡excluded_props!
[ComparisonGroupPF_xUPP_Layer.DRAW ComparisonGroupPF_xUPP_Layer.PARENT ComparisonGroupPF_xUPP_Layer.H ComparisonGroupPF_xUPP_Layer.UPDATE ComparisonGroupPF_xUPP_Layer.LISTENER_CB ComparisonGroupPF_xUPP_Layer.DROPDOWN]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonGroupPF_xUPP_Layer'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonGroupPF_xUPP_Layer'])