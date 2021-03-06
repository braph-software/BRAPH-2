%% ¡header!
PlotPropScalar < PlotProp (pl, plot property scalar) is a plot of a property scalar.

%%% ¡description!
PlotProp plots a property scalar of an element in a panel.

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
pp
edit_value

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the scalar property graphical panel.
    %
    % DRAW(PL) draws the scalar property graphical panel.
    %
    % H = DRAW(PL) returns a handle to the scalar property graphical panel.
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
    
    if isempty(pl.edit_value) || ~isgraphics(pl.edit_value, 'edit')
        pl.edit_value = uicontrol( ...
            'Style', 'edit', ...
            'Parent', pl.pp, ...
            'Units', 'normalized', ...
            'Position', [.01 .10 .29 .40], ...
            'HorizontalAlignment', 'left', ...
            'BackgroundColor', 'w', ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'Callback', {@cb_edit_value} ...
            );
    end

    % callback
    function cb_edit_value(src, ~)
        el.set(prop, str2double(get(src, 'String')))
   
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
        set(pl.edit_value, 'Enable', pl.get('ENABLE'))
    end

    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pl.edit_value, 'String', mat2str(el.get(prop)))

        case {Category.PARAMETER, Category.DATA}
            set(pl.edit_value, 'String', mat2str(el.get(prop)))

            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pl.edit_value, 'Enable', pl.get('ENABLE'))
            end

        case Category.RESULT
            value = el.getr(prop);

            if isa(value, 'NoValue')
                set(pl.edit_value, ...
                    'String', mat2str(el.getPropDefault(prop)), ...
                    'Enable', pl.get('ENABLE') ...
                    )
            else
                set(pl.edit_value, ...
                    'String', mat2str(el.get(prop)), ...
                    'Enable', pl.get('ENABLE') ...
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
    
    pl.resize@PlotProp('Height', 2.50)
end