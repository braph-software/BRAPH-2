close all
delete(findall(0, 'type', 'figure'))
clear all
clc

el_class = 'Group';
delete([fileparts(which('braph2')) '/src/cohort/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/src/cohort/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/cohort'])
create_Element([fileparts(which('braph2genesis')) '/src/cohort/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/cohort'])
% create_test_Element([fileparts(which('braph2genesis')) '/src/cohort/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/cohort'])
% test_code = ['test_' el_class]
% eval(test_code)

% el_class = 'SubjectST';
% delete([fileparts(which('braph2')) '/pipelines/structural/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/structural/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/structural'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/structural/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/structural'])
% % create_test_Element([fileparts(which('braph2genesis')) '/pipelines/structural/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/structural'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'SubjectFUN';
% delete([fileparts(which('braph2')) '/pipelines/functional/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/functional/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/functional/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional'])
% % create_test_Element([fileparts(which('braph2genesis')) '/pipelines/functional/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/functional'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'SubjectCON';
% delete([fileparts(which('braph2')) '/pipelines/connectivity/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
% create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
% % create_test_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% % % sub1 = SubjectST('ID','id1', 'LABEL', 'label1', 'NOTES', 'notes1');
% % % sub2 = SubjectCON('ID','id2', 'LABEL', 'label2', 'NOTES', 'notes2');
% % % sub3 = SubjectFUN('ID','id3', 'LABEL', 'label3', 'NOTES', 'notes3');
% % % subject_dict = IndexedDictionary( ...
% % %     'id', 'subject_idict', ...
% % %     'it_class', 'Subject', ...
% % %     'it_key', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
% % %     'it_list', {sub1, sub2, sub3} ...
% % %     );
% % % group = Group('ID', 'id', 'LABEL', 'label', 'NOTES', 'notes', 'SUB_DICT', subject_dict);
% % % gui = GUIElement('PE', group, 'CLOSEREQ', false);
% % % f = gui.draw();

% % % im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('SubjectST')) filesep 'example data ST (MRI)' filesep 'desikan_atlas.xlsx']);
% % % ba = im_ba.get('BA');
% % % im_gr = ImporterGroupSubjectST_XLS( ...
% % %     'FILE', [fileparts(which('SubjectST')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'], ...
% % %     'BA', ba ...
% % %     );
% % % gr = im_gr.get('GR');
% % % gui = GUIElement('PE', gr, 'CLOSEREQ', false);
% % % f = gui.draw();

% % % im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('SubjectCON')) filesep 'example data CON (DTI)' filesep 'desikan_atlas.xlsx']);
% % % ba = im_ba.get('BA');
% % % im_gr = ImporterGroupSubjectCON_XLS( ...
% % %     'DIRECTORY', [fileparts(which('SubjectCON')) filesep 'example data CON (DTI)' filesep 'xls' filesep 'GroupName1'], ...
% % %     'BA', ba ...
% % %     );
% % % gr = im_gr.get('GR');
% % % gui = GUIElement('PE', gr, 'CLOSEREQ', false);
% % % f = gui.draw();

im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('SubjectFUN')) filesep 'example data FUN (fMRI)' filesep 'craddock_atlas.xlsx']);
ba = im_ba.get('BA');
im_gr = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectFUN')) filesep 'example data FUN (fMRI)' filesep 'xls' filesep 'GroupName1'], ...
    'BA', ba ...
    );
gr = im_gr.get('GR');
gui = GUIElement('PE', gr, 'CLOSEREQ', false);
f = gui.draw();
