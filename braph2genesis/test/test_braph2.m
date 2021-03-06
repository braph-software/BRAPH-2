%TEST_BRAPH2 
% This script runs all the unit tests for BRAPH2.

close all
clear all %#ok<CLALL>

%% Identifies test directories
braph2_dir = fileparts(which('braph2'));

directories_to_test = { ...
    [braph2_dir filesep 'src' filesep 'util'] ...
    [braph2_dir filesep 'src' filesep 'ds'] ...
    [braph2_dir filesep 'src' filesep 'atlas'] ... 
    [braph2_dir filesep 'src' filesep 'cohort'] ...
    [braph2_dir filesep 'src' filesep 'gt'] ...
    [braph2_dir filesep 'src' filesep 'analysis'] ...
    [braph2_dir filesep 'src' filesep 'gui'] ...
    [braph2_dir filesep 'brainsurfs'] ...
    [braph2_dir filesep 'graphs'] ...
    [braph2_dir filesep 'measures'] ...
    };

workflows_dir = [fileparts(which('braph2')) filesep 'workflows'];

addpath(workflows_dir)
workflows_dir_list = dir(workflows_dir); % get the folder contents
workflows_dir_list = workflows_dir_list([workflows_dir_list(:).isdir] == 1); % remove all files (isdir property is 0)
workflows_dir_list = workflows_dir_list(~ismember({workflows_dir_list(:).name}, {'.', '..'})); % remove '.' and '..'
for i = 1:1:length(workflows_dir_list)
    directories_to_test{end + 1} = [workflows_dir filesep workflows_dir_list(i).name]; %#ok<SAGROW>
end

clear braph2_dir workflows_dir workflows_dir_list i

%% Runs tests
results = runtests(directories_to_test, 'UseParallel', true);

%% Shows test results
results_table = table(results) %#ok<NOPTS>

if all([results(:).Passed])
    disp('*** All good! ***')
else
    disp('*** Something went wrong! ***')
    failed_results_table = table(results([results(:).Failed])) %#ok<NOPTS>
end