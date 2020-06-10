% test PlotBrainSurf

%% Test 1: Basic use
bs = PlotBrainSurf('BrainMesh_ICBM152.nv');

bs.set_axes()
h = bs.get_axes();

bs.brain()
bs.brain_off()
bs.brain_on()

bs.brain_settings();

bs.hold_on()
bs.hold_off()

bs.grid_off()
bs.grid_on()

bs.axis_off()
bs.axis_on()

bs.axis_equal()

bs.axis_tight()

bs.view([45 45])

bs.lighting('phong')
bs.material('shiny')
bs.camlight('left')
bs.shading('interp')
bs.colormap('jet')

% close(gcf)
% close(gcf)