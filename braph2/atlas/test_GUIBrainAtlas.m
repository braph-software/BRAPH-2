% test GUIBrainAtlas

%% Test 1: Basic
file = [fileparts(which('test_braph2')) filesep 'desikan_atlas.txt'];
atlas = BrainAtlas.load_from_txt('File', file);
atlas.setID('BA ID')
atlas.setLabel('BA name')
atlas.setNotes('Brain atlas notes.')

GUIBrainAtlas(atlas)
set(gcf, 'CloseRequestFcn', 'closereq')

close(gcf)