%TEST_BRAPH2 
% This script runs all the unit tests for BRAPH2.

close all
clear all %#ok<CLALL>

%% Timer start
time_start = tic;

%% Identifies test directories
braph2_dir = fileparts(which('braph2'));

directories_to_test = { ...
    [braph2_dir filesep 'src' filesep 'util'] ...
    [braph2_dir filesep 'src' filesep 'ds'] ...
    [braph2_dir filesep 'src' filesep 'atlas'] ... 
    [braph2_dir filesep 'src' filesep 'gt'] ...
    [braph2_dir filesep 'src' filesep 'cohort'] ...
    [braph2_dir filesep 'src' filesep 'analysis'] ...
    [braph2_dir filesep 'src' filesep 'gui'] ...
    [braph2_dir filesep 'brainsurfs'] ...
    [braph2_dir filesep 'graphs'] ...
    [braph2_dir filesep 'measures'] ...
    [braph2_dir filesep 'neuralnetworks'] ...
    };

pipelines_dir = [fileparts(which('braph2')) filesep 'pipelines'];

addpath(pipelines_dir)
pipelines_dir_list = dir(pipelines_dir); % get the folder contents
pipelines_dir_list = pipelines_dir_list([pipelines_dir_list(:).isdir] == 1); % remove all files (isdir property is 0)
pipelines_dir_list = pipelines_dir_list(~ismember({pipelines_dir_list(:).name}, {'.', '..'})); % remove '.' and '..'
for i = 1:1:length(pipelines_dir_list)
    directories_to_test{end + 1} = [pipelines_dir filesep pipelines_dir_list(i).name]; %#ok<SAGROW>
end

clear braph2_dir pipelines_dir pipelines_dir_list i

%% Runs tests
global BRAPH2_IS_TESTING
BRAPH2_IS_TESTING = true; %#ok<NASGU>
results = runtests(directories_to_test, 'UseParallel', BRAPH2.TEST_PARALLEL);
BRAPH2_IS_TESTING = false;
clear BRAPH2_IS_TESTING

%% Shows test results
results_table = table(results) %#ok<NOPTS>

if all([results(:).Passed])
    disp('*** All good! ***')
else
    disp('*** Something went wrong! ***')
    failed_results_table = table(results([results(:).Failed])) %#ok<NOPTS>
end

%% Timer end
time_end = toc(time_start);

disp(['The test has taken ' int2str(time_end) '.' int2str(mod(time_end, 1) * 10) 's'])