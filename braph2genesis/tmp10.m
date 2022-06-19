close all
delete(findall(0, 'type', 'figure'))
clear all
clc

% el_class = 'MultigraphBUT';
% delete([fileparts(which('braph2')) '/graphs/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% create_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% % create_test_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'AnalyzeGroup_ST_BUT';
% delete([fileparts(which('braph2')) '/pipelines/structural/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/structural/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/structural'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/structural/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/structural'])
% % create_test_Element([fileparts(which('braph2genesis')) '/pipelines/structural/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/structural'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'PanelPropRVectorSmart';
% delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'AnalyzeGroup_ST_BUD';
% delete([fileparts(which('braph2')) '/pipelines/structural/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/structural/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/structural'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/structural/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/structural'])
% % create_test_Element([fileparts(which('braph2genesis')) '/pipelines/structural/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/structural'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'MultigraphBUD';
% delete([fileparts(which('braph2')) '/graphs/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% create_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% % create_test_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'GraphWU';
% delete([fileparts(which('braph2')) '/graphs/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% create_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% % create_test_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'PanelPropMatrix';
% delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'PanelPropCell';
% delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'AnalyzeGroup';
% delete([fileparts(which('braph2')) '/src/analysis/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'PPAnalyzeGroup_G';
% delete([fileparts(which('braph2')) '/src/analysis/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'PanelPropIDictTable';
% delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'PPPipeline_PSDict';
% delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% % pip = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_ST_WU.b2']);
% pip = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_ST_BUD.b2']);
% % pip = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_ST_BUT.b2']);
% gui = GUIElement('PE', pip);
% f = gui.draw();
% pip.get('PS_DICT').getItem(3).get('PC_DICT').getItem(1).get('EL').get('G').getMeasure('Degree');
% pip.get('PS_DICT').getItem(3).get('PC_DICT').getItem(1).get('EL').get('G').getMeasure('DegreeAv');
% pip.get('PS_DICT').getItem(3).get('PC_DICT').getItem(1).get('EL').get('G').getMeasure('Distance');
% pip.get('PS_DICT').getItem(3).get('PC_DICT').getItem(1).get('EL').get('G').getr('M_DICT')

% a = AnalyzeGroup_ST_BUD();
% gui = GUIElement('PE', a);
% f = gui.draw();

pip_ST_WU = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_ST_WU.b2']);
gui_ST_WU = GUIElement('PE', pip_ST_WU);
f_ST_WU = gui_ST_WU.draw();

pip_ST_BUD = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_ST_BUD.b2']);
gui_ST_BUD = GUIElement('PE', pip_ST_BUD);
f_ST_BUD = gui_ST_BUD.draw();

pip_ST_BUT = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_ST_BUT.b2']);
gui_ST_BUT = GUIElement('PE', pip_ST_BUT);
f_ST_BUT = gui_ST_BUT.draw();


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