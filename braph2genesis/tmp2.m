close all
delete(findall(0, 'type', 'figure'))
clear all
clc

el_class = 'GUI';
delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% test_code = ['test_' el_class]
% eval(test_code)

gui = GUI('MENUBAR', true, 'TOOLBAR', true);
f = gui.draw();
get(f, 'Position')
p = uipanel(f, 'Units', 'normalized', 'Position', [.05 .05 .90 .90]);

% et = ETA();
% gui = GUIElement('PE', et);
% f1 = gui.draw();
% f2 = gui.draw();
% close(f2)

% gui = GUIElement('PE', BRAPH2Constants);
% f = gui.draw();