% test PlotBrainSurf

%% Test 1: Basic use
bs = BrainSurface('ID', 'Human_ICBM152.nv');
pbs = PlotBrainSurf(bs);

pbs.set_axes()
h = pbs.get_axes();

pbs.brain()
pbs.brain_off()
pbs.brain_on()

pbs.brain_settings();

pbs.hold_on()
pbs.hold_off()

pbs.grid_off()
pbs.grid_on()

pbs.axis_off()
pbs.axis_on()

pbs.axis_equal()

pbs.axis_tight()

pbs.view([45 45])

pbs.lighting('phong')
pbs.material('shiny')
pbs.camlight('left')
pbs.shading('interp')
pbs.colormap('jet')

close(gcf)
close(gcf)