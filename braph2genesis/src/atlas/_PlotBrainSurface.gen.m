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

%% ¡methods!
function setPanel(pl, varargin)

    setPanel@Plot(pl, varargin{:})
    
    pl.h_axes = axes(pl.getPanel());
end
function h_axes = getAxes(pl)
    % GET_AXES gets current axes
    %
    % H = GET_AXES(BS) returns a handle to the axes used to plot
    % the brain surf.
    %
    % See also set_axes.

    h_axes = pl.h_axes;
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Basics
%%%% ¡code!
fig = figure();

pl = PlotBrainSurface('SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'));
pl.setPanel(uipanel('Units', 'normalized', 'Position', [.1 .1 .8 .8]));
h = pl.getPanel();

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