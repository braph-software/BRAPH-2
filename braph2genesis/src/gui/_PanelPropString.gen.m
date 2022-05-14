%% ¡header!
PanelPropString < PanelProp (pr, panel property string) plots the panel of a string property.

%%% ¡description!
% % % PanelPropString plots a STRING property of an element in an edit field.
% % % It works for all categories.
% % % It has the following additional properties:
% % % - ''Lines'', ''single'' (single-line edit field, default) or ''multi'' (multi-line edit field).
% % % - ''EditHeight'' with the height of the edit field in characters.

%%% ¡seealso!
GUI, PanelElement, PanelProp

%% ¡properties!
p
editfield

%% ¡methods!
function p_out = draw(pr, varargin)
% % %     %DRAW draws the panel of the string property.
% % %     %
% % %     % DRAW(PR) draws the panel of the string property.
% % %     %
% % %     % H = DRAW(PR) returns a handle to the property panel.
% % %     % 
% % %     % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
% % %     %  panel with custom Name-Value pairs.
% % %     %  All standard plot properties of uipanel can be used.
% % %     %
% % %     % It is possible to access the properties of the various graphical
% % %     %  objects from the handle H of the panel.
% % %     %
% % %     % See also update, redraw, refresh, uipanel.
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    pr.p = draw@PanelProp(pr, varargin{:});
    
    if ~check_graphics(pr.editfield, 'uieditfield')
        pr.editfield = uieditfield( ...
            'Parent', pr.p, ...
            'Tag', 'editfield', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_editfield} ...
            );
    end

    function cb_editfield(~, ~) % (src, event)
        pr.cb_editfield()
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
% % %     %UPDATE updates the content and permissions of the edit field.
% % %     %
% % %     % UPDATE(PR) updates the content and permissions of the edit field.
% % %     %
% % %     % See also draw, resize, refresh, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.editfield, ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.editfield, 'Value', el.get(prop))

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.editfield, 'Value', el.get(prop))

            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pr.editfield, ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.editfield, ...
                    'Value', el.getPropDefault(prop), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
                set(pr.editfield, ...
                    'String', el.get(prop), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
    end
end
function redraw(pr, varargin)
% % %     %REDRAW resizes the property panel and repositions its graphical objects.
% % %     %
% % %     % REDRAW(PR) resizes the property panel and repositions its
% % %     %   graphical objects. 
% % %     % 
% % %     % Important notes:
% % %     % 1. REDRAW() sets the units 'characters' for panel and all its graphical objects. 
% % %     % 2. REDRAW() is typically called internally by PanelElement and does not need 
% % %     %  to be explicitly called in children of PanelProp.
% % %     %
% % %     % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
% % %     %  repositions the property panel. It is possible to use a
% % %     %  subset of the Name-Value pairs.
% % %     %  By default:
% % %     %  - X0 does not change
% % %     %  - Y0 does not change
% % %     %  - WIDTH does not change
% % %     %  - HEIGHT=3.33 characters.
% % %     %
% % %     % See also draw, update, refresh, PanelElement.

    [h_p, varagin] = get_and_remove_from_varargin(4 * BRAPH2.FONTSIZE * BRAPH2.S, 'Height', varargin);

    pr.redraw@PanelProp('Height', h_p, varargin{:})

    set(pr.editfield, 'Position', [ ...
        ceil(5 * BRAPH2.S) ...
        ceil(.25 * BRAPH2.FONTSIZE * BRAPH2.S) ...
        ceil(w(pr.p, 'pixels') * .7) ...
        ceil(1.75 * BRAPH2.FONTSIZE * BRAPH2.S) ...
        ])
end
function cb_editfield(pr)
% % %     %CB_EDIT_VALUE executes callback for the edit value.
% % %     %
% % %     % CB_EDIT_VALUE(PR) executes callback for the edit value.

    el = pr.get('EL');
    prop = pr.get('PROP');

    el.set(prop, get(pr.editfield, 'Value'))

    pr.update()
end
  
%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PanelPropString and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PanelElement() and GUI()
fig1 = uifigure();
et1 = ETA();
props = [et1.PROP_STRING_M et1.PROP_STRING_P et1.PROP_STRING_D et1.PROP_STRING_F et1.PROP_STRING_G et1.PROP_STRING_R et1.PROP_STRING_R_CALC];
for i = 1:1:length(props)
    pr{i} = PanelPropString('EL', et1, 'PROP', props(i));
    pr{i}.draw( ...
        'Parent', fig1, ...
        'BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)] ...
        )
    pr{i}.update()
    pr{i}.redraw('Y0', (length(props) - i)/length(props) * h(fig1, 'pixels'))
end
close(fig1)
