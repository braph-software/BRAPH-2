%% ¡header!
PPNNBase_Model < PlotPropCell (pr, plot property model) plots the layer of neural networks.

%%% ¡description!
PPNNBase_Model plots the NN layers.

CALLBACK - This is a callback function:

    pr.<strong>cb_bring_to_front</strong>() - brings to the front the layer figure
    pr.<strong>cb_hide</strong>() - hides the layer figure
    pr.<strong>cb_close</strong>() - closes the layer figure

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
p
c_btn
d_btn
f_c
h
%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the panel of the graph property and the measure table.
    %
    % DRAW(PR) draws the panel of the graph property and the measure table.
    %
    % H = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H of the panel.
    %
    % See also update, redraw, refresh, uipanel.

    pr.p = draw@PlotPropCell(pr, varargin{:});
    pr.get_buttons();
    
    el = pr.get('el');
    
    set(pr.c_btn, 'Callback', {@cb_button_mod_calc})
    
    function cb_button_mod_calc(~, ~)              
        % position  %%%%%%%%%%%

        % supress ploting from command line usage
        el.set('PLOT_LAYERS', false);

        pr.cb_button_calc()

        f_ba = ancestor(pr.p, 'Figure'); % BrainAtlas GUI
        f_ba_x = Plot.x0(f_ba, 'pixels');
        f_ba_y = Plot.y0(f_ba, 'pixels');
        f_ba_w = Plot.w(f_ba, 'pixels');
        f_ba_h = Plot.h(f_ba, 'pixels');
        
        screen_x = Plot.x0(0, 'pixels');
        screen_y = Plot.y0(0, 'pixels');
        screen_w = Plot.w(0, 'pixels');
        screen_h = Plot.h(0, 'pixels');
        
        % golden ratio is defined as a+b/a = a/b = phi. phi = 1.61
        x = f_ba_x + f_ba_w;
        h = f_ba_h / 1.61;
        y = f_ba_y + f_ba_h - h;
        w = f_ba_w * 1.61;
        
        pr.h = figure('UNITS', 'normalized', 'POSITION', [x/screen_w y/screen_h w/screen_w h/screen_h]);
        net = el.to_net(el.get('MODEL'));
        lgraph = layerGraph(net);
        plot(lgraph)
    end

    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the pushbutton.
    %
    % UPDATE(PR) updates the content and permissions of the pushbutton.
    %
    % See also draw, redraw, refresh, PlotElement.

    update@PlotPropCell(pr)
    pr.get_buttons();
end
function redraw(pr, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PR) resizes the property panel and repositions its
    %   graphical objects.
    %
    % Important notes:
    % 1. REDRAW() sets the units 'characters' for panel and all its graphical objects.
    % 2. REDRAW() is typically called internally by PlotElement and does not need
    %  to be explicitly called in children of PlotProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT=3.33 characters.
    %
    % See also draw, update, refresh, PlotElement.

    pr.redraw@PlotProp(varargin{:})
end
function get_buttons(pr)
    % GET_BUTTON_CONDITION returns the calculate button state.
    %
    % STATE = GET_BUTTON_CONDITION(PR) returns the calculate button state.
    %
    % see also is_measure_calculated.

    plot_prop_children = get(pr.p, 'Children');    
    for i = 1:length(plot_prop_children)
        pp_c = plot_prop_children(i);
        if check_graphics(pp_c, 'pushbutton') && isequal(pp_c.Tag, 'button_calc')
            pr.c_btn = pp_c;
        end
        if check_graphics(pp_c, 'pushbutton') && isequal(pp_c.Tag, 'button_del')
            if isgraphics(pr.h)
                close(pr.h);
            end
            pr.d_btn = pp_c;
        end
    end
end
function cb_bring_to_front(pr)
    %CB_BRING_TO_FRONT brings to front the brain atlas figure and its settings figure.
    %
    % CB_BRING_TO_FRONT(PR) brings to front the brain atlas figure and its
    %  settings figure.
    %
    % See also cb_hide, cb_close.

    % bring to front settings panel
    pr.cb_bring_to_front@PlotProp();

    set(pr.h, 'Visible', 'on');
end
function cb_hide(pr)
    %CB_HIDE hides the brain atlas figure and its settings figure.
    %
    % CB_HIDE(PR) hides the brain atlas figure and its settings figure.
    %
    % See also cb_bring_to_front, cb_close.

    % hide settings panel
    pr.cb_hide@PlotProp();

    set(pr.h, 'Visible', 'off');
end
function cb_close(pr)
    %CB_CLOSE closes the figure.
    %
    % CB_CLOSE(PR) closes the figure and its children figures.
    %
    % See also cb_bring_to_front, cd_hide.
    
    if isgraphics(pr.h)
        close(pr.h);
    end
end