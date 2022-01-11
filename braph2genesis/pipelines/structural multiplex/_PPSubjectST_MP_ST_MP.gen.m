%% ¡header!
PPSubjectST_MP_ST_MP < PPSubjectST_ST (pr, plot subject structural multiplex data) represents the structural multiplex data of a subject.

%%% ¡description!
PPSubjectST_MP_ST_MP represents the structural multiplex data of a subject.

%%% ¡seealso!
GUI, PlotElement, PlotPropMatrix, Subject, SubjectSTMP.

%% ¡properties!
p
table_value
table_tag
slider
current_layer

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
    el = pr.get('EL');
    prop = pr.get('PROP');
    value = pr.get(prop);
    s_min_value = 1;
    s_max_value = length(value); % rows dimension
    
    % set on first layer
    pr.current_layer = 1;
    
    % transform width of slide into values
    width = Plot.w(s, 'characters');
    pr.slider = uicontrol( ...
        'Parent', pr.p, ...
        'Style', 'slider', ...
        'Units', 'characters', ...
        'Min', s_min_value, ...
        'Max', s_max_value, ...
        'Callback', {@cb_slide} ...
        );
    pr.table_tag = uicontrol('Parent', pr.p, ...
        'Style', 'text', ...
        'Units', 'characters', ...
        'HorizontalAlignment', 'left', ...
        'String', '');
    
    function cb_slide(~, ~)
        slider_current_value = get(pr.slider, 'Value');
        % change table tag
        set(pr.table_tag, 'String', num2str(slider_current_value)); 
        % change current layer
        pr.current_layer = num2str(slider_current_value);
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

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    value = el.get(prop);
    
    set(pr.table_value, ...
        'Data', value{pr.current_layer}, ...
        'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
        'ColumnEditable', true, ...
        'CellEditCallback', {@cb_matrix_value});
    
    
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
    
    p_t = pr_table_tag;
    s = pr.slider;
    
    set(p_t, ...
        'Position', [0 16 1 2]);
    
    set(s, ...
        'Position', [0 17 1 45]);
    
    varargin{end+1} = 'Height';
    varargin{end+1} = 2;
    varargin{end+1} = 'DHeight';
    varargin{end+1} = 21;
    
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        pr.redraw@PPSubjectST_ST(varargin{:})
    else
        pr.redraw@PPSubjectST_ST(varargin{:});
    end
    
    
end
function slide(pr)
    %SLIDE slides the panel horizontally.
    %
    % SLIDE(PL) slides the panel horizontally, without redrawing the prop panels.
    %
    % See also draw, update, redraw.

%     p = pr.pp;
%     s = pr.slider;
%     
%     el = pr.get('EL');
%     prop = pr.get('PROP');
%     value = pr.get(prop);
%     
%     s_min_value = 1;
%     s_max_value = length(value); % rows dimension
%     
%     % transform width of slide into values
%     width = Plot.w(s, 'characters');
%     set(s, ...
%         'Visible', 'on', ...
%         'Min', s_min_value, ...
%         'Max', s_max_value, ...
%         'Value', max(get(s, 'Value'), Plot.w(s, 'characters')) ...
%         );
%     
    

%     y0_s = y0(p) + h(pr.pp)*.01;
% 
%     dw = 1;
%     n = length(pr.table_value);
%     w_pp = cellfun(@(x) w(x), pr.table_value);
%     w_p = sum(w_pp + dw) + dw;
%     single_w = w_p / n;

%     if w_p > w(p)
%         offset = get(s, 'Value');
%         set(p, 'Position', [w(p)-w(p)-offset y0_s+1 w_p h(p)*.76])
% 
%         set(s, ...
%             'Position', [0 y0_s w(p) 1], ...
%             'Visible', 'on', ...
%             'Min', w(p) - w(p), ...
%             'Max', w_p, ...
%             'Value', max(get(s, 'Value'), w(p) - w(p)) ...
%             );
%         current_table = abs((w(p)-w(p)-offset)) / single_w;
%         set(pr.table_tag, 'String', ['Table : ' num2str(round(current_table) + 1)])
%         
%     else
%         set(p, 'Position', [0.1 h(p)*.2 w(p)*.98 h(p)-h(p)*.15])
% 
%         set(s, 'Visible', 'off')
%     end

%     set(p, 'Units', units)
% 
%     % auxiliary functions
%         function r = x0(h)
%             r = get(h, 'Position');
%             r = r(1);
%         end
%         function r = y0(h)
%             r = get(h, 'Position');
%             r = r(2);
%         end
%         function r = w(h)
%             r = get(h, 'Position');
%             r = r(3);
%         end
%         function r = h(h)
%             r = get(h, 'Position');
%             r = r(4);
%         end
end
function cb_matrix_value(pr, i, j, newdata)
    %CB_MATRIX_VALUE executes callback for the matrix table.
    %
    % CB_MATRIX_VALUE(PR, I, J, NEWDATA) executes callback for the matrix table.
    %  It updates the matrix at position (I,J) with NEWDATA and the
    %  information of current layer.

    el = pr.get('EL');
    prop = pr.get('PROP');
    current_layer = pr.current_layer;

    value = el.get(prop);
    layer_value = value{current_layer};
    layer_value(i, j) = newdata;
    value{current_layer} = layer_value;
    el.set(prop, value)

    pr.update()
end