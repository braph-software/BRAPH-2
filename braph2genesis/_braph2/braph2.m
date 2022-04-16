%BRAPH2 - BRrain Analysis using graPH theory version 2.0
% This script loads all packages necessary to use BRAPH2.
%
% BRAPH2 packages:
%  <a href="matlab:help src         ">src</a>           - software core
%  <a href="matlab:help brainsurfs  ">brainsurfs</a>    - brain surfaces
%  <a href="matlab:help graphs      ">graphs</a>        - graphs
%  <a href="matlab:help measures    ">measures</a>      - measures
%  <a href="matlab:help pipelines   ">pipelines</a>     - pipelines
%  <a href="matlab:help test        ">test</a>          - unit testing

src_dir = [fileparts(which('braph2')) filesep 'src'];
addpath(src_dir)
addpath([src_dir filesep 'util'])
addpath([src_dir filesep 'ds'])
addpath([src_dir filesep 'atlas'])
addpath([src_dir filesep 'gt'])
addpath([src_dir filesep 'cohort'])
addpath([src_dir filesep 'analysis'])
addpath([src_dir filesep 'nn'])
addpath([src_dir filesep 'gui'])

graphs_dir = [fileparts(which('braph2')) filesep 'graphs'];
addpath(graphs_dir)

measures_dir = [fileparts(which('braph2')) filesep 'measures'];
addpath(measures_dir)

brainsurfs_dir = [fileparts(which('braph2')) filesep 'brainsurfs'];
addpath(brainsurfs_dir)

neuralnetworks_dir = [fileparts(which('braph2')) filesep 'neuralnetworks'];
addpath(neuralnetworks_dir)

test_dir = [fileparts(which('braph2')) filesep 'test'];
addpath(test_dir)

pipelines_dir = [fileparts(which('braph2')) filesep 'pipelines'];
addpath(pipelines_dir)
pipelines_dir_list = dir(pipelines_dir); % get the folder contents
pipelines_dir_list = pipelines_dir_list([pipelines_dir_list(:).isdir] == 1); % remove all files (isdir property is 0)
pipelines_dir_list = pipelines_dir_list(~ismember({pipelines_dir_list(:).name}, {'.', '..'})); % remove '.' and '..'
for i = 1:1:length(pipelines_dir_list)
    addpath([pipelines_dir filesep pipelines_dir_list(i).name])
end

clear src_dir brainsurfs_dir graphs_dir measures_dir neuralnetworks_dir test_dir pipelines_dir pipelines_dir_list i

BRAPH2.checkMatLab('msgbox')
BRAPH2.installed('DM', 'msgbox')
BRAPH2.installed('NN', 'msgbox')
BRAPH2.installed('ONNXCONVERTER', 'msgbox')

% % % BRAPH2GUI()