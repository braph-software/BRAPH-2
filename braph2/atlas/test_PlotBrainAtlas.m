% test PlotBrainAtlas

br1 = BrainRegion('BR ID1', 'brain region label 1', 'brain region notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR ID2', 'brain region label 2', 'brain region notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR ID3', 'brain region label 3', 'brain region notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR ID4', 'brain region label 4', 'brain region notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR ID5', 'brain region label 5', 'brain region notes 5', 5, 5.5, 5.55);

atlas = BrainAtlas('BA ID', 'Brain Atlas Label', 'Brain atlas notes', 'BrainMesh_Cerebellum.nv', {br1, br2, br3, br4, br5});

%% Test 1: Basic use
ba = PlotBrainAtlas(atlas);

figure
ba.hold_on()
ba.view(PlotBrainSurf.VIEW_3D)
ba.axis_equal()

ba.br_syms([1 2 3  5], ...
    'Marker', ['o', '<', 'p', 's'], ...
    'MarkerEdgeColor', 'r', ...
    'MarkerFaceColor', 'k', ...
    'Size', [10 20 30 50])
ba.br_syms_settings()
% ba.br_syms_off()

ba.br_sphs([2 3 4 5], ...
    'EdgeColor', 'k', ...
    'EdgeAlpha', [.1 .5 .7 1], ...
    'FaceColor', 'r', ...    
    'FaceAlpha', [1 .7 .5 .1], ...    
    'R', [.2 .5 .7 1])
ba.br_sphs_settings()
% ba.br_sphs_off()

% ba.br_ids([2 4], ...
%     'FontSize', [20 40], ...
%     'FontName', 'Arial', ...
%     'Color', 'r', ...
%     'interpreter', {'Latex', 'Tex'})
% ba.br_ids_settings()
% % ba.br_ids_off()

ba.br_labs([], ...
    'FontSize', 5, ...
    'FontName', 'Times', ...
    'Color', 'b', ...
    'interpreter', 'none')
ba.br_labs([1 3 5], ...
    'FontSize', [10:20:50], ...
    'FontName', {'Arial', 'Times', 'Helvetica'}, ...
    'Color', 'r', ...
    'interpreter', {'Latex', 'Tex', 'none'})
ba.br_labs_settings()
% ba.br_labs_off()

% close(gcf)
% close(gcf)
% close(gcf)
% close(gcf)
% close(gcf)

%% Test 2: Distance Map
atlas = BrainAtlas.load_from_txt('File', 'desikan_atlas.txt');
ba = PlotBrainAtlas(atlas);

figure
ba.hold_on();
ba.view(PlotBrainAtlas.VIEW_3D);
ba.br_syms([], 'Size', 10, 'Color', 'r')
ba.brain('Colormap', 'summer')
ba.distance_map_on([14 50 68]);
% ba.distance_map_off()

% close(gcf)