function braph2(gui, ewm)
%BRAPH2 loads BRAPH 2.0.
%
% BRAPH2 loads all packages that are necessary to use 
%  BRAPH 2.0 - BRrain Analysis using graPH theory version 2.0.
%
% BRAPH2(true(default)|false) determines whether to open the BRAPH2GUI. 
%
% BRAPH2([], 'msgbox'(default)|'warning'|'error') throws a warning if 
%  the MatLab version is not sufficiently new, 
%  or some necessary addons are not installed.
%
% BRAPH2 uses the following addons:
%  - ST: "Statistics and Machine Learning Toolbox"
%  - DM: "Parallel Computing Toolbox"
%  - NN: "Deep Learning Toolbox"
%  - ONNXCONVERTER: "Deep Learning Toolbox Converter for ONNX Model Format"
%
% BRAPH2 packages:
%  <a href="matlab:help src         ">src</a>           - software core
%  <a href="matlab:help brainsurfs  ">brainsurfs</a>    - brain surfaces
%  <a href="matlab:help graphs      ">graphs</a>        - graphs
%  <a href="matlab:help measures    ">measures</a>      - measures
%  <a href="matlab:help pipelines   ">pipelines</a>     - pipelines
%  <a href="matlab:help test        ">test</a>          - unit testing
%
% See also BRAPH2GUI.

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

if nargin < 2
    ewm = 'msgbox';
end
BRAPH2.checkMatLab(ewm)
BRAPH2.installed('ST', ewm)
BRAPH2.installed('DM', ewm)
BRAPH2.installed('NN', ewm)
BRAPH2.installed('ONNXCONVERTER', ewm)

if nargin < 1 || isempty(gui) || gui
    BRAPH2GUI()
end

end