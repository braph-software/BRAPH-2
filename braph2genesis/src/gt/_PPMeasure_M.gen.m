%% ¡header!
PPMeasure_M < PlotProp (pr, plot property M of measure) is a plot of property M of measure.

%%% ¡description!
PPMeasure_M plots a Measure result.

CALLBACKS - These are callback functions:

    pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
    pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
    pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure

%%% ¡seealso!
GUI, PlotElement, PlotProp, MultigraphBUD, MultigraphBUT.

%% ¡properties!
p
f_br
br_type
br_btn

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
    
    if Measure.is_global(el) && (el.get('G').getGraphType()==1 || el.get('G').getGraphType()==2)
        pr.p = PlotPropMeasureGlobal( ...
            'EL', el, ...
            'PROP', prop, ...
            'ID', 'm', ...
            'TITLE', 'M', ...
            'BKGCOLOR', [0.8 0.5 0.2]).draw(varargin{:});
    elseif Measure.is_nodal(el) && (el.get('G').getGraphType()==1 || el.get('G').getGraphType()==2)
        pr.p = PlotPropMeasureNodal( ...
            'EL', el, ...
            'PROP', prop, ...
            'ID', 'm', ...
            'TITLE', 'M', ...
            'BKGCOLOR', [0.8 0.5 0.2]).draw(varargin{:});
    elseif Measure.is_binodal(el) && (el.get('G').getGraphType()==1 || el.get('G').getGraphType()==2) % binodal
        pr.p = PlotPropMeasureBinodal( ...
            'EL', el, ...
            'PROP', prop, ...
            'ID', 'm', ...
            'TITLE', 'M', ...
            'BKGCOLOR', [0.8 0.5 0.2]).draw(varargin{:});
    elseif Measure.is_global(el) && el.get('G').getGraphType()==4
        pr.p = PlotPropMeasureGlobalMultilayer( ...
            'EL', el, ...
            'PROP', prop, ...
            'ID', 'm', ...
            'TITLE', 'M', ...
            'BKGCOLOR', [0.8 0.5 0.2]).draw(varargin{:});
    elseif Measure.is_nodal(el) && el.get('G').getGraphType()==4
         pr.p = PlotPropMeasureNodalMultilayer( ...
            'EL', el, ...
            'PROP', prop, ...
            'ID', 'm', ...
            'TITLE', 'M', ...
            'BKGCOLOR', [0.8 0.5 0.2]).draw(varargin{:});
    else % binodal multilayer
         pr.p = PlotPropMeasureBinodalMultilayer( ...
            'EL', el, ...
            'PROP', prop, ...
            'ID', 'm', ...
            'TITLE', 'M', ...
            'BKGCOLOR', [0.8 0.5 0.2]).draw(varargin{:});
    end
    
    if Measure.is_nodal(el)        
        pr.br_btn = uicontrol('Parent', pr.p, ...
            'Style', 'pushbutton', ...
            'Units', 'normalized', ...
            'Visible', 'on', ...
            'TooltipString', 'Open the measure in a Brain View plot.', ...
            'String', 'Plot Brain View', ...
            'Position', [.02 .88 .3 .06], ...
            'Callback', {@cb_brainview});
    end
        
    function cb_brainview (~, ~)
        pr.cb_brain_view_fig();
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
    
    get(pr.p, 'UserData').update()
end
function redraw(pr, varargin)
    %REDRAW redraws the element graphical panel.
    %
    % REDRAW(PR) redraws the plot PR.
    %
    % REDRAW(PR, 'Height', HEIGHT) sets the height of PR (by default HEIGHT=3.3).
    %
    % See also draw, update, refresh.

    get(pr.p, 'UserData').redraw(varargin{:}) 
    if ~pr.get_button_condition()
        set(pr.br_btn, 'Visible', 'off')
    end
end
function cb_brain_view_fig(pr)
    f_pg = ancestor(pr.p, 'Figure');
    f_ba_x = Plot.x0(f_pg, 'pixels');
    f_ba_y = Plot.y0(f_pg, 'pixels');
    f_ba_w = Plot.w(f_pg, 'pixels');
    f_ba_h = Plot.h(f_pg, 'pixels');

    screen_x = Plot.x0(0, 'pixels');
    screen_y = Plot.y0(0, 'pixels');
    screen_w = Plot.w(0, 'pixels');
    screen_h = Plot.h(0, 'pixels');

    x = f_ba_x + f_ba_w;
    h = f_ba_h / 1.5;
    y = f_ba_y + f_ba_h - h;
    w = screen_w - x;
    
    if isempty(pr.f_br) || ~check_graphics(pr.f_br, 'figure')
        pr.f_br = figure( ...
            'NumberTitle', 'off', ...
            'Units', 'normalized', ...
            'MenuBar', 'none', ...
            'Toolbar', 'figure', ...
            'DockControls', 'off', ...
            'Position', [x/screen_w y/screen_h w/screen_w h/screen_h], ...
            'CloseRequestFcn', {@cb_f_br_close} ...
            );
        set_braph2_icon(pr.f_br)
        menu_about = BRAPH2.add_menu_about(pr.f_br);
        
        ui_toolbar = findall(pr.f_br, 'Tag', 'FigureToolBar');
        delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
        delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))
        
        el = pr.get('EL');
        prop = pr.get('PROP');
        
        g = el.get('G');
        
        if isequal(g.getClass(), 'MultigraphBUD') || isequal(g.getClass(), 'MultiplexBUD')
            type = 'Densities';
        elseif isequal(g.getClass(), 'MultigraphBUT') || isequal(g.getClass(), 'MultiplexBUT')
            type = 'Thresholds';
        else
            type = 'Weighted';
        end
        
        pbv = PlotBrainView('ME', el, ...
            'Atlas', g.get('BRAINATLAS'), ...
            'Type', type);

        
        pbv.draw('Parent', pr.f_br );
        f_settings = pbv.settings();
        set(pr.f_br, 'UserData', pbv);
        set(f_settings, 'Position', [x/screen_w f_ba_y/screen_h w/screen_w (f_ba_h-h)/screen_h])
        f_settings.OuterPosition(4) = (f_ba_h-h)/screen_h;
        f_settings.OuterPosition(2) = f_ba_y/screen_h;
    else
        gui = get(pr.f_br, 'UserData');
        gui.cb_bring_to_front()
    end
    
    function cb_f_br_close(~, ~)
        delete(pr.f_br);
        pr.update()
    end

    pr.update()
end
function cb_bring_to_front(pr)
    %CB_BRING_TO_FRONT brings to front the figure and its settings figure.
    %
    % CB_BRING_TO_FRONT(PR) brings to front the figure and its
    %  settings figure.
    %
    % See also cb_hide, cb_close.

    % brings to front settings panel
    pr.cb_bring_to_front@PlotProp();
    
    % bring to front plot graph
    if check_graphics(pr.f_br, 'figure')
        gui = get(pr.f_br, 'UserData');
        gui.cb_bring_to_front()
    end      
end
function cb_hide(pr)
    %CB_HIDE hides the figure and its settings figure.
    %
    % CB_HIDE(PR) hides the figure and its settings figure.
    %
    % See also cb_bring_to_front, cb_close.

    % hides settings panel
    pr.cb_hide@PlotProp();
    
    % bring to front plot graph
    if check_graphics(pr.f_br, 'figure')
        gui = get(pr.f_br, 'UserData');
        gui.cb_hide();
    end 

end
function cb_close(pr)
    %CB_CLOSE closes the figure.
    %
    % CB_CLOSE(PR) closes the figure and its children figures.
    %
    % See also cb_bring_to_front, cd_hide.

    % close adj graph figure
    if ~isempty(pr.f_br) && check_graphics(pr.f_br, 'figure')
        delete(pr.f_br);
    end     
end
function state = get_button_condition(pr)
    % GET_BUTTON_CONDITION returns the calculate button state.
    %
    % STATE = GET_BUTTON_CONDITION(PR) returns the calculate button state.
    %
    % see also is_measure_calculated.

    plot_prop_children = get(pr.p, 'Children');
    state = 0; % calculated
    for i = 1:length(plot_prop_children)
        pp_c = plot_prop_children(i);
        if check_graphics(pp_c, 'pushbutton') && isequal(pp_c.Tag, 'button_calc')
            if isequal(pp_c.Enable, 'off')
                state = 1;  % not calculated
            end
        end
    end
end