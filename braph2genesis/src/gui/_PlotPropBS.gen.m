%% ¡header!
PlotPropBS < PlotProp (pl, plot property of brain atlas surface) is a plot of brain atlas surface.

%%% ¡description!
PlotPropBS plots for Brain Atlas surface.

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

            parent_position = get_figure_position();
            x = parent_position(1);
            y = parent_position(2);
            w = parent_position(3);
            h = parent_position(4);

            screen_size = get(0,'screensize');

            if w >= screen_size(3)/2
                y2 = screen_size(3)/2 - 1;
                w2 = screen_size(3)/2 - 1;
            elseif h == screen_size(4)
                y2 = 1;
                h2 = screen_size(4);
            else
                x2 = x+w+2;
                y2 = y;
                w2 = w;
                h2 = h /2;
            end

            second_figure =  figure( ...
                'Visible', 'on', ...
                'NumberTitle', 'off', ...
                'Name', ['Brain Atlas - ' BRAPH2.STR], ...
                'Position', [x2 y2 w2 h2], ...
                'MenuBar', 'none', ...
                'Color', [.98 .95 .95] ...
                );

            update_tbn = uicontrol('Style', 'pushbutton', ...
                'Parent', second_figure, ...
                'Units', 'normalized', ...
                'Visible', 'off', ...
                'String', 'Hidden button', ...
                'Position', [.01 .01 .01 .01], ...
                'Callback', {@cb_pushbutton_update} ...
                );

            plba.draw('Parent', second_figure);
            plba.settings();
        end
        function cb_pushbutton_update(~, ~)
            plba.draw('Parent', second_figure);
        end
        function position = get_figure_position()
            figHandles = findobj('Type', 'figure');
            for i = 1:1:length(figHandles)
                fig_h = figHandles(i);
                if isequal(fig_h.Name, 'BrainAtlas - BA1 - BRAPH2')
                    position = getpixelposition(fig_h);
                end
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