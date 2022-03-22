%% ¡header!
PlotPropMeasureGlobalMultilayer < PlotPropScalar (pr, plot global measure mp) represents the global measure mp.

%%% ¡description!
PlotPropMeasureGlobalMultilayer represents the global measure mp.

%%% ¡seealso!
GUI, PlotElement, PlotPropMatrix, PPMeasure_M.

%% ¡properties!
p
edit_value
slider
slider_text
layer_slider
layer_text

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws a table with the global measure.
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
    
    pr.p = draw@PlotPropScalar(pr, varargin{:});

    % retrieves the handle of the table
    children = get(pr.p, 'Children');
    for i = 1:1:length(children)
        if check_graphics(children(i), 'edit')
            pr.edit_value = children(i);
        end
    end
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    g = el.get('g');
    L = size(g.get('B'), 2);
    label = 'Layer';
    map_multiplier = 100;
    if g.getPropNumber() > 9
        n = length(g.get(10)); % 10 is densities or thresholds
        L = size(g.get('B'), 2) / n;
        label = g.getPropTag(10);
    end
    
    if L == 1
        Ll = 1;
    else
        Ll = L-1;
    end
    
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
        'HorizontalAlignment', 'center', ...
        'Visible', 'off', ...
        'FontUnits', BRAPH2.FONTUNITS, ...
        'FontSize', BRAPH2.FONTSIZE, ...
        'FontWeight', 'normal', ...
        'String', '', ...
        'BackgroundColor', pr.get('BKGCOLOR') ...
        );
    
    function cb_slider(~, ~)
        pr.update()
    end

    if el.get('G').getPropNumber() > 9
        pr.layer_slider = uicontrol( ...
            'Parent', pr.p, ...
            'Style', 'slider', ...
            'Units', 'characters', ...
            'Visible', 'off', ...
            'Value', 1 / map_multiplier, ...
            'Min', 1 / map_multiplier, ...
            'Max', n / map_multiplier, ...
            'SliderStep', [map_multiplier/((n-1)*map_multiplier) map_multiplier/((n-1)*map_multiplier)] , ...
            'Callback', {@cb_slider_layer} ...
            );
        pr.layer_text = uicontrol(...
            'Parent', pr.p, ...
            'Style', 'text', ...
            'Units', 'characters', ...
            'HorizontalAlignment', 'center', ...
            'Visible', 'off', ...
            'FontUnits', BRAPH2.FONTUNITS, ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'FontWeight', 'normal', ...
            'String', '', ...
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
    g = el.get('g');
    L = size(g.get('B'), 2);
    label = 'Layer';
    map_multiplier = 100;
    slider_tags = {'1'};
    extra_label = '';
    if g.getPropNumber() > 9
        n = length(g.get(10)); % 10 is densities or thresholds
        L = size(g.get('B'), 2) / n;
        label = g.getPropTag(10);
        if strcmp(label, 'thresholds')
            label = 'Threshold';            
        elseif strcmp(label, 'densities')
            label = 'Density';
            extra_label = '%';
        end
        slider_tags = compose("%g", round(g.get(10), 2));
    end
    value = el.getr(prop);

    if isa(value, 'NoValue')
        % do nothing
    else
        set(pr.slider_text, ...
            'String', ['Layer: ' num2str(round(get(pr.slider, 'Value') * map_multiplier))]);
        
        if el.get('G').getPropNumber() > 9
            
            set(pr.layer_text, ...
            'String', [label ' ' num2str(round(get(pr.layer_slider, 'Value') * map_multiplier)) ': ' slider_tags{round(get(pr.layer_slider, 'Value') * map_multiplier)} ' ' extra_label]);
        
            % get the correct index
            l = round(get(pr.slider, 'Value') * map_multiplier); % layer
            d = round(get(pr.layer_slider, 'Value') * map_multiplier); % threshold or ddensity
        
            correct_i =  (d * L)- L + l ;
            
            set(pr.edit_value, ...
                'String', value{correct_i}, ...
                'Enable', pr.get('ENABLE') ...
                )
        else % wu
            set(pr.edit_value, ...
                'String', value{round(get(pr.slider, 'Value') * map_multiplier)}, ...
                'Enable', pr.get('ENABLE') ...
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
    g = el.get('g');
    L = size(el.get('B'), 2);
    n = 0;
    if el.get('G').getPropNumber() > 9
        n = length(el.get('G').get(10)); % 10 is densities or thresholds
    end

    if n > 1
        pr.redraw@PlotPropScalar('Height', h*2+Sh+Th, varargin{:});
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

        set(pr.layer_slider, ...
            'Units', 'normalized', ...
            'Visible', 'on', ...
            'Position', [.01 (Dh+h)/(h+Sh+Sh+Th+Th+Dh)-.2 .97 (Th/(h+Sh+Sh+Th+Th+Dh)-.02)] ...
            );

        set(pr.layer_text, ...
            'Units', 'normalized', ...
            'Visible', 'on', ...
            'Position', [.01 (Dh+Th+h)/(h+Sh+Sh+Th+Th+Dh)-.2 .97 (Th/(h+Sh+Sh+Th+Th+Dh)-.02)] ...
            );

        set(pr.edit_value, ...
            'Visible', 'on', ...
            'Units', 'normalized', ...
            'Position', [.01 .02 .97 ((Dh+h)/(h+Sh+Sh+Th+Th+Dh)-.2)] ...
            )
    else
        pr.redraw@PlotPropScalar('Height', h + Sh + Th + Dh, varargin{:});
        set(pr.slider, ...
            'Units', 'normalized', ...
            'Visible', 'on', ...
            'Position', [.01 (Dh+h)/(h+Sh+Th+Dh)-.2 .97 (Th/(h+Sh+Th+Dh)-.02)] ...
            );

        set(pr.slider_text, ...
            'Units', 'normalized', ...
            'Visible', 'on', ...
            'Position', [.01 (Th+Dh+h)/(h+Sh+Th+Dh)-.2 .97 (Th/(h+Sh+Th+Dh)-.02)] ...
            );

        set(pr.edit_value, ...
            'Visible', 'on', ...
            'Units', 'normalized', ...
            'Position', [.01 .02 .97 ((Dh+h)/(h+Sh+Th+Dh)-.2)] ...
            )
    end
    if ~pr.get_button_condition()
        set(pr.slider, ...
            'Visible', 'off' ...
            );
        
        set(pr.slider_text, ...
            'Visible', 'off' ...
            );
        
        set(pr.edit_value, ...
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
