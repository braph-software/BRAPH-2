%% ¡header!
PlotPropMatrix < PlotProp (pr, plot property matrix) is a plot of a matrix-like property.

%%% ¡description!
PlotPropMatrix plots a RVECTOR, CVECTOR, MATRIX or SMATRIX property matrix of an element in a table.
It works for all categories.

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
p
table_value

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the panel of the matrix-like property.
    %
    % DRAW(PR) draws the panel of rthe matrix-like (rvector, cvector, matrix, smatrix) property.
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
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    pr.p = draw@PlotProp(pr, varargin{:});
    
    if ~check_graphics(pr.table_value, 'uitable')
        pr.table_value = uitable( ...
            'Tag', 'table_value', ...
            'Parent', pr.p, ...
            'Units', 'normalized', ...
            'FontUnits', BRAPH2.FONTUNITS, ...
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
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the table.
    %
    % UPDATE(PR) updates the content and permissions of the table.
    %
    % See also draw, redraw, refresh, PlotElement.

    update@PlotProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.table_value, ...
            'Enable', pr.get('ENABLE'), ...
            'ColumnEditable', false ...
            )
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.table_value, ...
                'Data', el.get(prop), ...
                'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
                'ColumnEditable', true)

        case {Category.PARAMETER, Category.DATA}
            set(pr.table_value, ...
                'Data', el.get(prop), ...
                'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
                'ColumnEditable', true)
            
            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pr.table_value, ...
                'Enable', pr.get('ENABLE'), ...
                'ColumnEditable', false ...
                )
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                % don't plot anything for a result not yet calculated
                set(pr.table_value, 'Visible', 'off')
            else
                set(pr.table_value, ...
                    'Data', el.get(prop), ...
                    'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
                    'Enable', pr.get('ENABLE'), ...
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
    % 2. REDRAW() is typically called internally by PlotElement and does not need 
    %  to be explicitly called in children of PlotProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT, 'DHeight', DHEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT=1.8 characters.
    %  - DHEIGHT=20 characters (table height).
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
        value = el.get(prop);

        pr.redraw@PlotProp('Height', h + Dh, varargin{:})
        
        set(pr.table_value, ...
            'Units', 'normalized', ...
            'Position', [.01 .02 .97 (Dh/(h+Dh)-.02)] ...
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

% FIXME
%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
% draws PlotPropMatrix and calls update() and redraw()
% note that it doesn't work for category RESULT 
% because it needs to be used with PlotElement() and GUI()
figure('Units', 'normalized', 'Position', [0 .5 1 .5])
et = ETA( ...
    'PROP_MATRIX_M', rand(30, 5), ...
    'PROP_MATRIX_P', 3.14, ...
    'PROP_MATRIX_D', eye(6) ...
    );
props = [et.PROP_MATRIX_M et.PROP_MATRIX_P et.PROP_MATRIX_D et.PROP_MATRIX_R et.PROP_MATRIX_R_CALC];
for i = 1:1:length(props)
    pr{i} = PlotPropMatrix('EL', et, 'PROP', props(i));
    pr{i}.draw('BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)])
    pr{i}.update()
    pr{i}.redraw('X0', (i-1)/length(props) * Plot.w(gcf, 'characters'), ...
        'Width', 1/length(props) * Plot.w(gcf, 'characters'))
end
close(gcf)

% minimal working version for category RESULT
figure()
p = uipanel('Parent', gcf); % needed for the function refresh that is called when the result is calculated
set(gcf, 'SizeChangedFcn', 'pr_res.update(); pr_res.redraw();') % callback to update panel when figure is resized (in refresh)
et = ETA();
pr_res = PlotPropMatrix('EL', et, 'PROP', et.PROP_MATRIX_R_CALC);
pr_res.draw('Parent', p, 'BackgroundColor', [.8 .5 .2])
pr_res.update()
pr_res.redraw()
close(gcf)    
