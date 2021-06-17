%% ¡header!
PlotPropClass < PlotProp (pl, plot property class) is a plot of a property class.

%%% ¡description!
PlotProp plots a property class of an element in a panel.

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
pp
popupmenu_value

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the class property graphical panel.
    %
    % DRAW(PL) draws the class property graphical panel.
    %
    % H = DRAW(PL) returns a handle to the class property graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain surface graphical panel H.
    %
    % see also update, redraw, refresh, settings, uipanel, isgraphics.

    el = pl.get('EL');
    prop = pl.get('PROP');
    
    pl.pp = draw@PlotProp(pl, varargin{:});
    
    if isempty(pl.popupmenu_value) || ~isgraphics(pl.popupmenu_value, 'edit')
        pl.popupmenu_value = uicontrol( ...
            'Style', 'popupmenu', ...
            'Parent', pl.pp, ...
            'Units', 'normalized', ...
            'Position', [.01 .10 .98 .45], ...
            'String', subclasses(el.getPropSettings(prop), [], [], true), ...
            'HorizontalAlignment', 'left', ...
            'BackgroundColor', 'w', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'Callback', {@cb_popupmenu_value} ...
            );
    end

    % callback
    function cb_popupmenu_value(src, ~)
        el = pl.get('EL');
        options = subclasses(el.getPropSettings(prop), [], [], true);
        el.set(prop, options{get(src, 'Value')})
   
        pl.update()
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
    % See also draw, redraw, refresh.

    update@PlotProp(pl)
    
    el = pl.get('EL');
    prop = pl.get('PROP');
    
    if el.isLocked(prop)
        set(pl.popupmenu_value, 'Enable', pl.get('ENABLE'))
    end

    classes = subclasses(el.getPropSettings(prop), [], [], true);
    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pl.popupmenu_value, 'Value', find(cellfun(@(x) strcmpi(el.get(prop), x), classes)))

        case {Category.PARAMETER, Category.DATA}
            set(pl.popupmenu_value, 'Value', find(cellfun(@(x) strcmpi(el.get(prop), x), classes)))

            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pl.popupmenu_value, 'Enable', pl.get('ENABLE'))
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pl.popupmenu_value, ...
                    'Value', find(cellfun(@(x) strcmpi(el.getPropDefault(prop), x), classes)), ...
                    'Enable', pl.get('ENABLE') ...
                    )
            else
                set(pl.popupmenu_value, ...
                    'Value', find(cellfun(@(x) strcmpi(el.get(prop), x), classes)), ...
                    'Enable', pl.get('ENABLE') ...
                    )
            end
    end
end
function redraw(pl, varargin)
    %REDRAW redraws the element graphical panel.
    %
    % REDRAW(PL) redraws the plot PL.
    %
    % REDRAW(PL, 'Height', HEIGHT) sets the height of PL (by default HEIGHT=3.3).
    %
    % See also draw, update, refresh.
    
    pl.redraw@PlotProp('Height', 3.50, varargin{:})
end