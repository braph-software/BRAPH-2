%% ¡header!
SettingsGraphPP < PanelProp (pr, settings graph panel) is the panel with graph settings.

%%% ¡description!
SettingsGraphPP plots the panel for graph settings 

%%% ¡seealso!
SettingsPosition, uicheckbox, uipushbutton

%% ¡properties!
p

checkbox_weighted
checkbox_colorbar
checkbox_binary
checkbox_hist

label_binary
slider_binary

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of graph settings.
    %
    % DRAW(PR) draws the panel of graph settings.
    %
    % P = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard panel properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle P of the panel.
    %
    % See also update, redraw, uipanel.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    pr.p = draw@PanelProp(pr, varargin{:});    

    if ~check_graphics(pr.checkbox_weighted, 'uicheckbox')
        pr.checkbox_weighted = uicheckbox( ...
            'Parent', pr.p, ...
            'Tag', 'checkbox_weighted', ...
            'Text', 'weighted', ...
            'Value', 1, ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('WEIGHTED')) ' ' el.get(prop).getPropDescription('WEIGHTED')], ...
            'ValueChangedFcn', {@cb_checkbox_weighted} ...
            );
    end
    function cb_checkbox_weighted(~, ~) % (src, event)
        value = get(pr.checkbox_weighted, 'Value');
        if value
            set(pr.checkbox_binary, 'Value', ~value);
            set(pr.checkbox_hist, 'Value', ~value);
            
        end
        pr.cb_graph_s()
        state_colorbar()
    end

    if ~check_graphics(pr.checkbox_colorbar, 'uicheckbox')
        pr.checkbox_colorbar = uicheckbox( ...
            'Parent', pr.p, ...
            'Tag', 'checkbox_weighted', ...
            'Text', 'colorbar', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Visible', true, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('WEIGHTED')) ' ' el.get(prop).getPropDescription('WEIGHTED')], ...
            'ValueChangedFcn', {@cb_checkbox_colorbar} ...
            );
    end    
    function cb_checkbox_colorbar(~, ~) % (src, event)
        state_checkboxes()
        pr.cb_graph_s()
    end
    function state_colorbar()
        if get(pr.checkbox_weighted, 'Value')
            set(pr.checkbox_colorbar, 'Visible', true)
            set(pr.label_binary, 'Visible', false)
            set(pr.slider_binary, 'Visible', false)
        else
            set(pr.checkbox_colorbar, 'Visible', false)
            set(pr.label_binary, 'Visible', true)
            set(pr.slider_binary, 'Visible', true)
        end
    end

    if ~check_graphics(pr.label_binary, 'uilabel')
        pr.label_binary =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'label_binary', ...
            'Text', 'Density', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'right', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end

    if ~check_graphics(pr.checkbox_binary, 'uicheckbox')
        pr.checkbox_binary = uicheckbox( ...
            'Parent', pr.p, ...
            'Tag', 'checkbox_binary', ...
            'Text', 'binary', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('BINARY')) ' ' el.get(prop).getPropDescription('BINARY')], ...
            'ValueChangedFcn', {@cb_checkbox_binary} ...
            );
    end
    
    function cb_checkbox_binary(~, ~) % (src, event)
        value = get(pr.checkbox_binary, 'Value');
        if value
            set(pr.checkbox_weighted, 'Value', ~value);
            set(pr.checkbox_hist, 'Value', ~value);
        end
        pr.cb_graph_s()  
        state_colorbar()
    end

    if ~check_graphics(pr.slider_binary, 'uislider')
        pr.slider_binary = uislider( ...
            'Parent', pr.p, ...
            'Tag', 'slider_binary', ...
            'Limits', [0 100], ...
            'FontSize', BRAPH2.FONTSIZE / 2, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_slider_binary} ...
            );
    end
        function cb_slider_binary(~, ~) % (src, event)
            pr.cb_graph_s()
        end

    if ~check_graphics(pr.checkbox_hist, 'uicheckbox')
        pr.checkbox_hist = uicheckbox( ...
            'Parent', pr.p, ...
            'Tag', 'checkbox_hist', ...
            'Text', 'histogram', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('HIST')) ' ' el.get(prop).getPropDescription('HIST')], ...
            'ValueChangedFcn', {@cb_checkbox_hist} ...
            );
    end
    function cb_checkbox_hist(~, ~) % (src, event)
        value = get(pr.checkbox_hist, 'Value');
        if value
            set(pr.checkbox_weighted, 'Value', ~value);
            set(pr.checkbox_binary, 'Value', ~value);
            
        end
        pr.cb_graph_s()
    end   

    state_colorbar()
    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the graph settings.
    %
    % UPDATE(PR) updates the content and permissions of the graph settings.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.checkbox_weighted, 'Enable', pr.get('ENABLE'))
        set(pr.checkbox_colorbar, 'Enable', pr.get('ENABLE'))
        set(pr.checkbox_binary, 'Enable', pr.get('ENABLE'))
        set(pr.checkbox_hist, 'Enable', pr.get('ENABLE'))
        set(pr.slider_binary, 'Enable', pr.get('ENABLE'))
    end

    switch el.getPropCategory(prop)
        case Category.METADATA            
            set(pr.checkbox_weighted, 'Value', el.get(prop).get('WEIGHTED'))
            set(pr.checkbox_colorbar, 'VALUE', el.get(prop).get('COLORBAR'))
            set(pr.checkbox_binary, 'Value', el.get(prop).get('BINARY'))
            set(pr.checkbox_hist, 'Value', el.get(prop).get('HIST'))

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.checkbox_weighted, 'Value', el.get(prop).get('WEIGHTED'))
            set(pr.checkbox_colorbar, 'VALUE', el.get(prop).get('COLORBAR'))
            set(pr.checkbox_binary, 'Value', el.get(prop).get('BINARY'))
            set(pr.checkbox_hist, 'Value', el.get(prop).get('HIST'))


            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('WEIGHTED'), 'Callback')
                set(pr.checkbox_weighted, 'Enable', pr.get('ENABLE'))
                set(pr.checkbox_colorbar, 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('BINARY'), 'Callback')
                set(pr.checkbox_binary, 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('HIST'), 'Callback')
                set(pr.checkbox_hist, 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback')
                set(pr.slider_binary, 'Enable', pr.get('ENABLE'))
            end
            
        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.checkbox_weighted, ...
                    'Value', el.get(prop).getPropDefault('WEIGHTED'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.checkbox_colorbar, 'VALUE', el.get(prop).get('COLORBAR'), ...
                    'Enable', pr.get('ENABLE'))
                set(pr.checkbox_binary, ...
                    'Value', el.get(prop).getPropDefault('BINARY'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.checkbox_hist, ...
                    'Value', el.get(prop).getPropDefault('HIST'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.slider_binary, 'Enable', pr.get('ENABLE'))
            else
                set(pr.checkbox_weighted, ...
                    'Value', el.get(prop).get('AXIS'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.checkbox_colorbar, 'VALUE', el.get(prop).get('COLORBAR'), ...
                    'Enable', pr.get('ENABLE'))
                set(pr.checkbox_binary, ...
                    'Value', el.get(prop).get('BINARY'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.checkbox_hist, ...
                    'Value', el.get(prop).get('HIST'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.slider_binary, 'Enable', pr.get('ENABLE'))
            end
    end
end
function redraw(pr, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PR) resizes the property panel and repositions its graphical objects. 
    % 
    % Important notes:
    % 1. REDRAW() sets the units 'pixels' for panel. 
    % 2. REDRAW() is typically called internally by PanelElement and does not need 
    %  to be explicitly called in children of PanelProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT = s(5.5)
    %
    % See also draw, update, PanelElement, s.

    [h_p, varargin] = get_and_remove_from_varargin(s(8.5), 'Height', varargin);
    
    pr.redraw@PanelProp('Height', h_p, varargin{:})
    
    set(pr.checkbox_weighted, 'Position', [s(.3) s(4.3) .30*w(pr.p, 'pixels') s(1.7)])
    set(pr.checkbox_colorbar, 'Position', [s(.3)+.35*w(pr.p, 'pixels')+s(1.7) s(4.3) .30*w(pr.p, 'pixels') s(1.7)])
    set(pr.checkbox_binary, 'Position', [s(.3) s(2.3) .30*w(pr.p, 'pixels') s(1.7)])
    set(pr.label_binary, 'Position', [s(.6)+.35*w(pr.p, 'pixels')+s(1.7) s(4.3)  .20*w(pr.p, 'pixels')   s(1.7)])
    set(pr.slider_binary, 'Position', [s(.6)+.35*w(pr.p, 'pixels')+s(1.7) s(3.3) .50*w(pr.p, 'pixels')   3]) % the height of a slider cannot be changed
    set(pr.checkbox_hist, 'Position', [s(.3) s(.3) .30*w(pr.p, 'pixels') s(1.7)])
end
function cb_graph_s(pr)
    %CB_AXIS executes callback for all checkboxes.
    %
    % CB_AXIS(PR) executes callback for all checkboxes.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set( ...
        'WEIGHTED', get(pr.checkbox_weighted, 'Value'), ...
        'COLORBAR', get(pr.checkbox_colorbar, 'Value'), ...
        'BINARY', get(pr.checkbox_binary, 'Value'), ...
        'BINARY_VALUE', get(pr.slider_binary, 'Value'), ...
        'HIST', get(pr.checkbox_hist, 'Value') ...        
        )

end