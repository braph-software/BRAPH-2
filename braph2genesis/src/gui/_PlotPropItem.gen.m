%% ¡header!
PlotPropItem < PlotProp (pl, plot property item) is a plot of a property item.

%%% ¡description!
PlotProp plots a property item of an element in a panel.

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
pp
pushbutton_value

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the item property graphical panel.
    %
    % DRAW(PL) draws the item property graphical panel.
    %
    % H = DRAW(PL) returns a handle to the item property graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain surface graphical panel H.
    %
    % see also update, resize, refresh, settings, uipanel, isgraphics.

    el = pl.get('EL');
    prop = pl.get('PROP');
    
    pl.pp = draw@PlotProp(pl, varargin{:});
    
    if isempty(pl.pushbutton_value) || ~isgraphics(pl.pushbutton_value, 'edit')
        pl.pushbutton_value = uicontrol( ...
            'Style', 'pushbutton', ...
            'Parent', pl.pp, ...
            'Units', 'normalized', ...
            'Position', [.01 .10 .98 .45], ...
            'Callback', {@cb_pushbutton_value} ...
            );
    end

    % callback
    function cb_pushbutton_value(src, ~)
        pl.update()
        
        value = el.getr(prop);
        if isa(value, 'NoValue')
            GUI(el.getPropDefault(prop))
        else
            GUI(el.get(prop).tostring())
        end
    end

    % output
    if nargout > 0
        h_panel = pl.pp;
    end
end
function update(pl)
    %UPDATE updates the content of the property graphical panel.
    %
    % UPDATE(PL) updates the content of the property graphical panel.
    %
    % See also draw, resize, refresh.

    update@PlotProp(pl)
    
    el = pl.get('EL');
    prop = pl.get('PROP');
    
    set(pl.pushbutton_value, ...
        'String', el.get(prop).tostring(), ...
        'Tooltip', regexprep(el.tree(), {'<strong>', '</strong>'}, {'' ''}) ...
        )
end
function resize(pl, varargin)
    %RESIZE resizes the element graphical panel.
    %
    % RESIZE(PL) resizes the plot PL.
    %
    % RESIZE(PL, 'Height', HEIGHT) sets the height of PL (by default HEIGHT=3.3).
    %
    % See also draw, update, refresh.
    
    pl.resize@PlotProp('Height', 3.33)
end