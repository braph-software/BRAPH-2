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
pp
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
    
    pl.pp = draw@Plot(pl, ...
        varargin{:}, ...
        'Units', 'character', ...
        'BackgroundColor', pl.get('BKGCOLOR'), ...
        'BorderType', 'none', ... 
        'SizeChangedFcn', {@resize} ...
        );
    
    if isempty(pl.text_tag) || ~isgraphics(pl.text_tag, 'text')
        pl.text_tag =  uicontrol( ...
            'Style', 'text', ...
            'Parent', pl.pp, ...
            'Units', 'character', ...
            'String', upper(el.getPropTag(prop)), ...
            'HorizontalAlignment', 'left', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'BackgroundColor', pl.get('BKGCOLOR') ...
            );
    end
    
    switch el.getPropCategory(prop)
        case Category.METADATA
            %
            
        case {Category.PARAMETER, Category.DATA}
            if isempty(pl.button_cb) || ~isgraphics(pl.button_cb, 'pushbutton')
                pl.button_cb = uicontrol( ...
                    'Style', 'pushbutton', ...
                    'Parent', pl.pp, ...
                    'Units', 'character', ...
                    'String', '@', ...
                    'HorizontalAlignment', 'left', ...
                    'FontWeight', 'bold', ...
                    'Callback', {@cb_button_cb}, ...
                    'Visible', 'on' ...
                    );
            end
            
        case Category.RESULT
            if isempty(pl.button_calc) || ~isgraphics(pl.button_calc, 'pushbutton')
                pl.button_calc = uicontrol( ...
                    'Style', 'pushbutton', ...
                    'Parent', pl.pp, ...
                    'Units', 'character', ...
                    'String', 'C', ...
                    'HorizontalAlignment', 'left', ...
                    'FontWeight', 'bold', ...
                    'Tooltip', 'Calculate', ...
                    'Callback', {@cb_button_calc} ...
                    );
            end
            if isempty(pl.button_del) || ~isgraphics(pl.button_del, 'pushbutton')
                pl.button_del = uicontrol( ...
                    'Style', 'pushbutton', ...
                    'Parent', pl.pp, ...
                    'Units', 'character', ...
                    'String', 'D', ...
                    'HorizontalAlignment', 'left', ...
                    'FontWeight', 'bold', ...
                    'Tooltip', 'Delete', ...
                    'Callback', {@cb_button_del} ...
                    );
            end
    end
    
    % callback
    function resize(~, ~)
        pl.resize()
    end
    function cb_button_cb(~, ~)
        pl.cb_button_cb()
    end
    function cb_button_calc(~, ~)
        pl.cb_button_calc()
    end
    function cb_button_del(~, ~)
        pl.cb_button_del()
    end

    % output
    if nargout > 0
        h_panel = pl.pp;
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
    
    pp = pl.pp;

    set(pp, 'Position', [x0(pp) y0(pp) w(pp) 1.4])

    set(pl.text_tag, 'Position', [0 h(pp)-1 w(pp) 1]);

    switch el.getPropCategory(prop)
        case Category.METADATA
            %

        case {Category.PARAMETER, Category.DATA}
            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pl.button_cb, ...
                    'Position', [w(pp)-4 h(pp)-1.2 3 1], ...
                    'Tooltip', value.tostring(), ...
                    'Visible', 'on' ...
                    );
            else
                set(pl.button_cb, 'Visible', 'off')
            end

        case Category.RESULT
            set(pl.button_calc, 'Position', [w(pp)-7.5 h(pp)-1.2 3 1])

            set(pl.button_del, 'Position', [w(pp)-4 h(pp)-1.2 3 1])

            value = el.getr(prop);
            if isa(value, 'NoValue')
                set(pl.button_calc, 'Enable', 'on')
                set(pl.button_del, 'Enable', 'off')
            else
                set(pl.button_calc, 'Enable', 'off')
                set(pl.button_del, 'Enable', 'on')
            end
    end
    
    % auxiliary functions
    function r = x0(h)
        r = Plot.x0(h);
    end
    function r = y0(h)
        r = Plot.y0(h);
    end
    function r = w(h)
        r = Plot.w(h);
    end
    function r = h(h)
        r = Plot.h(h);
    end
end
function refresh(pl)
    %REFRESH recalculates the size and values of the parent.
    %
    % REFRESH(PL) recalculates the size and values of the parent.
    
    pp = pl.pp;
    f = get(pp, 'Parent');
    if isgraphics(f, 'uipanel')
        f = get(f, 'Parent');
    end
    units = get(f, 'Units');
    position = get(f, 'Position');
    set(f, 'Units', 'pixels') 
    set(f, 'Position', get(f, 'Position') + [0 0 0 -10])
    set(f, 'Units', units, 'Position', position)
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
    pl.refresh()
end
function cb_button_del(pl)
    %CB_BUTTON_DEL executes callback for button delete.
    %
    % CB_BUTTON_DEL(PL) executes callback for button delete.

    el = pl.get('EL');
    prop = pl.get('PROP');
    
    el.set(prop, NoValue.getNoValue())

    pl.resize()
    % pl.refresh()
end