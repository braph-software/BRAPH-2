%% ¡header!
PlotPropMeasureGlobal < PlotPropScalar (pr, plot global measure) represents the nodal measure.

%%% ¡description!
PlotPropMeasureGlobal represents the global measure.

%%% ¡seealso!
GUI, PlotElement, PlotPropString, PPMeasure_M.

%% ¡properties!
p
edit_value
slider
slider_text

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
    value = el.get(prop);
    L = size(value, 1);
    map_multiplier = 100;
    
    % set on first layer
    pr.slider = uicontrol( ...
        'Parent', pr.p, ...
        'Style', 'slider', ...
        'Units', 'characters', ...
        'Visible', 'off', ...
        'Value', 1 * map_multiplier, ...
        'Min', 1, ...
        'Max', L * map_multiplier, ...
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
        'FontWeight', 'bold', ...
        'String', '', ...
        'BackgroundColor', pr.get('BKGCOLOR') ...
        );
    
    function cb_slider(~, ~)
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
    value = el.get(prop);
    L = size(value, 1);
    map_multiplier = 100;
    if el.get('G').getPropNumber() > 9
        label = el.get('G').getPropTag(10);
    else
        label = 'Weighted';
        set(pr.slider, 'Enable', 'off')
    end
    br_dict = el.get('G').get('BRAINATLAS').get('BR_DICT');
    
    if isa(value, 'NoValue')
        set(pr.slider_text, ...
            'String', [label ' ' num2str(round(get(pr.slider, 'Value') / map_multiplier))]);
        set(pr.edit_value, ...
            'String', 'No Value', ...
            'Enable', pr.get('ENABLE') ...
            )
    else
        set(pr.slider_text, ...
            'String', [label ' ' num2str(round(get(pr.slider, 'Value') / map_multiplier))]);
        set(pr.edit_value, ...
            'String', value{round(get(pr.slider, 'Value') / map_multiplier)}, ...
            'Enable', pr.get('ENABLE') ...
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
    [Sh, varargin] = get_and_remove_from_varargin(2.0, 'SHeight', varargin);
    [Th, varargin] = get_and_remove_from_varargin(2.0, 'THeight', varargin);
    [Dh, varargin] = get_and_remove_from_varargin(2.0, 'DHeight', varargin);
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    value = el.get(prop);
    L = size(value, 1);
    
     if L > 1
        pr.redraw@PlotPropScalar('Height', h*2+Sh+Th, varargin{:});
        set(pr.slider, ...
            'Units', 'normalized', ...
            'Visible', 'on', ...
            'Position', [.01 Dh/(h+Sh+Th+Dh) .97 (Th/(h+Sh+Th+Dh)-.02)] ...
            );
        
        set(pr.slider_text, ...
            'Units', 'normalized', ...
            'Visible', 'on', ...
            'Position', [.01 (Th+Dh)/(h+Sh+Th+Dh) .97 (Th/(h+Sh+Th+Dh)-.02)] ...
            );
        
        set(pr.edit_value, ...
            'Visible', 'on', ...
            'Units', 'normalized', ...
            'Position', [.01 .02 .97 (Dh/(h+Sh+Th+Dh)-.02)] ...
            )
     else
        pr.redraw@PlotPropScalar(varargin{:});
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
