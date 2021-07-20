%% ¡header!
PlotBrainView < PlotGraph (pl, plot brain view) is a plot of a brain view.

%%% ¡description!
Plot is the plot of a graph of a function.
It is a graphical figure with empty axes, which should be filled by derived element.
To generate the plot, call pl.draw().

%%% ¡seealso!
uipanel, ishandle, isgraphics, figure, PlotGraph

%% ¡properties!
h_figure % panel graphical handle
h_axes % axes handle
subpanel % subpanel for pba
bg % plot brain graph

%% ¡props!
%%% ¡prop!
ME (metadata, item) is the measure.

%%% ¡prop!
ATLAS(metadata, item) is a brain atlas.

%%% ¡prop!
TYPE(metadata, string) is the type of measure.

%% ¡methods!
function h_panel = draw(pl, varargin)
[pl.h_figure, pl.h_axes, pl.subpanel] = draw@PlotGraph(pl, ...
    varargin{:});

set(pl.h_figure, 'Name', 'Brain View')
pl.getBrainView();

% output
if nargout > 0
    h_panel = pl.pp;
end
end
function p = getBrainView(pl)
    % GETBRAINVIEW creates a brain view panel for GUIAnalysis
    %
    % P = GETBRAINVIEW(ANALYSIS, PROPERTY, RULE, ...) creates a
    % brain view panel for GUIAnalysis.
    %
    % See also getGlobalPanel, getNodalPanel, getBinodalPanel.
    uiparent = pl.h_figure;
    atlas = pl.get('ATLAS');
    pl.bg =  PlotBrainGraph('ATLAS', atlas, 'Surf', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'));
    bgp = [];
    mrc = [];

    ui_brainview_panel = uipanel('Parent', uiparent, 'Units', 'normalized', 'Position', [0 0 1 .25]);
    ui_brainview_edges_panel_button = uicontrol(ui_brainview_panel);
    ui_brainview_analysis_dictionaries_button = uicontrol(ui_brainview_panel);
    ui_brain_view_show_checkbox = uicontrol(ui_brainview_panel, 'Style', 'checkbox');
    ui_brain_view_syms_checkbox = uicontrol(ui_brainview_panel, 'Style', 'checkbox');
    ui_brain_view_labs_checkbox = uicontrol(ui_brainview_panel, 'Style', 'checkbox');

    init_brainview()
        function init_brainview()
            set(ui_brain_view_show_checkbox, 'Units', 'normalized')
            set(ui_brain_view_show_checkbox, 'Position', [.02 .61 .25 .3])
            set(ui_brain_view_show_checkbox, 'String', 'Show Brain Surface')
            set(ui_brain_view_show_checkbox, 'Value', true)
            set(ui_brain_view_show_checkbox, 'Callback', {@cb_show_surf})

            set(ui_brain_view_syms_checkbox, 'Units', 'normalized')
            set(ui_brain_view_syms_checkbox, 'Position', [.02 .31 .25 .3])
            set(ui_brain_view_syms_checkbox, 'String', 'Show Brain Regions')
            set(ui_brain_view_syms_checkbox, 'Value', true)
            set(ui_brain_view_syms_checkbox, 'Callback', {@cb_show_brs})

            set(ui_brain_view_labs_checkbox, 'Units', 'normalized')
            set(ui_brain_view_labs_checkbox, 'Position', [.02 .01 .25 .3])
            set(ui_brain_view_labs_checkbox, 'String', 'Show Brain Labels')
            set(ui_brain_view_labs_checkbox, 'Value', true)
            set(ui_brain_view_labs_checkbox, 'Callback', {@cb_show_labs})

            set(ui_brainview_edges_panel_button, 'Units', 'normalized')
            set(ui_brainview_edges_panel_button, 'Position', [.3 .22 .25 .3])
            set(ui_brainview_edges_panel_button, 'String', 'Brain Graph Options')
            set(ui_brainview_edges_panel_button, 'Callback', {@cb_bv_bg_panel})

            set(ui_brainview_analysis_dictionaries_button, 'Units', 'normalized')
            set(ui_brainview_analysis_dictionaries_button, 'Position', [.62 .22 .25 .3])
            set(ui_brainview_analysis_dictionaries_button, 'String', 'Measurement Options')
            set(ui_brainview_analysis_dictionaries_button, 'Tooltip', 'Manage the Measurement, Comparison and Randomcomparison.')
            set(ui_brainview_analysis_dictionaries_button, 'Callback', {@cb_bv_meas_panel})
        end
    ui_contextmenu_figure_brainsurf = uicontextmenu();
    ui_contextmenu_figure_brainsurf_settings = uimenu(ui_contextmenu_figure_brainsurf);
    ui_contextmenu_figure_syms = uicontextmenu();
    ui_contextmenu_figure_symbol_settings = uimenu(ui_contextmenu_figure_syms);
    ui_contextmenu_figure_labs = uicontextmenu();
    ui_contextmenu_figure_labels_settings = uimenu(ui_contextmenu_figure_labs);
    init_contextmenus()
        function init_contextmenus()
            set(ui_contextmenu_figure_brainsurf_settings, 'Label', 'Brain Surface Settings')
            set(ui_contextmenu_figure_brainsurf_settings, 'Callback', {@cb_figure_brainsurf})

            function cb_figure_brainsurf(~, ~)  % (src, event)
                pl.bg.settings();
            end

            set(ui_contextmenu_figure_symbol_settings, 'Label', 'Brain Region Settings')
            set(ui_contextmenu_figure_symbol_settings, 'Callback', {@cb_figure_settingsbr})

            function cb_figure_settingsbr(~, ~)  % (src, event)
                pl.bg.syms_settings()
            end

            set(ui_contextmenu_figure_labels_settings, 'Label', 'Label Settings')
            set(ui_contextmenu_figure_labels_settings, 'Callback', {@cb_figure_settingslab})

            function cb_figure_settingslab(~, ~)  % (src, event)
                pl.bg.labs_settings()
            end
        end
        function create_figure()
            pl.bg.draw('Parent', pl.subpanel);
        end
        function update_brain_graph()
            if get(ui_brain_view_show_checkbox, 'Value')
                pl.bg.set('BRAIN', true)
            else
                pl.bg.set('BRAIN', false)
            end
            if get(ui_brain_view_syms_checkbox, 'Value')
                all_brs_show = pl.bg.get('SYMS');
                for i = 1:length(all_brs_show)
                    all_brs_show(i) = 1;
                end
                pl.bg.set('SYMS', all_brs_show);
            else
                all_brs_show = pl.bg.get('SYMS');
                for i = 1:length(all_brs_show)
                    all_brs_show(i) = 0;
                end
                pl.bg.set('SYMS', all_brs_show);
            end
            if get(ui_brain_view_labs_checkbox, 'Value')
                all_brs_show = pl.bg.get('LABS');
                for i = 1:length(all_brs_show)
                    all_brs_show(i) = 1;
                end
                pl.bg.set('LABS', all_brs_show);
            else
                all_brs_show = pl.bg.get('LABS');
                for i = 1:length(all_brs_show)
                    all_brs_show(i) = 0;
                end
                pl.bg.set('LABS', all_brs_show);
            end
            pl.bg.draw()
        end
        function cb_bv_bg_panel(~, ~)
            if isempty(bgp) || ~isvalid(bgp)
                bgp =  pl.getBrainGraphPanel();
            else
                figure(bgp);
            end
        end
        function cb_bv_meas_panel(~, ~)
            if isempty(mrc) || ~isvalid(mrc)
                mrc = pl.getMCRPanel();
            else
                figure(mrc)
            end
        end
        function cb_show_surf(~, ~)
            update_brain_graph()
        end
        function cb_show_brs(~, ~)
            update_brain_graph()
        end
        function cb_show_labs(~, ~)
            update_brain_graph()
        end

    create_figure()

    if nargout > 0
        p = ui_brainview_panel;
    end
end
function brain_graph_panel = getBrainGraphPanel(pl)
    % GETBRAINGRAPHPANEL creates a braingraph panel
    %
    % BRAIN_GRAPH_PANEL = GETBRAINGRAPHPANEL(ANAlYSIS, AXES, PLOTBRAINGRAPH)
    % creates a brain graph panel to manage the type of
    % PLOTBRAINGRAPH that the GUIAnalysis plots in the AXES.
    %
    % See also getBrainView,
    NAME_GRAPH =  'Brain Graph Panel';
    fig_graph = figure('Name', NAME_GRAPH, ...
        'Units', 'normalized', ...
        'Visible', 'off', ...
        'MenuBar', 'none', ...
        'Toolbar', 'none', ...
        'NumberTitle', 'off', ...
        'DockControls', 'off', ...
        'Position', [.3 .2 .2 .4]);

    % variables
    atlas = pl.get('ATLAS');
    br_axes = pl.h_axes; %#ok<NASGU>
    BKGCOLOR = [.95 .94 .94];

    ui_checkbox_graph_linecolor = uicontrol(fig_graph, 'Style',  'checkbox');
    ui_popup_graph_initcolor = uicontrol(fig_graph, 'Style', 'popup', 'String', {''});
    ui_popup_graph_fincolor = uicontrol(fig_graph, 'Style', 'popup', 'String', {''});
    ui_checkbox_graph_lineweight = uicontrol(fig_graph, 'Style',  'checkbox');
    ui_edit_graph_lineweight = uicontrol(fig_graph, 'Style', 'edit');
    ui_button_graph_show = uicontrol(fig_graph, 'Style', 'pushbutton');
    ui_button_graph_hide = uicontrol(fig_graph, 'Style', 'pushbutton');
    ui_button_graph_color = uicontrol(fig_graph, 'Style', 'pushbutton');
    ui_button_graph_edge_settings = uicontrol(fig_graph, 'Style', 'pushbutton');
    ui_text_graph_thickness = uicontrol(fig_graph, 'Style', 'text');
    ui_edit_graph_thickness = uicontrol(fig_graph, 'Style', 'edit');
    ui_link_type = uicontrol(fig_graph, 'Style', 'popup', 'String', {'line', 'arrow', 'cylinder'});

    init_graph()
    update_graph()

    %% Make the GUI visible.
    set(fig_graph, 'Visible', 'on');

        function init_graph()
            set(ui_checkbox_graph_linecolor, 'Units', 'normalized')
            set(ui_checkbox_graph_linecolor, 'BackgroundColor',BKGCOLOR)
            set(ui_checkbox_graph_linecolor, 'Position', [.10 .81 .23 .10])
            set(ui_checkbox_graph_linecolor, 'String', ' Color ')
            set(ui_checkbox_graph_linecolor, 'Value', false)
            set(ui_checkbox_graph_linecolor, 'FontWeight', 'bold')
            set(ui_checkbox_graph_linecolor, 'TooltipString', 'Shows brain regions by label')
            set(ui_checkbox_graph_linecolor, 'Callback', {@cb_checkbox_linecolor})

            set(ui_popup_graph_initcolor, 'Units', 'normalized')
            set(ui_popup_graph_initcolor, 'BackgroundColor',BKGCOLOR)
            set(ui_popup_graph_initcolor, 'Position', [.355 .8 .155 .10])
            set(ui_popup_graph_initcolor, 'String', {'R', 'G', 'B'})
            set(ui_popup_graph_initcolor, 'Value', 3)
            set(ui_popup_graph_initcolor, 'TooltipString', 'Select symbol');
            set(ui_popup_graph_initcolor, 'Callback', {@cb_popup_initcolor})

            set(ui_popup_graph_fincolor, 'Units', 'normalized')
            set(ui_popup_graph_fincolor, 'BackgroundColor',BKGCOLOR)
            set(ui_popup_graph_fincolor, 'Position', [.575 .8 .155 .10])
            set(ui_popup_graph_fincolor, 'String', {'R', 'G', 'B'})
            set(ui_popup_graph_fincolor, 'Value', 1)
            set(ui_popup_graph_fincolor, 'TooltipString', 'Select symbol');
            set(ui_popup_graph_fincolor, 'Callback', {@cb_popup_fincolor})

            set(ui_checkbox_graph_lineweight, 'Units', 'normalized')
            set(ui_checkbox_graph_lineweight, 'BackgroundColor',BKGCOLOR)
            set(ui_checkbox_graph_lineweight, 'Position', [.10 .61 .28 .10])
            set(ui_checkbox_graph_lineweight, 'String', ' Thickness ')
            set(ui_checkbox_graph_lineweight, 'Value', true)
            set(ui_checkbox_graph_lineweight, 'FontWeight', 'bold')
            set(ui_checkbox_graph_lineweight, 'TooltipString', 'Shows brain regions by label')
            set(ui_checkbox_graph_lineweight, 'Callback', {@cb_checkbox_lineweight})

            set(ui_edit_graph_lineweight, 'Units', 'normalized')
            set(ui_edit_graph_lineweight, 'Position', [.35 .62 .38 .08])
            set(ui_edit_graph_lineweight, 'String', '1');
            set(ui_edit_graph_lineweight, 'TooltipString', 'Set line weight.');
            set(ui_edit_graph_lineweight, 'FontWeight', 'bold')
            set(ui_edit_graph_lineweight, 'Callback', {@cb_edit_lineweight});

            set(ui_button_graph_show, 'Units', 'normalized')
            set(ui_button_graph_show, 'Position', [.1 .45 .4 .08])
            set(ui_button_graph_show, 'String', ' Show ')
            set(ui_button_graph_show, 'HorizontalAlignment', 'center')
            set(ui_button_graph_show, 'FontWeight', 'bold')
            set(ui_button_graph_show, 'FontSize', 10)
            set(ui_button_graph_show, 'Callback', {@cb_graph_show})

            set(ui_button_graph_hide, 'Units', 'normalized')
            set(ui_button_graph_hide, 'Position', [.1 .3 .4 .08])
            set(ui_button_graph_hide, 'String', ' Hide ')
            set(ui_button_graph_hide, 'HorizontalAlignment', 'center')
            set(ui_button_graph_hide, 'FontWeight', 'bold')
            set(ui_button_graph_hide, 'FontSize', 10)
            set(ui_button_graph_hide, 'Callback', {@cb_graph_hide})

            set(ui_button_graph_color, 'Units', 'normalized')
            set(ui_button_graph_color, 'Position', [.52 .45 .4 .08])
            set(ui_button_graph_color, 'String', ' Color ')
            set(ui_button_graph_color, 'HorizontalAlignment', 'center')
            set(ui_button_graph_color, 'FontWeight', 'bold')
            set(ui_button_graph_color, 'FontSize', 10)
            set(ui_button_graph_color, 'Callback', {@cb_graph_color})

            set(ui_button_graph_edge_settings, 'Units', 'normalized')
            set(ui_button_graph_edge_settings, 'Position', [.52 .3 .4 .08])
            set(ui_button_graph_edge_settings, 'String', 'Edge Settings')
            set(ui_button_graph_edge_settings, 'HorizontalAlignment', 'center')
            set(ui_button_graph_edge_settings, 'FontWeight', 'bold')
            set(ui_button_graph_edge_settings, 'FontSize', 10)
            set(ui_button_graph_edge_settings, 'Callback', {@cb_graph_links_settings})

            set(ui_text_graph_thickness, 'Units', 'normalized')
            set(ui_text_graph_thickness, 'Position', [.02 .05 .3 .08])
            set(ui_text_graph_thickness, 'String', 'Set thickness  ')
            set(ui_text_graph_thickness, 'HorizontalAlignment', 'center')
            set(ui_text_graph_thickness, 'FontWeight', 'bold')
            set(ui_text_graph_thickness, 'FontSize', 8)

            set(ui_edit_graph_thickness, 'Units', 'normalized')
            set(ui_edit_graph_thickness, 'Position', [.34 .06 .2 .08])
            set(ui_edit_graph_thickness, 'String', '1');
            set(ui_edit_graph_thickness, 'TooltipString', 'Set density.');
            set(ui_edit_graph_thickness, 'FontWeight', 'bold')
            set(ui_edit_graph_thickness, 'Callback', {@cb_graph_thickness});

            set(ui_link_type, 'Units', 'normalized')
            set(ui_link_type, 'Position', [.62 .05 .3 .08])
            set(ui_link_type, 'Callback', {@cb_link_type});
        end
        function cb_checkbox_linecolor(~, ~)  % (src, event)
            if get(ui_checkbox_graph_linecolor, 'Value')
                set(ui_popup_graph_initcolor, 'Enable', 'on')
                set(ui_popup_graph_fincolor, 'Enable', 'on')
                update_graph()
            else
                set(ui_popup_graph_initcolor, 'Enable', 'off')
                set(ui_popup_graph_fincolor, 'Enable', 'off')

                n = atlas.get('BR_DICT').length();
                for i = 1:1:n
                    for j = 1:1:n
                        pl.bg.link_edges(i, j, 'Color', [0 0 0])
                    end
                end
            end
        end
        function cb_checkbox_lineweight(~, ~)  % (src, event)
            if get(ui_checkbox_graph_lineweight, 'Value')
                set(ui_edit_graph_lineweight, 'Enable', 'on')
                update_graph()
            else
                set(ui_edit_graph_lineweight, 'Enable', 'off')

                weight = str2double(get(ui_edit_graph_lineweight, 'String'));
                n = atlas.get('BR_DICT').length();
                for i = 1:1:n
                    for j = 1:1:n
                        if i == j
                            continue;
                        end
                        pl.bg.link_edges(i, j, 'LineWidth', weight)
                    end
                end
            end
        end
        function cb_edit_lineweight(~, ~)  % (src, event)
            weigth = real(str2double(get(ui_edit_graph_bs, 'String')));
            if isnan(weigth) || weigth <= 0
                set(ui_edit_graph_lineweight, 'String', '5');
            end
            update_graph()
        end
        function cb_popup_initcolor(~, ~)  % (src, event)
            update_graph()
        end
        function cb_popup_fincolor(~, ~)  % (src, event)
            update_graph()
        end
        function cb_graph_show(~, ~)  % (src, event)
            set(ui_edit_graph_lineweight, 'Enable', 'on')

            update_graph()
        end
        function cb_graph_hide(~, ~)  % (src, event)
            link_style = get(ui_link_type, 'Value');
            if  link_style == 1
                pl.bg.link_edges_off([], [])
            elseif link_style == 2
                pl.bg.arrow_edges_off([],[])
            else
                pl.bg.cylinder_edges_off([],[])
            end
        end
        function cb_graph_color(~, ~)  % (src, event)
            color = uisetcolor();

            if length(color)==3
                n = atlas.get('BR_DICT').length();
                for i = 1:1:n
                    for j = 1:1:n
                        if i == j
                            continue;
                        end
                        pl.bg.link_edge(i, j, 'Color', color)
                    end
                end
            end
        end
        function cb_graph_thickness(~, ~)  % (src, event)
            thickness = real(str2double(get(ui_edit_graph_thickness, 'String')));
            if isnan(thickness) || thickness <= 0
                set(ui_edit_graph_thickness, 'String', '1');
            end
            update_graph()
        end
        function cb_link_type(~, ~)
            update_graph()
        end
        function update_graph()
            link_style = get(ui_link_type, 'Value');

            pl.bg.link_edges_off([], [])
            pl.bg.arrow_edges_off([],[])
            pl.bg.cylinder_edges_off([],[])

            if get(ui_checkbox_graph_linecolor, 'Value')
                val1 = get(ui_popup_graph_initcolor, 'Value');
                val2 = get(ui_popup_graph_fincolor, 'Value');
                n = atlas.get('BR_DICT').length();
                for i = 1:1:n
                    for j = 1:1:n
                        if i == j
                            continue;
                        end
                        if  link_style == 1
                            pl.bg.link_edges(i, j, 'Color', [val1 val2]);
                            pl.bg.link_edge_on(i, j);
                        elseif link_style == 2
                            pl.bg.arrow_edges(i, j, 'Color', [val1 val2]);
                            pl.bg.arrow_edge_on(i, j)
                        else
                            pl.bg.cylinder_edges(i, j, 'Color', [val1 val2]);
                            pl.bg.cylinder_edge_on(i, j)
                        end
                    end
                end
            end

            if get(ui_checkbox_graph_lineweight, 'Value')
                % get measure value
                n = atlas.get('BR_DICT').length();
                weight = str2double(get(ui_edit_graph_lineweight, 'String'));
                for i = 1:1:n
                    for j = 1:1:n
                        if i == j
                            continue;
                        end
                        if  link_style == 1
                            pl.bg.link_edges(i, j, 'LineWidth', weight);
                            pl.bg.link_edge_on(i, j);
                        elseif link_style == 2
                            pl.bg.arrow_edges(i, j, 'LineWidth', weight);
                            pl.bg.arrow_edge_on(i, j)
                        else
                            pl.bg.cylinder_edges(i, j, 'LineWidth', weight);
                            pl.bg.cylinder_edge_on(i, j)
                        end
                    end
                end
            end

        end
        function cb_graph_links_settings(~, ~)  % (src, event)
            link_style = get(ui_link_type, 'Value');
            if link_style == 1
                pl.bg.link_edges_settings([], []);
            elseif link_style == 2
                pl.bg.arrow_edges_settings([], []);
            else
                pl.bg.cylinder_edges_settings([], []);
            end
        end

    if nargout > 0
        brain_graph_panel = fig_graph;
    end
end
function h = getMCRPanel(pl)
    % sets position of figure
    APPNAME = [pl.get('ME').get('ID') ' Property Panel'];

    f = figure('Name', APPNAME, ...
        'Units', 'normalized', ...
        'Visible', 'off', ...
        'MenuBar', 'none', ...
        'Toolbar', 'none', ...
        'NumberTitle', 'off', ...
        'DockControls', 'off', ...
        'Position', [.3 .2 .2 .4]);

    % variables
    atlas = pl.get('ATLAS');
    br_axes = pl.h_axes; %#ok<NASGU>
    FigColor = [.95 .94 .94];

    measure_data = pl.get('ME').get('M');
    fdr_lim = [];
    p1 = [];
    p2 = [];

    % initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % measure container panel
    ui_measure_container_panel = uipanel(f, 'Units', 'normalized');

    % nodal measure figure options
    ui_layer_text = uicontrol(ui_measure_container_panel, 'Style', 'text');
    ui_layer_selector = uicontrol(ui_measure_container_panel, 'Style', 'popup', 'String', {''});
    ui_checkbox_meas_symbolsize = uicontrol(ui_measure_container_panel, 'Style',  'checkbox');
    ui_edit_meas_symbolsize = uicontrol(ui_measure_container_panel, 'Style', 'edit');
    ui_checkbox_meas_symbolcolor = uicontrol(ui_measure_container_panel, 'Style',  'checkbox');
    ui_popup_meas_initcolor = uicontrol(ui_measure_container_panel, 'Style', 'popup', 'String', {''});
    ui_popup_meas_fincolor = uicontrol(ui_measure_container_panel, 'Style', 'popup', 'String', {''});
    ui_checkbox_meas_sphereradius = uicontrol(ui_measure_container_panel, 'Style',  'checkbox');
    ui_edit_meas_sphereradius = uicontrol(ui_measure_container_panel, 'Style', 'edit');
    ui_checkbox_meas_spherecolor = uicontrol(ui_measure_container_panel, 'Style',  'checkbox');
    ui_popup_meas_sphinitcolor = uicontrol(ui_measure_container_panel, 'Style', 'popup', 'String', {''});
    ui_popup_meas_sphfincolor = uicontrol(ui_measure_container_panel, 'Style', 'popup', 'String', {''});
    ui_checkbox_meas_spheretransparency = uicontrol(ui_measure_container_panel, 'Style',  'checkbox');
    ui_slider_meas_spheretransparency = uicontrol(ui_measure_container_panel, 'Style', 'slider');
    ui_checkbox_meas_labelsize = uicontrol(ui_measure_container_panel, 'Style',  'checkbox');
    ui_edit_meas_labelsize = uicontrol(ui_measure_container_panel, 'Style', 'edit');
    ui_checkbox_meas_labelcolor = uicontrol(ui_measure_container_panel, 'Style',  'checkbox');
    ui_popup_meas_labelinitcolor = uicontrol(ui_measure_container_panel, 'Style', 'popup', 'String', {''});
    ui_popup_meas_labelfincolor = uicontrol(ui_measure_container_panel, 'Style', 'popup', 'String', {''});

    init_measures_panel()
    set(f, 'Visible', 'on')

    %% Callback functions
        function init_measures_panel()

            % measure figure *******************************
            set(ui_measure_container_panel, 'Position', [.0 .01 1 .99])

            set(ui_layer_text, ...
                'Units', 'normalized', ...
                'BackgroundColor', FigColor, ...
                'Position', [.01 .91 .30 .08], ...
                'FontWeight', 'bold', ...
                'TooltipString', 'Select the layer of the Measure to be ploted.', ...
                'String', 'Layer' ...
                )

            set(ui_layer_selector, ...
                'Units', 'normalized', ...
                'BackgroundColor', FigColor, ...
                'Position', [.31 .91 .30 .08], ...
                'String', cellfun(@(x) num2str(x),  num2cell([1:length(measure_data)]) , 'UniformOutput', false), ...
                'Callback', {@cb_layer_selector} ...
                )

            set(ui_checkbox_meas_symbolsize, 'Units', 'normalized')
            set(ui_checkbox_meas_symbolsize, 'BackgroundColor', FigColor)
            set(ui_checkbox_meas_symbolsize, 'Position', [.01 .8 .30 .08])
            set(ui_checkbox_meas_symbolsize, 'String', ' Symbol Size ')
            set(ui_checkbox_meas_symbolsize, 'Value', false)
            set(ui_checkbox_meas_symbolsize, 'FontWeight', 'bold')
            set(ui_checkbox_meas_symbolsize, 'TooltipString', 'Shows brain regions by label')
            set(ui_checkbox_meas_symbolsize, 'Callback', {@cb_checkbox_meas_symbolsize})

            set(ui_edit_meas_symbolsize, 'Units', 'normalized')
            set(ui_edit_meas_symbolsize, 'String', PlotBrainGraph.INIT_SYM_SIZE)
            set(ui_edit_meas_symbolsize, 'Enable', 'off')
            set(ui_edit_meas_symbolsize, 'Position', [.31 .8 .6 .08])
            set(ui_edit_meas_symbolsize, 'HorizontalAlignment', 'center')
            set(ui_edit_meas_symbolsize, 'FontWeight', 'bold')
            set(ui_edit_meas_symbolsize, 'Callback', {@cb_edit_meas_symbolsize})

            set(ui_checkbox_meas_symbolcolor, 'Units', 'normalized')
            set(ui_checkbox_meas_symbolcolor, 'BackgroundColor', FigColor)
            set(ui_checkbox_meas_symbolcolor, 'Position', [.01 .67 .3 .08])
            set(ui_checkbox_meas_symbolcolor, 'String', ' Symbol Color ')
            set(ui_checkbox_meas_symbolcolor, 'Value', false)
            set(ui_checkbox_meas_symbolcolor, 'FontWeight', 'bold')
            set(ui_checkbox_meas_symbolcolor, 'TooltipString', 'Shows brain regions by label')
            set(ui_checkbox_meas_symbolcolor, 'Callback', {@cb_checkbox_meas_symbolcolor})

            set(ui_popup_meas_initcolor, 'Units', 'normalized')
            set(ui_popup_meas_initcolor, 'BackgroundColor', FigColor)
            set(ui_popup_meas_initcolor, 'Enable', 'off')
            set(ui_popup_meas_initcolor, 'Position', [.31 .67 .3 .08])
            set(ui_popup_meas_initcolor, 'String', {'R', 'G', 'B'})
            set(ui_popup_meas_initcolor, 'Value', 3)
            set(ui_popup_meas_initcolor, 'TooltipString', 'Select symbol');
            set(ui_popup_meas_initcolor, 'Callback', {@cb_meas_initcolor})

            set(ui_popup_meas_fincolor, 'Units', 'normalized')
            set(ui_popup_meas_fincolor, 'BackgroundColor', FigColor)
            set(ui_popup_meas_fincolor, 'Enable', 'off')
            set(ui_popup_meas_fincolor, 'Position', [0.61 .67 .3 .08])
            set(ui_popup_meas_fincolor, 'String', {'R', 'G', 'B'})
            set(ui_popup_meas_fincolor, 'Value', 1)
            set(ui_popup_meas_fincolor, 'TooltipString', 'Select symbol');
            set(ui_popup_meas_fincolor, 'Callback', {@cb_meas_fincolor})

            set(ui_checkbox_meas_sphereradius, 'Units', 'normalized')
            set(ui_checkbox_meas_sphereradius, 'BackgroundColor', FigColor)
            set(ui_checkbox_meas_sphereradius, 'Position', [.01 0.54 .3 .08])
            set(ui_checkbox_meas_sphereradius, 'String', ' Sphere Radius ')
            set(ui_checkbox_meas_sphereradius, 'Value', false)
            set(ui_checkbox_meas_sphereradius, 'FontWeight', 'bold')
            set(ui_checkbox_meas_sphereradius, 'TooltipString', 'Shows brain regions by label')
            set(ui_checkbox_meas_sphereradius, 'Callback', {@cb_checkbox_meas_sphereradius})

            set(ui_edit_meas_sphereradius, 'Units', 'normalized')
            set(ui_edit_meas_sphereradius, 'String', PlotBrainGraph.INIT_SPH_R)
            set(ui_edit_meas_sphereradius, 'Enable', 'off')
            set(ui_edit_meas_sphereradius, 'Position', [.31 0.54 .6 .08])
            set(ui_edit_meas_sphereradius, 'HorizontalAlignment', 'center')
            set(ui_edit_meas_sphereradius, 'FontWeight', 'bold')
            set(ui_edit_meas_sphereradius, 'Callback', {@cb_edit_meas_sphereradius})

            set(ui_checkbox_meas_spherecolor, 'Units', 'normalized')
            set(ui_checkbox_meas_spherecolor, 'BackgroundColor', FigColor)
            set(ui_checkbox_meas_spherecolor, 'Position', [.01 0.41 .3 .08])
            set(ui_checkbox_meas_spherecolor, 'String', ' Sphere Color ')
            set(ui_checkbox_meas_spherecolor, 'Value', false)
            set(ui_checkbox_meas_spherecolor, 'FontWeight', 'bold')
            set(ui_checkbox_meas_spherecolor, 'TooltipString', 'Shows brain regions by label')
            set(ui_checkbox_meas_spherecolor, 'Callback', {@cb_checkbox_meas_spherecolor})

            set(ui_popup_meas_sphinitcolor, 'Units', 'normalized')
            set(ui_popup_meas_sphinitcolor, 'BackgroundColor', FigColor)
            set(ui_popup_meas_sphinitcolor, 'Enable', 'off')
            set(ui_popup_meas_sphinitcolor, 'Position', [.31 .41 .3 .08])
            set(ui_popup_meas_sphinitcolor, 'String', {'R', 'G', 'B'})
            set(ui_popup_meas_sphinitcolor, 'Value', 1)
            set(ui_popup_meas_sphinitcolor, 'TooltipString', 'Select symbol');
            set(ui_popup_meas_sphinitcolor, 'Callback', {@cb_meas_sphinitcolor})

            set(ui_popup_meas_sphfincolor, 'Units', 'normalized')
            set(ui_popup_meas_sphfincolor, 'BackgroundColor', FigColor)
            set(ui_popup_meas_sphfincolor, 'Enable', 'off')
            set(ui_popup_meas_sphfincolor, 'Position', [0.61 .41 .3 .08])
            set(ui_popup_meas_sphfincolor, 'String', {'R', 'G', 'B'})
            set(ui_popup_meas_sphfincolor, 'Value', 3)
            set(ui_popup_meas_sphfincolor, 'TooltipString', 'Select symbol');
            set(ui_popup_meas_sphfincolor, 'Callback', {@cb_meas_sphfincolor})

            set(ui_checkbox_meas_spheretransparency, 'Units', 'normalized')
            set(ui_checkbox_meas_spheretransparency, 'BackgroundColor', FigColor)
            set(ui_checkbox_meas_spheretransparency, 'Position', [.01 0.28 .3 .08])
            set(ui_checkbox_meas_spheretransparency, 'String', ' Sphere Transparency ')
            set(ui_checkbox_meas_spheretransparency, 'Value', false)
            set(ui_checkbox_meas_spheretransparency, 'FontWeight', 'bold')
            set(ui_checkbox_meas_spheretransparency, 'TooltipString', 'Shows brain regions by label')
            set(ui_checkbox_meas_spheretransparency, 'Callback', {@cb_checkbox_meas_spheretransparency})

            set(ui_slider_meas_spheretransparency, 'Units', 'normalized')
            set(ui_slider_meas_spheretransparency, 'BackgroundColor', FigColor)
            set(ui_slider_meas_spheretransparency, 'Min', 0, 'Max', 1, 'Value', PlotBrainGraph.INIT_SPH_FACE_ALPHA);
            set(ui_slider_meas_spheretransparency, 'Enable', 'off')
            set(ui_slider_meas_spheretransparency, 'Position', [.31 0.28 .6 .08])
            set(ui_slider_meas_spheretransparency, 'TooltipString', 'Brain region transparency (applied both to faces and edges)')
            set(ui_slider_meas_spheretransparency, 'Callback', {@cb_slider_meas_spheretransparency})

            set(ui_checkbox_meas_labelsize, 'Units', 'normalized')
            set(ui_checkbox_meas_labelsize, 'BackgroundColor', FigColor)
            set(ui_checkbox_meas_labelsize, 'Position', [.01 .15 .3 .08])
            set(ui_checkbox_meas_labelsize, 'String', ' Label Size ')
            set(ui_checkbox_meas_labelsize, 'Value', false)
            set(ui_checkbox_meas_labelsize, 'FontWeight', 'bold')
            set(ui_checkbox_meas_labelsize, 'TooltipString', 'Shows brain regions by label')
            set(ui_checkbox_meas_labelsize, 'Callback', {@cb_checkbox_meas_labelsize})

            set(ui_edit_meas_labelsize, 'Units', 'normalized')
            set(ui_edit_meas_labelsize, 'String', PlotBrainGraph.INIT_LAB_FONT_SIZE)
            set(ui_edit_meas_labelsize, 'Enable', 'off')
            set(ui_edit_meas_labelsize, 'Position', [.31 .15 .6 .08])
            set(ui_edit_meas_labelsize, 'HorizontalAlignment', 'center')
            set(ui_edit_meas_labelsize, 'FontWeight', 'bold')
            set(ui_edit_meas_labelsize, 'Callback', {@cb_edit_meas_labelsize})

            set(ui_checkbox_meas_labelcolor, 'Units', 'normalized')
            set(ui_checkbox_meas_labelcolor, 'BackgroundColor', FigColor)
            set(ui_checkbox_meas_labelcolor, 'Position', [.01 0.01 .3 .08])
            set(ui_checkbox_meas_labelcolor, 'String', ' Label Color ')
            set(ui_checkbox_meas_labelcolor, 'Value', false)
            set(ui_checkbox_meas_labelcolor, 'FontWeight', 'bold')
            set(ui_checkbox_meas_labelcolor, 'TooltipString', 'Shows brain regions by label')
            set(ui_checkbox_meas_labelcolor, 'Callback', {@cb_checkbox_meas_labelcolor})

            set(ui_popup_meas_labelinitcolor, 'Units', 'normalized')
            set(ui_popup_meas_labelinitcolor, 'BackgroundColor', FigColor)
            set(ui_popup_meas_labelinitcolor, 'Enable', 'off')
            set(ui_popup_meas_labelinitcolor, 'Position', [.31 .01 .3 .08])
            set(ui_popup_meas_labelinitcolor, 'String', {'R', 'G', 'B'})
            set(ui_popup_meas_labelinitcolor, 'Value', 1)
            set(ui_popup_meas_labelinitcolor, 'TooltipString', 'Select symbol');
            set(ui_popup_meas_labelinitcolor, 'Callback', {@cb_meas_labelinitcolor})

            set(ui_popup_meas_labelfincolor, 'Units', 'normalized')
            set(ui_popup_meas_labelfincolor, 'BackgroundColor', FigColor)
            set(ui_popup_meas_labelfincolor, 'Enable', 'off')
            set(ui_popup_meas_labelfincolor, 'Position', [0.61 .01 .3 .08])
            set(ui_popup_meas_labelfincolor, 'String', {'R', 'G', 'B'})
            set(ui_popup_meas_labelfincolor, 'Value', 3)
            set(ui_popup_meas_labelfincolor, 'TooltipString', 'Select symbol');
            set(ui_popup_meas_labelfincolor, 'Callback', {@cb_meas_labelfincolor})

        end
        function cb_layer_selector(~, ~)
            update_brain_meas_plot()
        end
        function cb_checkbox_meas_symbolsize(~, ~)  %  (src, event)
            if get(ui_checkbox_meas_symbolsize, 'Value')
                set(ui_edit_meas_symbolsize, 'Enable', 'on')

                update_brain_meas_plot()
            else
                size = str2double(get(ui_edit_meas_symbolsize, 'String'));
                size = 1 + size;
                pl.bg.set('SYMS_SIZE', size);

                set(ui_edit_meas_symbolsize, 'Enable', 'off')
                update_brain_meas_plot()
            end
        end
        function cb_edit_meas_symbolsize(~, ~)  %  (src, event)
            size = real(str2double(get(ui_edit_meas_symbolsize, 'String')));
            if isempty(size) || size<=0
                set(ui_edit_meas_symbolsize, 'String', '1')
                size = 5;
            end
            update_brain_meas_plot()
        end
        function cb_checkbox_meas_symbolcolor(~, ~)  %  (src, event)
            if get(ui_checkbox_meas_symbolcolor, 'Value')
                set(ui_popup_meas_initcolor, 'Enable', 'on')
                set(ui_popup_meas_fincolor, 'Enable', 'on')

                update_brain_meas_plot()
            else
                val = get(ui_popup_meas_initcolor, 'Value');
                str = get(ui_popup_meas_initcolor, 'String');
                pl.bg.set('SYMS_EDGE_COLOR', str{val});
                pl.bg.set('SYMS_FACE_COLOR', str{val});

                set(ui_popup_meas_initcolor, 'Enable', 'off')
                set(ui_popup_meas_fincolor, 'Enable', 'off')

                update_brain_meas_plot()
            end
        end
        function cb_meas_initcolor(~, ~)  %  (src, event)
            update_brain_meas_plot()
        end
        function cb_meas_fincolor(~, ~)  %  (src, event)
            update_brain_meas_plot()
        end
        function cb_checkbox_meas_sphereradius(~, ~)  %  (src, event)
            if get(ui_checkbox_meas_sphereradius, 'Value')
                set(ui_edit_meas_sphereradius, 'Enable', 'on')

                update_brain_meas_plot()
            else
                R = str2double(get(ui_edit_meas_sphereradius, 'String'));
                R = R + 1;
                pl.bg.set('SPHS_SIZE', R);

                set(ui_edit_meas_sphereradius, 'Enable', 'off')
                update_brain_meas_plot()
            end
        end
        function cb_edit_meas_sphereradius(~, ~)  %  (src, event)
            R = real(str2double(get(ui_edit_meas_sphereradius, 'String')));
            if isempty(R) || R<=0
                set(ui_edit_meas_sphereradius, 'String', '1')
                R = 3;
            end
            update_brain_meas_plot()
        end
        function cb_checkbox_meas_spherecolor(~, ~)  %  (src, event)
            if get(ui_checkbox_meas_spherecolor, 'Value')
                set(ui_popup_meas_sphinitcolor, 'Enable', 'on')
                set(ui_popup_meas_sphfincolor, 'Enable', 'on')
                update_brain_meas_plot()
            else
                val = get(ui_popup_meas_sphinitcolor, 'Value');
                str = get(ui_popup_meas_sphinitcolor, 'String');
                pl.bg.set('SPHS_EDGE_COLOR', str{val});
                pl.bg.set('SPHS_FACE_COLOR', str{val});

                set(ui_popup_meas_sphinitcolor, 'Enable', 'off')
                set(ui_popup_meas_sphfincolor, 'Enable', 'off')
                update_brain_meas_plot()
            end
        end
        function cb_meas_sphinitcolor(~, ~)  %  (src, event)
            update_brain_meas_plot()
        end
        function cb_meas_sphfincolor(~, ~)  %  (src, event)
            update_brain_meas_plot()
        end
        function cb_checkbox_meas_spheretransparency(~, ~)  %  (src, event)
            if get(ui_checkbox_meas_spheretransparency, 'Value')
                set(ui_slider_meas_spheretransparency, 'Enable', 'on')

                update_brain_meas_plot()
            else
                alpha = get(ui_slider_meas_spheretransparency, 'Value');
                pl.bg.set('SPHS_FACE_ALPHA', alpha);
                pl.bg.set('SPHS_EDGE_ALPHA', alpha);

                set(ui_slider_meas_spheretransparency, 'Enable', 'off')
                update_brain_meas_plot()
            end
        end
        function cb_slider_meas_spheretransparency(~, ~)  %  (src, event)
            update_brain_meas_plot();
        end
        function cb_checkbox_meas_labelsize(~, ~)  %  (src, event)
            if get(ui_checkbox_meas_labelsize, 'Value')
                set(ui_edit_meas_labelsize, 'Enable', 'on')

                update_brain_meas_plot()
            else
                size = str2double(get(ui_edit_meas_labelsize, 'String'));
                size = size + 1;
                pl.bg.set('LABS_SIZE', size);

                set(ui_edit_meas_labelsize, 'Enable', 'off')
                update_brain_meas_plot()
            end
        end
        function cb_edit_meas_labelsize(~, ~)  %  (src, event)
            size = real(str2double(get(ui_edit_meas_labelsize, 'String')));
            if isempty(size) || size<=0
                set(ui_edit_meas_labelsize, 'String', '1')
                size = 5;
            end
            update_brain_meas_plot()
        end
        function cb_checkbox_meas_labelcolor(~, ~)  %  (src, event)
            if get(ui_checkbox_meas_labelcolor, 'Value')
                set(ui_popup_meas_labelinitcolor, 'Enable', 'on')
                set(ui_popup_meas_labelfincolor, 'Enable', 'on')

                update_brain_meas_plot()
            else
                val = get(ui_popup_meas_labelinitcolor, 'Value');
                str = get(ui_popup_meas_labelinitcolor, 'String');
                pl.bg.set('LABS', str{val});

                set(ui_popup_meas_labelinitcolor, 'Enable', 'off')
                set(ui_popup_meas_labelfincolor, 'Enable', 'off')
                update_brain_meas_plot()
            end
        end
        function cb_meas_labelinitcolor(~, ~)  %  (src, event)
            update_brain_meas_plot()
        end
        function cb_meas_labelfincolor(~, ~)  %  (src, event)
            update_brain_meas_plot()
        end
        function update_brain_meas_plot()
            if ~isempty(measure_data)
                if  Measure.is_nodal(pl.get('ME'))

                    measure_data_inner = measure_data{get(ui_layer_selector, 'Value'))};

                end

                if get(ui_checkbox_meas_symbolsize, 'Value')

                    size_ = str2double(get(ui_edit_meas_symbolsize, 'String'));

                    size_(isnan(size_)) = 0.1;
                    size_(size_<=0) = 0.1;
                    pl.bg.set('SYMS_SIZE', size_');
                end

                if get(ui_checkbox_meas_symbolcolor, 'Value')

                    colorValue = measure_data_inner ;

                    colorValue(isnan(colorValue)) = 0;
                    colorValue(colorValue<0) = 0;
                    colorValue(colorValue>1) = 1;

                    C = zeros(length(colorValue), 3);

                    val1 = get(ui_popup_meas_initcolor, 'Value');
                    val2 = get(ui_popup_meas_fincolor, 'Value');
                    C(:, val1) = colorValue;
                    C(:, val2) = 1 - colorValue;

                    pl.bg.set('SYMS_FACE_COLOR', C);
                    pl.bg.set('SYMS_EDGE_COLOR', C);
                end

                if get(ui_checkbox_meas_sphereradius, 'Value')

                    R = str2double(get(ui_edit_meas_sphereradius, 'String'));

                    R = 1 + (measure_data_inner)*R;

                    R(isnan(R)) = 0.1;
                    R(R<=0) = 0.1;
                    pl.bg.set('SPHS_SIZE', R');
                end

                if get(ui_checkbox_meas_spherecolor, 'Value')

                    colorValue = (measure_data_inner);
                    colorValue(isnan(colorValue)) = 0;
                    colorValue(colorValue<0) = 0;
                    colorValue(colorValue>1) = 1;

                    C = zeros(length(colorValue), 3);

                    val1 = get(ui_popup_meas_sphinitcolor, 'Value');
                    val2 = get(ui_popup_meas_sphfincolor, 'Value');
                    C(:, val1) = colorValue;
                    C(:, val2) = 1 - colorValue;
                    pl.bg.set('SPHS_EDGE_COLOR', C);
                    pl.bg.set('SPHS_FACE_COLOR', C);
                end

                if get(ui_checkbox_meas_spheretransparency, 'Value')

                    alpha = get(ui_slider_meas_spheretransparency, 'Value');


                    alpha_vec = (measure_data_inner)*alpha;
                    alpha_vec(isnan(alpha_vec)) = 0;
                    alpha_vec(alpha_vec<0) = 0;
                    alpha_vec(alpha_vec>1) = 1;
                    pl.bg.set('SPHS_EDGE_ALPHA', alpha_vec);
                    pl.bg.set('SPHS_FACE_ALPHA', alpha_vec);
                end

                if get(ui_checkbox_meas_labelsize, 'Value')

                    size_ = str2double(get(ui_edit_meas_labelsize, 'String'));
                    size_ = (1 + (measure_data_inner )*size_);

                    size_(isnan(size_)) = 0.1;
                    size_(size_<=0) = 0.1;
                    pl.bg.set( 'LABS_SIZE', size_);
                end

                if get(ui_checkbox_meas_labelcolor, 'Value')
                    colorValue = (measure_data_inner);
                    colorValue(isnan(colorValue)) = 0;
                    colorValue(colorValue<0) = 0;
                    colorValue(colorValue>1) = 1;

                    C = zeros(length(colorValue), 3);

                    val1 = get(ui_popup_meas_labelinitcolor, 'Value');
                    val2 = get(ui_popup_meas_labelfincolor, 'Value');
                    C(:, val1) = colorValue;
                    C(:, val2) = 1 - colorValue;
                    pl.bg.set('LABS_FONT_COLOR', C);
                end
            end
        end

    % draw
    pl.bg.draw();
    if nargout > 0
        h = f;
    end
end