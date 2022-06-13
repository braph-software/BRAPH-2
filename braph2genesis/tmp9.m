close all
delete(findall(0, 'type', 'figure'))
clear all
clc

global BRAPH2_IS_TESTING
BRAPH2_IS_TESTING = true;

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

el_class = 'SubjectCON';
delete([fileparts(which('braph2')) '/pipelines/connectivity/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
create_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
create_test_Element([fileparts(which('braph2genesis')) '/pipelines/connectivity/_' el_class '.gen.m'], [fileparts(which('braph2')) '/pipelines/connectivity'])
test_code = ['test_' el_class]
eval(test_code)
