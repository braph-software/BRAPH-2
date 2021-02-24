%% ¡header!
PlotElement < Plot (pl, plot brain surface) is a plot of an element.

%%% ¡description!
PlotElement plots all properties of an element in a resizable scrollable panel.

%%% ¡seealso!
GUI, PlotProp

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
        'SizeChangedFcn', {@resize} ...
        );
    
    p = uipanel( ...
        'Parent', f, ...
        'Units', 'character', ...
        'Position', [0 0 w(f) h(f)], ...
        'BackgroundColor', pl.get('BKGCOLOR'), ...
        'BorderType', 'none' ...
        );

    s = uicontrol( ...
        'Style', 'slider', ...
        'Parent', f, ...
        'Units', 'character', ...
        'Position', [w(f)-5 0 5 h(f)], ... % defines slider width
        'Min', -eps, ...
        'Max', 0, ...
        'Value', 0, ...
        'Callback', {@cb_s});
    
%     function cb_s(~, ~)
%         offset = get(s, 'Value');
%         set(p, 'Position', [x0(p) h(f)-h(p)-offset w(p) h(p)]);
%     end
    
    function resize(~, ~)
        randn()
    end

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

pl = PlotElement();
pl.draw()
pl.settings()

% close(fig)