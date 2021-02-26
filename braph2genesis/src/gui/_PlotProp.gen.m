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
            'Position', [0 0 w(pp) 1], ... % defines prop text tag height
            'String', upper(el.getPropTag(prop)), ...
            'HorizontalAlignment', 'left', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'BackgroundColor', pl.get('BKGCOLOR') ...
            );
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
