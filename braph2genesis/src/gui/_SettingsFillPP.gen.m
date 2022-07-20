%% ¡header!
SettingsFillPP < PanelProp (pr, settings fill panel) is the panel with fill settings.

%%% ¡description!
SettingsFillPP plots the panel for fill settings including 

%%% ¡seealso!
SettingsFill, uicheckbox, uieditfield

%% ¡properties!
p

checkbox_visible
facecolor_button
facealpha_slider
facealpha_label

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of fill settings.
    %
    % DRAW(PR) draws the panel of fill settings.
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
    
    if ~check_graphics(pr.checkbox_visible, 'uicheckbox') 
        pr.checkbox_visible = uicheckbox( ...
            'Parent', pr.p, ...
            'Tag', 'checkbox_visible', ...
            'Text', 'auto', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('VISIBLE')) ' ' el.get(prop).getPropDescription('VISIBLE')], ...
            'ValueChangedFcn', {@cb_checkbox_visible} ...
            );
    end
    function cb_checkbox_visible(~, ~) % (src, event)
        pr.cb_fill()
    end

    if ~check_graphics(pr.facecolor_button, 'uibutton')
        pr.facecolor_button = uibutton( ...
            'Parent', pr.p, ...
            'Tag', 'facecolor_button', ...
            'Text', '', ...
            'Tooltip', [num2str(prop) ' ' upper(el.getPropTag(prop)) '>' num2str(el.get(prop).getPropProp('FACECOLOR')) ' ' el.get(prop).getPropDescription('FACECOLOR')], ...
            'ButtonPushedFcn', {@cb_facecolor_button} ...
            );
    end
        function cb_facecolor_button(~, ~) % (src, event)
            pr.cb_fill_color()
        end
    
    if ~check_graphics(pr.facealpha_label, 'uilabel')
        pr.facealpha_label =  uilabel( ...
            'Parent', pr.p, ...
            'Tag', 'facealpha', ...
            'Text', '', ...
            'Interpreter', 'html', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'right', ...            
            'BackgroundColor', pr.get('BKGCOLOR') ...
            );
    end
    if ~check_graphics(pr.facealpha_slider, 'uieditfield')
        pr.facealpha_slider = uislider( ...
            'Parent', pr.p, ...
            'Tag', 'facealpha_slider', ...
            'Limits', [0 100], ...
            'FontSize', BRAPH2.FONTSIZE / 2, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ValueChangedFcn', {@cb_facealpha_slider} ...
            );
    end
    function cb_facealpha_slider(~, ~) % (src, event)
        pr.cb_fill()
    end


    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the fill settings.
    %
    % UPDATE(PR) updates the content and permissions of the fill settings.
    %
    % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    if el.isLocked(prop)
        set(pr.checkbox_visible, 'Enable', pr.get('ENABLE'))

        set(pr.facealpha_slider, ...
            'Editable', 'off', ...
            'Enable', pr.get('ENABLE') ...
            )
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pr.checkbox_visible, 'Value', el.get(prop).get('VISIBLE'))
            set(pr.facealpha_slider, 'Value', el.get(prop).get('FACEALPHA'))

        case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
            set(pr.checkbox_visible, 'Value', el.get(prop).get('VISIBLE'))
            set(pr.facealpha_slider, 'Value', el.get(prop).get('FACEALPHA'))

            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('VISIBLE'), 'Callback')
                set(pr.checkbox_visible, 'Enable', pr.get('ENABLE'))
            end
            if isa(el.getr(prop), 'Callback') || isa(el.get(prop).get('FACEALPHA'), 'Callback')
                set(pr.facealpha_slider, ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end           
            
        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pr.checkbox_visible, ...
                    'Value', el.getPropDefault(prop).getPropDefault('VISIBLE'), ...
                    'Enable', pr.get('ENABLE') ...
                    )

                set(pr.facealpha_slider, ...
                    'Value', el.getPropDefault(prop).getPropDefault('FACEALPHA'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
               
            else
                set(pr.checkbox_visible, ...
                    'Value', el.get(prop).get('VISIBLE'), ...
                    'Enable', pr.get('ENABLE') ...
                    )

                set(pr.facealpha_slider, ...
                    'Value', el.get(prop).get('FACEALPHA'), ...
                    'Editable', 'off', ...
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
    % REDRAW(PR, 'FACECOLOR', FACECOLOR, 'FACEALPHA', FACEALPHA, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - FACECOLOR does not change
    %  - FACEALPHA does not change
    %  - WIDTH does not change
    %  - HEIGHT = s(3.5)
    %
    % See also draw, update, PanelElement, s.

    [h_p, varargin] = get_and_remove_from_varargin(s(7.5), 'Height', varargin);
    
    pr.redraw@PanelProp('Height', h_p, varargin{:})
    
    set(pr.checkbox_visible, 'Position', [s(.3) s(4.3) .15*w(pr.p, 'pixels') s(1.7)])
    set(pr.facecolor_button, 'Position', [s(.3) s(2) .12*w(pr.p, 'pixels') s(1.7)])
    set(pr.facealpha_label, 'Position', [s(.3) s(.3) .30*w(pr.p, 'pixels') s(1.7)])
    set(pr.facealpha_slider, 'Position', [s(.6)+.35*w(pr.p, 'pixels')+s(1.7) s(.3) .50*w(pr.p, 'pixels')   3])
end
function cb_fill_color(pr)

    el = pr.get('EL');
    prop = pr.get('PROP');

    new_color = uisetcolor(el.get(prop).get('FACECOLOR'));
    if ~isequal(new_color, el.get(prop).get('FACECOLOR'))
        el.get(prop).set('FACECOLOR', new_color)

        pr.update()
    end
end