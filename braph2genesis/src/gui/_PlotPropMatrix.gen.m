%% ¡header!
PlotPropMatrix < PlotProp (pl, plot property matrix) is a plot of a property matrix.

%%% ¡description!
PlotProp plots a property matrix of an element in a panel.

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
pp
table_value

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the matrix property graphical panel.
    %
    % DRAW(PL) draws the matrix property graphical panel.
    %
    % H = DRAW(PL) returns a handle to the matrix property graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain surface graphical panel H.
    %
    % see also update, redraw, refresh, settings, uipanel, isgraphics.

    el = pl.get('EL');
    prop = pl.get('PROP');
    
    pl.pp = draw@PlotProp(pl, varargin{:});
    
    if isempty(pl.table_value) || ~isgraphics(pl.table_value, 'uitable')
        pl.table_value = uitable( ...
            'Parent', pl.pp, ...
            'Units', 'normalized', ...
            'Position', [.01 .25 .98 .6], ...
            'FontUnits', BRAPH2.FONTUNITS, ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'CellEditCallback', {@cb_matrix_value} ...
            );
    end

    % callback
    function cb_matrix_value(src, event)
        el = pl.get('EL');
        value = el.get(prop);
        value(event.Indices(1), event.Indices(2)) = event.NewData;
        el.set(prop, value)
   
        pl.update()
    end

    % output
    if nargout > 0
        h_panel = pl.pp;
    end
end
function update(pl)
    %UPDATE updates the content of the property graphical panel.
    %
    % UPDATE(PL) updates the content of the property graphical panel.
    %
    % See also draw, redraw, refresh.

    update@PlotProp(pl)
    
    el = pl.get('EL');
    prop = pl.get('PROP');
    
    if el.isLocked(prop)
        set(pl.table_value, ...
            'Enable', pl.get('ENABLE'), ...
            'ColumnEditable', false ...
            )
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pl.table_value, ...
                'Data', el.get(prop), ...
                'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
                'ColumnEditable', true)

        case {Category.PARAMETER, Category.DATA}
            % new input method
            input_field = uicontrol('Parent', pl.pp, ...
                'Style', 'edit', ...
                'Units', 'normalized', ...
                'Position', [.01 .05 .98 .1], ...
                'Callback', {@cb_edit_values} ...
                );
            
            set(pl.table_value, ...
                'Data', el.get(prop), ...
                'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
                'ColumnEditable', true)
            
            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pl.table_value, ...
                'Enable', pl.get('ENABLE'), ...
                'ColumnEditable', false ...
                )
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pl.table_value, ...
                    'Data', el.getPropDefault(prop), ...
                    'ColumnFormat', repmat({'long'}, 1, size(el.getPropDefault(prop), 2)), ...
                    'Enable', pl.get('ENABLE'), ...
                    'ColumnEditable', false ...
                    )
            else
                set(pl.table_value, ...
                    'Data', el.get(prop), ...
                    'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
                    'Enable', pl.get('ENABLE'), ...
                    'ColumnEditable', false ...
                    )
            end
    end
    function cb_edit_values(~, ~)
        % get input and element
        input_string = get(input_field, 'String');
        el = pl.get('EL');
        
        % I want the input to be separeted via , or space. And column separtation with ; 
        % for example '1,2;3 4' = [1, 2; 3 4]
        
        input_values_array =  split(split(input_string, ';'), [" ", ","]);
        final_value = cellfun(@(x) str2double(x), input_values_array);
         
        % set the values
        try
            if isequal(el.getPropFormat(prop), 'nr')
                el.set(prop, final_value')
            else
                el.set(prop, final_value)
            end
        catch e 
            warndlg(['Please select a valid input. ' e.message], 'Warning');
        end

        pl.update()
    end
end
function redraw(pl, varargin)
    %REDRAW redraws the element graphical panel.
    %
    % REDRAW(PL) redraws the plot PL.
    %
    % REDRAW(PL, 'Height', HEIGHT) sets the height of PL (by default HEIGHT=3.3).
    %
    % See also draw, update, refresh.
    
    pl.redraw@PlotProp('Height', 20, varargin{:})
end