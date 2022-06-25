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

el_class = 'CompareGroup';
delete([fileparts(which('braph2')) '/src/analysis/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% create_test_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% test_code = ['test_' el_class]
% eval(test_code)

el_class = 'PPCompareGroup_CpDict';
delete([fileparts(which('braph2')) '/src/analysis/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
create_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% create_test_Element([fileparts(which('braph2genesis')) '/src/analysis/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/analysis'])
% test_code = ['test_' el_class]
% eval(test_code)

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
pip_ST_BUD = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_c_ST_BUD calc.b2']);
gui_ST_BUD = GUIElement('PE', pip_ST_BUD);
f_ST_BUD = gui_ST_BUD.draw();

%%
% % pip_ST_BUT = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_a_ST_BUT.b2']);
% pip_ST_BUT = BRAPH2.load([fileparts(which('braph2genesis')) '/pip_a_ST_BUT calc.b2']);
% gui_ST_BUT = GUIElement('PE', pip_ST_BUT);
% f_ST_BUT = gui_ST_BUT.draw();