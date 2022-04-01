%% ¡header!
PPNNData_GR_NN < PlotPropItem (pr, plot property item) is a plot of an item property.

%%% ¡description!
PPNNData_GR_NN plots NN group using a pushbutton that opens the linked object at a certain location.

CALLBACK - This is a callback function:

    pr.<strong>cb_bring_to_front</strong>() - brings to the front the NN group figure and its settings figure
    pr.<strong>cb_hide</strong>() - hides the NN group figure and its settings figure
    pr.<strong>cb_close</strong>() - closes the NN group figure and its settings figure

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
p
pushbutton
f_nn_data

%% ¡props_update!

%%% ¡prop!
ENABLE (metadata, option) switches between off and inactive fields.
%%%% ¡default!
'off'

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the panel of the item property.
    %
    % DRAW(PR) draws the panel of the item property.
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

    pr.p = draw@PlotPropItem(pr, varargin{:});

    children = get(pr.p, 'Children');
    for i = 1:1:length(children)
        if check_graphics(children(i), 'pushbutton')
            pr.pushbutton = children(i);
            break; % to do change the condition
        end
    end

    set(pr.pushbutton, 'Callback', {@cb_pushbutton_margin})

    function cb_pushbutton_margin(~, ~)
        pr.cb_pushbutton_margin()
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

    update@PlotPropItem(pr)
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

    pr.redraw@PlotPropItem(varargin{:})
end
function cb_pushbutton_margin(pr)
    %CB_PUSHBUTTON_VALUE executes callback for the pushbutton.
    %
    % CB_PUSHBUTTON_VALUE(PR) executes callback for the pushbutton.

    el = pr.get('EL');
    prop = pr.get('PROP');

    pr.update()
    f_ba = ancestor(pr.p, 'Figure');
    f_ba_x = Plot.x0(f_ba, 'pixels');
    f_ba_y = Plot.y0(f_ba, 'pixels');
    f_ba_w = Plot.w(f_ba, 'pixels');
    f_ba_h = Plot.h(f_ba, 'pixels');

    screen_x = Plot.x0(0, 'pixels');
    screen_y = Plot.y0(0, 'pixels');
    screen_w = Plot.w(0, 'pixels');
    screen_h = Plot.h(0, 'pixels');

    x = (f_ba_x + f_ba_w) / screen_w;
    y = f_ba_y / screen_h;
    w = f_ba_w / screen_w;
    h = f_ba_h / screen_h;

    value = el.getr(prop);
    if isa(value, 'NoValue')
        GUI('PE', el.getPropDefault(prop), 'POSITION', [x y w h]).draw()
    else
        f_nn_data = GUI('PE', el.get(prop), 'POSITION', [x y w h]).draw();
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

    % bring to front NN group figure
    children = get(pr.f_nn_data, 'Children');
    holder = get(pr.f_nn_data, 'UserData');
    holder.cb_bring_to_front();
end
function cb_hide(pr)
    %CB_HIDE hides the brain atlas figure and its settings figure.
    %
    % CB_HIDE(PR) hides the brain atlas figure and its settings figure.
    %
    % See also cb_bring_to_front, cb_close.

    % hide settings panel
    pr.cb_hide@PlotProp();

    % hide NN group figure
    holder = get(pr.f_nn_data, 'UserData');
    holder.cb_hide();
end
function cb_close(pr)
    %CB_CLOSE closes the figure.
    %
    % CB_CLOSE(PR) closes the figure and its children figures.
    %
    % See also cb_bring_to_front, cd_hide.

    % close NN group gui
    if check_graphics(pr.f_nn_data, 'figure')
        close(pr.f_nn_data)
    end
end