%% ¡header!
PPBrainAtlas_Surf < PlotProp (pr, plot property of brain atlas surface) is a plot of brain atlas surface.

%%% ¡description!
PPBrainAtlas_Surf plots for a brain atlas surface.

CALLBACK - This is a callback function:

    pr.<strong>cb_bring_to_front</strong>() - brings to the front the brain atlas figure and its settings figure

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
p
surf_selector_popup
plot_brain_atlas_btn

f_pba % figure for PlotBrainAtlas

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the panel to manage a brain atlas surface.
    %
    % DRAW(PR) draws the panel to manage a brain atlas surface, with a
    %  pupupmenu to select the brain surface and a button to open it in a
    %  separate GUI.
    %
    % H = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the panel 
    %  with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H of the panel.
    %
    % See also update, redraw, settings, uipanel.

    pr.p = draw@PlotProp(pr, 'DeleteFcn', {@close_f_pba}, varargin{:});
    function close_f_pba(~, ~)
        if check_graphics(pr.f_pba, 'figure')
            close(pr.f_pba)
        end
    end

    pr.surf_selector_popup = uicontrol( ...
        'Parent', pr.p, ...
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
            ba = pr.get('EL');
            ba_surf_id = erase(ba.get('SURF').get('ID'), '.nv');
            
            value = find(strcmp(ba_surf_id, get_brain_surfaces()));
            if isempty(value) % ba surf is not defined, so value is empty
                value = 6; % uses a standard brain surface
            end
        end
        function cb_surf_selector_popup(~, ~)
            brain_surfaces = get_brain_surfaces();
            selected_surface = brain_surfaces{get(pr.surf_selector_popup, 'Value')};

            ba = pr.get('EL');
            ba.set('SURF', ImporterBrainSurfaceNV('FILE', [selected_surface '.nv']).get('SURF'));

            pr.update();
        end

    pr.plot_brain_atlas_btn = uicontrol(...
        'Style', 'pushbutton', ...
        'Parent', pr.p, ...
        'Units', 'normalized', ...
        'String', 'Plot Brain Atlas', ...
        'Position', [.52 .1 .46 .65], ...
        'Callback', {@cb_plot_brain_atlas_btn} ...
        );
        function cb_plot_brain_atlas_btn(~, ~)
            % prevents multiple PlotBrainAtlas figure creations (re-enabled when figure is closed)
            set(pr.plot_brain_atlas_btn, 'Enable', 'off');
            set(pr.surf_selector_popup, 'Enable', 'off');
            drawnow()
            
            % determine position for figure of PlotBrainAtlas
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
            
            pr.f_pba = figure( ...
                'NumberTitle', 'off', ...
                'Units', 'normalized', ...
                'Position', [x/screen_w y/screen_h w/screen_w h/screen_h], ...
                'CloseRequestFcn', {@cb_f_pba_close} ...
                );
            set_braph2_icon(pr.f_pba)
            function cb_f_pba_close(~, ~)
                delete(pr.f_pba) % deletes also f_settings
                pr.update() % re-activates the surf_selector_popup and plot_brain_atlas_btn
            end

        menu_about = BRAPH2.add_menu_about(pr.f_pba);
% % %             menu_about = uimenu(pr.f_pba, 'Label', 'About');
% % %             uimenu(menu_about, ...
% % %                 'Label', 'License ...', ...
% % %                 'Callback', {@cb_license})
% % %             function cb_license(~, ~)
% % %                 BRAPH2.license()
% % %             end
% % %             uimenu(menu_about, ...
% % %                 'Label', 'About ...', ...
% % %                 'Callback', {@cb_about})
% % %             function cb_about(~, ~)
% % %                 BRAPH2.about()
% % %             end

            ui_toolbar = findall(pr.f_pba, 'Tag', 'FigureToolBar');
            delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
            delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))

            % Plot PlotBrainAtlas panel
            pba = pr.memorize('PBA');
            pba.draw('Parent', pr.f_pba)
            
            % Plot settings panel
            f_settings = pba.settings();
            set(f_settings, 'OuterPosition', [x/screen_w f_ba_y/screen_h w/screen_w (f_ba_h-h)/screen_h])
            
            % updates PlotProp panel
            pr.update()
        end
    
    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content of the property panel and its graphical objects.
    %
    % UPDATE(PR) updates the content of the property panel and its graphical objects.
    %
    % Important note:
    % 1. UPDATE() is typically called internally by PlotElement and does not need 
    %  to be explicitly called in children of PlotProp.
    %
    % See also draw, redraw, PlotElement.
    
    update@PlotProp(pr)
    
    ba = pr.get('EL');
    
    if check_graphics(pr.f_pba, 'figure')
        set(pr.f_pba, ...
            'Name', ba.get('ID') ...
            )            
        
        % prevents multiple PlotBrainAtlas figure creations (re-enabled when figure is closed)
        set(pr.plot_brain_atlas_btn, 'Enable', 'off');
        set(pr.surf_selector_popup, 'Enable', 'off');
    else
        % enables creation of a PlotBrainAtlas figure
        set(pr.plot_brain_atlas_btn, 'Enable', 'on');
        set(pr.surf_selector_popup, 'Enable', 'on');
    end
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
    %  - HEIGHT=1.4 characters.
    %
    % See also draw, update, PlotElement.
    
    pr.redraw@PlotProp('Height', 4, varargin{:});
end
function update_brain_atlas(pr)
    %UPDATE_BRAIN_ATLAS updates the brain atlas.
    %
    % UPDATE_BRAIN_ATLAS(PR) updates the brain atlas. Usually used
    %  triggered by PPBrainAtlas_BRDict.
    %
    % See also PPBrainAtlas_BRDict.
    
    if isgraphics(pr.f_pba, 'figure')
        pba = pr.get('PBA');
        try
            pba.draw('Parent', pr.f_pba)
        catch e
            if strcmp(e.identifier, 'MATLAB:badsubscript') % regions added too fast by the user
                % do nothing
            else
                rethrow(e)
            end
        end
    end
end
function cb_bring_to_front(pr)
    %CB_BRING_TO_FRONT brings to front the brain atlas figure and its settings figure.
    %
    % CB_BRING_TO_FRONT(GUI) brings to front the brain atlas figure and its
    %  settings figure.

    % brings to front settings panel
    pr.cb_bring_to_front@PlotProp();

    % brings to front brain atlas figure
    children = get(pr.f_pba, 'Children');
    for i = 1:1:length(children)
        if check_graphics(children(i), 'uipanel') && strcmp(get(children(i), 'Tag'), 'h_panel')
            pba = get(children(i), 'UserData');
            pba.cb_bring_to_front()
        end
    end
end

