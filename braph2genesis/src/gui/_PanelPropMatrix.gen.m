%% ¡header!
PanelPropMatrix < PanelProp (pr, panel property matrix) plots the panel of a matrix-like property in a table.

%%% ¡description!
PanelPropMatrix plots the panel of a RVECTOR, CVECTOR, MATRIX or SMATRIX property with a table.
It works for all categories.

%%% ¡seealso!
GUI, PanelElement, PanelProp, uitable

%% ¡props!

%%% ¡prop!
TAB_ENABLE (gui, option) switches table between on and off.
%%%% ¡settings!
{'on', 'off'}
%%%% ¡default!
'off'

%%% ¡prop!
TAB_H (gui, size) is the height of the table in font size units.
%%%% ¡default!
20

%% ¡properties!
p
table

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of the matrix-like property.
    %
    % DRAW(PR) draws the panel of rthe matrix-like (rvector, cvector, matrix, smatrix) property.
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
    
    if ~check_graphics(pr.table, 'uitable')
        pr.table = uitable( ...
            'Tag', 'table', ...
            'Parent', pr.p, ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'CellEditCallback', {@cb_matrix_value} ...
            );
    end

    function cb_matrix_value(~, event) % (src, event)
        pr.cb_matrix_value(event.Indices(1), event.Indices(2), event.NewData)
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the table.
    %
    % UPDATE(PR) updates the content and permissions of the table.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.table, ...
            'Enable', pr.get('TAB_ENABLE'), ...
            'ColumnEditable', false ...
            )
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.table, ...
                'Data', el.get(prop), ...
                'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
                'ColumnEditable', true ...
                )

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.table, ...
                'Data', el.get(prop), ...
                'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
                'ColumnEditable', true ...
                )
            
            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pr.table, ...
                    'Enable', pr.get('TAB_ENABLE'), ...
                    'ColumnEditable', false ...
                    )
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                % don't plot anything for a result not yet calculated
                set(pr.table, 'Visible', 'off')
            else
                set(pr.table, ...
                    'Data', el.get(prop), ...
                    'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
                    'Enable', pr.get('TAB_ENABLE'), ...
                    'ColumnEditable', false, ...
                    'Visible', 'on' ...
                    )
            end
    end
end
function redraw(pr, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PR) resizes the property panel and repositions its
    %   graphical objects. 
    % 
    % Important notes:
    % 1. REDRAW() sets the units 'characters' for panel and all its graphical objects. 
    % 2. REDRAW() is typically called internally by PanelElement and does not need 
    %  to be explicitly called in children of PanelProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT, 'DHeight', DHEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT = s(2) (header height)
    % The table height is set by the property TAB_H.
    %
    % See also draw, update, PanelElement, s.
    
    [h, varargin] = get_and_remove_from_varargin(s(2), 'Height', varargin);
    Dh = s(pr.get('TAB_H'));
    
    el = pr.get('EL');
    prop = pr.get('PROP');

    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        pr.redraw@PanelProp('Height', h, varargin{:})
    else
        pr.redraw@PanelProp('Height', h + Dh, varargin{:})
        
        set(pr.table, ...
            'Units', 'pixels', ...
            'Position', [s(.3) s(.3) w(pr.p, 'pixels')-s(.6) Dh-s(.6)] ...
            )
    end  
end
function cb_matrix_value(pr, i, j, newdata)
    %CB_MATRIX_VALUE executes callback for the matrix table.
    %
    % CB_MATRIX_VALUE(PR, I, J, NEWDATA) executes callback for the matrix table.
    %  It updates the matrix at position (I,J) with NEWDATA. 

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    value = el.get(prop);
    value(i, j) = newdata;
    el.set(prop, value)

    pr.update()
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PanelPropMatrix and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PanelElement() and GUI()
fig1 = uifigure('Units', 'normalized', 'Position', [0 .5 1 .5]);
et = ETA( ...
    'PROP_MATRIX_M', rand(30, 5), ...
    'PROP_MATRIX_P', 3.14, ...
    'PROP_MATRIX_D', eye(6), ...
    'PROP_MATRIX_F', rand(10, 10), ...
    'PROP_MATRIX_G', randn(3) ...
    );
props = [et.PROP_MATRIX_M et.PROP_MATRIX_P et.PROP_MATRIX_D et.PROP_MATRIX_F et.PROP_MATRIX_G et.PROP_MATRIX_R et.PROP_MATRIX_R_CALC];
for i = 1:1:length(props)
    pr{i} = PanelPropMatrix('EL', et, 'PROP', props(i));
    pr{i}.draw( ...
        'Parent', fig1, ...
        'BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)] ...
        )
    pr{i}.update()
    pr{i}.redraw('X0', (i-1)/length(props) * w(fig1, 'pixels'), ...
        'Width', 1/length(props) * w(fig1, 'pixels'))
end
close(fig1)