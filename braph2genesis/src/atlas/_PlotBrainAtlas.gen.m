%% ¡header!
PlotBrainAtlas < PlotBrainSurface (pla, plot brain atlas) is a plot of a brain atlas.

%%% ¡description!
PlotBrainAtlas manages the plot of the brain regions symbols,
spheres, ids and labels. PlotBrainAtlas utilizes the surface created
from PlotBrainSurface to integrate the regions to a brain surface.

%%% ¡seealso!
Plot, BrainSurface, PlotBrainSurface

%% ¡constants!
PLOT_SYMBOL_NAME = { ...
    'point' ...
    'circle' ...
    'x-mark' ...
    'plus' ...
    'star' ...
    'square' ...
    'diamond' ...
    'triangle (down)' ...
    'triangle (up)' ...
    'triangle (left)' ...
    'triangle (right)' ...
    'pentagram' ...
    'hexagram' ...
    'none' ...
    }

PLOT_SYMBOL_TAG = { ...
    '.' ...
    'o' ...
    'x' ...
    '+' ...
    '*' ...
    's' ...
    'd' ...
    'v' ...
    '^' ...
    '>' ...
    '<' ...
    'p' ...
    'h' ...
    'none' ...
    }

% Symbols
INIT_SYM_MARKER = 'o'
INIT_SYM_SIZE = 10
INIT_SYM_EDGE_COLOR = [0 0 1]
INIT_SYM_FACE_COLOR = [0 0 1]


% Spheres
INIT_SPH_EDGE_COLOR = [1 1 1]
INIT_SPH_EDGE_ALPHA = .5
INIT_SPH_FACE_COLOR = [.9 .4 .1]
INIT_SPH_FACE_ALPHA = .5
INIT_SPH_R = 1

% IDs
INIT_ID_FONT_SIZE = 13
INIT_ID_FONT_NAME = 'Helvetica'
INIT_ID_FONT_COLOR = [0 0 0]
INIT_ID_FONT_INTERPRETER = 'none'

% Labels
INIT_LAB_FONT_SIZE = 13
INIT_LAB_FONT_NAME = 'Helvetica'
INIT_LAB_FONT_COLOR = [0 0 0]
INIT_LAB_FONT_INTERPRETER = 'none'

%% ¡properties!
syms % handle for the symbols structure
sphs % handle for the spheres structure
ids % handle for the ids structure
labs % handle for the labs structure

%% ¡props!

%%% ¡prop!
ATLAS (metadata, item) is the brain atlas with the brain regions
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
sym_size (metadata, scalar) is the symbol size.
%%%% ¡default!
PlotBrainAtlas.INIT_SYM_SIZE

%%% ¡prop!
sym_marker (metadata, string) is the symbol marker.
%%%% ¡default!
PlotBrainAtlas.INIT_SYM_MARKER

%%% ¡prop!
sym_edge_color (metadata, rvector) is the symbol edge color.
%%%% ¡default!
PlotBrainAtlas.INIT_SYM_EDGE_COLOR

%%% ¡prop!
sym_face_color (metadata, rvector) is the symbol face color.
%%%% ¡default!
PlotBrainAtlas.INIT_SYM_FACE_COLOR

%%% ¡prop!
sphs_size (metadata, scalar) is the sphere radius size.
%%%% ¡default!
PlotBrainAtlas.INIT_SPH_R

%%% ¡prop!
sphs_edge_color (metadata, rvector) is the sphere edge color.
%%%% ¡default!
PlotBrainAtlas.INIT_SPH_EDGE_COLOR

%%% ¡prop!
sphs_edge_alfa (metadata, scalar) is the sphere edge alfa.
%%%% ¡default!
PlotBrainAtlas.INIT_SPH_EDGE_ALPHA

%%% ¡prop!
sphs_face_color (metadata, rvector) is the sphere face color.
%%%% ¡default!
PlotBrainAtlas.INIT_SPH_FACE_COLOR

%%% ¡prop!
sphs_face_alfa (metadata, scalar) is the sphere face alfa.
%%%% ¡default!
PlotBrainAtlas.INIT_SPH_FACE_ALPHA

%%% ¡prop!
ids_font_size (metadata, scalar) is the ids font size.
%%%% ¡default!
PlotBrainAtlas.INIT_ID_FONT_SIZE

%%% ¡prop!
ids_font_name (metadata, string) is the ids font name.
%%%% ¡default!
PlotBrainAtlas.INIT_ID_FONT_NAME

%%% ¡prop!
ids_font_color (metadata, rvector) is the ids font color.
%%%% ¡default!
PlotBrainAtlas.INIT_ID_FONT_COLOR

%%% ¡prop!
ids_font_interpreter (metadata, string) is the ids font interpreter.
%%%% ¡default!
PlotBrainAtlas.INIT_ID_FONT_INTERPRETER

%%% ¡prop!
labs_font_size (metadata, scalar) is the labs font size.
%%%% ¡default!
PlotBrainAtlas.INIT_LAB_FONT_SIZE

%%% ¡prop!
labs_font_name (metadata, string) is the labs font name.
%%%% ¡default!
PlotBrainAtlas.INIT_LAB_FONT_NAME

%%% ¡prop!
labs_font_color (metadata, rvector) is the labs font color.
%%%% ¡default!
PlotBrainAtlas.INIT_LAB_FONT_COLOR

%%% ¡prop!
labs_font_interpreter (metadata, string) is the labs font interpreter.
%%%% ¡default!
PlotBrainAtlas.INIT_LAB_FONT_INTERPRETER


%% ¡methods!
function draw(pla, varargin)
% DRAW draws the brain atlas specified region.
%
% DRAW(PLA, 'DrawOption', VALUE, ...) draws the specified brain atlas region. It sets the handle
%  to the specified handle.
%  Available DrawOptions are:
%   sym         -  Brain Region symbol plot.
%   sphs        -  Brain Region sphere plot.
%   ids         -  Brain Region identification plot.
%   labs        -  Brain Region label plot.
%
% DRAW(PLA, 'DrawOption', VALUE, 'Property, VALUE ...) draws the specified brain atlas region. It sets the handle
%  to the specified handle. Sets the draw property of the specified
%  DRAWOPTION.
%
% see also settings, PlotBrainSurface, uipanel.

draw_option = get_from_varargin('sym', 'PLADrawOption', varargin{:});
h = draw@PlotBrainSurface(pla, varargin{:});
i = get_from_varargin(1, 'plot_brain_region', varargin{:});
switch draw_option
    case 'sphs'
        % axes
        if isempty(pla.h_axes) || ~isgraphics(pla.h_axes, 'axes')
            pla.h_axes = axes(h);
        end
        
        % radius
        R = pla.sphs.R(i);
        
        % center coordinates
        X = pla.get('ATLAS').get('BR_DICT').getItem(i).get('X');
        Y = pla.get('ATLAS').get('BR_DICT').getItem(i).get('Y');
        Z = pla.get('ATLAS').get('BR_DICT').getItem(i).get('Z');
        
        % plot sphere
        if ~ishandle(pla.sphs.h(i))
            color = PlotBrainAtlas.INIT_SPH_FACE_COLOR;
            alpha = PlotBrainAtlas.INIT_SPH_FACE_ALPHA;
            
            [sx, sy, sz] = sphere();
            pla.sphs.h(i) = surf( ...
                pla.h_axes, ...
                X + R * sx, ...
                Y + R * sy, ...
                Z + R * sz ...
                );
        else
            if ~isequal(pla.sphs.X(i), num2cell(X)) || ~isequal(pla.sphs.Y(i), num2cell(Y)) || ~isequal(pla.sphs.Z(i), num2cell(Z)) || pla.sphs.R(i) ~= (R)
                
                [sx, sy, sz] = sphere();
                set(pla.sphs.h(i), 'XData',X + R * sx);
                set(pla.sphs.h(i), 'YData',Y + R * sy);
                set(pla.sphs.h(i), 'ZData',Z + R * sz);
            end
        end
        
        % saves new data
        pla.sphs.X(i) = num2cell(X);
        pla.sphs.Y(i) = num2cell(Y);
        pla.sphs.Z(i) = num2cell(Z);
        pla.sphs.R(i) = R;
        
        set(pla.sphs.h(i), ...
            'Visible', 'on', ...
            'EdgeColor', color, ...
            'EdgeAlpha', alpha, ...
            'FaceColor', color, ...
            'FaceAlpha', alpha ...
            )
        
    case 'ids'
    case 'labs'
    otherwise % 'sym'
        % axes
        if isempty(pla.h_axes) || ~isgraphics(pla.h_axes, 'axes')
            pla.h_axes = axes(h);
        end
        
        % center coordinates
        X = pla.get('ATLAS').get('BR_DICT').getItem(i).get('X');
        Y = pla.get('ATLAS').get('BR_DICT').getItem(i).get('Y');
        Z = pla.get('ATLAS').get('BR_DICT').getItem(i).get('Z');
        
        if ~ishandle(pla.syms.h(i))
            pla.syms.h(i) = plot3(...
                pla.h_axes, ...
                X, ...
                Y, ...
                Z ...
                );
        else
            if ~isequal(pla.syms.X(i), X) || ~isequal(pla.syms.Y(i), Y) || ~isequal(pla.syms.Z(i), Z)
                set(pla.syms.h(i), 'XData', X);
                set(pla.syms.h(i), 'YData', Y);
                set(pla.syms.h(i), 'ZData', Z);
            end
        end
        
        % saves new data
        pla.syms.X(i) = num2cell(X);
        pla.syms.Y(i) = num2cell(Y);
        pla.syms.Z(i) = num2cell(Z);
        
        set(pla.syms.h(i), ...
            'Visible', 'on', ...
            'Marker', pla.get('sym_marker'),...
            'MarkerSize', pla.get('sym_size'),...
            'MarkerEdgeColor', pla.get('sym_edge_color'),...
            'MarkerFaceColor', pla.get('sym_face_color'))
end
end
function settings(pla, varargin)
    settings_option = get_from_varargin('syms_settings', 'PLASettingsOption' , varargin{:});
    switch settings_option
        case 'sphs_settings'
        otherwise
            f = settings@Plot(pla, varargin{:});
            % Initialization
            ui_list = uicontrol(f, 'Style', 'listbox');
            set(ui_list, 'Units', 'normalized')
            set(ui_list, 'BackgroundColor', [.9 .4 .1])
            set(ui_list, 'Value', i_vec)
            set(ui_list, 'Max', 2, 'Min',0)
            set(ui_list, 'BackgroundColor', [1 1 1])
            set(ui_list, 'Position', [.05 .15 .40 .80])
            set(ui_list, 'TooltipString', 'Select brain regions');
            set(ui_list, 'Callback', {@cb_list});

            ui_checkbox_id = uicontrol(f, 'Style', 'checkbox');
            set(ui_checkbox_id, 'Units', 'normalized')
            set(ui_checkbox_id, 'BackgroundColor', [.9 .4 .1])
            set(ui_checkbox_id, 'Position', [.05 .05 .20 .10])
            set(ui_checkbox_id, 'String', 'id')
            set(ui_checkbox_id, 'Value', true)
            set(ui_checkbox_id, 'FontWeight', 'bold')
            set(ui_checkbox_id, 'TooltipString', 'Shows brain regions by id')
            set(ui_checkbox_id, 'Callback', {@cb_id})

            ui_checkbox_label = uicontrol(f, 'Style', 'checkbox');
            set(ui_checkbox_label, 'Units', 'normalized')
            set(ui_checkbox_label, 'BackgroundColor', [.9 .4 .1])
            set(ui_checkbox_label, 'Position', [.20 .05 .15 .10])
            set(ui_checkbox_label, 'String', 'label')
            set(ui_checkbox_label, 'Value', false)
            set(ui_checkbox_label, 'TooltipString', 'Shows brain regions by label')
            set(ui_checkbox_label, 'Callback', {@cb_label})

            ui_checkbox_xyz = uicontrol(f, 'Style', 'checkbox');
            set(ui_checkbox_xyz, 'Units', 'normalized')
            set(ui_checkbox_xyz, 'BackgroundColor', [.9 .4 .1])
            set(ui_checkbox_xyz, 'Position', [.35 .05 .15 .10])
            set(ui_checkbox_xyz, 'String', 'xyz')
            set(ui_checkbox_xyz, 'Value', false)
            set(ui_checkbox_xyz, 'TooltipString', 'Shows brain regions by name')
            set(ui_checkbox_xyz, 'Callback', {@cb_xyz})

            ui_button_show = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_show, 'Units','normalized')
            set(ui_button_show, 'Position', [.50 .85 .45 .10])
            set(ui_button_show, 'String', 'Show Regions')
            set(ui_button_show, 'TooltipString', 'Show selected brain regions')
            set(ui_button_show, 'Callback', {@cb_show})

            ui_button_hide = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_hide, 'Units', 'normalized')
            set(ui_button_hide, 'Position', [.50 .75 .45 .10])
            set(ui_button_hide, 'String', 'Hide Regions')
            set(ui_button_hide, 'TooltipString', 'Hide selected brain regions')
            set(ui_button_hide, 'Callback', {@cb_hide})

            ui_popup_marker = uicontrol(f, 'Style', 'popup', 'String', {''});
            set(ui_popup_marker, 'Units', 'normalized')
            set(ui_popup_marker, 'BackgroundColor', [.9 .4 .1])
            set(ui_popup_marker, 'Position', [.50 .50 .45 .10])
            set(ui_popup_marker, 'String', PlotBrainAtlas.PLOT_SYMBOL_NAME)
            set(ui_popup_marker, 'Value', 2)
            set(ui_popup_marker, 'TooltipString', 'Select symbol');
            set(ui_popup_marker, 'Callback', {@cb_marker})

            ui_text_size = uicontrol(f, 'Style', 'text');
            set(ui_text_size, 'Units', 'normalized')
            set(ui_text_size, 'BackgroundColor', [.9 .4 .1])
            set(ui_text_size, 'Position', [.50 .375 .20 .10])
            set(ui_text_size, 'String', 'symbol size ')
            set(ui_text_size, 'HorizontalAlignment', 'left')
            set(ui_text_size, 'FontWeight', 'bold')

            ui_edit_size = uicontrol(f, 'Style', 'edit');
            set(ui_edit_size, 'Units','normalized')
            set(ui_edit_size, 'BackgroundColor', [.9 .4 .1])
            set(ui_edit_size, 'Position', [.70 .40 .25 .10])
            set(ui_edit_size, 'HorizontalAlignment', 'center')
            set(ui_edit_size, 'FontWeight', 'bold')
            set(ui_edit_size, 'String', '1')
            set(ui_edit_size, 'Callback', {@cb_size})

            ui_button_facecolor = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_facecolor, 'Units', 'normalized')
            set(ui_button_facecolor, 'Position', [.50 .25 .45 .10])
            set(ui_button_facecolor, 'String', 'Symbol Color')
            set(ui_button_facecolor, 'TooltipString', 'Select symbol color')
            set(ui_button_facecolor, 'Callback', {@cb_facecolor})

            ui_button_edgecolor = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_edgecolor, 'Units', 'normalized')
            set(ui_button_edgecolor, 'Position', [.50 .15 .45 .10])
            set(ui_button_edgecolor, 'String', 'Edge Color')
            set(ui_button_edgecolor, 'TooltipString', 'Select symbol edge color')
            set(ui_button_edgecolor, 'Callback', {@cb_edgecolor})

            update_list()
            set(f, 'Visible', 'on')
    end

    function update_list()
        % get info
        ids = cellfun(@(br) br.get('ID'), pla.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false); %#ok<PROPLC>
        labels = cellfun(@(br) br.get('Label'), pla.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
        xs = cellfun(@(br) br.get('X'), pla.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
        ys = cellfun(@(br) br.get('Y'), pla.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
        zs = cellfun(@(br) br.get('Z'), pla.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
        
        % Set list names
        if get(ui_checkbox_id, 'Value')
            set(ui_list, 'String', ids) %#ok<PROPLC>
        elseif get(ui_checkbox_label, 'Value')
            set(ui_list, 'String', labels)
        elseif get(ui_checkbox_xyz, 'Value')
            xyz = cell(1, pla.get('ATLAS').get('BR_DICT').length());
            for j = 1:1:pla.get('ATLAS').get('BR_DICT').length()
                xyz{j} = [num2str(xs{j}) '   ' ...
                    num2str(ys{j}) '   ' ...
                    num2str(zs{j})];
            end
            set(ui_list, 'String', xyz)
        end
    end
    function cb_list(~, ~)  % (src, event)
        update_list()
    end
    function cb_id(~,~)  % (src,event)
        set(ui_checkbox_id, 'Value', true)
        set(ui_checkbox_id, 'FontWeight', 'bold')
        
        set(ui_checkbox_label, 'Value', false)
        set(ui_checkbox_label, 'FontWeight', 'normal')
        
        set(ui_checkbox_xyz, 'Value', false)
        set(ui_checkbox_xyz, 'FontWeight', 'normal')
        
        update_list()
    end
    function cb_label(~, ~)  % (src, event)
        set(ui_checkbox_id, 'Value', false)
        set(ui_checkbox_id, 'FontWeight', 'normal')
        
        set(ui_checkbox_label, 'Value', true)
        set(ui_checkbox_label, 'FontWeight', 'bold')
        
        set(ui_checkbox_xyz, 'Value', false)
        set(ui_checkbox_xyz, 'FontWeight', 'normal')
        
        update_list()
    end
    function cb_xyz(~, ~)  % (src, event)
        set(ui_checkbox_id, 'Value', false)
        set(ui_checkbox_id, 'FontWeight', 'normal')
        
        set(ui_checkbox_label, 'Value', false)
        set(ui_checkbox_label, 'FontWeight', 'normal')
        
        set(ui_checkbox_xyz, 'Value', true)
        set(ui_checkbox_xyz, 'FontWeight', 'bold')
        
        update_list()
    end
    function cb_show(~, ~)  % (src, event)
        brs = get_br_list();
        for i = 1:1:length(brs)
            br = brs{i};
            pla.draw('PLADrawOption', 'syms', 'plot_brain_region', br);
        end
    end
    function cb_hide(~, ~)  % (src, event)
        
    end
    function cb_marker(~, ~)  % (src, event)
        symbol = PlotBrainAtlas.PLOT_SYMBOL_TAG{get(ui_popup_marker, 'Value')};
        pla.set('sym_marker', symbol)
        
        brs = get_br_list();
        for i = 1:1:length(brs)
            br = brs{i};
            pla.draw('PLADrawOption', 'syms', 'plot_brain_region', br);
        end
    end
    function cb_size(~, ~)  % (src, event)
        size = real(str2double(get(ui_edit_size, 'String')));
        
        if isempty(size) || size <= 1
            set(ui_edit_size, 'String', '1')
            size = 1;
        end
        pla.set('sphs_size', size)
        
        brs = get_br_list();
        for i = 1:1:length(brs)
            br = brs{i};
            pla.draw('PLADrawOption', 'syms', 'plot_brain_region', br);
        end
    end
    function cb_facecolor(~, ~)  % (src, event)
        color = uisetcolor();
        
        if length(color) == 3
            pla.set('sym_face_color', color)
            
            brs = get_br_list();
            for i = 1:1:length(brs)
                br = brs{i};
                pla.draw('PLADrawOption', 'syms', 'plot_brain_region', br);
            end
        end
    end
    function cb_edgecolor(~, ~)  % (src, event)
        color = uisetcolor();
        
        if length(color) == 3
            pla.set('sym_edge_color', color)
            
            brs = get_br_list();
            for i = 1:1:length(brs)
                br = brs{i};
                pla.draw('PLADrawOption', 'syms', 'plot_brain_region', br);
            end
        end
    end
    function bri = get_br_list()
        if pla.get('ATLAS').get('BR_DICT').length()>0
            bri = get(ui_list, 'Value');
        else
            bri = [];
        end
    end
end


