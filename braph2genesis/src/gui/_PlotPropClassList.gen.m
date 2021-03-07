%% ¡header!
PlotPropClassList < PlotProp (pl, plot property class list) is a plot of a property class list.

%%% ¡description!
PlotProp plots a property class list of an element in a panel.

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
pp
listbox_value

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the class list property graphical panel.
    %
    % DRAW(PL) draws the class list property graphical panel.
    %
    % H = DRAW(PL) returns a handle to the class list property graphical panel.
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
    
    if isempty(pl.listbox_value) || ~isgraphics(pl.listbox_value, 'edit')
        pl.listbox_value = uicontrol( ...
            'Style', 'listbox', ...
            'Parent', pl.pp, ...
            'Units', 'normalized', ...
            'Position', [.01 .10 .98 .80], ...
            'String', subclasses(el.getPropSettings(prop), [], [], true), ...
            'Max', 2, ...
            'HorizontalAlignment', 'left', ...
            'BackgroundColor', 'w', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'Callback', {@cb_listbox_value} ...
            );
    end

    % callback
    function cb_listbox_value(src, ~)
        options = subclasses(el.getPropSettings(prop), [], [], true);
        el.set(prop, options(get(src, 'Value')))
   
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
        set(pl.listbox_value, 'Enable', pl.get('ENABLE'))
    end

    classes = subclasses(el.getPropSettings(prop), [], [], true);
    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pl.listbox_value, 'Value', find(cellfun(@(x) any(strcmpi(el.get(prop), x)), classes)))

        case {Category.PARAMETER, Category.DATA}
            set(pl.listbox_value, 'Value', find(cellfun(@(x) any(strcmpi(el.get(prop), x)), classes)))

            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pl.listbox_value, 'Enable', pl.get('ENABLE'))
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pl.listbox_value, ...
                    'Value', find(cellfun(@(x) any(strcmpi(el.getPropDefault(prop), x)), classes)), ...
                    'Enable', pl.get('ENABLE') ...
                    )
            else
                set(pl.listbox_value, ...
                    'Value', find(cellfun(@(x) any(strcmpi(el.get(prop), x)), classes)), ...
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
    
    pl.redraw@PlotProp('Height', 10, varargin{:})
end