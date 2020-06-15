% test PlotBrainAtlas

br1 = BrainRegion('BR ID1', 'brain region label 1', 'brain region notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR ID2', 'brain region label 2', 'brain region notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR ID3', 'brain region label 3', 'brain region notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR ID4', 'brain region label 4', 'brain region notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR ID5', 'brain region label 5', 'brain region notes 5', 5, 5.5, 5.55);

atlas = BrainAtlas('BA ID', 'Brain Atlas Label', 'Brain atlas notes', 'BrainMesh_Cerebellum.nv', {br1, br2, br3, br4, br5});

%% Test 1: Basic use
ba = PlotBrainAtlas(atlas);
ba.hold_on()
ba.view(PlotBrainSurf.VIEW_3D)
ba.axis_equal()

ba.br_syms([], ...
    'Marker', ['o', '<', '>', 'p', 's'], ...
    'MarkerEdgeColor', 'r', ...
    'MarkerFaceColor', 'k', ...
    'Size', [10:10:50])
ba.br_syms_settings()
ba.br_syms_off()

ba.br_sphs([], ...
    'EdgeColor', 'k', ...
    'EdgeAlpha', [.2:.2:1], ...
    'FaceColor', 'r', ...    
    'FaceAlpha', [1:-.2:.2], ...    
    'R', [.2:.2:1])
ba.br_sphs_settings()


% %% Test 1: Basic Functions
% ba = PlotBrainAtlas(atlas);
% ba.set_axes();
% ba.hold_on();
% ba.view(PlotBrainAtlas.VIEW_3D);
% 
% assert(~isempty(ba), ...
%     [BRAPH2.STR ':' class(ba) ':' BRAPH2.WRONG_OUTPUT], ...
%     'PlotBrainAtlas does not work.')
% 
% close(gcf)
% 
% %% Test 2: Symbols
% ba = PlotBrainAtlas(atlas);
% h = ba.set_axes();
% ba.hold_on();
% ba.view(PlotBrainAtlas.VIEW_3D);
% ba.br_syms()
% ba.br_syms_on()
% 
% ba.br_syms_settings([], ...
%     'FigPosition', [.1 .2 .4 .4], ...
%     'FigColor', [.95 .95 .95], ...
%     'FigTitle','PlotBrainSurf - Symbols' ...
%     )
% 
% close(gcf)
% 
% %% Test 3: Spheres
% ba = PlotBrainAtlas(atlas);
% h = ba.set_axes();
% ba.hold_on();
% ba.view(PlotBrainAtlas.VIEW_3D);
% ba.br_sphs()
% ba.br_sphs_on()
% 
% ba.br_sphs_settings([], ...
%     'FigPosition',[.2 .3 .4 .4], ...
%     'FigColor', [.95 .95 .95], ...
%     'FigTitle','PlotBrainSurf - Spheres' ...
%     )
% 
% close(gcf)
% 
% %% Test 4: Labels
% ba = PlotBrainAtlas(atlas);
% h = ba.set_axes();
% ba.hold_on();
% ba.view(PlotBrainAtlas.VIEW_3D);
% ba.br_labs()
% ba.br_labs_on()
% 
% ba.br_labs_settings([], ...
%     'FigPosition',[.3 .4 .4 .4], ...
%     'FigColor', [.95 .95 .95], ...
%     'FigTitle','PlotBrainSurf - Labels' ...
%     )
% 
% close(gcf)
% 
% %% Test 5: Distance
% file = [fileparts(which('test_braph2')) filesep 'desikan_atlas2.txt'];
% atlas = BrainAtlas.load_from_txt('File', file);
% 
% ba = PlotBrainAtlas(atlas);
% axes = ba.set_axes();
% ba.hold_on();
% ba.view(PlotBrainAtlas.VIEW_3D);
% ba.brain();
% ba.br_sphs()
% ba.br_sphs_on()
% 
% ba.distanceMapOn([1 10 29]);  % select the first
% 
% close(gcf)