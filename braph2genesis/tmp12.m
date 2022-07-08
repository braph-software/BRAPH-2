%%
delete(findall(0, 'type', 'figure'))
close all
clear all
clc

el_class = 'ComparisonEnsemble';
delete([fileparts(which('braph2')) '/src/analysis/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% create_test_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% test_code = ['test_' el_class]
% eval(test_code)
example_FUN_WU
example_FUN_BUD
example_FUN_BUT
example_CON_WU
example_CON_BUD
example_CON_BUT
example_FUN_MP_WU
example_FUN_MP_BUD
example_FUN_MP_BUT
example_FUN_OMP_WU
example_CON_FUN_MP_WU
example_CON_FUN_MP_BUD
example_CON_FUN_MP_BUT

% el_class = 'MultiplexBUD';
% delete([fileparts(which('braph2')) '/graphs/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% create_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% % create_test_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% % test_code = ['test_' el_class]
% % eval(test_code)
% % example_FUN_MP_BUD

% el_class = 'MultiplexBUT';
% delete([fileparts(which('braph2')) '/graphs/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% create_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% % create_test_Element([fileparts(which('braph2genesis')) '/graphs/_' el_class '.gen.m'], [fileparts(which('braph2')) '/graphs'])
% % test_code = ['test_' el_class]
% % eval(test_code)
% example_FUN_MP_BUT

% el_class = 'MeasureEnsemble';
% delete([fileparts(which('braph2')) '/src/analysis/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'PFMeasureEnsemble';
% delete([fileparts(which('braph2')) '/src/analysis/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'PFMeasureEnsembleGU';
% delete([fileparts(which('braph2')) '/src/analysis/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'PFMeasureEnsembleNU';
% delete([fileparts(which('braph2')) '/src/analysis/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'PFMeasureEnsembleBU';
% delete([fileparts(which('braph2')) '/src/analysis/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'AnalyzeEnsemble';
% delete([fileparts(which('braph2')) '/src/analysis/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'PPAnalyzeEnsemble_MeDict';
% delete([fileparts(which('braph2')) '/src/analysis/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'AnalyzeEnsemble_CON_WU';
% delete([fileparts(which('braph2')) '/pipelines/connectivity/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
% % create_test_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'AnalyzeEnsemble_CON_BUD';
% delete([fileparts(which('braph2')) '/pipelines/connectivity/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
% % create_test_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'AnalyzeEnsemble_CON_BUT';
% delete([fileparts(which('braph2')) '/pipelines/connectivity/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
% % create_test_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'AnalyzeEnsemble_FUN_MP_BUD';
% delete([fileparts(which('braph2')) '/pipelines/functional multiplex/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/functional multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional multiplex'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/functional multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional multiplex'])
% % create_test_Element([fileparts(which('braph2genesis')) '/pipelines/functional multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional multiplex'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'AnalyzeEnsemble_FUN_MP_BUT';
% delete([fileparts(which('braph2')) '/pipelines/functional multiplex/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/functional multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional multiplex'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/functional multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional multiplex'])
% % create_test_Element([fileparts(which('braph2genesis')) '/pipelines/functional multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional multiplex'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'AnalyzeEnsemble_CON_FUN_MP_BUD';
% delete([fileparts(which('braph2')) '/pipelines/connectivity-functional multiplex/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity-functional multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity-functional multiplex'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity-functional multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity-functional multiplex'])
% create_test_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity-functional multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity-functional multiplex'])
% test_code = ['test_' el_class]
% global BRAPH2_IS_TESTING, BRAPH2_IS_TESTING = true, braph2_testing
% eval(test_code)

% el_class = 'AnalyzeEnsemble_CON_FUN_MP_BUT';
% delete([fileparts(which('braph2')) '/pipelines/connectivity-functional multiplex/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity-functional multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity-functional multiplex'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity-functional multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity-functional multiplex'])
% create_test_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity-functional multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity-functional multiplex'])
% test_code = ['test_' el_class]
% global BRAPH2_IS_TESTING, BRAPH2_IS_TESTING = true, braph2_testing
% eval(test_code)

% el_class = 'AnalyzeEnsemble_FUN_MP_BUD';
% delete([fileparts(which('braph2')) '/pipelines/functional multiplex/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/functional multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional multiplex'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/functional multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional multiplex'])
% create_test_Element([fileparts(which('braph2genesis')) '/pipelines/functional multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional multiplex'])
% test_code = ['test_' el_class]
% global BRAPH2_IS_TESTING, BRAPH2_IS_TESTING = true, braph2_testing
% eval(test_code)

% el_class = 'AnalyzeEnsemble_FUN_MP_BUT';
% delete([fileparts(which('braph2')) '/pipelines/functional multiplex/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/functional multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional multiplex'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/functional multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional multiplex'])
% create_test_Element([fileparts(which('braph2genesis')) '/pipelines/functional multiplex/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional multiplex'])
% test_code = ['test_' el_class]
% global BRAPH2_IS_TESTING, BRAPH2_IS_TESTING = true, braph2_testing
% eval(test_code)

%% 
% GUIElement('PE', Pipeline()).draw

%%
% pip_CON_WU = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_a_CON_WU.b2']);
% % pip_CON_WU = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_c_CON_WU.b2']);
% gui_CON_WU = GUIElement('PE', pip_CON_WU);
% f_CON_WU = gui_CON_WU.draw();

% pip_CON_BUD = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_a_CON_BUD.b2']);
% % pip_CON_BUD = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_c_CON_BUD.b2']);
% gui_CON_BUD = GUIElement('PE', pip_CON_BUD);
% f_CON_BUD = gui_CON_BUD.draw();

% pip_CON_BUT = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_a_CON_BUT.b2']);
% % pip_CON_BUT = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_c_CON_BUT.b2']);
% gui_CON_BUT = GUIElement('PE', pip_CON_BUT);
% f_CON_BUT = gui_CON_BUT.draw();

% pip_FUN_MP_BUD = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_a_FUN_MP_BUD.b2']);
% gui_FUN_MP_BUD = GUIElement('PE', pip_FUN_MP_BUD);
% f_FUN_MP_BUD = gui_FUN_MP_BUD.draw();
