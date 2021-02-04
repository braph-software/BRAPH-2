%% ¡header!
PlotBrainSurface < Plot (pl, plot brain surface) is a plot of a brain surfce.

%%% ¡description!
...

%%% ¡seealso!
Plot, BrainSurface

%% ¡properties!
h_axes % handle for the axes
h_brain % handle for brain surface

%% ¡props!

%%% ¡prop!
SURF (metadata, item) is the brain surface to be plotted.
%%%% ¡settings!
'BrainSurface'

%%% ¡prop!
BRAIN (metadata, logical) determines whether the brain surface is shown.
%%%% ¡default!
true

%%% ¡prop!
EDGECOLOR (metadata, rvector) is the RGB edge color.
%%%% ¡check_prop!
check = (length(value) == 3) && all(value >= 0 & value <= 1);
%%%% ¡default!
[1 1 1]

%%% ¡prop!
EDGEALPHA (metadata, scalar) is the edge transparency.
%%%% ¡check_prop!
check = value >= 0 && value <= 1;
%%%% ¡default!
0

%%% ¡prop!
FACECOLOR (metadata, rvector) is the RGB face color.
%%%% ¡check_prop!
check = (length(value) == 3) && all(value >= 0 & value <= 1);
%%%% ¡default!
[.5 .5 .5]

%%% ¡prop!
FACEALPHA (metadata, scalar) is the face transparency.
%%%% ¡check_prop!
check = value >= 0 && value <= 1;
%%%% ¡default!
.5

%% ¡methods!
function h_panel = draw(pl, varargin)

    h_panel = draw@Plot(pl, varargin{:});

    % axes
    if isempty(pl.h_axes) || ~isgraphics(pl.h_axes, 'axes')
        pl.h_axes = axes(h_panel);
    end
    
    % brain
    if pl.get('BRAIN')
        if isempty(pl.h_brain) || ~isgraphics(pl.h_brain, 'patch')
            triangles = pl.get('SURF').get('TRIANGLES');
            coordinates = pl.get('SURF').get('COORDINATES');
            pl.h_brain = trisurf( ...
                triangles, ...
                coordinates(1, :), ...
                coordinates(2, :), ...
                coordinates(3, :), ...
                'Parent', pl.h_axes ...
                );
        end
        set(pl.h_brain, ...
            'Visible', 'on', ...
            'EdgeColor', pl.get('EDGECOLOR'), ...
            'EdgeAlpha', pl.get('EDGEALPHA'), ...
            'FaceColor', pl.get('FACECOLOR'), ...
            'FaceAlpha', pl.get('FACEALPHA') ...
            )
    else
        if ~isempty(pl.h_brain) && isgraphics(pl.h_brain, 'patch')
            set(pl.h_brain, 'Visible', 'off')
        end
    end

    if nargout == 0
        clear h_panel
    end
end
% function setPanel(pl, varargin)
% 
%     setPanel@Plot(pl, varargin{:})
%     
%     pl.h_axes = axes(pl.getPanel());
% end
% function h_axes = getAxes(pl)
%     % GET_AXES gets current axes
%     %
%     % H = GET_AXES(BS) returns a handle to the axes used to plot
%     % the brain surf.
%     %
%     % See also set_axes.
% 
%     h_axes = pl.h_axes;
% end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Basics
%%%% ¡code!
fig = figure();

pl = PlotBrainSurface('SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'));
pl.draw('Units', 'normalized', 'Position', [.1 .1 .8 .8]);

pl.set('FACECOLOR', [1 0 0 ])
pl.draw()

pl.set('BRAIN', false)
pl.draw()

% pbs.set_axes()
% h = pbs.get_axes();
% 
% pbs.brain()
% pbs.brain_off()
% pbs.brain_on()
% 
% pbs.brain_settings();
% 
% pbs.hold_on()
% pbs.hold_off()
% 
% pbs.grid_off()
% pbs.grid_on()
% 
% pbs.axis_off()
% pbs.axis_on()
% 
% pbs.axis_equal()
% 
% pbs.axis_tight()
% 
% pbs.view([45 45])
% 
% pbs.lighting('phong')
% pbs.material('shiny')
% pbs.camlight('left')
% pbs.shading('interp')
% pbs.colormap('jet')
% 
% close(gcf)
% close(gcf)

close(fig)