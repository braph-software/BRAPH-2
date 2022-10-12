%% ¡header!
SettingsAmbientPP < PanelProp (pr, settings ambient panel) is the panel with position settings.

%%% ¡description!
SettingsAmbientPP plots the panel for ambient settings including 
including drop-down lists for lighting, material, camlight, shading, and colormap.
It works for all categories.

%%% ¡seealso!
SettingsAmbient, uidropdown

%% ¡properties!
p
label_lighting
dropdown_lighting
label_material
dropdown_material
label_camlight
dropdown_camlight
label_shading
dropdown_shading
label_colormap
dropdown_colormap

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of ambient settings.
    %
    % DRAW(PR) draws the panel of ambient settings.
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
    
    if ~check_graphics(pr.label_lighting, 'uilabel')
        pr.label_lighting =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'label_lighting', ...
            'Text', 'lightning', ...
            'Interpreter', 'html', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'right', ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LIGHTING')) ' ' el.get(prop).getPropDescription('LIGHTING')], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end
    if ~check_graphics(pr.dropdown_lighting, 'uieditfield')
        pr.dropdown_lighting = uidropdown( ...
            'Parent', pr.p, ...
            'Tag', 'dropdown_lighting', ...
            'Items', el.get(prop).getPropSettings('LIGHTING'), ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('LIGHTING')) ' ' el.get(prop).getPropDescription('LIGHTING')], ...
            'ValueChangedFcn', {@cb_dropdown_lightning} ...
            );
    end
    function cb_dropdown_lightning(~, ~) % (src, event)
        pr.cb_ambient()
    end

    if ~check_graphics(pr.label_material, 'uilabel')
        pr.label_material =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'label_material', ...
            'Text', 'material', ...
            'Interpreter', 'html', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'right', ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('MATERIAL')) ' ' el.get(prop).getPropDescription('MATERIAL')], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end
    if ~check_graphics(pr.dropdown_material, 'uieditfield')
        pr.dropdown_material = uidropdown( ...
            'Parent', pr.p, ...
            'Tag', 'dropdown_material', ...
            'Items', el.get(prop).getPropSettings('MATERIAL'), ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('MATERIAL')) ' ' el.get(prop).getPropDescription('MATERIAL')], ...
            'ValueChangedFcn', {@cb_dropdown_material} ...
            );
    end
    function cb_dropdown_material(~, ~) % (src, event)
        pr.cb_ambient()
    end

    if ~check_graphics(pr.label_camlight, 'uilabel')
        pr.label_camlight =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'label_camlight', ...
            'Text', 'camera light', ...
            'Interpreter', 'html', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'right', ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('CAMLIGHT')) ' ' el.get(prop).getPropDescription('CAMLIGHT')], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end
    if ~check_graphics(pr.dropdown_camlight, 'uieditfield')
        pr.dropdown_camlight = uidropdown( ...
            'Parent', pr.p, ...
            'Tag', 'dropdown_camlight', ...
            'Items', el.get(prop).getPropSettings('CAMLIGHT'), ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('CAMLIGHT')) ' ' el.get(prop).getPropDescription('CAMLIGHT')], ...
            'ValueChangedFcn', {@cb_dropdown_camlight} ...
            );
    end
    function cb_dropdown_camlight(~, ~) % (src, event)
        pr.cb_ambient()
    end

    if ~check_graphics(pr.label_shading, 'uilabel')
        pr.label_shading =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'label_shading', ...
            'Text', 'shading', ...
            'Interpreter', 'html', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'right', ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('SHADING')) ' ' el.get(prop).getPropDescription('SHADING')], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end
    if ~check_graphics(pr.dropdown_shading, 'uieditfield')
        pr.dropdown_shading = uidropdown( ...
            'Parent', pr.p, ...
            'Tag', 'dropdown_shading', ...
            'Items', el.get(prop).getPropSettings('SHADING'), ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('SHADING')) ' ' el.get(prop).getPropDescription('SHADING')], ...
            'ValueChangedFcn', {@cb_dropdown_shading} ...
            );
    end
    function cb_dropdown_shading(~, ~) % (src, event)
        pr.cb_ambient()
    end

    if ~check_graphics(pr.label_colormap, 'uilabel')
        pr.label_colormap =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'label_colormap', ...
            'Text', 'colormap', ...
            'Interpreter', 'html', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'right', ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('COLORMAP')) ' ' el.get(prop).getPropDescription('COLORMAP')], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end
    if ~check_graphics(pr.dropdown_colormap, 'uieditfield')
        pr.dropdown_colormap = uidropdown( ...
            'Parent', pr.p, ...
            'Tag', 'dropdown_colormap', ...
            'Items', el.get(prop).getPropSettings('COLORMAP'), ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('COLORMAP')) ' ' el.get(prop).getPropDescription('COLORMAP')], ...
            'ValueChangedFcn', {@cb_dropdown_colormap} ...
            );
    end
    function cb_dropdown_colormap(~, ~) % (src, event)
        pr.cb_ambient()
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the ambient settings.
    %
    % UPDATE(PR) updates the content and permissions of the ambient settings.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.dropdown_lighting, 'Enable', pr.get('ENABLE'))
        set(pr.dropdown_material, 'Enable', pr.get('ENABLE'))
        set(pr.dropdown_camlight, 'Enable', pr.get('ENABLE'))
        set(pr.dropdown_shading, 'Enable', pr.get('ENABLE'))
        set(pr.dropdown_colormap, 'Enable', pr.get('ENABLE'))
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.dropdown_lighting, 'Value', el.get(prop).get('LIGHTING'))
            set(pr.dropdown_material, 'Value', el.get(prop).get('MATERIAL'))
            set(pr.dropdown_camlight, 'Value', el.get(prop).get('CAMLIGHT'))
            set(pr.dropdown_shading, 'Value', el.get(prop).get('SHADING'))
            set(pr.dropdown_colormap, 'Value', el.get(prop).get('COLORMAP'))

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.dropdown_lighting, 'Value', el.get(prop).get('LIGHTING'))
            set(pr.dropdown_material, 'Value', el.get(prop).get('MATERIAL'))
            set(pr.dropdown_camlight, 'Value', el.get(prop).get('CAMLIGHT'))
            set(pr.dropdown_shading, 'Value', el.get(prop).get('SHADING'))
            set(pr.dropdown_colormap, 'Value', el.get(prop).get('COLORMAP'))

            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('LIGHTING'), 'Callback')
                set(pr.dropdown_lighting, ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('MATERIAL'), 'Callback')
                set(pr.dropdown_material, ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('CAMLIGHT'), 'Callback')
                set(pr.dropdown_camlight, ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('SHADING'), 'Callback')
                set(pr.dropdown_shading, ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('COLORMAP'), 'Callback')
                set(pr.dropdown_colormap, ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            
        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.dropdown_lighting, ...
                    'Value', el.get(prop).getPropDefault('LIGHTING'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.dropdown_material, ...
                    'Value', el.get(prop).getPropDefault('MATERIAL'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.dropdown_camlight, ...
                    'Value', el.get(prop).getPropDefault('CAMLIGHT'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.dropdown_shading, ...
                    'Value', el.get(prop).getPropDefault('SHADING'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.dropdown_colormap, ...
                    'Value', el.get(prop).getPropDefault('COLORMAP'), ...
                    'Enable', pr.get('ENABLE') ...
                    )                
            else
                set(pr.dropdown_lighting, ...
                    'Value', el.get(prop).get('LIGHTING'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.dropdown_material, ...
                    'Value', el.get(prop).get('MATERIAL'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.dropdown_camlight, ...
                    'Value', el.get(prop).get('CAMLIGHT'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.dropdown_shading, ...
                    'Value', el.get(prop).get('SHADING'), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.dropdown_colormap, ...
                    'Value', el.get(prop).get('COLORMAP'), ...
                    'Enable', pr.get('ENABLE') ...
                    )                
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
    %  - HEIGHT = s(12.5)
    %
    % See also draw, update, PanelElement, s.

    [h_p, varargin] = get_and_remove_from_varargin(s(12.5), 'Height', varargin);
    
    pr.redraw@PanelProp('Height', h_p, varargin{:})
    
    set(pr.label_lighting, 'Position', [s(.3) s(8.3) s(8) s(1.7)])
    set(pr.dropdown_lighting, 'Position', [s(8.6) s(8.3) w(pr.p, 'pixels')-s(10) s(1.7)])

    set(pr.label_material, 'Position', [s(.3) s(6.3) s(8) s(1.7)])
    set(pr.dropdown_material, 'Position', [s(8.6) s(6.3) w(pr.p, 'pixels')-s(10) s(1.7)])

    set(pr.label_camlight, 'Position', [s(.3) s(4.3) s(8) s(1.7)])
    set(pr.dropdown_camlight, 'Position', [s(8.6) s(4.3) w(pr.p, 'pixels')-s(10) s(1.7)])

    set(pr.label_shading, 'Position', [s(.3) s(2.3) s(8) s(1.7)])
    set(pr.dropdown_shading, 'Position', [s(8.6) s(2.3) w(pr.p, 'pixels')-s(10) s(1.7)])

    set(pr.label_colormap, 'Position', [s(.3) s(.3) s(8) s(1.7)])
    set(pr.dropdown_colormap, 'Position', [s(8.6) s(.3) w(pr.p, 'pixels')-s(10) s(1.7)])
end
function cb_ambient(pr)
    %CB_AMBIENT executes callback for all fields.
    %
    % CB_AMBIENT(PR) executes callback for all fields.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    el.get(prop).set( ...
        'LIGHTING', get(pr.dropdown_lighting, 'Value'), ...
        'MATERIAL', get(pr.dropdown_material, 'Value'), ...
        'CAMLIGHT', get(pr.dropdown_camlight, 'Value'), ...
        'SHADING', get(pr.dropdown_shading, 'Value'), ...
        'COLORMAP', get(pr.dropdown_colormap, 'Value') ...
        )

    pr.update()
end