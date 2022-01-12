%% ¡header!
PPSubjectFUN_MP_FUN_MP < PPSubjectFUN_FUN (pr, plot subject functional multiplex data) represents the functional multiplex data of a subject.

%%% ¡description!
PPSubjectFUN_MP_FUN_MP represents the functional multiplex data of a subject.

%%% ¡seealso!
GUI, PlotElement, PlotPropMatrix, Subject, SubjectFUNMP.

%% ¡properties!
p
table_value
table_tag
slider

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws a table with the functional multiplex data of a subject.
    %
    % DRAW(PR) draws the property panel a table with the functional multiplex data of
    %  a subject.
    %
    % H = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the panel
    %  with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H of the panel.
    %
    % See also update, redraw, settings, uipanel.

    pr.p = draw@PPSubjectFUN_FUN(pr, varargin{:});

    % retrieves the handle of the table
    children = get(pr.p, 'Children');
    for i = 1:1:length(children)
        if check_graphics(children(i), 'uitable')
            pr.table_value = children(i);
        end
    end

    % create panel with slider
    el = pr.get('EL');
    prop = pr.get('PROP');
    value = el.get(prop);
    L = length(value);

    % set on first layer
    pr.slider = uicontrol( ...
        'Parent', pr.p, ...
        'Style', 'slider', ...
        'Units', 'characters', ...
        'Value', 1, ...
        'Min', 1, ...
        'Max', L, ...
        'SliderStep', [1/L L], ...
        'Callback', {@cb_slider} ...
        );
    
    function cb_slider(~, ~)
        pr.update()
    end

    pr.table_tag = uicontrol(...
        'Parent', pr.p, ...
        'Style', 'text', ...
        'Units', 'characters', ...
        'HorizontalAlignment', 'left', ...
        'FontUnits', BRAPH2.FONTUNITS, ...
        'FontSize', BRAPH2.FONTSIZE, ...
        'String', '1', ...
        'BackgroundColor', pr.get('BKGCOLOR') ...
        );

    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content of the property panel and its graphical objects.
    %
    % UPDATE(PR) updates the content of the property panel and its graphical objects.
    %
    % Important note:
    % 1. UPDATE() is typically called internally by PlotElement and does not need
    %  to be expricitly called in children of PlotProp.
    %
    % See also draw, redraw, PlotElement.

    update@PlotProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    value = el.get(prop);
    
    if el.isLocked(prop)
        set(pr.table_value, ...
            'Enable', pr.get('ENABLE'), ...
            'ColumnEditable', false ...
            )
    end

    set(pr.table_value, ...
        'Data', value{get(pr.slider, 'Value')}', ...
        'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
        'ColumnEditable', true)

    value = el.getr(prop);
    if isa(value, 'Callback')
        set(pr.table_value, ...
            'Enable', pr.get('ENABLE'), ...
            'ColumnEditable', false ...
            )
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
    % 2. REDRAW() is typically called internally by PlotElement and does not need
    %  to be expricitly called in children of PlotProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT=1.4 characters.
    %
    % See also draw, update, PlotElement.

    [h, varargin] = get_and_remove_from_varargin(1.8, 'Height', varargin);
    [Sh, varargin] = get_and_remove_from_varargin(2.0, 'SHeight', varargin);
    [Th, varargin] = get_and_remove_from_varargin(2.0, 'THeight', varargin);
    [Dh, varargin] = get_and_remove_from_varargin(20, 'DHeight', varargin);

    set(pr.slider, ...
        'Units', 'normalized', ...
        'Position', [.01 (Th+Dh)/(h+Sh+Th+Dh) .97 (Th/(h+Sh+Th+Dh)-.02)] ...
        );
    
    set(pr.table_tag, ...
        'Units', 'normalized', ...
        'Position', [.01 Dh/(h+Sh+Th+Dh) .97 (Th/(h+Sh+Th+Dh)-.02)] ...
        );
    
    set(pr.table_value, ...
        'Units', 'normalized', ...
        'Position', [.01 .02 .97 (Dh/(h+Sh+Th+Dh)-.02)] ...
        )
end
function cb_matrix_value(pr, i, j, newdata)
    %CB_MATRIX_VALUE executes callback for the matrix table.
    %
    % CB_MATRIX_VALUE(PR, I, J, NEWDATA) executes callback for the matrix table.
    %  It updates the matrix at position (I,J) with NEWDATA 
    %  for the layer that is currently selected by the slider. 

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    value = el.get(prop);
    value{get(pr.slider, 'Value')}(i, j) = newdata;
    el.set(prop, value)

    pr.update()
end