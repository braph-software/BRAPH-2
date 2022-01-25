%% ¡header!
PPMeasure_M < PlotProp (pr, plot property M of measure) is a plot of property M of measure.

%%% ¡description!
PPMeasure_M plots a Measure result table and plot.

%%% ¡seealso!
GUI, PlotElement, PlotProp, MultigraphBUD, MultigraphBUT.

%% ¡properties!
p
measure_value_container
measure_text
slider

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the idict for group ensemble property graphical panel.
    %
    % DRAW(PR) draws the idict property graphical panel.
    %
    % H = DRAW(PR) returns a handle to the idict property graphical panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain surface graphical panel H.
    %
    % see also update, redraw, refresh, settings, uipanel, isgraphics.

    % create panel with slider
    el = pr.get('EL');
    prop = pr.get('PROP');
    value = el.get(prop);
    L = length(value);
    
    if Measure.is_global(el)
        pr.measure_value_container = PlotGlobalMeasure('EL', el, 'PROP', prop, varargin{:});
        pr.p = pr.measure_value_container.draw();
    elseif Measure.is_nodal(el)
        pr.measure_value_container = PlotNodalMeasure('EL', el, 'PROP', prop, varargin{:});
        pr.p = pr.measure_value_container.draw();
    else % binodal
        pr.measure_value_container = PlotBinodalMeasure('EL', el, 'PROP', prop, varargin{:});
        pr.p = pr.measure_value_container.draw();
    end
    
    % set on first layer
    pr.slider = uicontrol( ...
        'Parent', pr.p, ...
        'Style', 'slider', ...
        'Units', 'characters', ...
        'Value', 1, ...
        'Min', 1, ...
        'Max', L, ...
        'Visible', 'off', ...
        'Enable', 'off', ...
        'SliderStep', [1 1], ...
        'Callback', {@cb_slider} ...
        );

        function cb_slider(~, ~)
            pr.update()
        end

    pr.measure_text = uicontrol(...
        'Parent', pr.p, ...
        'Style', 'text', ...
        'Units', 'characters', ...
        'HorizontalAlignment', 'left', ...
        'FontUnits', BRAPH2.FONTUNITS, ...
        'FontSize', BRAPH2.FONTSIZE, ...
        'String', '1', ...
        'Visible', 'off', ...
        'Enable', 'off', ...
        'BackgroundColor', pr.get('BKGCOLOR') ...
        );

    if L > 1
        set(pr.slider, ...
            'Enable', 'on', ...
            'Visible', 'on' ...
            )

        set(pr.measure_text, ...
            'Enable', 'on', ...
            'Visible', 'on' ...
            )
    end

    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content of the property graphical panel.
    %
    % UPDATE(PR) updates the content of the property graphical panel.
    %
    % See also draw, redraw, refresh.

    el = pr.get('EL');
    prop = pr.get('PROP');

    if el.isLocked(prop)
        set(pr.measure_tbl, ...
            'Enable', pr.get('ENABLE'), ...
            'ColumnEditable', false ...
            )
    end

    set(pr.measure_text, ...
        'String', num2str(round(get(pr.slider, 'Value'))));
    
    pr.measure_value_container.update(round(get(pr.slider, 'Value')));

end
function redraw(pr, varargin)
    %REDRAW redraws the element graphical panel.
    %
    % REDRAW(PR) redraws the plot PR.
    %
    % REDRAW(PR, 'Height', HEIGHT) sets the height of PR (by default HEIGHT=3.3).
    %
    % See also draw, update, refresh.

    [h, varargin] = get_and_remove_from_varargin(1.8, 'Height', varargin);
    [Sh, varargin] = get_and_remove_from_varargin(2.0, 'SHeight', varargin);
    [Th, varargin] = get_and_remove_from_varargin(2.0, 'THeight', varargin);
    [Dh, varargin] = get_and_remove_from_varargin(20, 'DHeight', varargin);

    el = pr.get('EL');
    prop = pr.get('PROP');
    value = el.get(prop);
    L = length(value);

    set(pr.slider, ...
        'Units', 'normalized', ...
        'Position', [.01 (Th+Dh)/(h+Sh+Th+Dh) .97 (Th/(h+Sh+Th+Dh)-.02)] ...
        );

    set(pr.measure_text, ...
        'Units', 'normalized', ...
        'Position', [.01 Dh/(h+Sh+Th+Dh) .97 (Th/(h+Sh+Th+Dh)-.02)] ...
        );

    if L > 1
        pr.measure_value_container.redraw('Height', h + Sh + Th + Dh, varargin{:})
    else
        if Measure.is_global(el)
            pr.measure_value_container.redraw('EDITHEIGHT', 3.3)
        else
            pr.measure_value_container.redraw()
        end
        
    end
end