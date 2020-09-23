% test PlotBrainGraph

atlas_file = [fileparts(which('example_workflow_ST_WU.m')) filesep() 'example data ST (MRI)' filesep() 'desikan_atlas.xlsx'];
atlas = BrainAtlas.load_from_xls('File', atlas_file);

%% Init edges lines
bg = PlotBrainGraph(atlas);
figure
bg.hold_on()
bg.view(PlotBrainSurf.VIEW_3D)
bg.axis_equal()
bg.link_edges();
bg.link_edges_on();
bg.link_edges_settings();

close(gcf)
close(gcf)

% %% Edges arrows
% 
% bg = PlotBrainGraph(atlas);
% figure
% bg.hold_on()
% bg.view(PlotBrainSurf.VIEW_3D)
% bg.axis_equal()
% bg.arrow_edges();
% bg.arrow_edges_on();
% bg.arrow_edges_settings();
% 
% close(gcf)
% close(gcf)
% 
% %% Edges Cylinders
% 
% bg = PlotBrainGraph(atlas);
% figure
% bg.hold_on()
% bg.view(PlotBrainSurf.VIEW_3D)
% bg.axis_equal()
% bg.cylinder_edges();
% bg.cylinder_edges_on();
% bg.cylinder_edges_settings();
% 
% close(gcf)
% close(gcf)