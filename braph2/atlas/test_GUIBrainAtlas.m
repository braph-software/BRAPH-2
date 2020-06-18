% test GUIBrainAtlas

close all

%% Test 1: Basic
% atlas = BrainAtlas.load_from_txt('File', 'desikan_atlas.txt');
% atlas.setID('BA ID')
% atlas.setLabel('BA name')
% atlas.setNotes('Brain atlas notes.')
% 
% GUIBrainAtlas(atlas)
GUIBrainAtlas()
set(gcf, 'CloseRequestFcn', 'closereq')

% close(gcf)