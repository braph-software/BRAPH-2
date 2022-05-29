close all
delete(findall(0, 'type', 'figure'))
clear all
clc

copydir([fileparts(which('braph2genesis')) '/src/ds'], [fileparts(which('braph2')) '/src/ds'])
disp('¡! copied ready files - ds')

el_class = 'PanelElement';
delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % test_code = ['test_' el_class]
% % eval(test_code)

pf1 = PFBrainSurface('SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'));
gui1 = GUIFig('PF', pf1, 'FILE', 'xxx sss', 'CLOSEREQ', false);
f1 = gui1.draw('Units', 'normalized', 'Position', [.1 .5 .4 .4]);

