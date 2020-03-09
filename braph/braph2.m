format long

dir = fileparts(which('braph2'));

addpath(dir)
addpath([dir filesep 'util'])
addpath([dir filesep 'graph'])
addpath([dir filesep 'graph' filesep 'graphs'])
addpath([dir filesep 'graph' filesep 'measures'])
addpath([dir filesep 'atlas'])
addpath([dir filesep 'cohort'])
addpath([dir filesep 'cohort' filesep 'datas'])
addpath([dir filesep 'cohort' filesep 'subjects'])
addpath([dir filesep 'analysis'])
addpath([dir filesep 'analysis' filesep 'analyses'])
addpath([dir filesep 'test'])

clear dir