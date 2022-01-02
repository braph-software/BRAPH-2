%% ¡header!
PlotPropCell < PlotProp (pr, plot property cell) is a plot of a cell property.

%%% ¡description!
PlotPropCell plots a CELL property of an element in a table.
It works for all categories.

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
p
table_value_cell

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the panel of the cell property.
    %
    % DRAW(PR) draws the panel of the cell property.
    %
    % H = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H of the panel.
    %
    % See also update, redraw, refresh, uipanel.
    
    pr.p = draw@PlotProp(pr, varargin{:});
    
    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permission of the table.
    %
    % UPDATE(PR) updates the content and permission of the table.
    %
    % See also draw, redraw, refresh, PlotElement.

    update@PlotProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')        
        % don't plot anything for a result not yet calculated
    else
        value_cell = el.get(prop);
        if isempty(pr.table_value_cell) || ~isequal(size(pr.table_value_cell), size(value_cell))
            pr.table_value_cell = cell(size(value_cell));
        end
        for r = 1:1:size(pr.table_value_cell, 1)
            for c = 1:1:size(pr.table_value_cell, 2)
                if ~check_graphics(pr.table_value_cell{r, c}, 'uitable')
                    pr.table_value_cell{r, c} = uitable('Parent', pr.p);
                end
                set(pr.table_value_cell{r, c}, ...
                    'Data', value_cell{r, c}, ...
                    'Tooltip', [num2str(r) ' ' num2str(c)], ...
                    'FontUnits', BRAPH2.FONTUNITS, ...
                    'FontSize', BRAPH2.FONTSIZE, ...
                    'ColumnEditable', true, ...
                    'CellEditCallback', {@cb_table_value_cell, r, c} ...
                    )
            end
        end
        
    end

    function cb_table_value_cell(~, event, r, c) % (src, event)
        pr.cb_table_value_cell(r, c, event.Indices(1), event.Indices(2), event.NewData)
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
    %  to be explicitly called in children of PlotProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT=1.8 minimum height when no cell to show
    %  - DHEIGHT=20 additional height when data to show
    %
    % See also draw, update, refresh, PlotElement.
    
    [h, varargin] = get_and_remove_from_varargin(1.8, 'Height', varargin);
    [Dh, varargin] = get_and_remove_from_varargin(20, 'DHeight', varargin);
    
    el = pr.get('EL');
    prop = pr.get('PROP');

    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        pr.redraw@PlotProp('Height', h, varargin{:})
    else
        value_cell = el.get(prop);

        if isempty(value_cell)
            pr.redraw@PlotProp('Height', h, varargin{:})
        else
            pr.redraw@PlotProp('Height', h + Dh, varargin{:})
        end
        
        for r = 1:1:size(value_cell, 1)
            for c = 1:1:size(value_cell, 2)
                table_w = (.98 - .01) / size(value_cell, 2);
                table_h = (Dh / (h + Dh) - .02) / size(value_cell, 1);
                set(pr.table_value_cell{r, c}, ...
                    'Units', 'normalized', ...
                    'Position', ...
                        [ ...
                            .01 + (c - 1) * table_w ...
                            .02 + (size(value_cell, 1) - r) * table_h ...
                            table_w ...
                            table_h ...
                        ] ...
                    )
            end
        end
    end    
end
function cb_table_value_cell(pr, r, c, i, j, newdata)
    %CB_TABLE_VALUE_CELL executes callback for the cell tables.
    %
    % CB_TABLE_VALUE_CELL(PR, R, C, I, J, NEWDATA) executes callback for the cell tables.
    %  It updates the value at position (I,J) of the matrix (R,C) with NEWDATA. 

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    value = el.get(prop);
    value_rc = value{r, c};
    value_rc(i, j) = newdata;
    value{r, c} = value_rc;
    el.set(prop, value)

    pr.update()
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PlotPropCell and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PlotElement() and GUI()
figure('Units', 'normalized', 'Position', [0 .5 1 .5])
et = ETA( ...
    'PROP_CELL_M', {rand(10) eye(10); eye(10) rand(10)}, ...
    'PROP_CELL_P', {3.14 eye(2) rand(3)}, ...
    'PROP_CELL_D', rand(3) ... % note that this works only because of the conditioning (otherwise not a valid cell input)
    );
props = [et.PROP_CELL_M et.PROP_CELL_P et.PROP_CELL_D et.PROP_CELL_R et.PROP_CELL_R_CALC];
for i = 1:1:length(props)
    pr{i} = PlotPropCell('EL', et, 'PROP', props(i));
    pr{i}.draw('BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)])
    pr{i}.update()
    pr{i}.redraw('X0', (i-1)/length(props) * Plot.w(gcf, 'characters'), ...
        'Width', 1/length(props) * Plot.w(gcf, 'characters'), ...
        'DHeight', 25)
end
close(gcf)

% minimal working version for category RESULT
figure()
p = uipanel('Parent', gcf); % needed for the function refresh that is called when the result is calculated
set(gcf, 'SizeChangedFcn', 'pr_res.update(); pr_res.redraw();') % callback to update panel when figure is resized (in refresh)
et = ETA();
pr_res = PlotPropCell('EL', et, 'PROP', et.PROP_CELL_R_CALC);
pr_res.draw('Parent', p, 'BackgroundColor', [.8 .5 .2])
pr_res.update()
pr_res.redraw()
close(gcf)