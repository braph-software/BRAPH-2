% BRAPH2 - BRrain Analysis using graPH theory version 2.0
%
% This script loads all BRAPH2 packages:
%   <a href="matlab:help util     ">util</a>        general utility tools
%   <a href="matlab:help graph    ">graph</a>       graphs and measures
%   <a href="matlab:help atlas    ">atlas</a>       brain atlas
%   <a href="matlab:help cohort   ">cohort</a>      subjects and cohort
%   <a href="matlab:help analysis ">analysis</a>	analysis tools
%   <a href="matlab:help workflows">workflows</a>	workflows
%   <a href="matlab:help test     ">test</a>        unit test
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
addpath([directory filesep 'atlas' filesep 'brainsurfs'])
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