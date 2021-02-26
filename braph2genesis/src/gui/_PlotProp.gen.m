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
    % see also settings, uipanel, isgraphics.

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
    end
    function cb_button_cb(~, ~)
        warning('TBI')
        % GUI(el.getr(prop).get('EL'))
    end
    function cb_button_calc(~, ~)
        el.memorize(prop);
        
        resize()
    end
    function cb_button_del(~, ~)
        el.set(prop, NoValue.getNoValue())
        
        resize()
    end

    % auxiliary functions
    function r = x0(h)
        r = pl.x0(h);
    end
    function r = y0(h)
        r = pl.y0(h);
    end
    function r = w(h)
        r = pl.w(h);
    end
    function r = h(h)
        r = pl.h(h);
    end

    % output
    if nargout > 0
        h_panel = pp;
    end
end

%% ¡staticmethods!
function r = x0(h)
    %X0 returns the position of the left edge of a graphical element in character units.
    %
    % R = X0(H) is the distance from the inner left edge of the parent
    %  container to the outer left edge of the graphical element H.
    % 
    % See also y0, w, h.

    units = get(h, 'Units');
    set(h, 'Units', 'character')
    r = x0@Plot(h);
    set(h, 'Units', units)
end
function r = y0(h)
    %Y0 returns the position of the bottom edge of a graphical element in character units.
    %
    % R = Y0(H) is the distance from the inner bottom edge of the parent 
    %  container to the outer bottom edge of the graphical element H.
    %
    % See also x0, w, h.

    units = get(h, 'Units');
    set(h, 'Units', 'character')
    r = y0@Plot(h);
    set(h, 'Units', units)
end
function r = w(h)
    %W returns the width of a graphical element in character units.
    %
    % R = W(H) is the distance between the right and left outer edges of the
    %   graphical element H.
    % 
    % See also x0, y0, h.

    units = get(h, 'Units');
    set(h, 'Units', 'character')
    r = w@Plot(h);
    set(h, 'Units', units)
end
function r = h(h)
    %H returns the height of a graphical element in character units.
    %
    % R = H(H) is the distance between the top and bottom outer edges of the
    %  graphical element H.
    % 
    % See also x0, y0, w.

    units = get(h, 'Units');
    set(h, 'Units', 'character')
    r = h@Plot(h);
    set(h, 'Units', units)
end
