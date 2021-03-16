%% ¡header!
PlotPropItemList < PlotProp (pl, plot property item list) is a plot of a property item list.

%%% ¡description!
PlotProp plots a property item list of an element in a panel.

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
pp
pushbutton_value_list

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the item list property graphical panel.
    %
    % DRAW(PL) draws the item list property graphical panel.
    %
    % H = DRAW(PL) returns a handle to the item list property graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain surface graphical panel H.
    %
    % see also update, redraw, refresh, settings, uipanel, isgraphics.

    pl.pp = draw@PlotProp(pl, varargin{:});

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
        
    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        %
    else
        item_list = el.get(prop);
        if isempty(pl.pushbutton_value_list)
            pl.pushbutton_value_list = cell(1, length(item_list));
        end
        for i = 1:1:length(item_list)
            if isempty(pl.pushbutton_value_list{i}) || ~isgraphics(pl.pushbutton_value_list{i}, 'pushbutton')
                pl.pushbutton_value_list{i} = uicontrol( ...
                    'Style', 'pushbutton', ...
                    'Parent', pl.pp ...
                    );
            end
            set(pl.pushbutton_value_list{i}, ...
                'String', item_list{i}.tostring(), ...
                'Tooltip', regexprep(item_list{i}.tree(), {'<strong>', '</strong>'}, {'' ''}), ...
                'Callback', {@cb_pushbutton_value, item_list{i}} ...
                )
        end
    end
    
    % callback
    function cb_pushbutton_value(~, ~, item)
        pl.update()
        
        GUI(item)
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
    
    el = pl.get('EL');
    prop = pl.get('PROP');

    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        pl.redraw@PlotProp('Height', 1.8, varargin{:})
    else
        item_list = el.get(prop);
        
        pl.redraw@PlotProp('Height', 1.8 + 1.5 * length(item_list), varargin{:})
        
        for i = 1:1:length(item_list)
            set(pl.pushbutton_value_list{i}, ...
                'Units', 'character', ...
                'Position', ...
                    [ ...
                        0.01*Plot.w(pl.pp) ...
                        1.5*(length(item_list)-i)+.3 ...
                        0.98*Plot.w(pl.pp) ...
                        1.2 ...
                    ] ...
                )
        end
    end
end