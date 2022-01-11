%% ¡header!
PPSubjectSTMP_STMP < PPSubjectST_ST (pr, plot subject structural multiplex data) represents the structural multiplex data of a subject.

%%% ¡description!
PPSubjectSTMP_STMP represents the structural multiplex data of a subject.

%%% ¡seealso!
GUI, PlotElement, PlotPropMatrix, Subject, SubjectSTMP.

%% ¡properties!
p
table_value
table_tag
ui_sliding_panel
ui_slider

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws a table with the structural multiplex data of a subject.
    %
    % DRAW(PR) draws the property panel a table with the structural multiplex data of 
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
    
    pr.p = draw@PPSubjectST_ST(pr, varargin{:});

    % retrieves the handle of the table
    children = get(pr.p, 'Children');
    for i = 1:1:length(children)
        if check_graphics(children(i), 'uitable')
            pr.table_value = children(i);
        end
    end
    
    % create panel with slider
    pr.ui_sliding_panel = uipanel( ...
        'Parent', pr.p, ...
        'Units', 'characters', ...
        'BackgroundColor', [.62 .545 .439]);
    pr.ui_slider = uicontrol( ...
        'Parent', pr.p, ...
        'Style', 'slider', ...
        'Units', 'characters', ...
        'Value', 1, ...
        'Callback', {@cb_slide} ...
        );
    pr.table_tag = uicontrol('Parent', pr.p, ...
        'Style', 'text', ...
        'Units', 'normalized', ...
        'Position', [.01 .09 .3 .05], ...
        'BackgroundColor', [.62 .545 .439], ...
        'HorizontalAlignment', 'left', ...
        'String', '');
    
    % get some needed variables
    el = pr.get('EL');
    prop = pr.get('PROP');
    value = el.get(prop);    
    br_dict = el.get('BA').get('BR_DICT');
    
    % change type of table    
    if ~isempty(pr.table_value) && ~iscell(pr.table_value)
        delete(pr.table_value)
        pr.table_value = cell(size(value));
    end
    
    for i = 1:1:size(pr.table_value, 1)
        for j = 1:1:size(pr.table_value, 2)
            if isempty(pr.table_value{i, j}) || ~isgraphics(pr.table_value{i, j}, 'uitable')
                pr.table_value{i, j} = uitable('Parent', pr.ui_sliding_panel, 'Visible', 'on');
            end
            set(pr.table_value{i, j}, ...
                'Data', value{i, j}, ...
                'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                'ColumnName', el.get('ID'), ...
                'RowName', cellfun(@(x) x.get('ID'), br_dict.getItems(), 'UniformOutput', false) ...
                )
        end
    end
    function cb_slide(~, ~)
        pr.slide()
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

    update@PPSubjectST_ST(pr)
    
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
    
    pr.redraw@PPSubjectST_ST(varargin{:});
end
function slide(pr)
    %SLIDE slides the panel horizontally.
    %
    % SLIDE(PL) slides the panel horizontally, without redrawing the prop panels.
    %
    % See also draw, update, redraw.

    f = pr.pp;
    p = pr.ui_sliding_panel;
    s = pr.ui_slider;

    units = get(f, 'Units');
    set(f, 'Units', 'character')

    y0_s = y0(f) + h(pr.pp)*.01;

    dw = 1;
    n = length(pr.table_value);
    w_pp = cellfun(@(x) w(x), pr.table_value);
    w_p = sum(w_pp + dw) + dw;
    single_w = w_p / n;

    if w_p > w(f)
        offset = get(s, 'Value');
        set(p, 'Position', [w(p)-w(f)-offset y0_s+1 w_p h(f)*.76])

        set(s, ...
            'Position', [0 y0_s w(f) 1], ...
            'Visible', 'on', ...
            'Min', w(p) - w(f), ...
            'Max', w_p, ...
            'Value', max(get(s, 'Value'), w(p) - w(f)) ...
            );
        current_table = abs((w(p)-w(f)-offset)) / single_w;
        set(pr.table_tag, 'String', ['Table : ' num2str(round(current_table) + 1)])
        
    else
        set(p, 'Position', [0.1 h(f)*.2 w(f)*.98 h(f)-h(f)*.15])

        set(s, 'Visible', 'off')
    end

    set(f, 'Units', units)

    % auxiliary functions
        function r = x0(h)
            r = get(h, 'Position');
            r = r(1);
        end
        function r = y0(h)
            r = get(h, 'Position');
            r = r(2);
        end
        function r = w(h)
            r = get(h, 'Position');
            r = r(3);
        end
        function r = h(h)
            r = get(h, 'Position');
            r = r(4);
        end
end