%% ¡header!
PPSubjectCON_FUN_MP_CON_FUN_MP < PPSubjectFUN_FUN (pr, plot subject connectivity and functional multiplex data) represents the connectivity and functional multiplex data of a subject.

%%% ¡description!
PPSubjectCON_FUN_MP_CON_FUN_MP represents the connectivity and functional multiplex data of a subject.

%%% ¡seealso!
GUI, PlotElement, PlotPropMatrix, Subject, SubjectCON_FUN_MP.

%% ¡properties!
p
table_value
table_tag
slider
current_layer

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws a table with the connectivity and functional multiplex data of a subject.
    %
    % DRAW(PR) draws the property panel a table with the connectivity and functional multiplex data of
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
    total_rows = length(value);

    % set on first layer
    pr.current_layer = 1;

    % transform width of slide into values
    pr.slider = uicontrol( ...
        'Parent', pr.p, ...
        'Style', 'slider', ...
        'Units', 'characters', ...
        'Value', 1, ...
        'Callback', {@cb_slide} ...
        );
    pr.table_tag = uicontrol('Parent', pr.p, ...
        'Style', 'text', ...
        'Units', 'characters', ...
        'HorizontalAlignment', 'left', ...
        'String', 'CON', ...
        'BackgroundColor', pr.get('BKGCOLOR') );

        function cb_slide(~, ~)
            slider_current_value = get(pr.slider, 'Value');
            max_value = get(pr.slider, 'Max');
            segments = round(max_value / total_rows);
            c_s = segments;
            for i = 1:total_rows
                if slider_current_value < c_s
                    n = i;
                    break;
                end
                c_s =  c_s + segments;
            end


            % change table tag
            if n == 1
                tag = 'CON';
            else
                tag = 'FUN';
            end
            set(pr.table_tag, 'String', tag);
            % change current layer
            pr.current_layer = n;
            % change values
            pr.update();
        end

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

    set(pr.table_value, ...
        'Data', value{pr.current_layer}, ...
        'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
        'ColumnEditable', true, ...
        'CellEditCallback', {@cb_matrix_value});

        function cb_matrix_value(~, event)
            layer_value = value{pr.current_layer};
            layer_value(event.Indices(1), event.Indices(2)) = event.NewData;
            value{pr.current_layer} = layer_value;
            el.set(prop, value)

            pr.update()
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

    el = pr.get('EL');
    prop = pr.get('PROP');

    p_t = pr.table_tag;
    s = pr.slider;

    set(p_t, ...
        'Position', [0 16 2 1]);

    set(s, ...
        'Position', [0 17 45 1], ...
        'Min', 1, ...
        'Max', Plot.w(s));

    varargin{end+1} = 'Height';
    varargin{end+1} = 5;
    varargin{end+1} = 'DHeight';
    varargin{end+1} = 15;

    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        pr.redraw@PPSubjectFUN_FUN(varargin{:})
    else
        pr.redraw@PPSubjectFUN_FUN(varargin{:});
    end
end