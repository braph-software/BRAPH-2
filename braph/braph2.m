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

dir = fileparts(which('braph2'));

addpath(dir)
addpath([dir filesep 'util'])
addpath([dir filesep 'graph'])
addpath([dir filesep 'graph' filesep 'graphs'])
addpath([dir filesep 'graph' filesep 'measures'])
addpath([dir filesep 'atlas'])
% addpath([dir filesep 'cohort'])
% addpath([dir filesep 'cohort' filesep 'datas'])
% addpath([dir filesep 'cohort' filesep 'subjects'])
% addpath([dir filesep 'analysis'])
% addpath([dir filesep 'analysis' filesep 'analyses'])
% addpath([dir filesep 'analysis' filesep 'measurements'])
% addpath([dir filesep 'analysis' filesep 'comparisons'])
% addpath([dir filesep 'analysis' filesep 'randomcomparisons'])
addpath([dir filesep 'test'])

clear dir