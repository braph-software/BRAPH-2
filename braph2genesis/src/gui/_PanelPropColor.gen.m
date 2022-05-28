%% ¡header!
PanelPropColor < PanelProp (pr, panel property color) plots the panel of a property color.

%%% ¡description!
PanelPropColor plots the panel for a COLOR property with a button.
It works for all categories.

%%% ¡seealso!
GUI, PanelElement, PanelProp, uibutton

%% ¡properties!
p
button

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of the color property.
    %
    % DRAW(PR) draws the panel of the color property.
    %
    % P = DRAW(PR) returns a handle to the property panel.
    % 
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle P of the panel.
    %
    % See also update, redraw, uipanel.
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    pr.p = draw@PanelProp(pr, varargin{:});
    
    if ~check_graphics(pr.button, 'uibutton')
        pr.button = uibutton( ...
            'Parent', pr.p, ...
            'Tag', 'button', ...
            'Text', '', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ButtonPushedFcn', {@cb_button} ...
            );
    end

    function cb_button(~, ~) % (src, event)
        pr.cb_button()
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the button.
    %
    % UPDATE(PR) updates the content and permissions of the button.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.button, 'Enable', pr.get('ENABLE'))
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.button, 'BackgroundColor', el.get(prop))

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.button, 'BackgroundColor', el.get(prop))

            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pr.button, 'Enable', pr.get('ENABLE'))
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.button, ...
                    'BackgroundColor', el.getPropDefault(prop), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
                set(pr.button, ...
                    'BackgroundColor', el.get(prop), ...
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
    %  - HEIGHT = s(3.5)
    %
    % See also draw, update, PanelElement, s.

    [h_p, varagin] = get_and_remove_from_varargin(s(3.5), 'Height', varargin);

    pr.redraw@PanelProp('Height', h_p, varargin{:})

    set(pr.button, 'Position', [s(.3) s(.3) .70*w(pr.p, 'pixels') s(1.7)])
end
function cb_button(pr)
    %CB_EDITFIELD executes callback for the edit field.
    %
    % CB_EDITFIELD(PR) executes callback for the edit field.

    el = pr.get('EL');
    prop = pr.get('PROP');

    new_color = uisetcolor(el.get(prop));
    if ~isequal(new_color, el.get(prop))
        el.set(prop, new_color)

        pr.update()
    end
end
  
%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PanelPropColor and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PanelElement() and GUI()
fig1 = uifigure();
et1 = ETA();
props = [et1.PROP_COLOR_M et1.PROP_COLOR_P et1.PROP_COLOR_D et1.PROP_COLOR_F et1.PROP_COLOR_G et1.PROP_COLOR_R et1.PROP_COLOR_R_CALC];
for i = 1:1:length(props)
    pr{i} = PanelPropColor('EL', et1, 'PROP', props(i));
    pr{i}.draw( ...
        'Parent', fig1, ...
        'BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)] ...
        )
    pr{i}.update()
    pr{i}.redraw('Y0', (length(props) - i)/length(props) * h(fig1, 'pixels'))
end
close(fig1)
