%% ¡header!
PlotPropLogical < PlotProp (pl, plot property logical) is a plot of a property logical.

%%% ¡description!
PlotProp plots a property logical of an element in a panel.

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
pp
checkbox_value

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the logical property graphical panel.
    %
    % DRAW(PL) draws the logical property graphical panel.
    %
    % H = DRAW(PL) returns a handle to the logical property graphical panel.
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
    
    if isempty(pl.checkbox_value) || ~isgraphics(pl.checkbox_value, 'checkbox')
        pl.checkbox_value = uicontrol( ...
            'Style', 'checkbox', ...
            'Parent', pl.pp, ...
            'Units', 'normalized', ...
            'Position', [.01 .10 .29 .40], ...
            'HorizontalAlignment', 'center', ...
            'BackgroundColor', pl.get('BKGCOLOR'), ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'Callback', {@cb_checkbox_value} ...
            );
    end

    % callback
    function cb_checkbox_value(src, ~)
        el.set(prop, logical(get(src, 'Value')))
   
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
    % See also draw, resize, refresh.

    update@PlotProp(pl)
    
    el = pl.get('EL');
    prop = pl.get('PROP');
    
    if el.isLocked(prop)
        set(pl.checkbox_value, 'Enable', 'off')
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pl.checkbox_value, 'Value', el.get(prop))

        case {Category.PARAMETER, Category.DATA}
            set(pl.checkbox_value, 'Value', el.get(prop))

            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pl.checkbox_value, 'Enable', 'off')
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pl.checkbox_value, ...
                    'Value', el.getPropDefault(prop), ...
                    'Enable', 'off' ...
                    )
            else
            set(pl.checkbox_value, ...
                'Value', el.get(prop), ...
                'Enable', 'off' ...
                )
            end
    end
end
function resize(pl, varargin)
    %RESIZE resizes the element graphical panel.
    %
    % RESIZE(PL) resizes the plot PL.
    %
    % RESIZE(PL, 'Height', HEIGHT) sets the height of PL (by default HEIGHT=3.3).
    %
    % See also draw, update, refresh.
    
    pl.resize@PlotProp('Height', 2.5)
end