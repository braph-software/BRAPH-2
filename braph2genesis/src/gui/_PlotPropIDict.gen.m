%% ¡header!
PlotPropIDict < PlotProp (pl, plot property idict) is a plot of a property idict.

%%% ¡description!
PlotProp plots a property idict of an element in a panel.

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
pp
pushbutton_value

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the idict property graphical panel.
    %
    % DRAW(PL) draws the idict property graphical panel.
    %
    % H = DRAW(PL) returns a handle to the idict property graphical panel.
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
        el = pl.get('EL');
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
    % See also draw, redraw, refresh.

    update@PlotProp(pl)
    
    el = pl.get('EL');
    prop = pl.get('PROP');
    
    if el.isLocked(prop)
        set(pl.pushbutton_value, 'Enable', pl.get('ENABLE'))
    end
    
    switch el.getPropCategory(prop)
        case Category.METADATA
            set(pl.pushbutton_value, ...
                'String', el.get(prop).tostring(), ...
                'Tooltip', regexprep(el.get(prop).tree(), {'<strong>', '</strong>'}, {'' ''}) ...
                )
            
        case {Category.PARAMETER, Category.DATA}
            set(pl.pushbutton_value, ...
                'String', el.get(prop).tostring(), ...
                'Tooltip', regexprep(el.get(prop).tree(), {'<strong>', '</strong>'}, {'' ''}) ...
                )
            
            value = el.getr(prop);
            if isa(value, 'Callback')
                set(pl.pushbutton_value, 'Enable', pl.get('ENABLE'))
            end

        case Category.RESULT
            value = el.getr(prop);
            
            if isa(value, 'NoValue')
                set(pl.pushbutton_value, ...
                    'String', el.getPropDefault(prop).tostring(), ...
                    'Tooltip', regexprep(el.getPropDefault(prop).tree(), {'<strong>', '</strong>'}, {'' ''}), ...
                    'Enable', pl.get('ENABLE') ...
                    )
            else
                set(pl.pushbutton_value, ...
                    'String', el.get(prop).tostring(), ...
                    'Tooltip', regexprep(el.get(prop).tree(), {'<strong>', '</strong>'}, {'' ''}), ...
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
    
    pl.redraw@PlotProp('Height', 3.33, varargin{:})
end