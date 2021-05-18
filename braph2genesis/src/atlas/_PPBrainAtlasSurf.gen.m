%% ¡header!
PPBrainAtlasSurf < PlotProp (pl, plot property of brain atlas surface) is a plot of brain atlas surface.

%%% ¡description!
PPBrainAtlasSurf plots for Brain Atlas surface.

%%% ¡seealso!
GUI, PlotElement, PlotProp, BrainAtlas

%% ¡properties!
pp
plot_brain_atlas_btn
plot_ba


%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the idict for brain atlas property graphical panel.
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
    pl.pp = draw@PlotProp(pl, varargin{:});
    plba = [];
    second_figure = [];
    set(pl.pp, 'DeleteFcn', {@close_f_settings}, ...
        varargin{:})
    
    function close_f_settings(~,~)
        if ~isempty(second_figure) && isgraphics(second_figure)           
           close(second_figure)               
        end
    end

    if isempty(pl.plot_brain_atlas_btn) || ~isgraphics(pl.plot_brain_atlas_btn, 'edit')
        if isempty(el.get('surf').get('id'))
            surf = ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF');
        end
        plba =  PlotBrainAtlas('ATLAS', el, 'Surf', surf);

        pl.plot_brain_atlas_btn = uicontrol(...
            'Style', 'pushbutton', ...
            'Parent', pl.pp, ...
            'Units', 'normalized', ...
            'String', 'Plot Brain Atlas', ...
            'Position', [.05 .1 .9 .65], ...
            'Callback', {@cb_pushbutton_brain_atlas} ...
            );
        
    end
    
        function cb_pushbutton_brain_atlas(~, ~)

            [parent_position_pixels, normalized] = get_figure_position();
            x = parent_position_pixels(1);
            y = parent_position_pixels(2);
            w = parent_position_pixels(3);
            h = parent_position_pixels(4);

            screen_size = get(0,'screensize');

            if w >= screen_size(3)/2
                x2 = normalized(1) / 2;
                w2 = normalized(3) / 2 - .01;
            elseif h == screen_size(4)
                y2 = normalized(2);
                h2 = normalized(4)/2;
            else % golden ratio 
                % golden ratio is defined as a+b/a = a/b = phi. phi = 1.61
                x2 = normalized(1)+ normalized(3);
                h2 = normalized(4) / 1.61;
                y2 = normalized(2) + h2 - .195;
                w2 = normalized(3) * 1.61;               
            end
            
            second_figure =  figure( ...
                'Visible', 'on', ...
                'NumberTitle', 'off', ...
                'Name', ['Brain Surface - ' BRAPH2.STR], ...
                'Units', 'normalized', ...
                'Position', [x2 y2 w2 h2], ...
                'MenuBar', 'none', ...
                'Toolbar', 'figure', ...
                'Color', 'w' ...
                );
            
            ui_toolbar = findall(second_figure, 'Tag', 'FigureToolBar');
            
            delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
            delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))
            delete(findall(ui_toolbar, 'Tag', 'Standard.SaveFigure'))
            delete(findall(ui_toolbar, 'Tag', 'Standard.PrintFigure'))
            delete(findall(ui_toolbar, 'Tag', 'Standard.EditPlot'))
            delete(findall(ui_toolbar, 'Tag', 'Standard.OpenInspector'))
            delete(findall(ui_toolbar, 'Tag', 'Exploration.Brushing'))
            delete(findall(ui_toolbar, 'Tag', 'DataManager.Linking'))
            delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertColorbar'))
            delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertLegend'))
            delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOff'))
            delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOn'))

            update_tbn = uicontrol('Style', 'pushbutton', ...
                'Parent', second_figure, ...
                'Units', 'normalized', ...
                'Visible', 'off', ...
                'String', 'Hidden button', ...
                'Position', [.01 .01 .01 .01], ...
                'Callback', {@cb_pushbutton_update} ...
                );

            plba.draw('Parent', second_figure);
            plba.set('SETPOS', [x2 normalized(2) w2 h2*1.61-h2-.065]); % height has to be correcter for the toolbar and menu
            plba.settings();
            set(pl.plot_brain_atlas_btn, 'Enable', 'off');
        end
        function cb_pushbutton_update(~, ~)
            plba.draw('Parent', second_figure);
        end
        function [pixels, normalized] = get_figure_position()
            fig_h = getGUIFigureObj();
            set(fig_h, 'Units', 'normalized'); % set it to get position on normal units
            pixels = getpixelposition(fig_h);
            normalized = get(fig_h, 'Position');
            set(fig_h, 'Units', 'characters'); % go back
        end
        function obj = getGUIFigureObj()
            figHandles = findobj('Type', 'figure');
            for i = 1:1:length(figHandles)
                fig_h = figHandles(i);
                if contains(fig_h.Name, 'BrainAtlas - ')
                    obj = fig_h;
                end
            end
        end        
        function cb_close_atlas_srf(~, ~)
            set(pl.plot_brain_atlas_btn, 'Enable', 'on');
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
end
function redraw(pl, varargin)
    %REDRAW redraws the element graphical panel.
    %
    % REDRAW(PL) redraws the plot PL.
    %
    % REDRAW(PL, 'Height', HEIGHT) sets the height of PL (by default HEIGHT=3.3).
    %
    % See also draw, update, refresh.

    pl.redraw@PlotProp('Height', 4, varargin{:});
end