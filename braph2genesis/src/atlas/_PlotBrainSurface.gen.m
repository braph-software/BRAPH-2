%% ¡header!
PlotBrainSurface < Plot (pl, plot brain surface) is a plot of a brain surfce.

%%% ¡description!
...

%%% ¡seealso!
Plot, BrainSurface

%% ¡properties!
h_axes % handle for the axes

%% ¡props_update!

%%% ¡prop!
PLOT (result, empty) is an empty property to plot.
%%%% ¡calculate!
value = calculateValue@Plot(pl, prop);

%% ¡props!

%%% ¡prop!
SURF (metadata, item) is the brain surface to be plotted.
%%%% ¡settings!
'BrainSurface'

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Basics
%%%% ¡code!
pl = PlotBrainSurface('SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'));

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