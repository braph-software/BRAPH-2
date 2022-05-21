%% ¡header!
PanelPropAlpha < PanelProp (pr, panel property alpha) plots the panel of a property alpha.

%%% ¡description!
PanelPropAlpha plots the panel for a ALPHA property with a numeric edit field and a slider.
It works for all categories.

%%% ¡seealso!
GUI, PanelElement, PanelProp, uieditfield, uislider

%% ¡properties!
p
editfield
slider

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of the alpha property.
    %
    % DRAW(PR) draws the panel of the alpha property.
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
    
    if ~check_graphics(pr.editfield, 'uieditfield')
        pr.editfield = uieditfield('numeric', ...
            'Parent', pr.p, ...
            'Tag', 'editfield', ...
            'Limits', [0 1], ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_editfield} ...
            );
    end

    function cb_editfield(~, ~) % (src, event)
        pr.cb_editfield()
    end

    if ~check_graphics(pr.slider, 'uislider')
        pr.slider = uislider( ...
            'Parent', pr.p, ...
            'Tag', 'slider', ...
            'Limits', [0 1], ...
            'FontSize', BRAPH2.FONTSIZE / 2, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_slider} ...
            );
    end
    
    function cb_slider(~, ~) % (src, event)
        pr.cb_slider()
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the edit field.
    %
    % UPDATE(PR) updates the content and permissions of the edit field.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.editfield, ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.slider, 'Enable', pr.get('ENABLE'))
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.editfield, 'Value', el.get(prop))
            set(pr.slider, 'Value', el.get(prop))

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.editfield, 'Value', el.get(prop))
            set(pr.slider, 'Value', el.get(prop))

            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pr.editfield, ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.slider, 'Enable', pr.get('ENABLE'))
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.editfield, ...
                    'Value', el.getPropDefault(prop), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.slider, ...
                    'Value', el.getPropDefault(prop), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
                set(pr.editfield, ...
                    'Value', el.get(prop), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.slider, ...
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
    %  - HEIGHT = 5 * BRAPH2.FONTSIZE * BRAPH2.S
    %
    % See also draw, update, PanelElement, BRAPH2.

    [h_p, varargin] = get_and_remove_from_varargin(ceil(5 * BRAPH2.FONTSIZE * BRAPH2.S), 'Height', varargin);
    
    pr.redraw@PanelProp('Height', h_p, varargin{:})
    
    set(pr.editfield, 'Position', [ ...
        ceil(5 * BRAPH2.S) ...
        ceil(.75 * BRAPH2.FONTSIZE * BRAPH2.S) ...
        ceil(w(pr.p, 'pixels') * .15) ...
        ceil(1.75 * BRAPH2.FONTSIZE * BRAPH2.S) ...
        ])
    
    set(pr.slider, 'Position', [ ...
        ceil(5 * BRAPH2.S) + ceil(w(pr.p, 'pixels') * .15) + ceil(20 * BRAPH2.S) ...
        ceil(2.25 * BRAPH2.FONTSIZE * BRAPH2.S) ...
        ceil(w(pr.p, 'pixels') * .7) ...
        3 ... % the height of a slider cannot be changed
        ])
end
function cb_editfield(pr)
    %CB_EDITFIELD executes callback for the edit field.
    %
    % CB_EDITFIELD(PR) executes callback for the edit field.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.set(prop, get(pr.editfield, 'Value'))

    pr.update()
end
function cb_slider(pr)
    %CB_SLIDER executes callback for the slider.
    %
    % CB_SLIDER(PR) executes callback for the slider.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.set(prop, get(pr.slider, 'Value'))

    pr.update()
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PanelPropAlpha and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PanelElement() and GUI()
fig1 = uifigure();
et = ETA();
props = [et.PROP_ALPHA_M et.PROP_ALPHA_P et.PROP_ALPHA_D et.PROP_ALPHA_F et.PROP_ALPHA_G et.PROP_ALPHA_R et.PROP_ALPHA_R_CALC];
for i = 1:1:length(props)
    pr{i} = PanelPropAlpha('EL', et, 'PROP', props(i));
    pr{i}.draw( ...
        'Parent', fig1, ...
        'BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)] ...
        )
    pr{i}.update()
    pr{i}.redraw('Y0', (length(props) - i)/length(props) * h(fig1, 'pixels'))
end
close(fig1)