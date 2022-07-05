%%
delete(findall(0, 'type', 'figure'))
close all
clear all
clc

el_class = 'AnalyzeEnsemble_CON_WU';
delete([fileparts(which('braph2')) '/pipelines/connectivity/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
% create_test_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
% test_code = ['test_' el_class]
% eval(test_code)

el_class = 'AnalyzeEnsemble_CON_BUD';
delete([fileparts(which('braph2')) '/pipelines/connectivity/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
% create_test_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
% test_code = ['test_' el_class]
% eval(test_code)

el_class = 'AnalyzeEnsemble_CON_BUT';
delete([fileparts(which('braph2')) '/pipelines/connectivity/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
% create_test_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
% test_code = ['test_' el_class]
% eval(test_code)

%% 
GUIElement('PE', Pipeline()).draw

%%
% pip_CON_WU = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_a_CON_WU.b2']);
% gui_CON_WU = GUIElement('PE', pip_CON_WU);
% f_CON_WU = gui_CON_WU.draw();

% pip_CON_BUD = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_a_CON_BUD.b2']);
% gui_CON_BUD = GUIElement('PE', pip_CON_BUD);
% f_CON_BUD = gui_CON_BUD.draw();

% pip_CON_BUT = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_a_CON_BUT.b2']);
% gui_CON_BUT = GUIElement('PE', pip_CON_BUT);
% f_CON_BUT = gui_CON_BUT.draw();
