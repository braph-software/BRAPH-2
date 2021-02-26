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
    
    pp = draw@Plot(pl, varargin{:});
    set(pp, ...
        'Units', 'character', ...
        'Position', [x0(pp) y0(pp) w(pp) 1.4], ...
        'BorderType', 'none' ...
        )
        
    if isempty(pl.text_tag) || ~isgraphics(pl.text_tag, 'text')    
        pl.text_tag =  uicontrol( ...
            'Style', 'text', ...
            'Parent', pp ...
            );
    end
    set(pl.text_tag, ...
        'Units', 'character', ...
        'Position', [0 0 w(pp) 1], ... % defines prop text tag height
        'String', upper(el.getPropTag(prop)), ...
        'HorizontalAlignment', 'left', ...
        'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
        'BackgroundColor', pl.get('BKGCOLOR') ...
        );
    
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
        h_panel = pp;
    end
end