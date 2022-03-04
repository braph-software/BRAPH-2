close all
clear all
clc
braph_path = [pwd '\braph2']
genesis_path = [pwd '\braph2genesis']
%% list the files that need to be validated for a quick check
% list the files to be directly copied to braph2 folder
files_for_copy = { ...
    '\pipelines\structural NN\example_NNCV_ST_Classification.m'
    '\pipelines\structural NN\example_NN_ST_Classification.m'
    }

% list the genesis files to be compiled to braph2 folder
gen_files = { ...
    '\src\nn\_NNBase.gen.m' ...
    '\src\nn\_NNData.gen.m' ...
    '\src\nn\_NNEvaluator.gen.m'};

%% Delete the files
for i = 1:length(gen_files)
    delete([braph_path extractBefore(gen_files{i}, "\_") filesep char(extractBetween(gen_files{i}, "\_", ".gen")) '.m']);
end 

%% Compile and run the test
for i = 1:length(files_for_copy)
    status = copyfile([genesis_path files_for_copy{i}], [braph_path extractBefore(files_for_copy{i}, "\_")]);
    if status == 0
        warning([files_for_copy{i} ' copy failed'])
    end
end

for i = 1:length(gen_files)
    create_Element([genesis_path gen_files{i}], [braph_path extractBefore(gen_files{i}, "\_")])
end
for i = 1:length(gen_files)
    create_test_Element([genesis_path gen_files{i}], [braph_path extractBefore(gen_files{i}, "\_")])
    eval(['test_' char(extractBetween(gen_files{i}, "\_", ".gen"))])
    %eval(['test_' char(extractBetween(gen_files{i}, "\_", ".gen"))])
end

%% test on GUI
GUI('pe', Pipeline()).draw()

%% archived codes
% delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui/PlotElement.m')
% create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotElement.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotElement.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% create_test_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotElement.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% test_PlotElement
% delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui/PlotPropString.m')
% create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotPropString.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotPropString.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui/GUI.m')
% create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_GUI.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_GUI.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/cohort/PPGroup_SUBDict.m')
% create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/cohort/_PPGroup_SUBDict.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/cohort')
% create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/cohort/_PPGroup_SUBDict.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/cohort')
% delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/atlas/PPBrainAtlas_Surf.m')
% create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/atlas/_PPBrainAtlas_Surf.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/atlas')
% create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/atlas/_PPBrainAtlas_Surf.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/atlas')
% delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui/PPPipeline_PSDict.m')
% create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PPPipeline_PSDict.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PPPipeline_PSDict.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')

lf = load('pip_c.b2', '-mat');
pip = lf.el;
% lf = load('pip_c.b2', '-mat');
% pip = lf.el;

% gui = GUI( ...
%     'PE', pip, ...
%     'MENU_FILE', false, ...
%     'MENU_IMPORT', false, ...
%     'MENU_EXPORT', false, ...
%     'MENU_PERSONALIZE', false, ...
%     'MENU_ABOUT', false, ...
%     'TOOL_FIG', true, ...
%     'CLOSEREQ', false ...
%     );
gui = GUI( ...
    'PE', pip, ...
    'CLOSEREQ', false ...
    );
gui.draw()
% gui = GUI( ...
%     'PE', pip, ...
%     'CLOSEREQ', false ...
%     );
% gui.draw()

% % % delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui/PPPipeline_PSDict.m')
% % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PPPipeline_PSDict.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PPPipeline_PSDict.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % 
% % lf = load('pip_c.b2', '-mat');
% % pip = lf.el;
% % 
% % % im = ImporterPipelineBRAPH2(...
% % %     'FILE', [fileparts(which('SubjectST')) filesep 'pipeline_structural_comparison_wu.braph2'], ...
% % %     'WAITBAR', false ...
% % %     ); 
% % % pip = im.get('PIP');
% % 
% % gui = GUI('PE', pip, 'CLOSEREQ', false);
% % gui.draw()
% load('tmp_pip.mat')
% 
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotPropString.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotPropText.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_Pipeline.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PPPipeline_PSDict.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')