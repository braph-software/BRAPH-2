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
bg % plot brain atlas

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
            set(ui_checkbox_graph_lineweight, 'Value', false)
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
APPNAME = 'Analysis Property Panel';
FigPosition = [.10 .30 .35 .50];
FigColor = GUI.BKGCOLOR;

% create a figure
f = GUI.init_figure(APPNAME, .45, .6, 'west');

set(f, 'Units', 'normalized')
set(f, 'Position', FigPosition)
set(f, 'Color', FigColor)
set(f, 'Name', [APPNAME ' : Group settings - ' BRAPH2.VERSION])
set(f, 'MenuBar', 'none')
set(f, 'Toolbar', 'none')
set(f, 'NumberTitle', 'off')
set(f, 'DockControls', 'off')

measure_data = [];
fdr_lim = [];
p1 = [];
p2 = [];
ga = analysis;

% get all measures
mlist = Graph.getCompatibleMeasureList(analysis.getGraphType());  % list of nodal measures

%% initialization
% groups, actions and measures
ui_action_measures_checkbox = uicontrol(f, 'Style', 'checkbox');
ui_action_comparison_checkbox = uicontrol(f, 'Style', 'checkbox');
ui_action_random_checkbox = uicontrol(f, 'Style', 'checkbox');
ui_text_group1 = uicontrol(f, 'Style', 'text');
ui_text_group2 = uicontrol(f, 'Style', 'text');
ui_text_view_action = uicontrol(f, 'Style', 'text');
ui_popup_grouplists1 = uicontrol(f, 'Style', 'popup', 'String', {''});
ui_popup_grouplists2 = uicontrol(f, 'Style', 'popup', 'String', {''});
ui_list_gr = uicontrol(f, 'Style',  'listbox');
ui_list_threshold_or_density = uicontrol(f, 'Style', 'listbox');
list_tittle = uicontrol(f, 'Style', 'text');

% rescaling panel
ui_panel_meas_scaling = uipanel(f);
ui_text_meas_offset = uicontrol(ui_panel_meas_scaling, 'Style', 'text');
ui_edit_meas_offset = uicontrol(ui_panel_meas_scaling, 'Style', 'edit');
ui_text_meas_rescaling = uicontrol(ui_panel_meas_scaling, 'Style', 'text');
ui_edit_meas_rescaling = uicontrol(ui_panel_meas_scaling, 'Style', 'edit');
ui_checkbox_meas_fdr1 = uicontrol(ui_panel_meas_scaling, 'Style',  'checkbox');
ui_edit_meas_fdr1 = uicontrol(ui_panel_meas_scaling, 'Style', 'edit');
ui_checkbox_meas_fdr2 = uicontrol(ui_panel_meas_scaling, 'Style',  'checkbox');
ui_edit_meas_fdr2 = uicontrol(ui_panel_meas_scaling, 'Style', 'edit');
ui_button_meas_automatic = uicontrol(ui_panel_meas_scaling, 'Style', 'pushbutton');

% measure container panel
ui_measure_container_panel = uipanel(f, 'Units', 'normalized');

% nodal measure figure options
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

% binodal measure figure options
ui_edge_value_show = uicontrol(f, 'Units', 'normalized', 'Style', 'checkbox');

init_measures_panel()
update_figure_panel()
update_popup_grouplist()
update_measure_data(1);

set(f, 'Visible', 'on')

%% Callback functions
    function init_measures_panel()
        % actions ****************************************
        set(ui_action_measures_checkbox, 'Units', 'normalized')
        set(ui_action_measures_checkbox, 'Position', [.02 .95 .28 .03])
        set(ui_action_measures_checkbox, 'Value', true)
        set(ui_action_measures_checkbox, 'String', 'Measurement')
        set(ui_action_measures_checkbox, 'Callback', {@cb_action_measurement})
        
        set(ui_action_comparison_checkbox, 'Units', 'normalized')
        set(ui_action_comparison_checkbox, 'Position', [.32 .95 .28 .03])
        set(ui_action_comparison_checkbox, 'Value', false)
        set(ui_action_comparison_checkbox, 'String', 'Comparison')
        set(ui_action_comparison_checkbox, 'Callback', {@cb_action_comparison})
        
        set(ui_action_random_checkbox, 'Units', 'normalized')
        set(ui_action_random_checkbox, 'Position', [.62 .95 .28 .03])
        set(ui_action_random_checkbox, 'Value', false)
        set(ui_action_random_checkbox, 'String', 'Random Comparison')
        set(ui_action_random_checkbox, 'Callback', {@cb_action_random})
        
        % text ***************************************
        set(ui_text_group1, 'Units', 'normalized')
        set(ui_text_group1, 'Position', [.02 .9125 .25 .035])
        set(ui_text_group1, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_text_group1, 'String', 'group 1')
        set(ui_text_group1, 'HorizontalAlignment', 'left')
        set(ui_text_group1, 'FontWeight', 'bold')
        
        set(ui_text_group2, 'Units', 'normalized')
        set(ui_text_group2, 'Position', [.02 .795 .25 .035])
        set(ui_text_group2, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_text_group2, 'String', 'group 2')
        set(ui_text_group2, 'HorizontalAlignment', 'left')
        set(ui_text_group2, 'FontWeight', 'bold')
        
        set(ui_text_view_action, 'Units', 'normalized')
        set(ui_text_view_action, 'Position', [0.4525 .9125 .40 .035])
        set(ui_text_view_action, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_text_view_action, 'HorizontalAlignment', 'center')
        set(ui_text_view_action, 'FontWeight', 'bold')
        
        set(list_tittle, 'Units', 'normalized')
        set(list_tittle, 'BackgroundColor', GUI.BKGCOLOR)
        set(list_tittle, 'HorizontalAlignment', 'center')
        set(list_tittle, 'FontWeight', 'bold')
        
        % groups *******************************************
        set(ui_popup_grouplists1, 'Units', 'normalized')
        set(ui_popup_grouplists1, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_popup_grouplists1, 'Position', [.02 .86 .30 .04])
        set(ui_popup_grouplists1, 'Value', 1)
        set(ui_popup_grouplists1, 'TooltipString', 'Select group1');
        set(ui_popup_grouplists1, 'Callback', {@cb_popup_grouplist})
        
        set(ui_popup_grouplists2, 'Units', 'normalized')
        set(ui_popup_grouplists2, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_popup_grouplists2, 'Position', [.02 .7575 .30 .04])
        set(ui_popup_grouplists2, 'Value', 1)
        set(ui_popup_grouplists2, 'TooltipString', 'Select group2');
        set(ui_popup_grouplists2, 'Callback', {@cb_popup_grouplist})
        
        % lists ***************************************
        set(ui_list_gr, 'Units', 'normalized')
        set(ui_list_gr, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_list_gr, 'String', cellfun(@(x) Measure.getName(x), mlist, 'UniformOutput', false))
        set(ui_list_gr, 'Value', 1)
        set(ui_list_gr, 'Max', -1, 'Min', 0)
        set(ui_list_gr, 'BackgroundColor', [1 1 1])
        set(ui_list_gr, 'Position', [.02 .02 .30 .68])
        set(ui_list_gr, 'TooltipString', 'Select brain regions');
        set(ui_list_gr, 'Callback', {@cb_list_gr});
        
        set(ui_list_threshold_or_density, 'Units', 'normalized')
        set(ui_list_threshold_or_density, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_list_threshold_or_density, 'Value', 1)
        set(ui_list_threshold_or_density, 'Max', -1, 'Min', 0)
        set(ui_list_threshold_or_density, 'BackgroundColor', [1 1 1])
        set(ui_list_threshold_or_density, 'Callback', {@cb_list_t_or_d});
        
        % panels ******************************************
        set(ui_panel_meas_scaling, 'Position', [.35 .65 .605 .2550])
        
        set(ui_text_meas_offset, 'Units', 'normalized')
        set(ui_text_meas_offset, 'Position', [.02 .75 .15 .15])
        set(ui_text_meas_offset, 'String', 'offset')
        set(ui_text_meas_offset, 'HorizontalAlignment', 'center')
        set(ui_text_meas_offset, 'FontWeight', 'bold')
        
        set(ui_edit_meas_offset, 'Units', 'normalized')
        set(ui_edit_meas_offset, 'String', '0')
        set(ui_edit_meas_offset, 'Enable', 'on')
        set(ui_edit_meas_offset, 'Position', [.2 .75 .25 .15])
        set(ui_edit_meas_offset, 'HorizontalAlignment', 'center')
        set(ui_edit_meas_offset, 'FontWeight', 'bold')
        set(ui_edit_meas_offset, 'Callback', {@cb_edit_meas_offset})
        
        set(ui_text_meas_rescaling, 'Units', 'normalized')
        set(ui_text_meas_rescaling, 'Position', [.02 .45 .15 .15])
        set(ui_text_meas_rescaling, 'String', 'rescale')
        set(ui_text_meas_rescaling, 'HorizontalAlignment', 'center')
        set(ui_text_meas_rescaling, 'FontWeight', 'bold')
        
        set(ui_edit_meas_rescaling, 'Units', 'normalized')
        set(ui_edit_meas_rescaling, 'String', '10')
        set(ui_edit_meas_rescaling, 'Enable', 'on')
        set(ui_edit_meas_rescaling, 'Position', [.2 .45 .25 .15])
        set(ui_edit_meas_rescaling, 'HorizontalAlignment', 'center')
        set(ui_edit_meas_rescaling, 'FontWeight', 'bold')
        set(ui_edit_meas_rescaling, 'Callback', {@cb_edit_meas_rescaling})
        
        set(ui_button_meas_automatic, 'Units', 'normalized')
        set(ui_button_meas_automatic, 'Position', [.3 .02 .4 .2])
        set(ui_button_meas_automatic, 'String', 'Automatic rescaling')
        set(ui_button_meas_automatic, 'HorizontalAlignment', 'center')
        set(ui_button_meas_automatic, 'Callback', {@cb_meas_automatic})
        
        set(ui_checkbox_meas_fdr1, 'Units', 'normalized')
        set(ui_checkbox_meas_fdr1, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_checkbox_meas_fdr1, 'Position', [.47 .75 .25 .15])
        set(ui_checkbox_meas_fdr1, 'String', 'fdr (1-tailed)')
        set(ui_checkbox_meas_fdr1, 'Value', false)
        set(ui_checkbox_meas_fdr1, 'FontWeight', 'bold')
        set(ui_checkbox_meas_fdr1, 'TooltipString', 'apply 1-tailed false discovery rate limit')
        set(ui_checkbox_meas_fdr1, 'Callback', {@cb_checkbox_meas_fdr1})
        
        set(ui_edit_meas_fdr1, 'Units', 'normalized')
        set(ui_edit_meas_fdr1, 'String', '0.05')
        set(ui_edit_meas_fdr1, 'Position', [.74 0.75 .2 .15])
        set(ui_edit_meas_fdr1, 'HorizontalAlignment', 'center')
        set(ui_edit_meas_fdr1, 'FontWeight', 'bold')
        set(ui_edit_meas_fdr1, 'Callback', {@cb_edit_meas_fdr1})
        
        set(ui_checkbox_meas_fdr2, 'Units', 'normalized')
        set(ui_checkbox_meas_fdr2, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_checkbox_meas_fdr2, 'Position', [.47 .45 .25 .15])
        set(ui_checkbox_meas_fdr2, 'String', 'fdr (2-tailed)')
        set(ui_checkbox_meas_fdr2, 'Value', false)
        set(ui_checkbox_meas_fdr2, 'FontWeight', 'bold')
        set(ui_checkbox_meas_fdr2, 'TooltipString', 'apply false discovery rate limit')
        set(ui_checkbox_meas_fdr2, 'Callback', {@cb_checkbox_meas_fdr2})
        
        set(ui_edit_meas_fdr2, 'Units', 'normalized')
        set(ui_edit_meas_fdr2, 'String', '0.05')
        set(ui_edit_meas_fdr2, 'Position', [.74 0.45 .2 .15])
        set(ui_edit_meas_fdr2, 'HorizontalAlignment', 'center')
        set(ui_edit_meas_fdr2, 'FontWeight', 'bold')
        set(ui_edit_meas_fdr2, 'Callback', {@cb_edit_meas_fdr2})
        
        % measure figure *******************************
        set(ui_measure_container_panel, 'Position', [.35 .01 .605 .64])
        
        set(ui_checkbox_meas_symbolsize, 'Units', 'normalized')
        set(ui_checkbox_meas_symbolsize, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_checkbox_meas_symbolsize, 'Position', [.01 .9 .30 .08])
        set(ui_checkbox_meas_symbolsize, 'String', ' Symbol Size ')
        set(ui_checkbox_meas_symbolsize, 'Value', false)
        set(ui_checkbox_meas_symbolsize, 'FontWeight', 'bold')
        set(ui_checkbox_meas_symbolsize, 'TooltipString', 'Shows brain regions by label')
        set(ui_checkbox_meas_symbolsize, 'Callback', {@cb_checkbox_meas_symbolsize})
        
        set(ui_edit_meas_symbolsize, 'Units', 'normalized')
        set(ui_edit_meas_symbolsize, 'String', PlotBrainGraph.INIT_SYM_SIZE)
        set(ui_edit_meas_symbolsize, 'Enable', 'off')
        set(ui_edit_meas_symbolsize, 'Position', [.31 .9 .6 .08])
        set(ui_edit_meas_symbolsize, 'HorizontalAlignment', 'center')
        set(ui_edit_meas_symbolsize, 'FontWeight', 'bold')
        set(ui_edit_meas_symbolsize, 'Callback', {@cb_edit_meas_symbolsize})
        
        set(ui_checkbox_meas_symbolcolor, 'Units', 'normalized')
        set(ui_checkbox_meas_symbolcolor, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_checkbox_meas_symbolcolor, 'Position', [.01 .8 .3 .08])
        set(ui_checkbox_meas_symbolcolor, 'String', ' Symbol Color ')
        set(ui_checkbox_meas_symbolcolor, 'Value', false)
        set(ui_checkbox_meas_symbolcolor, 'FontWeight', 'bold')
        set(ui_checkbox_meas_symbolcolor, 'TooltipString', 'Shows brain regions by label')
        set(ui_checkbox_meas_symbolcolor, 'Callback', {@cb_checkbox_meas_symbolcolor})
        
        set(ui_popup_meas_initcolor, 'Units', 'normalized')
        set(ui_popup_meas_initcolor, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_popup_meas_initcolor, 'Enable', 'off')
        set(ui_popup_meas_initcolor, 'Position', [.31 .8 .3 .08])
        set(ui_popup_meas_initcolor, 'String', {'R', 'G', 'B'})
        set(ui_popup_meas_initcolor, 'Value', 3)
        set(ui_popup_meas_initcolor, 'TooltipString', 'Select symbol');
        set(ui_popup_meas_initcolor, 'Callback', {@cb_meas_initcolor})
        
        set(ui_popup_meas_fincolor, 'Units', 'normalized')
        set(ui_popup_meas_fincolor, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_popup_meas_fincolor, 'Enable', 'off')
        set(ui_popup_meas_fincolor, 'Position', [0.61 .8 .3 .08])
        set(ui_popup_meas_fincolor, 'String', {'R', 'G', 'B'})
        set(ui_popup_meas_fincolor, 'Value', 1)
        set(ui_popup_meas_fincolor, 'TooltipString', 'Select symbol');
        set(ui_popup_meas_fincolor, 'Callback', {@cb_meas_fincolor})
        
        set(ui_checkbox_meas_sphereradius, 'Units', 'normalized')
        set(ui_checkbox_meas_sphereradius, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_checkbox_meas_sphereradius, 'Position', [.01 0.7 .3 .08])
        set(ui_checkbox_meas_sphereradius, 'String', ' Sphere Radius ')
        set(ui_checkbox_meas_sphereradius, 'Value', false)
        set(ui_checkbox_meas_sphereradius, 'FontWeight', 'bold')
        set(ui_checkbox_meas_sphereradius, 'TooltipString', 'Shows brain regions by label')
        set(ui_checkbox_meas_sphereradius, 'Callback', {@cb_checkbox_meas_sphereradius})
        
        set(ui_edit_meas_sphereradius, 'Units', 'normalized')
        set(ui_edit_meas_sphereradius, 'String', PlotBrainGraph.INIT_SPH_R)
        set(ui_edit_meas_sphereradius, 'Enable', 'off')
        set(ui_edit_meas_sphereradius, 'Position', [.31 0.7 .6 .08])
        set(ui_edit_meas_sphereradius, 'HorizontalAlignment', 'center')
        set(ui_edit_meas_sphereradius, 'FontWeight', 'bold')
        set(ui_edit_meas_sphereradius, 'Callback', {@cb_edit_meas_sphereradius})
        
        set(ui_checkbox_meas_spherecolor, 'Units', 'normalized')
        set(ui_checkbox_meas_spherecolor, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_checkbox_meas_spherecolor, 'Position', [.01 0.6 .3 .08])
        set(ui_checkbox_meas_spherecolor, 'String', ' Sphere Color ')
        set(ui_checkbox_meas_spherecolor, 'Value', false)
        set(ui_checkbox_meas_spherecolor, 'FontWeight', 'bold')
        set(ui_checkbox_meas_spherecolor, 'TooltipString', 'Shows brain regions by label')
        set(ui_checkbox_meas_spherecolor, 'Callback', {@cb_checkbox_meas_spherecolor})
        
        set(ui_popup_meas_sphinitcolor, 'Units', 'normalized')
        set(ui_popup_meas_sphinitcolor, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_popup_meas_sphinitcolor, 'Enable', 'off')
        set(ui_popup_meas_sphinitcolor, 'Position', [.31 .6 .3 .08])
        set(ui_popup_meas_sphinitcolor, 'String', {'R', 'G', 'B'})
        set(ui_popup_meas_sphinitcolor, 'Value', 1)
        set(ui_popup_meas_sphinitcolor, 'TooltipString', 'Select symbol');
        set(ui_popup_meas_sphinitcolor, 'Callback', {@cb_meas_sphinitcolor})
        
        set(ui_popup_meas_sphfincolor, 'Units', 'normalized')
        set(ui_popup_meas_sphfincolor, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_popup_meas_sphfincolor, 'Enable', 'off')
        set(ui_popup_meas_sphfincolor, 'Position', [0.61 .6 .3 .08])
        set(ui_popup_meas_sphfincolor, 'String', {'R', 'G', 'B'})
        set(ui_popup_meas_sphfincolor, 'Value', 3)
        set(ui_popup_meas_sphfincolor, 'TooltipString', 'Select symbol');
        set(ui_popup_meas_sphfincolor, 'Callback', {@cb_meas_sphfincolor})
        
        set(ui_checkbox_meas_spheretransparency, 'Units', 'normalized')
        set(ui_checkbox_meas_spheretransparency, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_checkbox_meas_spheretransparency, 'Position', [.01 0.5 .3 .08])
        set(ui_checkbox_meas_spheretransparency, 'String', ' Sphere Transparency ')
        set(ui_checkbox_meas_spheretransparency, 'Value', false)
        set(ui_checkbox_meas_spheretransparency, 'FontWeight', 'bold')
        set(ui_checkbox_meas_spheretransparency, 'TooltipString', 'Shows brain regions by label')
        set(ui_checkbox_meas_spheretransparency, 'Callback', {@cb_checkbox_meas_spheretransparency})
        
        set(ui_slider_meas_spheretransparency, 'Units', 'normalized')
        set(ui_slider_meas_spheretransparency, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_slider_meas_spheretransparency, 'Min', 0, 'Max', 1, 'Value', PlotBrainGraph.INIT_SPH_FACE_ALPHA);
        set(ui_slider_meas_spheretransparency, 'Enable', 'off')
        set(ui_slider_meas_spheretransparency, 'Position', [.31 0.5 .6 .08])
        set(ui_slider_meas_spheretransparency, 'TooltipString', 'Brain region transparency (applied both to faces and edges)')
        set(ui_slider_meas_spheretransparency, 'Callback', {@cb_slider_meas_spheretransparency})
        
        set(ui_checkbox_meas_labelsize, 'Units', 'normalized')
        set(ui_checkbox_meas_labelsize, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_checkbox_meas_labelsize, 'Position', [.01 .4 .3 .08])
        set(ui_checkbox_meas_labelsize, 'String', ' Label Size ')
        set(ui_checkbox_meas_labelsize, 'Value', false)
        set(ui_checkbox_meas_labelsize, 'FontWeight', 'bold')
        set(ui_checkbox_meas_labelsize, 'TooltipString', 'Shows brain regions by label')
        set(ui_checkbox_meas_labelsize, 'Callback', {@cb_checkbox_meas_labelsize})
        
        set(ui_edit_meas_labelsize, 'Units', 'normalized')
        set(ui_edit_meas_labelsize, 'String', PlotBrainGraph.INIT_LAB_FONT_SIZE)
        set(ui_edit_meas_labelsize, 'Enable', 'off')
        set(ui_edit_meas_labelsize, 'Position', [.31 .4 .6 .08])
        set(ui_edit_meas_labelsize, 'HorizontalAlignment', 'center')
        set(ui_edit_meas_labelsize, 'FontWeight', 'bold')
        set(ui_edit_meas_labelsize, 'Callback', {@cb_edit_meas_labelsize})
        
        set(ui_checkbox_meas_labelcolor, 'Units', 'normalized')
        set(ui_checkbox_meas_labelcolor, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_checkbox_meas_labelcolor, 'Position', [.01 0.3 .3 .08])
        set(ui_checkbox_meas_labelcolor, 'String', ' Label Color ')
        set(ui_checkbox_meas_labelcolor, 'Value', false)
        set(ui_checkbox_meas_labelcolor, 'FontWeight', 'bold')
        set(ui_checkbox_meas_labelcolor, 'TooltipString', 'Shows brain regions by label')
        set(ui_checkbox_meas_labelcolor, 'Callback', {@cb_checkbox_meas_labelcolor})
        
        set(ui_popup_meas_labelinitcolor, 'Units', 'normalized')
        set(ui_popup_meas_labelinitcolor, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_popup_meas_labelinitcolor, 'Enable', 'off')
        set(ui_popup_meas_labelinitcolor, 'Position', [.31 .3 .3 .08])
        set(ui_popup_meas_labelinitcolor, 'String', {'R', 'G', 'B'})
        set(ui_popup_meas_labelinitcolor, 'Value', 1)
        set(ui_popup_meas_labelinitcolor, 'TooltipString', 'Select symbol');
        set(ui_popup_meas_labelinitcolor, 'Callback', {@cb_meas_labelinitcolor})
        
        set(ui_popup_meas_labelfincolor, 'Units', 'normalized')
        set(ui_popup_meas_labelfincolor, 'BackgroundColor', GUI.BKGCOLOR)
        set(ui_popup_meas_labelfincolor, 'Enable', 'off')
        set(ui_popup_meas_labelfincolor, 'Position', [0.61 .3 .3 .08])
        set(ui_popup_meas_labelfincolor, 'String', {'R', 'G', 'B'})
        set(ui_popup_meas_labelfincolor, 'Value', 3)
        set(ui_popup_meas_labelfincolor, 'TooltipString', 'Select symbol');
        set(ui_popup_meas_labelfincolor, 'Callback', {@cb_meas_labelfincolor})
        
        set(ui_edge_value_show, 'Position', [0.4 0.3 0.4 0.2])
        set(ui_edge_value_show, 'String', 'Show Binodal Measures as Labels')
        set(ui_edge_value_show, 'Value', false)
        set(ui_edge_value_show, 'Callback', {@cb_binodal_measure_show})
        
        update_measure_control_panel()
    end
    function cb_action_measurement(~, ~)
        value = true;
        set(ui_action_measures_checkbox, 'Value', value)
        set(ui_action_comparison_checkbox, 'Value', ~value)
        set(ui_action_random_checkbox, 'Value', ~value)
        update_figure_panel()
    end
    function cb_action_comparison(~, ~)
        value = true;
        set(ui_action_measures_checkbox, 'Value', ~value)
        set(ui_action_comparison_checkbox, 'Value', value)
        set(ui_action_random_checkbox, 'Value', ~value)
        update_figure_panel()
    end
    function cb_action_random(~, ~)
        value = true;
        set(ui_action_measures_checkbox, 'Value', ~value)
        set(ui_action_comparison_checkbox, 'Value', ~value)
        set(ui_action_random_checkbox, 'Value', value)
        update_figure_panel()
    end
    function cb_list_gr(~, ~)
        update_measure_data(2)
        update_brain_meas_plot()
        update_measure_control_panel()
    end
    function cb_list_t_or_d(~, ~)
        update_measure_data(2)
        update_brain_meas_plot()
    end
    function cb_popup_grouplist(~, ~)  % (src, event)
        update_measure_data(2)
        update_brain_meas_plot()
    end
    function cb_edit_meas_offset(~, ~)  %  (src, event)
        offset = real(str2double(get(ui_edit_meas_offset, 'String')));
        if isempty(offset)
            set(ui_edit_meas_offset, 'String', '100')
        else
            set(ui_edit_meas_offset, 'String', num2str(offset))
        end
        update_brain_meas_plot()
    end
    function cb_edit_meas_rescaling(~, ~)  %  (src, event)
        rescaling = real(str2double(get(ui_edit_meas_rescaling, 'String')));
        if isempty(rescaling) || isnan(rescaling) || rescaling < 10^(-4) || rescaling > (10^+4)
            set(ui_edit_meas_rescaling, 'String', '10')
        else
            set(ui_edit_meas_rescaling, 'String', num2str(rescaling))
        end
        update_brain_meas_plot()
    end
    function cb_checkbox_meas_fdr1(~, ~)  %  (src, event)
        if get(ui_checkbox_meas_fdr1, 'Value')
            set(ui_edit_meas_fdr1, 'Enable', 'on')
            set(ui_edit_meas_fdr2, 'Enable', 'off')
            set(ui_checkbox_meas_fdr2, 'Enable', 'off')
            
            update_measure_data(2)
            update_brain_meas_plot()
        else
            set(ui_edit_meas_fdr1, 'Enable', 'off')
            set(ui_checkbox_meas_fdr2, 'Enable', 'on')
            
            update_measure_data(2)
            update_brain_meas_plot()
        end
    end
    function cb_edit_meas_fdr1(~, ~)  %  (src, event)
        lim = real(str2double(get(ui_edit_meas_fdr1, 'String')));
        if isempty(lim) || lim <= 0 || lim > 1
            set(ui_edit_meas_fdr1, 'String', '0.05')
        else
            set(ui_edit_meas_fdr1, 'String', num2str(lim))
        end
        update_measure_data(2)
        update_brain_meas_plot()
    end
    function cb_checkbox_meas_fdr2(~, ~)  %  (src, event)
        if get(ui_checkbox_meas_fdr2, 'Value')
            set(ui_edit_meas_fdr2, 'Enable', 'on')
            set(ui_edit_meas_fdr1, 'Enable', 'off')
            set(ui_checkbox_meas_fdr1, 'Enable', 'off')
            
            update_measure_data(2)
            update_brain_meas_plot()
        else
            set(ui_edit_meas_fdr2, 'Enable', 'off')
            set(ui_checkbox_meas_fdr1, 'Enable', 'on')
            
            update_measure_data(2)
            update_brain_meas_plot()
        end
    end
    function cb_edit_meas_fdr2(~, ~)  %  (src, event)
        lim = real(str2double(get(ui_edit_meas_fdr2, 'String')));
        if isempty(lim) || lim <= 0 || lim > 1
            set(ui_edit_meas_fdr2, 'String', '0.05')
        else
            set(ui_edit_meas_fdr2, 'String', num2str(lim))
        end
        update_measure_data(2)
        update_brain_meas_plot()
    end
    function cb_meas_automatic(~, ~)  %  (src, event)
        if ~isempty(measure_data)
            if iscell(measure_data)
                measure_data_inner = [measure_data{:}];
            else
                measure_data_inner = measure_data;
            end
            offset = min(measure_data_inner(:));
            if isnan(offset) || offset == 0 || ~isreal(offset)
                set(ui_edit_meas_offset, 'String', '0');
            else
                set(ui_edit_meas_offset, 'String', num2str(offset))
            end
            
            rescaling = max(measure_data_inner(:)) - offset;
            if rescaling == 0 || isnan(rescaling) || ~isreal(rescaling)
                set(ui_edit_meas_rescaling, 'String', '1');
            else
                set(ui_edit_meas_rescaling, 'String', num2str(rescaling))
            end
            
            update_brain_meas_plot()
        end
    end
    function cb_checkbox_meas_symbolsize(~, ~)  %  (src, event)
        if get(ui_checkbox_meas_symbolsize, 'Value')
            set(ui_edit_meas_symbolsize, 'Enable', 'on')
            
            update_brain_meas_plot()
        else
            size = str2double(get(ui_edit_meas_symbolsize, 'String'));
            size = 1 + size;
            bg.br_syms([], 'Size', size);
            
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
            bg.br_syms([], 'Color', str{val});
            
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
            bg.br_sphs([], 'R', R);
            
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
            bg.br_sphs([], 'Color', str{val});
            
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
            bg.br_sphs([], 'Alpha', alpha);
            
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
            bg.br_labs([], 'FontSize', size);
            
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
            bg.br_labs([], 'Color', str{val});
            
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
    function update_figure_panel()
        if isequal(ga.getClass(), 'AnalysisFNC_WU')
            set(ui_list_gr, 'Position', [.02 .02 .30 .68])
            set(ui_list_threshold_or_density, 'Position', [0 0 0 0])
        else
            set(ui_list_gr, 'Position', [.02 .36 .3 .36])
            set(ui_list_threshold_or_density, 'Position', [.02 .02 .3 .3])
            set(list_tittle, 'Position', [.02 .32 .25 .04])
            if isequal(ga.getClass(), 'AnalysisFNC_BUT')
                set(list_tittle, 'String', 'Select Threshold')
            else  % desity
                set(list_tittle, 'String', 'Select Density')
            end
        end
        if get(ui_action_comparison_checkbox, 'Value')
            % generals
            set(ui_popup_grouplists2, 'Enable', 'on')
            set(ui_text_group2, 'Enable', 'on')
            set(ui_text_view_action, 'String', 'View difference')
            % mesure panel
            set(ui_checkbox_meas_fdr1, 'Enable', 'on')
            set(ui_checkbox_meas_fdr2, 'Enable', 'on')
            set(ui_edit_meas_fdr1, 'Enable', 'off')
            set(ui_edit_meas_fdr2, 'Enable', 'off')
        elseif get(ui_action_random_checkbox, 'Value')
            set(ui_popup_grouplists2, 'Enable', 'off')
            set(ui_text_group2, 'Enable', 'off')
            set(ui_text_view_action, 'String', 'View measure')
            
            set(ui_checkbox_meas_fdr1, 'Enable', 'off')
            set(ui_checkbox_meas_fdr2, 'Enable', 'off')
            set(ui_edit_meas_fdr1, 'Enable', 'off')
            set(ui_edit_meas_fdr2, 'Enable', 'off')
        else
            set(ui_popup_grouplists2, 'Enable', 'off')
            set(ui_text_group2, 'Enable', 'off')
            set(ui_text_view_action, 'String', 'View measure')
            
            set(ui_checkbox_meas_fdr1, 'Enable', 'off')
            set(ui_checkbox_meas_fdr2, 'Enable', 'off')
            set(ui_edit_meas_fdr1, 'Enable', 'off')
            set(ui_edit_meas_fdr2, 'Enable', 'off')
        end
    end
    function update_list_t_d(selected_case)
        if isequal(ga.getClass(), 'AnalysisFNC_BUT')
            if get(ui_action_comparison_checkbox, 'Value')
                [a, b] = selected_case.getGroups();
                set(ui_list_threshold_or_density, 'String', analysis.selectComparisons(selected_case.getMeasureCode(), a, b, '.getThreshold()'))
            elseif get(ui_action_random_checkbox, 'Value')
                set(ui_list_threshold_or_density, 'String', analysis.selectRandomComparisons(selected_case.getMeasureCode(), selected_case.getGroup(), '.getThreshold()'))
            else
                set(ui_list_threshold_or_density, 'String', analysis.selectMeasurements(selected_case.getMeasureCode(), selected_case.getGroup(), '.getThreshold()'))
            end
        elseif isequal(ga.getClass(), 'AnalysisFNC_BUD')
            if get(ui_action_comparison_checkbox, 'Value')
                [a, b] = selected_case.getGroups();
                set(ui_list_threshold_or_density, 'String', analysis.selectComparisons(selected_case.getMeasureCode(), a, b, '.getDensity()'))
            elseif get(ui_action_random_checkbox, 'Value')
                set(ui_list_threshold_or_density, 'String', analysis.selectRandomComparisons(selected_case.getMeasureCode(), selected_case.getGroup(), '.getDensity()'))
            else
                set(ui_list_threshold_or_density, 'String', analysis.selectMeasurements(selected_case.getMeasureCode(), selected_case.getGroup(), '.getDensity()'))
            end
        else
        end
    end
    function update_popup_grouplist()
        if ga.getCohort().getGroups().length() > 0
            % updates group lists of popups
            GroupList = ga.getCohort().getGroups().getKeys();
            %                     for g = 1:1:ga.getCohort().getGroups().length()
            %                         GroupList{g} = ga.getCohort().getGroups().getValue(g);
            %                     end
        else
            GroupList = {''};
        end
        set(ui_popup_grouplists1, 'String', GroupList)
        set(ui_popup_grouplists2, 'String', GroupList)
    end
    function update_measure_data(init_or_selection)
        if  init_or_selection == 2
            i = get(ui_list_gr, 'Value');
            group1_index = get(ui_popup_grouplists1, 'Value');
            group1 = ga.getCohort().getGroups().getValue(group1_index);
            measure = mlist{i};
            selected_case = [];
            if get(ui_action_comparison_checkbox, 'Value')
                % i want to look in comprison
                group2_index = get(ui_popup_grouplists2, 'Value');
                group2 = ga.getCohort().getGroups().getValue(group2_index);
                comparisons_idict = ga.getComparisons();
                
                for i = 1:1:comparisons_idict.length()
                    comparison = comparisons_idict.getValue(i);
                    [a, b] = comparison.getGroups();
                    if isequal(comparison.getMeasureCode(), measure) && ((isequal(a, group1) && isequal (b, group2)) || (isequal(a, group2) && isequal (b, group1)))
                        selected_case = comparison;
                        update_list_t_d(selected_case)
                        break;
                    end
                end
                selected_action = 'Comparison';
            elseif get(ui_action_random_checkbox, 'Value')
                % i want to look in rcomprison
                randoms_idict = ga.getRandomComparisons();
                for i = 1:1:randoms_idict.length()
                    r_comparison = randoms_idict.getValue(i);
                    g = r_comparison.getGroup();
                    if isequal(r_comparison.getMeasureCode(), measure) && isequal(g, group1)
                        selected_case = r_comparison;
                        update_list_t_d(selected_case)
                        break;
                    end
                end
                selected_action = 'Random Comparison';
            else
                % i want to look in measurements
                meas_idict = ga.getMeasurements();
                for i = 1:1:meas_idict.length()
                    mesurements = meas_idict.getValue(i);
                    g = mesurements.getGroup();
                    if isequal(mesurements.getMeasureCode(), measure) && isequal(g, group1)
                        selected_case = mesurements;
                        update_list_t_d(selected_case)
                        break;
                    end
                end
                selected_action = 'Measurement';
            end
            if isempty(selected_case)
                errordlg(['The measure: ' measure ' for ' selected_action ' does not exist.'])
            else
                if isequal(analysis.getClass(), 'AnalysisFNC_WU')
                    switch selected_action
                        case 'Measurement'
                            measure_data = selected_case.getGroupAverageValue();
                        case 'Comparison'
                            atlases = ga.getCohort().getBrainAtlases();
                            atlas = atlases{1};
                            fdr_lim = ones(1, atlas.getBrainRegions().length());
                            measure_data = selected_case.getDifference();
                            p1 = selected_case.getP1();
                            p2 = selected_case.getP2();
                            calculate_fdr_lim()
                        otherwise
                            atlases = ga.getCohort().getBrainAtlases();
                            atlas = atlases{1};
                            fdr_lim = ones(1, atlas.getBrainRegions().length());
                            measure_data = selected_case.getDifference();
                            p1 = selected_case.getP1();
                            p2 = selected_case.getP2();
                            calculate_fdr_lim()
                    end
                elseif isequal(analysis.getClass(), 'AnalysisFNC_BUT')
                    a = get(ui_list_threshold_or_density, 'String');
                    b = a{get(ui_list_threshold_or_density, 'Value')};
                    
                    switch selected_action
                        case 'Measurement'
                            measurements = ga.getMeasurements().getValues();  % array
                            for i = 1:1:length(measurements)
                                m = measurements{i};
                                if isequal(m.getClass(), selected_case.getClass()) && isequal(round(m.getThreshold(), 4), round(str2double(b), 4))
                                    refined_case = m;
                                    break;
                                end
                            end
                            measure_data = refined_case.getGroupAverageValue();
                        case 'Comparison'
                            comparisons = ga.getComparisons().getValues();
                            for i = 1:1:length(comparisons)
                                c = comparisons{i};
                                if isequal(c.getClass(), selected_case.getClass()) && isequal(round(c.getThreshold(), 4), round(str2double(b), 4))
                                    refined_case = c;
                                    break;
                                end
                            end
                            atlases = ga.getCohort().getBrainAtlases();
                            atlas = atlases{1};
                            fdr_lim = ones(1, atlas.getBrainregions().length());
                            measure_data = refined_case.getDifference()';
                            p1 = refined_case.getP1();
                            p2 = refined_case.getP2();
                            calculate_fdr_lim()
                        otherwise
                            r_comparisons = ga.getRandomComparisons().getValues();
                            for i = 1:1:length(r_comparisons)
                                rc = r_comparisons{i};
                                if isequal(rc.getClass(), selected_case.getClass()) && isequal(round(rc.getThreshold(), 4), round(str2double(b), 4))
                                    refined_case = rc;
                                    break;
                                end
                            end
                            atlases = ga.getCohort().getBrainAtlases();
                            atlas = atlases{1};
                            fdr_lim = ones(1, atlas.getBrainregions().length());
                            measure_data = refined_case.getDifference()';
                            p1 = refined_case.getP1();
                            p2 = refined_case.getP2();
                            calculate_fdr_lim()
                    end
                else  % density
                    a = get(ui_list_threshold_or_density, 'String');
                    b = a{get(ui_list_threshold_or_density, 'Value')};
                    
                    switch selected_action
                        case 'Measurement'
                            measurements = ga.getMeasurements().getValues();  % array
                            for i = 1:1:length(measurements)
                                m = measurements{i};
                                if isequal(m.getClass(), selected_case.getClass()) && isequal(round(m.getDensity(), 4), round(str2double(b), 4))
                                    refined_case = m;
                                    break;
                                end
                            end
                            measure_data = refined_case.getGroupAverageValue();
                        case 'Comparison'
                            comparisons = ga.getComparisons().getValues();
                            for i = 1:1:length(comparisons)
                                c = comparisons{i};
                                if isequal(c.getClass(), selected_case.getClass()) && isequal(round(c.getDensity(), 4), round(str2double(b), 4))
                                    refined_case = c;
                                    break;
                                end
                            end
                            atlases = ga.getCohort().getBrainAtlases();
                            atlas = atlases{1};
                            fdr_lim = ones(1, atlas.getBrainregions().length());
                            measure_data = refined_case.getDifference()';
                            p1 = refined_case.getP1();
                            p2 = refined_case.getP2();
                            calculate_fdr_lim()
                        otherwise
                            r_comparisons = ga.getRandomComparisons().getValues();
                            for i = 1:1:length(r_comparisons)
                                rc = r_comparisons{i};
                                if isequal(rc.getClass(), selected_case.getClass()) && isequal(round(rc.getDensity(), 4), round(str2double(b), 4))
                                    refined_case = rc;
                                    break;
                                end
                            end
                            atlases = ga.getCohort().getBrainAtlases();
                            atlas = atlases{1};
                            fdr_lim = ones(1, atlas.getBrainregions().length());
                            measure_data = refined_case.getDifference()';
                            p1 = refined_case.getP1();
                            p2 = refined_case.getP2();
                            calculate_fdr_lim()
                    end
                end
            end
        else
            % nothing
        end
    end
    function update_brain_meas_plot()
        if ~isempty(measure_data)
            if isequal(size(measure_data, 2), 1)  % nodal
                if iscell(measure_data)
                    measure_data_inner = [measure_data{:}];
                else
                    measure_data_inner = measure_data;
                end
            elseif isequal(size(measure_data, 1), 1)  % global
                % do nothing
            else  % binodal
            end
            
            if get(ui_checkbox_meas_symbolsize, 'Value')
                
                size_ = str2double(get(ui_edit_meas_symbolsize, 'String'));
                offset = str2double(get(ui_edit_meas_offset, 'String'));
                rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                
                if isempty(fdr_lim)
                    size_ = 1 + ((measure_data_inner - offset)./rescaling) * size_;
                else
                    size_ = (1 + ((measure_data_inner - offset)./rescaling) * size_) .* fdr_lim;
                end
                
                size_(isnan(size_)) = 0.1;
                size_(size_<=0) = 0.1;
                bg.br_syms([], 'Size', size_);
            end
            
            if get(ui_checkbox_meas_symbolcolor, 'Value')
                
                offset = str2double(get(ui_edit_meas_offset, 'String'));
                rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                
                colorValue = (measure_data_inner - offset)./rescaling;
                %colorValue = (measure_data_inner - min(measure_data_inner))./(max(measure_data_inner)-min(measure_data_inner));
                colorValue(isnan(colorValue)) = 0;
                colorValue(colorValue<0) = 0;
                colorValue(colorValue>1) = 1;
                
                C = zeros(length(colorValue), 3);
                
                val1 = get(ui_popup_meas_initcolor, 'Value');
                val2 = get(ui_popup_meas_fincolor, 'Value');
                C(:, val1) = colorValue;
                C(:, val2) = 1 - colorValue;
                
                bg.br_syms([], 'Color', C);
            end
            
            if get(ui_checkbox_meas_sphereradius, 'Value')
                
                R = str2double(get(ui_edit_meas_sphereradius, 'String'));
                offset = str2double(get(ui_edit_meas_offset, 'String'));
                rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                
                if isempty(fdr_lim)
                    R = 1 + ((measure_data_inner - offset)./rescaling)*R;
                else
                    R = (1 + ((measure_data_inner - offset)./rescaling)*R).*fdr_lim;
                end
                
                R(isnan(R)) = 0.1;
                R(R<=0) = 0.1;
                bg.br_sphs([], 'R', R);
            end
            
            if get(ui_checkbox_meas_spherecolor, 'Value')
                
                offset = str2double(get(ui_edit_meas_offset, 'String'));
                rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                
                colorValue = (measure_data_inner - offset)./rescaling;
                %colorValue = (measure_data_inner - min(measure_data_inner))./(max(measure_data_inner)-min(measure_data_inner));
                colorValue(isnan(colorValue)) = 0;
                colorValue(colorValue<0) = 0;
                colorValue(colorValue>1) = 1;
                
                C = zeros(length(colorValue), 3);
                
                val1 = get(ui_popup_meas_sphinitcolor, 'Value');
                val2 = get(ui_popup_meas_sphfincolor, 'Value');
                C(:, val1) = colorValue;
                C(:, val2) = 1 - colorValue;
                bg.br_sphs([], 'Color', C);
            end
            
            if get(ui_checkbox_meas_spheretransparency, 'Value')
                
                alpha = get(ui_slider_meas_spheretransparency, 'Value');
                offset = str2double(get(ui_edit_meas_offset, 'String'));
                rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                
                if isempty(fdr_lim)
                    alpha_vec = ((measure_data_inner - offset)./rescaling).*alpha;
                else
                    alpha_vec = (((measure_data_inner - offset)./rescaling).*alpha).*fdr_lim;
                end
                alpha_vec(isnan(alpha_vec)) = 0;
                alpha_vec(alpha_vec<0) = 0;
                alpha_vec(alpha_vec>1) = 1;
                bg.br_sphs([], 'Alpha', alpha_vec);
            end
            
            if get(ui_checkbox_meas_labelsize, 'Value')
                
                size_ = str2double(get(ui_edit_meas_labelsize, 'String'));
                offset = str2double(get(ui_edit_meas_offset, 'String'));
                rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                
                if isempty(fdr_lim)
                    size_ = 1 + ((measure_data_inner - offset)./rescaling)*size_;
                else
                    size_ = (1 + ((measure_data_inner - offset)./rescaling)*size_).*fdr_lim;
                end
                
                size_(isnan(size_)) = 0.1;
                size_(size_<=0) = 0.1;
                bg.br_labs([], 'FontSize', size_);
            end
            
            if get(ui_checkbox_meas_labelcolor, 'Value')
                
                offset = str2double(get(ui_edit_meas_offset, 'String'));
                rescaling = str2double(get(ui_edit_meas_rescaling, 'String'));
                
                colorValue = (measure_data_inner - offset)./rescaling;
                %colorValue = (measure_data_inner - min(measure_data_inner))./(max(measure_data_inner)-min(measure_data_inner));
                colorValue(isnan(colorValue)) = 0;
                colorValue(colorValue<0) = 0;
                colorValue(colorValue>1) = 1;
                
                C = zeros(length(colorValue), 3);
                
                val1 = get(ui_popup_meas_labelinitcolor, 'Value');
                val2 = get(ui_popup_meas_labelfincolor, 'Value');
                C(:, val1) = colorValue;
                C(:, val2) = 1 - colorValue;
                bg.br_labs([], 'Color', C);
            end
        end
    end
    function calculate_fdr_lim()
        i = get(ui_list_gr, 'Value');
        m = mlist{i};
        atlases = ga.getCohort().getBrainAtlases();
        atlas = atlases{1};
        if Measure.is_nodal(m)
            fdr_lim = ones(1, atlas.getBrainRegions().length());
            for i = 1:1:atlas.getBrainRegions().length()
                if get(ui_checkbox_meas_fdr1, 'Value')
                    if p1(i) > fdr(p1, str2double(get(ui_edit_meas_fdr1, 'String')))
                        fdr_lim(i) = 0;
                    end
                elseif get(ui_checkbox_meas_fdr2, 'Value')
                    if p2(i) > fdr(p2, str2double(get(ui_edit_meas_fdr2, 'String')))
                        fdr_lim(i) = 0;
                    end
                end
            end
        elseif Measure.is_binodal(m)
            
        else
            % do nothing
        end
    end
    function update_measure_control_panel()
        i = get(ui_list_gr, 'Value');
        measure = mlist{i};
        if (Measure.is_nodal(measure))
            set(ui_measure_container_panel, 'Visible', 'on')
            childs_visibility(ui_measure_container_panel, 'on')
            set(ui_edge_value_show, 'Enable', 'off')
            set(ui_edge_value_show, 'Visible', 'off')
        else
            set(ui_measure_container_panel, 'Visible', 'off')
            childs_visibility(ui_measure_container_panel, 'off')
            set(ui_edge_value_show, 'Enable', 'on')
            set(ui_edge_value_show, 'Visible', 'on')
        end
    end
    function childs_visibility(handle, rule)
        childs = allchild(handle);
        set(handle, 'visible', rule)
        for i = 1:1:length(childs)
            set(childs(i), 'visible', rule)
        end
    end
    function cb_binodal_measure_show(~, ~)
        if iscell(measure_data)
            measure_data_inner = [measure_data{:}];
        else
            measure_data_inner = measure_data;
        end
        if get(ui_edge_value_show, 'Value')
            for i = 1:1:size(measure_data_inner, 1)
                for j = 1:1:size(measure_data_inner, 2)
                    if bg.link_edge_is_on(i, j) || bg.arrow_edge_is_on(i, j) || bg.cylinder_edge_is_on(i, j)
                        if bg.tex_edge_is_off(i, j)
                            bg.text_edge_on(i, j)
                        else
                            bg.text_edge(brain_axes, i, j, string(measure_data_inner(i, j)))
                        end
                    end
                end
            end
        else
            for i = 1:1:size(measure_data_inner, 1)
                for j = 1:1:size(measure_data_inner, 2)
                    if bg.link_edge_is_on(i, j) || bg.arrow_edge_is_on(i, j) || bg.cylinder_edge_is_on(i, j)
                        bg.text_edge_off(i, j);
                    end
                end
            end
        end
    end

if nargout > 0
    h = f;
end
end