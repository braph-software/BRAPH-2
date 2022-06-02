close all
delete(findall(0, 'type', 'figure'))
clear all
clc

el_class = 'PFBrainAtlas';
delete([fileparts(which('braph2')) '/src/atlas/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/src/atlas/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/atlas'])
create_Element([fileparts(which('braph2genesis')) '/src/atlas/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/atlas'])
% create_test_Element([fileparts(which('braph2genesis')) '/src/atlas/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/atlas'])
% test_code = ['test_' el_class]
% eval(test_code)

pf1 = PFBrainAtlas('SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'));
gui1 = GUIFig('PF', pf1, 'FILE', 'xxx sss', 'WAITBAR', true, 'CLOSEREQ', false);
f1 = gui1.draw('Units', 'normalized', 'Position', [.1 .5 .4 .4]);
