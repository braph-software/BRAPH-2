function [target_dir, source_dir] = genesis(target_dir, source_dir, run_number, rollcall)
%GENESIS generates BRAPH2.
%
% [TARGET_DIR, SOURCE_DIR] = GENESIS() generates BRAPH2 from the default
%  SOURCE_DIR (the directory that contains braph2genesis) to the default
%  TARGET_DIR (the directory 'braph2' in the superdirectory of SOURCE_DIR).
%
% GENESIS(TARGET_DIR) generates BRAPH2 in TARGET_DIR from the default
%  SOURCE_DIR.
%
% GENESIS(TARGET_DIR, SOURCE_DIR) generates BRAPH2 in TARGET_DIR from
%  SOURCE_DIR.
%
% GENESIS(TARGET_DIR, SOURCE_DIR, RUN_NUMBER) runs the creation scripts
%  RUN_NUMBER times. RUN_NUMBER = 2 (default) improves the computational
%  efficiency of the code  mainly by hardcoding some intermediate values.
%
% GENESIS([], [], [], ROLLCALL) excludes or includes folders and
%  elements based on the ROLLCALL cell array of strings, whose elements
%  can be:
%   '-folder'                  the folder and its elements will be excluded
%
%   '+folder'                  the folder is included, but not its elements
%       '+_ElementName.gen.m'  the element is included,
%                              if the folder is included
%
%   '+folder*'                 the folder and its elements are included
%       '-_ElementName.gen.m'  the element is excluded,
%                              if the folder and its elements are included
%
% See also braph2genesis, create_Element, create_layout,
%  create_test_Element, hard_code_constants.

fp = filesep();

if nargin < 4
    rollcall = {'-ds_examples', '-gui_examples', '-sandbox'};
end

if nargin < 3 || isempty(run_number)
    run_number = 1;
end

if nargin < 2 || isempty(source_dir)
    source_dir = fileparts(which('braph2genesis'));
end

if nargin < 1 || isempty(target_dir)
    target_dir = [fileparts(source_dir) fp 'braph2'];
end

disp('¡ BRAPH 2 Genesis')
disp(['¡ source dir: ' source_dir])
disp(['¡ target dir: ' target_dir])
disp(' ')

%% CREATE DIR STRUCTURE
% braph2
mkdir(target_dir)

disp('¡! created target dir')

% src
if any(ismember({'+util', '+util*'}, rollcall))
    mkdir([target_dir fp 'src' fp 'util'])
end
if any(ismember({'+ds', '+ds*'}, rollcall))
    mkdir([target_dir fp 'src' fp 'ds'])
    if any(ismember({'+ds_examples', '+ds_examples*'}, rollcall))
        mkdir([target_dir fp 'src' fp 'ds' fp 'ds_examples'])
    end
end
if any(ismember({'+atlas', '+atlas*'}, rollcall))
    mkdir([target_dir fp 'src' fp 'atlas'])
end
if any(ismember({'+gt', '+gt*'}, rollcall))
    mkdir([target_dir fp 'src' fp 'gt'])
end
if any(ismember({'+cohort', '+cohort*'}, rollcall))
    mkdir([target_dir fp 'src' fp 'cohort'])
end
if any(ismember({'+analysis', '+analysis*'}, rollcall))
    mkdir([target_dir fp 'src' fp 'analysis'])
end
if any(ismember({'+nn', '+nn*'}, rollcall))
    mkdir([target_dir fp 'src' fp 'nn'])
end
if any(ismember({'+gui', '+gui*'}, rollcall))
    mkdir([target_dir fp 'src' fp 'gui'])
    mkdir([target_dir fp 'src' fp 'gui' fp 'layouts'])
    if any(ismember({'+gui_examples', '+gui_examples*'}, rollcall))
        mkdir([target_dir fp 'src' fp 'gui' fp 'gui_examples'])
    end
end

disp('¡! created dir structure - SRC')

% brainsurfs
if any(ismember({'+atlas', '+atlas*'}, rollcall))
    mkdir([target_dir fp 'brainsurfs'])
end

disp('¡! created dir structure - BRAINSURFS')

% atlases
if any(ismember({'+atlas', '+atlas*'}, rollcall))
    mkdir([target_dir fp 'atlases'])
end

disp('¡! created dir structure - ATLASES')

% graphs
if any(ismember({'+atlas', '+atlas*'}, rollcall))
    mkdir([target_dir fp 'graphs'])
end

disp('¡! created dir structure - GRAPHS')

% measures
if any(ismember({'+atlas', '+atlas*'}, rollcall))
    mkdir([target_dir fp 'measures'])
end

disp('¡! created dir structure - MEASURES')

% neural networks
if any(ismember({'+atlas', '+atlas*'}, rollcall))
    mkdir([target_dir fp 'neuralnetworks'])
end

disp('¡! created dir structure - NEURALNETWORKS')

% pipelines
if any(ismember({'+atlas', '+atlas*'}, rollcall))
    mkdir([target_dir fp 'pipelines'])
end

disp('¡! created dir structure - PIPELINES')

% test
if any(ismember({'+test', '+test*'}, rollcall))
    mkdir([target_dir fp 'test'])
end

disp('¡! created dir structure - TEST')

% test
if any(ismember({'+atlas', '+atlas*'}, rollcall))
    mkdir([target_dir fp 'test'])
end

disp('¡! created dir structure - SANDBOX')

disp(' ')

%% COPY READY FILES
% braph2.m and license.rtf
copyfile([source_dir fp '_braph2' fp 'braph2.m'], [target_dir fp 'braph2.m'])
copyfile([source_dir fp 'braph2license.rtf'], [target_dir fp 'braph2license.rtf'])
disp('¡! copied ready files - braph2')
disp(' ')

% src
if any(ismember({'+util', '+util*'}, rollcall))
    copydir([source_dir fp 'src' fp 'util'], [target_dir fp 'src' fp 'util'])
    disp('¡! copied ready files - src/util')
end
if any(ismember({'+ds', '+ds*'}, rollcall))
    copydir([source_dir fp 'src' fp 'ds'], [target_dir fp 'src' fp 'ds'])
    disp('¡! copied ready files - src/ds')
    if any(ismember({'+ds_examples', '+ds_examples*'}, rollcall))
        copydir([source_dir fp 'src' fp 'ds' fp 'ds_examples'], [target_dir fp 'src' fp 'ds' fp 'ds_examples'])
        disp('¡! copied ready files - ds/ds_examples')
    end
end
if any(ismember({'+atlas', '+atlas*'}, rollcall))
    copydir([source_dir fp 'src' fp 'atlas'], [target_dir fp 'src' fp 'atlas'])
    disp('¡! copied ready files - src/atlas')
end
if any(ismember({'+gt', '+gt*'}, rollcall))
    copydir([source_dir fp 'src' fp 'gt'], [target_dir fp 'src' fp 'gt'])
    disp('¡! copied ready files - src/gt')
end
if any(ismember({'+cohort', '+cohort*'}, rollcall))
    copydir([source_dir fp 'src' fp 'cohort'], [target_dir fp 'src' fp 'cohort'])
    disp('¡! copied ready files - src/cohort')
end
if any(ismember({'+analysis', '+analysis*'}, rollcall))
    copydir([source_dir fp 'src' fp 'analysis'], [target_dir fp 'src' fp 'analysis'])
    disp('¡! copied ready files - src/analysis')
end
if any(ismember({'+nn', '+nn*'}, rollcall))
    copydir([source_dir fp 'src' fp 'nn'], [target_dir fp 'src' fp 'nn'])
    disp('¡! copied ready files - src/nn')
end
if any(ismember({'+gui', '+gui*'}, rollcall))
    copydir([source_dir fp 'src' fp 'gui'], [target_dir fp 'src' fp 'gui'])
    disp('¡! copied ready files - src/gui')
    copydir([source_dir fp 'src' fp 'gui' fp 'layouts'], [target_dir fp 'src' fp 'gui' fp 'layouts'])
    disp('¡! copied ready files - src/gui/layouts')
    if any(ismember({'+gui_examples', '+gui_examples*'}, rollcall))
        copydir([source_dir fp 'src' fp 'gui' fp 'gui_examples'], [target_dir fp 'src' fp 'gui' fp 'gui_examples'])
        disp('¡! copied ready files - src/gui/gui_examples')
    end
end
disp(' ')

% brainsurfs
if any(ismember({'+brainsurfs', '+brainsurfs*'}, rollcall))
    copydir([source_dir fp 'brainsurfs'], [target_dir fp 'brainsurfs'], Inf)
    disp('¡! copied ready files - brainsurf')
    disp(' ')
end

% atlases
if any(ismember({'+atlases', '+atlases*'}, rollcall))
    copydir([source_dir fp 'atlases'], [target_dir fp 'atlases'], Inf)
    disp('¡! copied ready files - atlases')
    disp(' ')
end

% graphs
if any(ismember({'+graphs', '+graphs*'}, rollcall))
    copydir([source_dir fp 'graphs'], [target_dir fp 'graphs'], Inf)
    disp('¡! copied ready files - graphs')
    disp(' ')
end

% measures
if any(ismember({'+measures', '+measures*'}, rollcall))
    copydir([source_dir fp 'measures'], [target_dir fp 'measures'], Inf)
    disp('¡! copied ready files - measures')
    disp(' ')
end

% neuralnetworks
if any(ismember({'+neuralnetworks', '+neuralnetworks*'}, rollcall))
    copydir([source_dir fp 'neuralnetworks'], [target_dir fp 'neuralnetworks'], Inf)
    disp('¡! copied ready files - neuralnetworks')
    disp(' ')
end

% pipelines
if any(ismember({'+pipelines', '+pipelines*'}, rollcall))
    copydir([source_dir fp 'pipelines'], [target_dir fp 'pipelines'], Inf)
    disp('¡! copied ready files - pipelines')
    disp(' ')
end

% test
if any(ismember({'+test', '+test*'}, rollcall))
    copydir([source_dir fp 'test'], [target_dir fp 'test'], Inf)
    disp('¡! copied ready files - test')
    disp(' ')
end

% sandbox
if any(ismember({'+sandbox', '+sandbox*'}, rollcall))
    copydir([source_dir fp 'sandbox'], [target_dir fp 'sandbox'], Inf)
    disp('¡! copied ready files - sandbox')
    disp(' ')
end

%% CREATE ELEMENTS
% % % for run = 1:1:run_number
% % % 
% % %     disp(['¡! started run number ' int2str(run)])
% % %     disp(' ')
% % % 
% % %     % src
% % %     if ~any(strcmp(excluded, 'util'))
% % %         util_gen_list = getGenerators([source_dir fp 'src' fp 'util']);
% % %         for i = 1:1:numel(util_gen_list)
% % %             if ~any(strcmp(excluded, util_gen_list{i}))
% % %                 create_Element([source_dir fp 'src' fp 'util' fp util_gen_list{i}], [target_dir fp 'src' fp 'util'])
% % %             end
% % %         end
% % %     end
% % % 
% % %     if ~any(strcmp(excluded, 'ds'))
% % %         if exist('Category', 'class') == 8 && run_number == 2, hard_code_constants([target_dir fp 'src' fp 'ds' fp 'Category.m']), end % % % TO BE CHECKED
% % %         if exist('Format', 'class') == 8 && run_number == 2, hard_code_constants([target_dir fp 'src' fp 'ds' fp 'Format.m']), end % % % TO BE CHECKED
% % % 	    if exist('Element', 'class') == 8 && run_number == 2, hard_code_constants([target_dir fp 'src' fp 'ds' fp 'Element.m']), end % % % TO BE CHECKED
% % % 	    ds_gen_list = getGenerators([source_dir fp 'src' fp 'ds']);
% % %         for i = 1:1:numel(ds_gen_list)
% % %             if ~any(strcmp(excluded, ds_gen_list{i}))
% % %                 create_Element([source_dir fp 'src' fp 'ds' fp ds_gen_list{i}], [target_dir fp 'src' fp 'ds'])
% % %             end
% % %         end
% % %     end
% % % 
% % %     if develop
% % %         if ~any(strcmp(excluded, 'examples'))
% % %             ds_examples_gen_list = getGenerators([source_dir fp 'src' fp 'ds' fp 'examples']);
% % %             for i = 1:1:numel(ds_examples_gen_list)
% % %                 if ~any(strcmp(excluded, ds_examples_gen_list{i}))
% % %                     create_Element([source_dir fp 'src' fp 'ds' fp 'examples' fp ds_examples_gen_list{i}], [target_dir fp 'src' fp 'ds' fp 'examples'])
% % %                 end
% % %             end
% % %         end
% % %     end
% % %     
% % %     if ~any(strcmp(excluded, 'atlas'))
% % %         atlas_gen_list = getGenerators([source_dir fp 'src' fp 'atlas']);
% % %         for i = 1:numel(atlas_gen_list)
% % %             if ~any(strcmp(excluded, atlas_gen_list{i}))
% % %                 create_Element([source_dir fp 'src' fp 'atlas' fp atlas_gen_list{i}], [target_dir fp 'src' fp 'atlas'])
% % %             end
% % %         end
% % %     end
% % % 
% % %     if ~any(strcmp(excluded, 'gt'))
% % %         gt_gen_list = getGenerators([source_dir fp 'src' fp 'gt']);
% % %         for i = 1:numel(gt_gen_list)
% % %             if ~any(strcmp(excluded, gt_gen_list{i}))
% % %                 create_Element([source_dir fp 'src' fp 'gt' fp gt_gen_list{i}], [target_dir fp 'src' fp 'gt'])
% % %             end
% % %         end
% % %     end
% % % 
% % %     if ~any(strcmp(excluded, 'cohort'))
% % %         cohort_gen_list = getGenerators([source_dir fp 'src' fp 'cohort']);
% % %         for i = 1:numel(cohort_gen_list)
% % %             if ~any(strcmp(excluded, cohort_gen_list{i}))
% % %                 create_Element([source_dir fp 'src' fp 'cohort' fp cohort_gen_list{i}], [target_dir fp 'src' fp 'cohort'])
% % %             end
% % %         end
% % %     end
% % % 
% % %     if ~any(strcmp(excluded, 'analysis'))
% % %         analysis_gen_list = getGenerators([source_dir fp 'src' fp 'analysis']);
% % %         for i = 1:numel(analysis_gen_list)
% % %             if ~any(strcmp(excluded, analysis_gen_list{i}))
% % %                 create_Element([source_dir fp 'src' fp 'analysis' fp analysis_gen_list{i}], [target_dir fp 'src' fp 'analysis'])
% % %             end
% % %         end
% % %     end
% % %     
% % %     % nn
% % %     if ~any(strcmp(excluded, 'nn'))
% % %         nn_gen_list = getGenerators([source_dir fp 'src' fp 'nn']);
% % %         for i = 1:numel(nn_gen_list)
% % %             if ~any(strcmp(excluded, nn_gen_list{i}))
% % %                 create_Element([source_dir fp 'src' fp 'nn' fp nn_gen_list{i}], [target_dir fp 'src' fp 'nn'])
% % %             end
% % %         end
% % %     end
% % % 
% % %     % graphs
% % %     if ~any(strcmp(excluded, 'graphs'))
% % %         graphs_gen_list = getGenerators([source_dir fp 'graphs']);
% % %         for i = 1:numel(graphs_gen_list)
% % %             if ~any(strcmp(excluded, graphs_gen_list{i}))
% % %                 create_Element([source_dir fp 'graphs' fp graphs_gen_list{i}], [target_dir fp 'graphs'])
% % %             end
% % %         end
% % %     end
% % % 
% % %     % measures
% % %     if ~any(strcmp(excluded, 'measures'))
% % %         measures_gen_list = getGenerators([source_dir fp 'measures']);
% % %         for i = 1:numel(measures_gen_list)
% % %             if ~any(strcmp(excluded, measures_gen_list{i}))
% % %                 create_Element([source_dir fp 'measures' fp measures_gen_list{i}], [target_dir fp 'measures'])
% % %             end
% % %         end
% % %     end
% % % 
% % %     % neural networks
% % %     if ~any(strcmp(excluded, 'neuralnetworks'))
% % %         neuralnetworks_gen_list = getGenerators([source_dir fp 'neuralnetworks']);
% % %         for i = 1:numel(neuralnetworks_gen_list)
% % %             if ~any(strcmp(excluded, neuralnetworks_gen_list{i}))
% % %                 create_Element([source_dir fp 'neuralnetworks' fp neuralnetworks_gen_list{i}], [target_dir fp 'neuralnetworks'])
% % %             end
% % %         end
% % %     end
% % % 
% % %     % gui
% % %     if ~any(strcmp(excluded, 'gui'))
% % %         gui_gen_list = getGenerators([source_dir fp 'src' fp 'gui']);
% % %         for i = 1:numel(gui_gen_list)
% % %             if ~any(strcmp(excluded, gui_gen_list{i}))
% % %                 create_Element([source_dir fp 'src' fp 'gui' fp gui_gen_list{i}], [target_dir fp 'src' fp 'gui'])
% % %             end
% % %         end
% % %     end
% % % 
% % %     if develop
% % %         if ~any(strcmp(excluded, 'examples'))
% % %             gui_examples_gen_list = getGenerators([source_dir fp 'src' fp 'gui' fp 'examples']);
% % %             for i = 1:numel(gui_examples_gen_list)
% % %                 if ~any(strcmp(excluded, gui_examples_gen_list{i}))
% % %                     create_Element([source_dir fp 'src' fp 'gui' fp 'examples' fp gui_examples_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'examples'])
% % %                 end
% % %             end
% % %         end
% % %     end
% % % 
% % %     % pipelines
% % %     if ~any(strcmp(excluded, 'pipelines'))    
% % %         pipelines_contents = dir([source_dir fp 'pipelines']);  % get the folder contents
% % %         pipelines_dir_list = pipelines_contents([pipelines_contents(:).isdir] == 1);  % remove all files (isdir property is 0)
% % %         pipelines_dir_list = pipelines_dir_list(~ismember({pipelines_dir_list(:).name}, {'.', '..'}));  % remove '.' and '..'
% % %         for i = 1:1:length(pipelines_dir_list)
% % %             pipeline_dir_name = pipelines_dir_list(i).name;
% % %             if ~any(strcmp(excluded, pipeline_dir_name))
% % %                 pipeline_gen_list = getGenerators([source_dir fp 'pipelines' fp pipeline_dir_name]);
% % %                 for j = 1:numel(pipeline_gen_list)
% % %                     if ~any(strcmp(excluded, pipeline_gen_list{j}))
% % %                         create_Element([source_dir fp 'pipelines' fp pipeline_dir_name fp pipeline_gen_list{j}], [target_dir fp 'pipelines' fp pipeline_dir_name])
% % %                     end
% % %                 end
% % %             end
% % %         end
% % %     end
% % % 
% % %     % LOAD BRAPH2
% % %     addpath(target_dir)
% % %     braph2(false, 'warning')
% % % 
% % %     disp('¡! loaded BRAPH2')
% % %     disp(' ')
% % %     
% % %     disp(['¡! completed run number ' int2str(run)])
% % %     disp(' ')
% % % end
% % % 
% % % %% CREATE LAYOUTS
% % % % src
% % % if ~any(strcmp(excluded, 'util'))
% % %     util_gen_list = getGenerators([source_dir fp 'src' fp 'util']);
% % %     parfor i = 1:numel(util_gen_list)
% % %         if ~any(strcmp(excluded, util_gen_list{i}))
% % %             create_layout([source_dir fp 'src' fp 'util' fp util_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
% % %         end
% % %     end
% % % end
% % % 
% % % if ~any(strcmp(excluded, 'ds'))
% % %     ds_gen_list = getGenerators([source_dir fp 'src' fp 'ds']);
% % %     parfor i = 1:numel(ds_gen_list)
% % %         if ~any(strcmp(excluded, ds_gen_list{i}))
% % %             create_layout([source_dir fp 'src' fp 'ds' fp ds_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
% % %         end
% % %     end
% % % end
% % % 
% % % if develop
% % %     if ~any(strcmp(excluded, 'examples'))
% % %         ds_examples_gen_list = getGenerators([source_dir fp 'src' fp 'ds' fp 'examples']);
% % %         parfor i = 1:numel(ds_examples_gen_list)
% % %             if ~any(strcmp(excluded, ds_examples_gen_list{i}))
% % %                 create_layout([source_dir fp 'src' fp 'ds' fp 'examples' fp ds_examples_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
% % %             end
% % %         end
% % %     end
% % % end
% % % 
% % % if ~any(strcmp(excluded, 'atlas'))
% % %     atlas_gen_list = getGenerators([source_dir fp 'src' fp 'atlas']);
% % %     parfor i = 1:numel(atlas_gen_list)
% % %         if ~any(strcmp(excluded, atlas_gen_list{i}))
% % %             create_layout([source_dir fp 'src' fp 'atlas' fp atlas_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
% % %         end
% % %     end
% % % end
% % % 
% % % if ~any(strcmp(excluded, 'gt'))
% % %     gt_gen_list = getGenerators([source_dir fp 'src' fp 'gt']);
% % %     parfor i = 1:numel(gt_gen_list)
% % %         if ~any(strcmp(excluded, gt_gen_list{i}))
% % %             create_layout([source_dir fp 'src' fp 'gt' fp gt_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
% % %         end
% % %     end
% % % end
% % % 
% % % if ~any(strcmp(excluded, 'cohort'))
% % %     cohort_gen_list = getGenerators([source_dir fp 'src' fp 'cohort']);
% % %     parfor i = 1:numel(cohort_gen_list)
% % %         if ~any(strcmp(excluded, cohort_gen_list{i}))
% % %             create_layout([source_dir fp 'src' fp 'cohort' fp cohort_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
% % %         end
% % %     end
% % % end
% % % 
% % % if ~any(strcmp(excluded, 'analysis'))
% % %     analysis_gen_list = getGenerators([source_dir fp 'src' fp 'analysis']);
% % %     parfor i = 1:numel(analysis_gen_list)
% % %         if ~any(strcmp(excluded, analysis_gen_list{i}))
% % %             create_layout([source_dir fp 'src' fp 'analysis' fp analysis_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
% % %         end
% % %     end
% % % end
% % % 
% % % % nn
% % % if ~any(strcmp(excluded, 'nn'))
% % %     nn_gen_list = getGenerators([source_dir fp 'src' fp 'nn']);
% % %     parfor i = 1:numel(nn_gen_list)
% % %         if ~any(strcmp(excluded, nn_gen_list{i}))
% % %             create_layout([source_dir fp 'src' fp 'nn' fp nn_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
% % %         end
% % %     end
% % % end
% % % 
% % % % gui
% % % if ~any(strcmp(excluded, 'gui'))
% % %     gui_gen_list = getGenerators([source_dir fp 'src' fp 'gui']);
% % %     parfor i = 1:numel(gui_gen_list)
% % %         if ~any(strcmp(excluded, gui_gen_list{i}))
% % %             create_layout([source_dir fp 'src' fp 'gui' fp gui_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
% % %         end
% % %     end
% % % end
% % % 
% % % if develop
% % %     if ~any(strcmp(excluded, 'examples'))
% % %         gui_examples_gen_list = getGenerators([source_dir fp 'src' fp 'gui' fp 'examples']);
% % %         parfor i = 1:numel(gui_examples_gen_list)
% % %             if ~any(strcmp(excluded, gui_examples_gen_list{i}))
% % %                 create_layout([source_dir fp 'src' fp 'gui' fp 'examples' fp gui_examples_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
% % %             end
% % %         end
% % %     end
% % % end
% % % 
% % % % graphs
% % % if ~any(strcmp(excluded, 'graphs'))
% % %     graphs_gen_list = getGenerators([source_dir fp 'graphs']);
% % %     parfor i = 1:numel(graphs_gen_list)
% % %         if ~any(strcmp(excluded, graphs_gen_list{i}))
% % %             create_layout([source_dir fp 'graphs' fp graphs_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
% % %         end
% % %     end
% % % end
% % % 
% % % % measures
% % % if ~any(strcmp(excluded, 'measures'))
% % %     measures_gen_list = getGenerators([source_dir fp 'measures']);
% % %     parfor i = 1:numel(measures_gen_list)
% % %         if ~any(strcmp(excluded, measures_gen_list{i}))
% % %             create_layout([source_dir fp 'measures' fp measures_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
% % %         end
% % %     end
% % % end
% % % 
% % % % neuralnetworks
% % % if ~any(strcmp(excluded, 'neuralnetworks'))
% % %     neuralnetworks_gen_list = getGenerators([source_dir fp 'neuralnetworks']);
% % %     parfor i = 1:numel(neuralnetworks_gen_list)
% % %         if ~any(strcmp(excluded, neuralnetworks_gen_list{i}))
% % %             create_layout([source_dir fp 'neuralnetworks' fp neuralnetworks_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
% % %         end
% % %     end 
% % % end
% % % 
% % % % pipelines
% % % if ~any(strcmp(excluded, 'pipelines'))
% % %     pipelines_contents = dir([source_dir fp 'pipelines']);  % get the folder contents
% % %     pipelines_dir_list = pipelines_contents([pipelines_contents(:).isdir] == 1);  % remove all files (isdir property is 0)
% % %     pipelines_dir_list = pipelines_dir_list(~ismember({pipelines_dir_list(:).name}, {'.', '..'}));  % remove '.' and '..'
% % %     for i = 1:1:length(pipelines_dir_list)
% % %         pipeline_dir_name = pipelines_dir_list(i).name;
% % %         if ~any(strcmp(excluded, pipeline_dir_name))
% % %             pipeline_gen_list = getGenerators([source_dir fp 'pipelines' fp pipeline_dir_name]);
% % %             parfor j = 1:numel(pipeline_gen_list)
% % %                 if ~any(strcmp(excluded, pipeline_gen_list{j}))
% % %                     create_layout([source_dir fp 'pipelines' fp pipeline_dir_name fp pipeline_gen_list{j}], [target_dir fp 'src' fp 'gui' fp 'layouts'])
% % %                 end
% % %             end
% % %         end
% % %     end
% % % end
% % % 
% % % %% CREATE TEST
% % % % src
% % % if ~any(strcmp(excluded, 'util'))
% % %     util_gen_list = getGenerators([source_dir fp 'src' fp 'util']);
% % %     parfor i = 1:numel(util_gen_list)
% % %         if ~any(strcmp(excluded, util_gen_list{i}))
% % %             create_test_Element([source_dir fp 'src' fp 'util' fp util_gen_list{i}], [target_dir fp 'src' fp 'util'])
% % %         end
% % %     end
% % % end
% % % 
% % % if ~any(strcmp(excluded, 'ds'))
% % %     ds_gen_list = getGenerators([source_dir fp 'src' fp 'ds']);
% % %     parfor i = 1:numel(ds_gen_list)
% % %         if ~any(strcmp(excluded, ds_gen_list{i}))
% % %             create_test_Element([source_dir fp 'src' fp 'ds' fp ds_gen_list{i}], [target_dir fp 'src' fp 'ds'])
% % %         end
% % %     end
% % % end
% % % 
% % % if develop
% % %     if ~any(strcmp(excluded, 'examples'))
% % %         ds_examples_gen_list = getGenerators([source_dir fp 'src' fp 'ds' fp 'examples']);
% % %         parfor i = 1:numel(ds_examples_gen_list)
% % %             if ~any(strcmp(excluded, ds_examples_gen_list{i}))
% % %                 create_test_Element([source_dir fp 'src' fp 'ds' fp 'examples' fp ds_examples_gen_list{i}], [target_dir fp 'src' fp 'ds' fp 'examples'])
% % %             end
% % %         end
% % %     end
% % % end
% % % 
% % % if ~any(strcmp(excluded, 'atlas'))
% % %     atlas_gen_list = getGenerators([source_dir fp 'src' fp 'atlas']);
% % %     parfor i = 1:numel(atlas_gen_list)
% % %         if ~any(strcmp(excluded, atlas_gen_list{i}))
% % %             create_test_Element([source_dir fp 'src' fp 'atlas' fp atlas_gen_list{i}], [target_dir fp 'src' fp 'atlas'])
% % %         end
% % %     end
% % % end
% % % 
% % % if ~any(strcmp(excluded, 'gt'))
% % %     gt_gen_list = getGenerators([source_dir fp 'src' fp 'gt']);
% % %     parfor i = 1:numel(gt_gen_list)
% % %         if ~any(strcmp(excluded, gt_gen_list{i}))
% % %             create_test_Element([source_dir fp 'src' fp 'gt' fp gt_gen_list{i}], [target_dir fp 'src' fp 'gt'])
% % %         end
% % %     end
% % % end
% % % 
% % % if ~any(strcmp(excluded, 'cohort'))
% % %     cohort_gen_list = getGenerators([source_dir fp 'src' fp 'cohort']);
% % %     parfor i = 1:numel(cohort_gen_list)
% % %         if ~any(strcmp(excluded, cohort_gen_list{i}))
% % %             create_test_Element([source_dir fp 'src' fp 'cohort' fp cohort_gen_list{i}], [target_dir fp 'src' fp 'cohort'])
% % %         end
% % %     end
% % % end
% % % 
% % % if ~any(strcmp(excluded, 'analysis'))
% % %     analysis_gen_list = getGenerators([source_dir fp 'src' fp 'analysis']);
% % %     parfor i = 1:numel(analysis_gen_list)
% % %         if ~any(strcmp(excluded, analysis_gen_list{i}))
% % %             create_test_Element([source_dir fp 'src' fp 'analysis' fp analysis_gen_list{i}], [target_dir fp 'src' fp 'analysis'])
% % %         end
% % %     end
% % % end
% % % 
% % % % nn
% % % if ~any(strcmp(excluded, 'nn'))
% % %     nn_gen_list = getGenerators([source_dir fp 'src' fp 'nn']);
% % %     parfor i = 1:numel(nn_gen_list)
% % %         if ~any(strcmp(excluded, nn_gen_list{i}))
% % %             create_test_Element([source_dir fp 'src' fp 'nn' fp nn_gen_list{i}], [target_dir fp 'src' fp 'nn'])
% % %         end
% % %     end
% % % end
% % % 
% % % % gui
% % % if ~any(strcmp(excluded, 'gui'))
% % %     gui_gen_list = getGenerators([source_dir fp 'src' fp 'gui']);
% % %     parfor i = 1:numel(gui_gen_list)
% % %         if ~any(strcmp(excluded, gui_gen_list{i}))
% % %             create_test_Element([source_dir fp 'src' fp 'gui' fp gui_gen_list{i}], [target_dir fp 'src' fp 'gui'])
% % %         end
% % %     end
% % % end
% % % 
% % % if develop
% % %     if ~any(strcmp(excluded, 'examples'))
% % %         gui_examples_gen_list = getGenerators([source_dir fp 'src' fp 'gui' fp 'examples']);
% % %         parfor i = 1:numel(gui_examples_gen_list)
% % %             if ~any(strcmp(excluded, gui_examples_gen_list{i}))
% % %                 create_test_Element([source_dir fp 'src' fp 'gui' fp 'examples' fp gui_examples_gen_list{i}], [target_dir fp 'src' fp 'gui' fp 'examples'])
% % %             end
% % %         end
% % %     end
% % % end
% % % 
% % % % graphs
% % % if ~any(strcmp(excluded, 'graphs'))
% % %     graphs_gen_list = getGenerators([source_dir fp 'graphs']);
% % %     parfor i = 1:numel(graphs_gen_list)
% % %         if ~any(strcmp(excluded, graphs_gen_list{i}))
% % %             create_test_Element([source_dir fp 'graphs' fp graphs_gen_list{i}], [target_dir fp 'graphs'])
% % %         end
% % %     end
% % % end
% % % 
% % % % measures
% % % if ~any(strcmp(excluded, 'measures'))
% % %     measures_gen_list = getGenerators([source_dir fp 'measures']);
% % %     parfor i = 1:numel(measures_gen_list)
% % %         if ~any(strcmp(excluded, measures_gen_list{i}))
% % %             create_test_Element([source_dir fp 'measures' fp measures_gen_list{i}], [target_dir fp 'measures'])
% % %         end
% % %     end
% % % end
% % % 
% % % % neuralnetworks
% % % if ~any(strcmp(excluded, 'neuralnetworks'))
% % %     neuralnetworks_gen_list = getGenerators([source_dir fp 'neuralnetworks']);
% % %     parfor i = 1:numel(neuralnetworks_gen_list)
% % %         if ~any(strcmp(excluded, neuralnetworks_gen_list{i}))
% % %             create_test_Element([source_dir fp 'neuralnetworks' fp neuralnetworks_gen_list{i}], [target_dir fp 'neuralnetworks'])
% % %         end
% % %     end
% % % end
% % % 
% % % % pipelines
% % % if ~any(strcmp(excluded, 'pipelines'))
% % %     pipelines_contents = dir([source_dir fp 'pipelines']);  % get the folder contents
% % %     pipelines_dir_list = pipelines_contents([pipelines_contents(:).isdir] == 1);  % remove all files (isdir property is 0)
% % %     pipelines_dir_list = pipelines_dir_list(~ismember({pipelines_dir_list(:).name}, {'.', '..'}));  % remove '.' and '..'
% % %     for i = 1:1:length(pipelines_dir_list)
% % %         pipeline_dir_name = pipelines_dir_list(i).name;
% % %         if ~any(strcmp(excluded, pipeline_dir_name))
% % %             pipeline_gen_list = getGenerators([source_dir fp 'pipelines' fp pipeline_dir_name]);
% % %             parfor j = 1:numel(pipeline_gen_list)
% % %                 if ~any(strcmp(excluded, pipeline_gen_list{j}))
% % %                     create_test_Element([source_dir fp 'pipelines' fp pipeline_dir_name fp pipeline_gen_list{j}], [target_dir fp 'pipelines' fp pipeline_dir_name])
% % %                 end
% % %             end
% % %         end
% % %     end
% % % end

end