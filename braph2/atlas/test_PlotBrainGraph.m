% test PlotBrainGraph

atlas_file = [fileparts(which('example_workflow_ST_WU.m')) filesep() 'example data ST (MRI)' filesep() 'desikan_atlas.xlsx'];
atlas = BrainAtlas.load_from_xls('File', atlas_file);

%% Init 
bg = PlotBrainGraph(atlas);
bg.link_edges();