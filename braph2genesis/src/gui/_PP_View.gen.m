%% ¡header!
PP_View < PanelProp (pr, view panel) plots the panel of a view with azimuth and elevation angles.

%%% ¡description!
PP_View plots the panel for the azimuth and elevation angles of the camera''s line of sight.
 Azimuth — The angle of rotation around the z-axis, as measured from the negative y-axis. 
  Increasing this angle corresponds to counterclockwise rotation about the z-axis 
  when viewing the xy plane from above.
 Elevation — The minimum angle between the line of sight and the xy plane. Increasing the elevation 
  from -90 to 90 degrees corresponds to a rotation from the negative z-axis to the positive z-axis.
It works for all categories.

%%% ¡seealso!
GUI, PanelElement, PanelProp, view, uieditfield, uislider

%% ¡properties!
p
label_az
editfield_az
slider_az
label_el
editfield_el
slider_el

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of the view.
    %
    % DRAW(PR) draws the panel of the view.
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
    
    if ~check_graphics(pr.label_az, 'uilabel')
        pr.label_az =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'label_az', ...
            'Text', 'azimuth', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'right', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end
    
    if ~check_graphics(pr.editfield_az, 'uieditfield')
        pr.editfield_az = uieditfield('numeric', ...
            'Parent', pr.p, ...
            'Tag', 'editfield_az', ...
            'Limits', [-180 180], ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_editfield_az} ...
            );
    end
    function cb_editfield_az(~, ~) % (src, event)
        pr.cb_view(get(pr.editfield_az, 'Value'), [])
    end

    if ~check_graphics(pr.slider_az, 'uislider')
        pr.slider_az = uislider( ...
            'Parent', pr.p, ...
            'Tag', 'slider_az', ...
            'Limits', [-180 180], ...
            'FontSize', BRAPH2.FONTSIZE / 2, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_slider_az} ...
            );
    end
    function cb_slider_az(~, ~) % (src, event)
        pr.cb_view(get(pr.slider_az, 'Value'), [])
    end

    if ~check_graphics(pr.label_el, 'uilabel')
        pr.label_el =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'label_el', ...
            'Text', 'elevation', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'right', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end
    
    if ~check_graphics(pr.editfield_el, 'uieditfield')
        pr.editfield_el = uieditfield('numeric', ...
            'Parent', pr.p, ...
            'Tag', 'editfield_el', ...
            'Limits', [-90 90], ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_editfield_el} ...
            );
    end
    function cb_editfield_el(~, ~) % (src, event)
        pr.cb_view([], get(pr.editfield_el, 'Value'))
    end

    if ~check_graphics(pr.slider_el, 'uislider')
        pr.slider_el = uislider( ...
            'Parent', pr.p, ...
            'Tag', 'slider_el', ...
            'Limits', [-90 90], ...
            'FontSize', BRAPH2.FONTSIZE / 2, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_slider_el} ...
            );
    end
    function cb_slider_el(~, ~) % (src, event)
        pr.cb_view([], get(pr.slider_el, 'Value'))
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the view.
    %
    % UPDATE(PR) updates the content and permissions of the view.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.editfield_az, ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.slider_az, 'Enable', pr.get('ENABLE'))
        set(pr.editfield_el, ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
        set(pr.slider_el, 'Enable', pr.get('ENABLE'))
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            v = el.get(prop);
            set(pr.editfield_az, 'Value', v(1))
            set(pr.slider_az, 'Value', v(1))
            set(pr.editfield_el, 'Value', v(2))
            set(pr.slider_el, 'Value', v(2))

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            v = el.get(prop);
            set(pr.editfield_az, 'Value', v(1))
            set(pr.slider_az, 'Value', v(1))
            set(pr.editfield_el, 'Value', v(2))
            set(pr.slider_el, 'Value', v(2))

            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pr.editfield_az, ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.slider_az, 'Enable', pr.get('ENABLE'))
                set(pr.editfield_el, ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.slider_el, 'Enable', pr.get('ENABLE'))
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                v = el.getPropDefault(prop);
                set(pr.editfield_az, ...
                    'Value', v(1), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.slider_az, ...
                    'Value', v(1), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.editfield_el, ...
                    'Value', v(2), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.slider_el, ...
                    'Value', v(2), ...
                    'Enable', pr.get('ENABLE') ...
                    )
            else
                v = el.get(prop);
                set(pr.editfield_az, ...
                    'Value', v(1), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.slider_az, ...
                    'Value', v(1), ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.editfield_el, ...
                    'Value', v(2), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
                set(pr.slider_el, ...
                    'Value', v(2), ...
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
    %  - HEIGHT = s(6.4)
    %
    % See also draw, update, PanelElement, s.

    [h_p, varargin] = get_and_remove_from_varargin(s(6.4), 'Height', varargin);
    
    pr.redraw@PanelProp('Height', h_p, varargin{:})
    
    set(pr.label_az,     'Position', [s(.3)                              s(3.2)  .20*w(pr.p, 'pixels')   s(1.7)])
    set(pr.editfield_az, 'Position', [s(.6)+.20*w(pr.p, 'pixels')        s(3.2)  .15*w(pr.p, 'pixels')   s(1.7)])
    set(pr.slider_az,    'Position', [s(.6)+.35*w(pr.p, 'pixels')+s(1.7) s(4.75) .50*w(pr.p, 'pixels')   3]) % the height of a slider cannot be changed
    set(pr.label_el,     'Position', [s(.3)                              s(.7)   .20*w(pr.p, 'pixels')   s(1.7)])
    set(pr.editfield_el, 'Position', [s(.6)+.20*w(pr.p, 'pixels')        s(.7)   .15*w(pr.p, 'pixels')   s(1.7)])
    set(pr.slider_el,    'Position', [s(.6)+.35*w(pr.p, 'pixels')+s(1.7) s(2.25) .50*w(pr.p, 'pixels')   3]) % the height of a slider cannot be changed
end
function cb_view(pr, azimuth, elevation)
    %CB_VIEW executes callback for the view.
    %
    % CB_VIEW(PR) executes callback for the view.

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if isempty(azimuth)
        old_v = el.get(prop);
        azimuth = old_v(1);
    end
    if isempty(elevation)
        old_v = el.get(prop);
        elevation = old_v(2);
    end
    
    el.set(prop, [azimuth, elevation])

    pr.update()
end