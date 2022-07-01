% file = 'MultigraphBUT.layout'
% load(file, '-mat')
% order = [order(1:3) NaN order(4:end)]
% title = {title{1:3} 'TEMPLATE' title{4:end}}
% save(file, 'order', 'title', '-mat')

%%
delete(findall(0, 'type', 'figure'))
close all
clear all
clc

% el_class = 'PFBrainAtlas';
% delete([fileparts(which('braph2')) '/src/atlas/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/atlas/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/atlas'])
% create_Element([fileparts(which('braph2genesis')) '/src/atlas/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/atlas'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/atlas/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/atlas'])
% % test_code = ['test_' el_class]
% % eval(test_code)

el_class = 'SettingsPPTable';
delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% test_code = ['test_' el_class]
% eval(test_code)

% el_class = 'SettingsText';
% delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'SettingsLine';
% delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'Measure';
% delete([fileparts(which('braph2')) '/src/gt/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% create_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'PFMeasure';
% delete([fileparts(which('braph2')) '/src/gt/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% create_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'PP_BrainRegion';
% delete([fileparts(which('braph2')) '/src/gt/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% create_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% % test_code = ['test_' el_class]
% % eval(test_code)

el_class = 'PFMeasureGU';
delete([fileparts(which('braph2')) '/src/gt/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
create_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% create_test_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% test_code = ['test_' el_class]
% eval(test_code)

% el_class = 'PFMeasureNU';
% delete([fileparts(which('braph2')) '/src/gt/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% create_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'PFMeasureBU';
% delete([fileparts(which('braph2')) '/src/gt/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% create_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'AnalyzeGroup_FUN_OMP_GA_WU';
% delete([fileparts(which('braph2')) '/pipelines/functional ordered_multiplex group_average/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/functional ordered_multiplex group_average/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional ordered_multiplex group_average'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/functional ordered_multiplex group_average/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional ordered_multiplex group_average'])
% % create_test_Element([fileparts(which('braph2genesis')) '/pipelines/functional ordered_multiplex group_average/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional ordered_multiplex group_average'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'AnalyzeGroup_FUN_MP_GA_WU';
% delete([fileparts(which('braph2')) '/pipelines/functional multiplex group_average/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/functional multiplex group_average/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional multiplex group_average'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/functional multiplex group_average/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional multiplex group_average'])
% % create_test_Element([fileparts(which('braph2genesis')) '/pipelines/functional multiplex group_average/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional multiplex group_average'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'MultigraphBUT';
% delete([fileparts(which('braph2')) '/graphs/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% create_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% % create_test_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% % test_code = ['test_' el_class]
% % eval(test_code)
% eval(['GUIElement(''PE'', ' el_class '()).draw()'])

% el_class = 'AnalyzeGroup_ST_MP_BUD';
% delete([fileparts(which('braph2')) '/pipelines/structural multiplex/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/structural multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/structural multiplex'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/structural multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/structural multiplex'])
% % create_test_Element([fileparts(which('braph2genesis')) '/pipelines/structural multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/structural multiplex'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'AnalyzeGroup_ST_MP_BUT';
% delete([fileparts(which('braph2')) '/pipelines/structural multiplex/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/structural multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/structural multiplex'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/structural multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/structural multiplex'])
% % create_test_Element([fileparts(which('braph2genesis')) '/pipelines/structural multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/structural multiplex'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'ComparisonGroup';
% delete([fileparts(which('braph2')) '/src/analysis/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'CompareGroup';
% delete([fileparts(which('braph2')) '/src/analysis/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'PPCompareGroup_CpDict';
% delete([fileparts(which('braph2')) '/src/analysis/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'AnalyzeGroup';
% delete([fileparts(which('braph2')) '/src/analysis/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'Measure';
% delete([fileparts(which('braph2')) '/src/gt/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% create_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'GUIElement';
% delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'PPAnalyzeGroup_G';
% delete([fileparts(which('braph2')) '/src/analysis/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'Graph';
% delete([fileparts(which('braph2')) '/src/gt/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% create_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/gt/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gt'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'GraphWU';
% delete([fileparts(which('braph2')) '/graphs/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% create_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% % create_test_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'MultigraphBUD';
% delete([fileparts(which('braph2')) '/graphs/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% create_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% % create_test_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'AnalyzeGroup_ST_BUD';
% delete([fileparts(which('braph2')) '/pipelines/structural/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/structural/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/structural'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/structural/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/structural'])
% % create_test_Element([fileparts(which('braph2genesis')) '/pipelines/structural/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/structural'])
% % test_code = ['test_' el_class]
% % eval(test_code)

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

%% 
% GUIElement('PE', Pipeline()).draw

%% 
% % pip_ST_WU = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_a_ST_WU.b2']);
% pip_ST_WU = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_a_ST_WU calc.b2']);
% gui_ST_WU = GUIElement('PE', pip_ST_WU);
% f_ST_WU = gui_ST_WU.draw();

%%
% pip_ST_BUD = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_a_ST_BUD.b2']);
% pip_ST_BUD = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_a_ST_BUD calc.b2']);
pip_ST_BUD = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_a_ST_BUD.b2']);
gui_ST_BUD = GUIElement('PE', pip_ST_BUD);
f_ST_BUD = gui_ST_BUD.draw();

%%
% % pip_ST_BUT = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_a_ST_BUT.b2']);
% pip_ST_BUT = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_a_ST_BUT calc.b2']);
% gui_ST_BUT = GUIElement('PE', pip_ST_BUT);
% f_ST_BUT = gui_ST_BUT.draw();

%%
% pip_ST_BUD = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_c_ST_BUD calc.b2']);
% ba = pip_ST_BUD.get('PS_DICT').getItem(1).get('PC_DICT').getItem(1).get('EL');
% gr1 = pip_ST_BUD.get('PS_DICT').getItem(2).get('PC_DICT').getItem(1).get('EL');
% gr2 = pip_ST_BUD.get('PS_DICT').getItem(2).get('PC_DICT').getItem(2).get('EL');
% a_BUD1 = pip_ST_BUD.get('PS_DICT').getItem(3).get('PC_DICT').getItem(1).get('EL');
% a_BUD2 = pip_ST_BUD.get('PS_DICT').getItem(4).get('PC_DICT').getItem(1).get('EL');
% c_BUD = CompareGroup('P', 10, 'A1', a_BUD1, 'A2', a_BUD2, 'MEMORIZE', true);
% c_BUD.getComparison('Degree').get('DIFF')

%% 
% pip_ST_MP_WU = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_c_ST_MP_WU.b2']);
% gui_ST_MP_WU = GUIElement('PE', pip_ST_MP_WU);
% f_ST_MP_WU = gui_ST_MP_WU.draw();

%% 
% pip_ST_MP_BUD = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_c_ST_MP_BUD.b2']);
% gui_ST_MP_BUD = GUIElement('PE', pip_ST_MP_BUD);
% f_ST_MP_BUD = gui_ST_MP_BUD.draw();

%% 
% pip_ST_MP_BUT = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_c_ST_MP_BUT.b2']);
% gui_ST_MP_BUT = GUIElement('PE', pip_ST_MP_BUT);
% f_ST_MP_BUT = gui_ST_MP_BUT.draw();

%% 
% pip_CON_GA_WU = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_a_CON_GA_WU.b2']);
% gui_CON_GA_WU = GUIElement('PE', pip_CON_GA_WU);
% f_CON_GA_WU = gui_CON_GA_WU.draw();

%% 
% pip_FUN_GA_WU = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_a_FUN_GA_WU.b2']);
% gui_FUN_GA_WU = GUIElement('PE', pip_FUN_GA_WU);
% f_FUN_GA_WU = gui_FUN_GA_WU.draw();
