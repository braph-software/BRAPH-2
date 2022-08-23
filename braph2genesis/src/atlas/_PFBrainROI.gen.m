%% ¡header!
PFBrainROI < PanelFig (pf, plot brain graph) is a plot of a brain graph.

%%% ¡description!
PFBrainROI manages the plot of the graph edges, arrows and cylinders.
PFBrainROI utilizes the surface created from PFBrainAtlas to
integrate the regions to a brain surface.

%%% ¡seealso!
Plot, BrainAtlas, PFBrainSurface, PFBrainAtlas.

%% ¡properties!
p % handle for panel
h_axes % handle for axes

toolbar
toolbar_roi

h_rois

%% ¡props!
%%% ¡prop!
ME (metadata, item) is the measure.

%%% ¡prop!
ROIS (figure, logical) determines whether the rois are showned.
%%%% ¡default!
true
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('ROIS', varargin)) && ~braph2_testing
   if ~pf.get('ROIS')
        for i = 1:1:length(pf.h_rois)
            set(pf.h_rois{i}, 'Visible', false)
        end        
   end
    
   % triggers the update of SPH_DICT
    pf.set('ROI_DICT', pf.get('ROI_DICT'))
    
    % update state of toggle tool
    set(pf.toolbar_roi, 'State', pf.get('ROIS'))
end

%%% ¡prop!
ROI_DICT (figure, idict) contians the rois.
%%%% ¡settings!
'SettingsROIS'
%%%% ¡postprocessing!
if pf.get('ROIS') 
    if isa(pf.getr('ROI_DICT'), 'NoValue')
        roi_dict = ImporterROINIFTI().get('ROI_DICT');
        pf.set('ROI_DICT', roi_dict);
    end
end
%%%% ¡gui!
pr = PanelPropIDictTable('EL', pf, 'PROP', PFBrainROI.ROI_DICT, ...
    'COLS', [PanelPropIDictTable.SELECTOR SettingsROIS.VISIBLE SettingsROIS.FACECOLOR SettingsROIS.FACEALPHA SettingsROIS.EDGECOLOR SettingsROIS.EDGEALPHA], ...
    varargin{:});

%% ¡methods!
function h_panel = draw(pf, varargin)
    %DRAW draws the brain atlas graph graphical panel.
    %
    % DRAW(PL) draws the brain atlas graph graphical panel.
    %
    % H = DRAW(PL) returns a handle to the brain atlas graph graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain atlas graph graphical panel H.
    %
    % see also settings, uipanel, isgraphics.

    pf.p = draw@PanelFig(pf, varargin{:});

    % axes
    if ~check_graphics(pf.h_axes, 'axes')
        pf.h_axes = uiaxes( ...
            'Parent', pf.p, ...
            'Tag', 'h_axes', ...
            'Units', 'normalized', ...
            'OuterPosition', [0 0 1 1] ...
            );
        pf.h_axes.Toolbar.Visible = 'off';
        pf.h_axes.Interactions = [];
    end
    
    %plot
    if isempty(pf.h_rois) && ~isempty(pf.roi_dict)
        for i = 1:pf.roi_dict.length()
            roi = pf.roi_dict.getItem(i);
            vert = roi.get('vertices');
            pf.h_rois{i} = trisurf(roi.get('faces'), vert(:, 1), vert(:, 2), vert(:,3));
            color = [randi(225)/225 randi(225)/225 randi(225)/225];
            set(pf.h_rois{i}, 'FaceColor', color, 'EdgeAlpha', 0.1);
        end
    end

    % get toolbar
    if ~check_graphics(pf.toolbar, 'uitoolbar')
        pf.toolbar = findobj(ancestor(pf.p, 'Figure'), 'Tag', 'ToolBar');
    end

    % set new toogletools
    if ~check_graphics(pf.toolbar_roi, 'uitoggletool')

        uipushtool(pf.toolbar, 'Separator', 'on', 'Visible', 'off')

        % measures
        pf.toolbar_roi = uitoggletool(pf.toolbar, ...
            'Tag', 'toolbar_roi', ...
            'Separator', 'on', ...
            'State', pf.get('ROI'), ...
            'Tooltip', 'Show ROIS', ...
            'CData', imread('icon_measure_roi.png'), ...
            'OnCallback', {@cb_rois, true}, ...
            'OffCallback', {@cb_rois, false});

    end

        function cb_rois(~, ~, measures) % (src, event)
            pf.set('ROI', measures)
        end
        

    % listener to changes in

    % output
    if nargout > 0
        h_panel = pf.p;
    end
end
function str = tostring(pf, varargin)
    %TOSTRING string with information about the brain atlas.
    %
    % STR = TOSTRING(PF) returns a string with information about the brain atlas.
    %
    % STR = TOSTRING(PF, N) trims the string to the first N characters.
    %
    % STR = TOSTRING(PF, N, ENDING) ends the string with ENDING if it has
    %  been trimmed.
    %
    % See also disp, tree.

    str = 'Plot Brain ROI';
    str = tostring(str, varargin{:});
    str = str(2:1:end-1);
end

