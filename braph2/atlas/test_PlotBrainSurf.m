% test PlotBrainSurf

%% Test 1: Basic Functions
bs = PlotBrainSurf('BrainMesh_Cerebellum.nv');
bs.brain();

assert(ischar(bs.tostring()), ...
	[BRAPH2.STR ':' class(bs) ':' BRAPH2.WRONG_OUTPUT], ...
    'PlotBrainSurf.tostring() does not work.')
assert(ischar(bs.getName()), ...
	[BRAPH2.STR ':' class(bs) ':' BRAPH2.WRONG_OUTPUT], ...
    'PlotBrainSurf.getName() does not work.')

close(gcf)

%% Test 2: Change default properties
bs = PlotBrainSurf('BrainMesh_ICBM152.nv', 'PlotBrainSurf.Lighting', 'gouraud', 'PlotBrainSurf.Material', 'metal', 'PlotBrainSurf.CamLight', 'right');
handle = bs.brain();
bs.axis_equal();
bs.view(PlotBrainSurf.VIEW_3D);
bs.update_light();

bs2 = PlotBrainSurf('ferret.nv', 'PlotBrainSurf.Lighting', 'gouraud', 'PlotBrainSurf.Material', 'metal', 'PlotBrainSurf.CamLight', 'right');
handle = bs2.brain();
bs2.axis_equal();
bs2.view(PlotBrainSurf.VIEW_3D);
bs2.update_light();

assert(~isempty(bs2), ...
  [BRAPH2.STR ':' class(bs2) ':' BRAPH2.WRONG_OUTPUT], ...
  'PlotBrainSurf.getName() does not work.')
assert(~isempty(handle), ...
    [BRAPH2.STR ':' class(bs) ':' BRAPH2.WRONG_OUTPUT], ...
    'PlotBrainSurf.brain() does not work')    

close(gcf)

%% Test 3: Static Functions
bs = PlotBrainSurf.loadBrainSurface('BrainSurface',  'BrainMesh_ICBM152.nv');
assert(~isempty(bs), ...
	[BRAPH2.STR ':' class(bs) ':' BRAPH2.WRONG_OUTPUT], ...
    'PlotBrainSurf.loadBrainSurface() does not work.')