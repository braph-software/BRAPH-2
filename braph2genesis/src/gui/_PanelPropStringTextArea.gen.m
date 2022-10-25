%% ¡header!
PanelPropStringTextArea < PanelProp (pr, panel property string) plots the panel of a property string.

%%% ¡description!
PanelPropStringTextArea plots the panel for a STRING property with a text area.
It works for all categories.

%%% ¡seealso!
GUI, PanelElement, PanelProp, uitextarea

%% ¡props!

%%% ¡prop!
TA_H (gui, size) is the height of the text area in font size units.
%%%% ¡default!
5

%% ¡properties!
p
textarea

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of the string property.
    %
    % DRAW(PR) draws the panel of the string property.
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
    
    if ~check_graphics(pr.textarea, 'uitextarea')
        pr.textarea = uitextarea( ...
            'Parent', pr.p, ...
            'Tag', 'textarea', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_textarea} ...
            );
    end

    function cb_textarea(~, ~) % (src, event)
        pr.cb_textarea()
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the text area.
    %
    % UPDATE(PR) updates the content and permissions of the text area.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.textarea, ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.textarea, 'Value', el.get(prop))

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.textarea, 'Value', el.get(prop))

            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pr.textarea, ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.textarea, ...
                    'Value', el.getPropDefault(prop), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
                set(pr.textarea, ...
                    'Value', el.get(prop), ...
                    'Editable', 'off', ...
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
    %  - HEIGHT = s(2) (header height)
    % The text area is set by the property TA_H.
    %
    % See also draw, update, PanelElement, s.

    [h, varargin] = get_and_remove_from_varargin(s(2), 'Height', varargin);
    Dh = s(pr.get('TA_H'));

    h_p = h + Dh;
    
    pr.redraw@PanelProp('Height', h_p, varargin{:})

    set(pr.textarea, 'Position', [s(.3) s(.3) w(pr.p, 'pixels')-s(.6) Dh])
end
function cb_textarea(pr)
    %CB_EDITFIELD executes callback for the edit field.
    %
    % CB_EDITFIELD(PR) executes callback for the edit field.

    el = pr.get('EL');
    prop = pr.get('PROP');

    value = get(pr.textarea, 'Value');
    el.set(prop, sprintf('%s\\n', value{:})) % double \\ to be converted to single \\ in compilation

% % %     pr.update()
end
  
%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PanelPropStringTextArea and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PanelElement() and GUI()
fig1 = uifigure();
et1 = ETA();
props = [et1.PROP_STRING_M et1.PROP_STRING_P et1.PROP_STRING_D et1.PROP_STRING_F et1.PROP_STRING_G et1.PROP_STRING_R et1.PROP_STRING_R_CALC];
for i = 1:1:length(props)
    pr{i} = PanelPropStringTextArea('EL', et1, 'PROP', props(i), 'TA_H', 2);
    pr{i}.draw( ...
        'Parent', fig1, ...
        'BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)] ...
        )
    pr{i}.update()
    pr{i}.redraw('Y0', (length(props) - i)/length(props) * h(fig1, 'pixels'))
end
close(fig1)
