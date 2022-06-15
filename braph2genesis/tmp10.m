close all
delete(findall(0, 'type', 'figure'))
clear all
clc

el_class = 'PanelPropCell';
delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% test_code = ['test_' el_class]
% eval(test_code)

et = ETA( ...
    'PROP_CELL_M', {
    rand(3) rand(3, 2) []
    rand(2, 3) rand(2) rand(2, 4)
    [] rand(4, 2) rand(4)
    }, ...
    'PROP_CELL_P', {}, ...
    'PROP_CELL_D', {}, ...
    'PROP_CELL_F', {}, ...
    'PROP_CELL_G', {} ...
    );
gui = GUIElement('PE', et);
f = gui.draw();