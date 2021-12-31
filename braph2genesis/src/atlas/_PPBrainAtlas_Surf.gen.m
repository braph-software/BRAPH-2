%% ¡header!
PPBrainAtlas_Surf < PlotProp (pl, plot property of brain atlas surface) is a plot of brain atlas surface.

%%% ¡description!
PPBrainAtlas_Surf plots for Brain Atlas surface.

%%% ¡seealso!
GUI, PlotElement, PlotProp, BrainAtlas

%% ¡props!

%%% ¡prop!
PBA (result, item) is a plot brain atlas.
%%%% ¡settings!
'PlotBrainAtlas'
%%%% ¡calculate!
ba = pl.get('el');
pba =  PlotBrainAtlas('ATLAS', ba);
value = pba;

%% ¡props_update!

%%% ¡prop!
EL (metadata, item) is the element (BrainAtlas).
%%%% ¡settings!
'BrainAtlas'
%%%% ¡default!
BrainAtlas()

%%% ¡prop!
PROP (data, scalar) is the property number (BrainAtlas.SURF).
%%%% ¡default!
BrainAtlas.SURF

%% ¡properties!
pp
surf_selector_popup
plot_brain_atlas_btn

f_pba % figure for PlotBrainAtlas

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

    pl.pp = draw@PlotProp(pl, 'DeleteFcn', {@close_f_pba}, varargin{:});
    function close_f_pba(~, ~)
        if ~isempty(pl.f_pba) && isgraphics(pl.f_pba, 'figure')
            close(pl.f_pba)
        end
    end

    pl.surf_selector_popup = uicontrol( ...
        'Parent', pl.pp, ...
        'Style', 'popupmenu', ...
        'Units', 'normalized', ...
        'Position', [.02 .1 .46 .5], ... 
        'String', get_brain_surfaces(), ...
        'Value', get_surf_selector_popup_value(), ...
        'Callback', {@cb_surf_selector_popup} ...
        );
        function surfs = get_brain_surfaces()
            surfs_path = [fileparts(which('braph2.m')) filesep() 'brainsurfs'];
            files = dir(fullfile(surfs_path, '*.nv'));
            files_array = struct2cell(files);
            surfs = cellfun(@(x) erase(x, '.nv'), files_array(1, :), 'UniformOutput', false);
        end
        function value = get_surf_selector_popup_value()
            ba = pl.get('EL');
            ba_surf_id = erase(ba.get('SURF').get('ID'), '.nv');
            
            value = find(strcmp(ba_surf_id, get_brain_surfaces()));
            if isempty(value) % ba surf is not defined, so value is empty
                value = 6; % uses a standard brain surface
            end
        end
        function cb_surf_selector_popup(~, ~)
            brain_surfaces = get_brain_surfaces();
            selected_surface = brain_surfaces{get(pl.surf_selector_popup, 'Value')};

            ba = pl.get('EL');
            ba.set('SURF', ImporterBrainSurfaceNV('FILE', [selected_surface '.nv']).get('SURF'));

            pl.update();
        end

    pl.plot_brain_atlas_btn = uicontrol(...
        'Style', 'pushbutton', ...
        'Parent', pl.pp, ...
        'Units', 'normalized', ...
        'String', 'Plot Brain Atlas', ...
        'Position', [.52 .1 .46 .65], ...
        'Callback', {@cb_plot_brain_atlas_btn} ...
        );
        function cb_plot_brain_atlas_btn(~, ~)
            % determine position for figure of PlotBrainAtlas
            f_ba = ancestor(pl.pp, 'Figure'); % BrainAtlas GUI
            backup_units = get(f_ba, 'Units');
            set(f_ba, 'Units', 'pixels')
            f_ba_pos = get(f_ba, 'Position'); % pixels
            f_ba_x = f_ba_pos(1);
            f_ba_y = f_ba_pos(2);
            f_ba_w = f_ba_pos(3);
            f_ba_h = f_ba_pos(4);
            set(f_ba, 'Units', backup_units);

            screen_pos = get(0,'screensize');  % pixels
            screen_x = screen_pos(1);
            screen_y = screen_pos(2);
            screen_w = screen_pos(3);
            screen_h = screen_pos(4);

            % golden ratio is defined as a+b/a = a/b = phi. phi = 1.61
            x = f_ba_x + f_ba_w;
            h = f_ba_h / 1.61;
            y = f_ba_y + f_ba_h - h;
            w = f_ba_w * 1.61;
            
            pl.f_pba = figure( ...
                'NumberTitle', 'off', ...
                'Units', 'normalized', ...
                'Position', [x/screen_w y/screen_h w/screen_w h/screen_h], ...
                'CloseRequestFcn', {@cb_f_pba_close} ...
                );
                set_braph2_icon(pl.f_pba)
                function cb_f_pba_close(~, ~)
                    delete(pl.f_pba)

                    pl.update()
                end
                
                ui_menu_about = uimenu(pl.f_pba, 'Label', 'About');
                uimenu(ui_menu_about, ...
                    'Label', 'License ...', ...
                    'Callback', {@cb_license})
                function cb_license(~, ~)
                    BRAPH2.license()
                end
                uimenu(ui_menu_about, ...
                    'Label', 'About ...', ...
                    'Callback', {@cb_about})
                function cb_about(~, ~)
                    BRAPH2.about()
                end
                % % % ui_menu = uimenu(pl.f_pba, 'Label', 'Figure');
                % % % uimenu(ui_menu, ...
                % % %     'Label', 'Save Figure ...', ...
                % % %     'Accelerator', 'F', ...
                % % %     'Callback', {@cb_save_figure})
                % % % function cb_save_figure(~, ~)
                % % %     % select file
                % % %     [file, path, filterindex] = uiputfile('*.jpg', ['Select the ' pl.f_pba.Name ' file.']);
                % % %     % save file
                % % %     if filterindex
                % % %         filename = fullfile(path, file);
                % % %         saveas(gcf, filename, 'jpg');
                % % %     end
                % % % end

                ui_toolbar = findall(pl.f_pba, 'Tag', 'FigureToolBar');
                delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
                delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))

            % Plor figure PlotBrainAtlas
            pba = pl.memorize('PBA');
            pba.draw('Parent', pl.f_pba)
            
            % Plot setting panel
            f_settings = pba.settings();
            set(f_settings, 'OuterPosition', [x/screen_w f_ba_y/screen_h w/screen_w (f_ba_h-h)/screen_h])
            pba.set('SETPOS', get(f_settings, 'Position'))
            
            pl.update()
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
    
    ba = pl.get('EL');
    
    if isgraphics(pl.f_pba, 'figure')
        set(pl.f_pba, ...
            'Name', ba.get('ID') ...
            )            
        
        % prevents multiple PlotBrainAtlas figure creations (re-enabled when figure is closed)
        set(pl.plot_brain_atlas_btn, 'Enable', 'off');
        set(pl.surf_selector_popup, 'Enable', 'off');
    else
        % enables creation of a PlotBrainAtlas figure
        set(pl.plot_brain_atlas_btn, 'Enable', 'on');
        set(pl.surf_selector_popup, 'Enable', 'on');
    end
end
function redraw(pl, varargin)
    %REDRAW redraws the element graphical panel.
    %
    % REDRAW(PL) redraws the plot PL.
    %
    % REDRAW(PL, 'Height', HEIGHT) sets the height of PL (by default HEIGHT=4).
    %
    % See also draw, update, refresh.

    pl.redraw@PlotProp('Height', 4, varargin{:});
end
function update_brain_atlas(pl)
    %UPDATE_BRAIN_ATLAS updates the brain atlas.
    %
    % UPDATE_BRAIN_ATLAS(PL) updates the brain atlas. Usually used
    %  triggered by PPBrainAtlas_BRDict.
    %
    % See also PPBrainAtlas_BRDict.
    
    if isgraphics(pl.f_pba, 'figure')
        pba = pl.get('PBA');
        try
            pba.draw('Parent', pl.f_pba)
        catch e
            if strcmp(e.identifier, 'MATLAB:badsubscript') % regions added too fast by the user
                % do nothing
            else
                rethrow(e)
            end
        end
    end
end
