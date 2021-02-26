%% ¡header!
PlotProp < Plot (pl, plot property) is a plot of a property.

%%% ¡description!
PlotProp plots a property of an element in a panel.

%%% ¡seealso!
GUI, PlotElement

%% ¡props!

%%% ¡prop!
EL (metadata, item) is the element.

%%% ¡prop!
PROP (data, scalar) is the property number.

%% ¡properties!
text_tag
button_cb % only for PARAMETER and DATA
button_calc % only for RESULT
button_del % only for RESULT

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the property graphical panel.
    %
    % DRAW(PL) draws the property graphical panel.
    %
    % H = DRAW(PL) returns a handle to the property graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain surface graphical panel H.
    %
    % see also resize, settings, uipanel, isgraphics.

    el = pl.get('EL');
    prop = pl.get('PROP');
    
    pp = draw@Plot(pl, varargin{:}, 'SizeChangedFcn', {@resize});

    if isempty(pl.text_tag) || ~isgraphics(pl.text_tag, 'text')
        pl.text_tag =  uicontrol( ...
            'Style', 'text', ...
            'Parent', pp ...
            );
    end
    
    switch el.getPropCategory(prop)
        case Category.METADATA
            %
            
        case {Category.PARAMETER, Category.DATA}
            if isempty(pl.button_cb) || ~isgraphics(pl.button_cb, 'pushbutton')
                pl.button_cb = uicontrol( ...
                    'Style', 'pushbutton', ...
                    'Parent', pp ...
                    );
            end
            
        case Category.RESULT
            if isempty(pl.button_calc) || ~isgraphics(pl.button_calc, 'pushbutton')
                pl.button_calc = uicontrol( ...
                    'Style', 'pushbutton', ...
                    'Parent', pp ...
                    );
            end
            if isempty(pl.button_del) || ~isgraphics(pl.button_del, 'pushbutton')
                pl.button_del = uicontrol( ...
                    'Style', 'pushbutton', ...
                    'Parent', pp ...
                    );
            end
    end

    resize()
    
    function resize(~, ~)
        pl.resize()
    end

    % output
    if nargout > 0
        h_panel = pp;
    end
end
function resize(pl)
    %RESIZE resizes the element graphical panel.
    %
    % RESIZE(PL) resizes the plot PL.
    %
    % See also draw.
    
    el = pl.get('EL');
    prop = pl.get('PROP');
    
    pp = get(pl.text_tag, 'Parent');

    set(pp, ...
        'Units', 'character', ...
        'Position', [x0(pp) y0(pp) w(pp) 1.4], ...
        'BackgroundColor', pl.get('BKGCOLOR'), ...
        'BorderType', 'none' ...
        )

    set(pl.text_tag, ...
        'Units', 'character', ...
        'Position', [0 h(pp)-1 w(pp) 1], ... % defines prop text tag height
        'String', upper(el.getPropTag(prop)), ...
        'HorizontalAlignment', 'left', ...
        'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
        'BackgroundColor', pl.get('BKGCOLOR') ...
        );

    switch el.getPropCategory(prop)
        case Category.METADATA
            %

        case {Category.PARAMETER, Category.DATA}
            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pl.button_cb, ...
                    'Units', 'character', ...
                    'Position', [w(pp)-4 h(pp)-1.2 3 1], ...
                    'String', '@', ...
                    'HorizontalAlignment', 'left', ...
                    'FontWeight', 'bold', ...
                    'Tooltip', value.tostring(), ...
                    'Callback', {@cb_button_cb}, ...
                    'Visible', 'on' ...
                    );
            else
                set(pl.button_cb, 'Visible', 'off')
            end

        case Category.RESULT
            set(pl.button_calc, ...
                'Units', 'character', ...
                'Position', [w(pp)-7.5 h(pp)-1.2 3 1], ...
                'String', 'C', ...
                'HorizontalAlignment', 'left', ...
                'FontWeight', 'bold', ...
                'Tooltip', 'Calculate', ...
                'Callback', {@cb_button_calc} ...
                );

            set(pl.button_del, ...
                'Units', 'character', ...
                'Position', [w(pp)-4 h(pp)-1.2 3 1], ...
                'String', 'D', ...
                'HorizontalAlignment', 'left', ...
                'FontWeight', 'bold', ...
                'Tooltip', 'Delete', ...
                'Callback', {@cb_button_del} ...
                );

            value = el.getr(prop);
            if isa(value, 'NoValue')
                set(pl.button_calc, 'Enable', 'on')
                set(pl.button_del, 'Enable', 'off')
            else
                set(pl.button_calc, 'Enable', 'off')
                set(pl.button_del, 'Enable', 'on')
            end
    end
    
    % callback functions
    function cb_button_cb(~, ~)
        pl.cb_button_cb()
    end
    function cb_button_calc(~, ~)
        pl.cb_button_calc()
    end
    function cb_button_del(~, ~)
        pl.cb_button_del()
    end
    
    % auxiliary functions
    function r = x0(h)
        r = PlotElement.x0(h);
    end
    function r = y0(h)
        r = PlotElement.y0(h);
    end
    function r = w(h)
        r = PlotElement.w(h);
    end
    function r = h(h)
        r = PlotElement.h(h);
    end
end
function cb_button_cb(pl)
    %CB_BUTTON_CB executes callback for button callback.
    %
    % CB_BUTTON_CB(PL) executes callback for button callback.

    warning('TBI')
    % GUI(el.getr(prop).get('EL'))
end
function cb_button_calc(pl)
    %CB_BUTTON_CALC executes callback for button calculate.
    %
    % CB_BUTTON_CALC(PL) executes callback for button calculate.

    el = pl.get('EL');
    prop = pl.get('PROP');

    el.memorize(prop);

    pl.resize()

    pp = get(pl.text_tag, 'Parent');
    f = get(pp, 'Parent');
    if isgraphics(f, 'uipanel')
        f = get(f, 'Parent');
    end
    units = get(f, 'Units');
    position = get(f, 'Position');
    set(f, 'Units', 'pixels', 'Position', get(f, 'Position') + [0 0 0 -1])
    set(f, 'Units', units, 'Position', position)
end
function cb_button_del(pl)
    %CB_BUTTON_DEL executes callback for button delete.
    %
    % CB_BUTTON_DEL(PL) executes callback for button delete.

    el = pl.get('EL');
    prop = pl.get('PROP');
    
    el.set(prop, NoValue.getNoValue())

    pl.resize()

    pp = get(pl.text_tag, 'Parent');
    f = get(pp, 'Parent');
    if isgraphics(f, 'uipanel')
        f = get(f, 'Parent');
    end
    units = get(f, 'Units');
    position = get(f, 'Position');
    set(f, 'Units', 'pixels', 'Position', get(f, 'Position') + [0 0 0 -1])
    set(f, 'Units', units, 'Position', position)
end