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

% format long

src_dir = [fileparts(which('braph2')) filesep 'src'];
addpath(src_dir)
addpath([src_dir filesep 'util'])
addpath([src_dir filesep 'ds'])
addpath([src_dir filesep 'atlas'])
% % % addpath([src_dir filesep 'cohort'])
% % % addpath([src_dir filesep 'gt'])
% % % addpath([src_dir filesep 'analysis'])
% % % addpath([src_dir filesep 'gui'])
% % % addpath([src_dir filesep 'nn'])

brainsurfs_dir = [fileparts(which('braph2')) filesep 'brainsurfs'];
addpath(brainsurfs_dir)

% % % graphs_dir = [fileparts(which('braph2')) filesep 'graphs'];
% % % addpath(graphs_dir)
% % % 
% % % measures_dir = [fileparts(which('braph2')) filesep 'measures'];
% % % addpath(measures_dir)
% % % 
% % % neuralnetworks_dir = [fileparts(which('braph2')) filesep 'neuralnetworks'];
% % % addpath(neuralnetworks_dir)

test_dir = [fileparts(which('braph2')) filesep 'test'];
addpath(test_dir)

% % % pipelines_dir = [fileparts(which('braph2')) filesep 'pipelines'];
% % % addpath(pipelines_dir)
% % % pipelines_dir_list = dir(pipelines_dir); % get the folder contents
% % % pipelines_dir_list = pipelines_dir_list([pipelines_dir_list(:).isdir] == 1); % remove all files (isdir property is 0)
% % % pipelines_dir_list = pipelines_dir_list(~ismember({pipelines_dir_list(:).name}, {'.', '..'})); % remove '.' and '..'
% % % for i = 1:1:length(pipelines_dir_list)
% % %     addpath([pipelines_dir filesep pipelines_dir_list(i).name])
% % % end
% % % 
% % % addons = matlab.addons.installedAddons;
% % % installed = all(ismember(["Deep Learning Toolbox"; "Deep Learning Toolbox Converter for ONNX Model Format"], addons.Name));
% % % if ~installed
% % %     warning('Deep Learning Toolboxs are not installed. Please refer to <a href="matlab: web(''https://se.mathworks.com/products/deep-learning.html'') ">Deep Learning Toolbox</a> and <a href="matlab: web(''https://se.mathworks.com/matlabcentral/fileexchange/67296-deep-learning-toolbox-converter-for-onnx-model-format'') ">Deep Learning Toolbox Converter for ONNX Model Format</a>');
% % % end
% % % 
% % % clear src_dir brainsurfs_dir graphs_dir measures_dir test_dir pipelines_dir pipelines_dir_list i addons installed
% % % 
% % % % BRAPH2GUI()