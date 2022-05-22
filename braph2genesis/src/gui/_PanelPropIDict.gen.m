%% ¡header!
PanelPropIDict < PanelProp (pr, panel property idict) plots the panel of a property idict.

%%% ¡description!
PanelPropIDict plots the panel of an IDICT property with a pushbutton to open the indexed dictionary.
It works for all categories.

%%% ¡seealso!
GUI, PanelElement, PanelProp, uibutton

%% ¡properties!
p
button

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of the idict property.
    %
    % DRAW(PR) draws the panel of the idict property.
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
    
    if ~check_graphics(pr.button, 'pushbutton')
        pr.button = uibutton( ...
            'Parent', pr.p, ...
            'Tag', 'button', ...
            'FontSize', BRAPH2.FONTSIZE, ...
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
    
    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.button, ...
                'Text', el.get(prop).tostring(), ...
                'Tooltip', regexprep(el.get(prop).tree(), {'<strong>', '</strong>'}, {'' ''}) ...
                )
            
        case {Category.PARAMETER, Category.DATA}
            set(pr.button, ...
                'Text', el.get(prop).tostring(), ...
                'Tooltip', regexprep(el.get(prop).tree(), {'<strong>', '</strong>'}, {'' ''}) ...
                )
            
        case Category.RESULT
            value = el.getr(prop);
            
            if isa(value, 'NoValue')
                set(pr.button, ...
                    'Text', el.getPropDefault(prop).tostring(), ...
                    'Tooltip', regexprep(el.getPropDefault(prop).tree(), {'<strong>', '</strong>'}, {'' ''}), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
                set(pr.button, ...
                    'Text', el.get(prop).tostring(), ...
                    'Tooltip', regexprep(el.get(prop).tree(), {'<strong>', '</strong>'}, {'' ''}), ...
                    'Enable', 'on' ...
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
    % 1. REDRAW() sets the units 'characters' for panel. 
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
    
    [h_p, varagin] = get_and_remove_from_varargin(ceil(3.5 * BRAPH2.FONTSIZE * BRAPH2.S), 'Height', varargin);

    pr.redraw@PanelProp('Height', h_p, varargin{:})

    set(pr.button, 'Position', [ ...
        ceil(5 * BRAPH2.S) ...
        ceil(.25 * BRAPH2.FONTSIZE * BRAPH2.S) ...
        ceil(w(pr.p, 'pixels') - 10) ...
        ceil(1.75 * BRAPH2.FONTSIZE * BRAPH2.S) ...
        ])
end
function cb_button(pr)
    %CB_PUSHBUTTON_VALUE executes callback for the pushbutton.
    %
    % CB_PUSHBUTTON_VALUE(PR) executes callback for the pushbutton.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    pr.update()

% % %     % TODO: check once GUI is finalized
% % %     value = el.getr(prop);
% % %     if isa(value, 'NoValue')
% % %         GUI('PE', el.getPropDefault(prop)).draw()
% % %     else
% % %         GUI('PE', el.get(prop)).draw()
% % %     end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PanelPropIDict and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PanelElement() and GUI()
fig1 = uifigure();
et = ETA();
props = [et.PROP_IDICT_M et.PROP_IDICT_P et.PROP_IDICT_D et.PROP_IDICT_F et.PROP_IDICT_G et.PROP_IDICT_R et.PROP_IDICT_R_CALC];
for i = 1:1:length(props)
    pr{i} = PanelPropIDict('EL', et, 'PROP', props(i));
    pr{i}.draw( ...
        'Parent', fig1, ...
        'BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)] ...
        )
    pr{i}.update()
    pr{i}.redraw('Y0', (length(props) - i)/length(props) * h(fig1, 'pixels'))
end
close(fig1)