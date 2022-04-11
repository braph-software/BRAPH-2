%% ¡header!
PlotPropMeasureEnsembleNodalMultilayer < PlotPropMatrix (pr, plot nodal measure mp) represents the nodal measure mp.

%%% ¡description!
PlotPropMeasureEnsembleNodalMultilayer represents the nodal measure mp.

%%% ¡seealso!
GUI, PlotElement, PlotPropMatrix, PPMeasureEnsemble_M.

%% ¡properties!
p
table_value
slider
slider_text
extra_slider
extra_text

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws a table with the nodal measure.
    %
    % DRAW(PR) draws the property panel a table with the structural data of 
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
    
    pr.p = draw@PlotPropMatrix(pr, varargin{:});

    % retrieves the handle of the table
    children = get(pr.p, 'Children');
    for i = 1:1:length(children)
        if check_graphics(children(i), 'uitable')
            pr.table_value = children(i);
        end
    end
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    value = el.get(prop);
    L = size(value, 1);
    label = 'Layer';
    g_dict = el.get('A').get('G_DICT');
    g = g_dict.getItem(1);
    check = g.getPropNumber() > 9;
    map_multiplier = 100;

    if check  % bud
        n = length(g.get(10)); % 10 is densities or thresholds
        L = size(value, 1) / n;
        label = g.getPropTag(10);
    else
        n = 1;
    end
    
    if L == 1
        Ll = 1;
    else
        Ll = L-1;
    end
    
    if n == 1
        nn = 1;
    else
        nn = n-1;
    end
		 
    if L > 1
        % set on first layer
        pr.slider = uicontrol( ...
            'Parent', pr.p, ...
            'Style', 'slider', ...
            'Units', 'characters', ...
            'Visible', 'off', ...
            'Value', 1 / map_multiplier, ...
            'Min', 1 / map_multiplier, ...
            'Max', L / map_multiplier, ...
            'SliderStep', [map_multiplier/(Ll*map_multiplier) map_multiplier/(Ll*map_multiplier)] , ...
            'Callback', {@cb_slider} ...
            );
        
        pr.slider_text = uicontrol(...
            'Parent', pr.p, ...
            'Style', 'text', ...
            'Units', 'characters', ...
            'Visible', 'off', ...
            'HorizontalAlignment', 'center', ...
            'FontUnits', BRAPH2.FONTUNITS, ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'FontWeight', 'normal', ...
            'String', '', ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end
    
    function cb_slider(~, ~)
        pr.update()
    end

    if check
        pr.extra_slider = uicontrol( ...
            'Parent', pr.p, ...
            'Style', 'slider', ...
            'Units', 'characters', ...
            'Visible', 'off', ...
            'Value', 1 / map_multiplier, ...
            'Min', 1 / map_multiplier, ...
            'Max', n / map_multiplier, ...
            'SliderStep', [map_multiplier/(nn*map_multiplier) map_multiplier/(nn*map_multiplier)] , ...
            'Callback', {@cb_slider_layer} ...
            );
        pr.extra_text = uicontrol(...
            'Parent', pr.p, ...
            'Style', 'text', ...
            'Units', 'characters', ...
            'HorizontalAlignment', 'center', ...
            'Visible', 'off', ...
            'FontUnits', BRAPH2.FONTUNITS, ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'FontWeight', 'normal', ...
            'String', [label ' ' num2str(round(get(pr.extra_slider, 'Value')))], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end

        function cb_slider_layer(~, ~)
            pr.update()
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
    %  to be explicitly called in children of PlotProp.
    %
    % See also draw, redraw, PlotElement.

    update@PlotProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    value = el.getr(prop);
    L = size(value, 1);
    label = 'Layer';
    g_dict = el.get('A').get('G_DICT');
    g = g_dict.getItem(1);
    br_dict = g.get('BRAINATLAS').get('BR_DICT');
    check = g.getPropNumber() > 9;
    map_multiplier = 100;
    slider_tags = {'1'};
    extra_label = '';
    if check
        n = length(g.get(10)); % 10 is densities or thresholds
        L = size(value, 1) / n;
        label = g.getPropTag(10);
        if strcmp(label, 'thresholds')
            label = 'Threshold';
        elseif strcmp(label, 'densities')
            label = 'Density';
            extra_label = '%';
        end
        slider_tags = compose("%g", round(g.get(10), 2));
    else
        n = 1;
    end
    
    br_ids = cell(br_dict.length(), 1);
    for i = 1:1:br_dict.length()
        br = br_dict.getItem(i);
        br_id = br.get(BrainRegion.ID);
        if length(br_id) > 10
            br_id = [br_id(1:8) '..'];
        end
        br_ids{i} = br_id;
    end

    if isa(value, 'NoValue')
        set(pr.table_value, ...
            'ColumnName', {}, ...
            'RowName', br_ids ...
            )
    else
       set(pr.slider_text, ...
            'String', ['Layer ' num2str(round(get(pr.slider, 'Value') * map_multiplier))]);
        
        if check
            
            set(pr.extra_text, ...
            'String', [label ' ' num2str(round(get(pr.extra_slider, 'Value') * map_multiplier)) ': '  slider_tags{round(get(pr.extra_slider, 'Value') * map_multiplier)}]);
        
            % get the correct index
            l = round(get(pr.slider, 'Value') * map_multiplier); % layer
            d = round(get(pr.extra_slider, 'Value') * map_multiplier); % threshold or ddensity
        
            correct_i =  (d * L)- L + l ;
            
            if isempty(l) || isempty(d) % superglobal
                set(pr.table_value, ...
                    'Data', value{d}, ...
                    'ColumnName', {}, ...
                    'RowName', br_ids ...
                    )
            else
                set(pr.table_value, ...
                    'Data', value{correct_i}, ...
                    'ColumnName', {}, ...
                    'RowName', br_ids ...
                    )
            end
        else % wu
            if ~isempty(pr.slider)
                set(pr.table_value, ...
                    'Data', value{round(get(pr.slider, 'Value') * map_multiplier)}, ...
                    'ColumnName', {}, ...
                    'RowName', br_ids ...
                    )
            else % superglobal
                set(pr.table_value, ...
                    'Data', value{1}, ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
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
    [Sh, varargin] = get_and_remove_from_varargin(1.8, 'SHeight', varargin);
    [Th, varargin] = get_and_remove_from_varargin(1.8, 'THeight', varargin);
    [Dh, varargin] = get_and_remove_from_varargin(18, 'DHeight', varargin);

    el = pr.get('EL');
    prop = pr.get('PROP');
    value = el.get(prop);
    L = size(value, 1);
    n = 0;
    g_dict = el.get('A').get('G_DICT');
    g = g_dict.getItem(1);
    if g.getPropNumber() > 9
        n = length(g.get(10)); % 10 is densities or thresholds
    end

    if n > 1
        pr.redraw@PlotPropMatrix('Height', h*2+Sh+Th, varargin{:});
        set(pr.slider, ...
            'Units', 'normalized', ...
            'Visible', 'on', ...
            'Position', [.01 (Sh+Th+Dh+h)/(h+Sh+Sh+Th+Th+Dh)-.2 .97 (Th/(h+Sh+Sh+Th+Th+Dh)-.02)] ...
            );

        set(pr.slider_text, ...
            'Units', 'normalized', ...
            'Visible', 'on', ...
            'Position', [.01 (Sh+Th+Th+Dh+h)/(h+Sh+Sh+Th+Th+Dh)-.2 .97 (Th/(h+Sh+Sh+Th+Th+Dh)-.02)] ...
            );

        set(pr.extra_slider, ...
            'Units', 'normalized', ...
            'Visible', 'on', ...
            'Position', [.01 (Dh+h)/(h+Sh+Sh+Th+Th+Dh)-.2 .97 (Th/(h+Sh+Sh+Th+Th+Dh)-.02)] ...
            );

        set(pr.extra_text, ...
            'Units', 'normalized', ...
            'Visible', 'on', ...
            'Position', [.01 (Dh+Th+h)/(h+Sh+Sh+Th+Th+Dh)-.2 .97 (Th/(h+Sh+Sh+Th+Th+Dh)-.02)] ...
            );

        set(pr.table_value, ...
            'Visible', 'on', ...
            'Units', 'normalized', ...
            'Position', [.01 .02 .97 ((Dh+h)/(h+Sh+Sh+Th+Th+Dh)-.2)] ...
            )
    else
        pr.redraw@PlotPropMatrix('Height', h*2+Sh, varargin{:});
        set(pr.slider, ...
            'Units', 'normalized', ...
            'Visible', 'on', ...
            'Position', [.01 (Dh+h)/(h+Sh+Th+Dh)-.15 .97 (Th/(h+Sh+Th+Dh)-.02)] ...
            );

        set(pr.slider_text, ...
            'Units', 'normalized', ...
            'Visible', 'on', ...
            'Position', [.01 (Th+Dh+h)/(h+Sh+Th+Dh)-.15 .97 (Th/(h+Sh+Th+Dh)-.02)] ...
            );

        set(pr.table_value, ...
            'Visible', 'on', ...
            'Units', 'normalized', ...
            'Position', [.01 .02 .97 ((Dh+h)/(h+Sh+Th+Dh)-.15)] ...
            )
    end
    if ~pr.get_button_condition()
        set(pr.slider, ...
            'Visible', 'off' ...
            );

        set(pr.slider_text, ...
            'Visible', 'off' ...
            );

        set(pr.table_value, ...
            'Visible', 'off' ...
            )

        if ~isempty(pr.layer_slider) && ~isempty(pr.layer_text)
            set(pr.layer_slider, ...
                'Visible', 'off' ...
                );

            set(pr.layer_text, ...
                'Visible', 'off' ...
                );

        end
        pr.redraw@PlotProp(varargin{:});
    end
end
function state = get_button_condition(pr)
    % GET_BUTTON_CONDITION returns the calculate button state.
    %
    % STATE = GET_BUTTON_CONDITION(PR) returns the calculate button state.
    %
    % see also is_measure_calculated.

    plot_prop_children = get(pr.p, 'Children');
    state = 0; % calculated
    for i = 1:length(plot_prop_children)
        pp_c = plot_prop_children(i);
        if check_graphics(pp_c, 'pushbutton') && isequal(pp_c.Tag, 'button_calc')
            if isequal(pp_c.Enable, 'off')
                state = 1;  % not calculated
            end
        end
    end
end
