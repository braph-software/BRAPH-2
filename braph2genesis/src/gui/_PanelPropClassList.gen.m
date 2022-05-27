%% ¡header!
PanelPropClassList < PanelProp (pr, panel property class list) plots the panel of a property class-list.

%%% ¡description!
PanelPropClassList plots the panel of a CLASSLIST property with a list box.
It works for all categories.

%%% ¡seealso!
GUI, PanelElement, PanelProp, uilistbox

%% ¡properties!
p
listbox

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of the class-list property.
    %
    % DRAW(PR) draws the panel of the class-list property.
    %
    % P = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard panel properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle P of the panel.
    %
    % See also update, redraw, uipanel.
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    pr.p = draw@PanelProp(pr, varargin{:});
    
    if ~check_graphics(pr.listbox, 'uilistbox') 
        pr.listbox = uilistbox( ...
            'Parent', pr.p, ...
            'Tag', 'listbox', ...
            'Items', subclasses(el.getPropSettings(prop), [], [], true), ...
            'Multiselect', 'on', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_listbox} ...
            );
    end

    % callback
    function cb_listbox(~, ~) % (src, event)
        pr.cb_listbox()
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the listbox.
    %
    % UPDATE(PR) updates the content and permissions of the listbox.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.listbox, 'Enable', pr.get('ENABLE'))
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.listbox, 'Value', el.get(prop))

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.listbox, 'Value', el.get(prop))

            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pr.listbox, 'Enable', pr.get('ENABLE'))
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.listbox, ...
                    'Value', el.getPropDefault(prop), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
                set(pr.listbox, ...
                    'Value', el.get(prop), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
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
    %  - HEIGHT = 3.5 * BRAPH2.FONTSIZE * BRAPH2.S
    %
    % See also draw, update, PanelElement, BRAPH2.
    
    [h_p, varargin] = get_and_remove_from_varargin(ceil(10 * BRAPH2.FONTSIZE * BRAPH2.S), 'Height', varargin);

    pr.redraw@PanelProp('Height', h_p, varargin{:})

    set(pr.listbox, 'Position', [ ...
        ceil(5 * BRAPH2.S) ...
        ceil(.25 * BRAPH2.FONTSIZE * BRAPH2.S) ...
        ceil(w(pr.p, 'pixels') * .7) ...
        ceil(h_p - 2 * BRAPH2.FONTSIZE * BRAPH2.S) ...
        ])    
end
function cb_listbox(pr)
    %CB_LISTBOX_VALUE executes callback for the listbox.
    %
    % CB_LISTBOX_VALUE(PR) executes callback for the listbox.

    el = pr.get('EL');
    prop = pr.get('PROP');

    el.set(prop, get(pr.listbox, 'Value'))

    pr.update()
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PanelPropClassList and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PanelElement() and GUI()
fig1 = uifigure();
et = ETA();
props = [et.PROP_CLASSLIST_M et.PROP_CLASSLIST_P et.PROP_CLASSLIST_D et.PROP_CLASSLIST_F et.PROP_CLASSLIST_G et.PROP_CLASSLIST_R et.PROP_CLASSLIST_R_CALC];
for i = 1:1:length(props)
    pr{i} = PanelPropClassList('EL', et, 'PROP', props(i));
    pr{i}.draw( ...
        'Parent', fig1, ...
        'BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)] ...
        )
    pr{i}.update()
    pr{i}.redraw('Y0', (length(props) - i)/length(props) * h(fig1, 'pixels'))
end
close(fig1)