% BRAPH2 - BRrain Analysis using graPH theory version 2.0
%
% This script loads all packages of the BRAPH2.
%
% BRAPH2 packages
%   <a href="matlab:help util ">util</a>    - general utility functions
%   <a href="matlab:help test">test</a>    - braph2 unit test script
%   <a href="matlab:help graph">graph</a>   - graph analysis tools
%   <a href="matlab:help atlas">atlas</a>   - brain atlas
%

clc
format long

directory = fileparts(which('braph2'));

addpath(directory)
addpath([directory filesep 'util'])
addpath([directory filesep 'graph'])
addpath([directory filesep 'graph' filesep 'graphs'])
addpath([directory filesep 'graph' filesep 'measures'])
addpath([directory filesep 'atlas'])
addpath([directory filesep 'cohort'])
addpath([directory filesep 'cohort' filesep 'datas'])
addpath([directory filesep 'analysis'])
addpath([directory filesep 'test'])

addpath([directory filesep 'workflows'])
workflows_directories = dir([directory filesep 'workflows']);   % get the folder contents
workflows_directories = workflows_directories([workflows_directories(:).isdir] == 1);  % remove all files (isdir property is 0)
workflows_directories = workflows_directories(~ismember({workflows_directories(:).name}, {'.', '..'}));  % remove '.' and '..'
for i = 1:1:length(workflows_directories)
    addpath([directory filesep 'workflows' filesep workflows_directories(i).name])
end

clear directory workflows_directories i