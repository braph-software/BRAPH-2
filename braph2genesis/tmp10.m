close all
delete(findall(0, 'type', 'figure'))
clear all
clc

%% PanelPropCell

% el_class = 'PanelPropCell';
% delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% et = ETA( ...
%     'PROP_CELL_M', {}, ...
%     'PROP_CELL_P', {
%         [1 1; 1 1] [1 2; 1 2] [1 3; 1 3]
%         [2 1; 2 1] [2 2; 2 2] [2 3; 2 3]
%         [3 1; 3 1] [3 2; 3 2] [3 3; 3 3]
%         }, ...
%     'PROP_CELL_D', {
%         [] [1] [1 2] [1 3]
%         [] [1; 1] [1 2; 1 2] [1 3; 1 3]
%         }, ...
%     'PROP_CELL_F', {}, ...
%     'PROP_CELL_G', {
%         rand(3) rand(3, 2) []
%         rand(2, 3) rand(2) rand(2, 4)
%         [] rand(4, 2) rand(4)
%         } ...
%     );
% gui = GUIElement('PE', et);
% f = gui.draw();