% test PlotBrainSurf

% Test 1: Basic Functions
% 
% bs = PlotBrainSurf('BrainSurfaceType', 'BrainMesh_Cerebellum.nv');
% 
% bs.brain();
% bs.axis_equal();
% bs.view(PlotBrainSurf.VIEW_3D);
% bs.update_light();

assert(ischar(bs.tostring()), ...
	[BRAPH2.STR ':' class(bs) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainRegion.copy() does not work.')

% Test 2: Change default properties

bs = PlotBrainSurf('BrainSurfaceType', 'BrainMesh_ICBM152.nv', 'BrainSurfaceLighting', 'gouraud', 'BrainSurfaceMaterial', 'metal', 'BrainSurfaceCamLight', 'right');
bs.brain();
bs.axis_equal();
bs.view(PlotBrainSurf.VIEW_3D);
bs.update_light();
bs.brain_settings()
