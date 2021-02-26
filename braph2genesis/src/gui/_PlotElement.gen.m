%% ¡header!
PlotElement < Plot (pl, plot element) is a plot of an element.

%%% ¡description!
PlotElement plots all properties of an element in a resizable scrollable panel.

%%% ¡seealso!
GUI, PlotProp

%% ¡props!

%%% ¡prop!
EL (metadata, item) is the element to be plotted.

%%% ¡prop!
PP_DICT (result, idict) is a dictionary of the property plots.
%%%% ¡settings!
'PlotProp'

%%% ¡prop!
DW (metadata, scalar) is the margin along the width in character units.
%%%% ¡deafult!
1

%%% ¡prop!
DH (metadata, scalar) is the margin along the height in character units.
%%%% ¡deafult!
.5

%% ¡properties!
p % handle for scrollable
s % handle for slider

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the element graphical panel.
    %
    % DRAW(PL) draws the element graphical panel.
    %
    % H = DRAW(PL) returns a handle to the element graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain surface graphical panel H.
    %
    % see also settings, uipanel, isgraphics.

    % initialization
    f = draw@Plot(pl, varargin{:}, ...
        'Visible', 'off', ...
        'SizeChangedFcn', {@resize} ...
        );
    
    if isempty(pl.p) || ~isgraphics(pl.p, 'uipanel')
        pl.p = uipanel( ...
            'Parent', f, ...
            'Units', 'character', ...
            'Position', [0 0 w(f) h(f)], ...
            'BackgroundColor', pl.get('BKGCOLOR'), ...
            'BorderType', 'none' ...
            );
    end
    p = pl.p;

    if isempty(pl.s) || ~isgraphics(pl.s, 'slider')    
        pl.s = uicontrol( ...
            'Style', 'slider', ...
            'Parent', f, ...
            'Units', 'character', ...
            'Position', [w(f)-5 0 5 h(f)], ... % defines slider width
            'Min', -eps, ...
            'Max', 0, ...
            'Value', 0, ...
            'Callback', {@cb_s});
    end
    s = pl.s;

    function cb_s(~, ~)
        offset = get(s, 'Value');
        set(p, 'Position', [x0(p) h(f)-h(p)-offset w(p) h(p)]);
    end
    
    el = pl.get('EL');
    pp = cell(1, el.getPropNumber());
    for prop = 1:1:el.getPropNumber()
        if pl.get('PP_DICT').length() < prop
            pl.memorize('PP_DICT').add(PlotProp('ID', el.getPropTag(prop), 'EL', el, 'PROP', prop))
        end
        
        pp{prop} = pl.get('PP_DICT').getItem(prop).draw('Parent', p);
    end

    resize()
    function resize(~, ~)
        dw = pl.get('DW');
        dh = pl.get('DH');
        
        pp_w = w(f) - 2 * dw - w(s);
        pp_h = cellfun(@(x) h(x), pp);
        pp_x0 = dw;
        pp_y0 = sum(pp_h + dh) - cumsum(pp_h + dh) + dh;
        for prop = 1:1:el.getPropNumber()
            set(pp{prop}, ...
                'Units', 'character', ...
                'Position', [pp_x0 pp_y0(prop) pp_w pp_h(prop)] ...
                )
        end

        h_p = sum(pp_h + dh) + dh;
        if h_p < h(f)
            set(p, 'Position', [0 0 w(f) h(f)])
            for prop = 1:1:el.getPropNumber()
                set(pp{prop}, 'Position', [x0(pp{prop}) y0(pp{prop})+h(f)-h_p w(pp{prop}) h(pp{prop})])
            end
        else
            offset = get(s, 'Value');
            set(p, 'Position', [0 h(f)-h_p-offset w(f) h_p])
        end

        if h(f) >= h(p) - dh
            set(s, 'Visible', 'off')
        else
            set(s, ...
                'Visible', 'on', ...
                'Position', [w(p)-w(s) 0 w(s) h(f)], ...
                'Min', h(f) - h(p) ...
                )            
        end
    end

    % show
    set(f, 'Visible', 'on')

    % auxiliary functions
    function r = x0(h)
        units = get(h, 'Units');
        set(h, 'Units', 'character')
        r = pl.x0(h);
        set(h, 'Units', units)
    end
    function r = y0(h)
        units = get(h, 'Units');
        set(h, 'Units', 'character')
        r = pl.y0(h);
        set(h, 'Units', units)
    end
    function r = w(h)
        units = get(h, 'Units');
        set(h, 'Units', 'character')
        r = pl.w(h);
        set(h, 'Units', units)
    end
    function r = h(h)
        units = get(h, 'Units');
        set(h, 'Units', 'character')
        r = pl.h(h);
        set(h, 'Units', units)
    end

    % output
    if nargout > 0
        h_panel = f;
    end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Basics
%%%% ¡code!
fig = figure();

et = ETA();
pl = PlotElement('EL', et);
pl.draw()
pl.settings()

% close(fig)