close all; delete(findall(0, 'type', 'figure')); clear all; clc
%%%%% if new element is added, manually add that element name in
%%%%% ConcretElement.m function subclass_list = getSubclasses(), the list,
%%%%% and the parent class, find getSubclasses

%% test b2 files
file = 'pipeline_NN_CON.b2';
path = which(file);
pip = Element.load(path);

gui = GUIElement( ...
    'PE', pip, ...
    'WAITBAR', true, ...
    'CLOSEREQ', true ...
    );
gui.get('DRAW')
gui.get('SHOW')

%% test pipeline
file = 'pipeline_classification_cross_validation_connectivity_functional_multiplex_bud_measure.braph2';
path = which(file);
pip = ImporterPipelineBRAPH2( ...
    'FILE', path, ...
    'WAITBAR', true ...
    ).get('PIP');

gui = GUIElement( ...
    'PE', pip, ...
    'WAITBAR', true, ...
    'CLOSEREQ', true ...
    );
gui.get('DRAW')
gui.get('SHOW')
% 
%% /src/ds/
el_path = '/src/ds';
el_class_list = {'ConcreteElement'}; 
regenerate(el_path, el_class_list);

%% /src/nn/
el_path = '/src/nn';
el_class_list = {'NNCrossValidation'}; 
regenerate(el_path, el_class_list);

%% /neuralnetworks
el_path = '/neuralnetworks';
%el_class_list = {'NNClassifierMLP' 'NNDataPointMLP_Shuffled' 'NNxMLP_FeatureImportance' 'NNxMLP_FeatureImportance_CV' 'NNxMLP_FeatureImportanceAcrossMeasures' 'NNxMLP_FeatureImportanceAcrossMeasures_CV' 'NNxMLP_FeatureImportanceBrainSurface' 'NNxMLP_FeatureImportanceBrainSurface_CV' 'NNxMLP_FeatureImportanceBrainSurfacePP_Data' 'NNxMLP_FeatureImportanceBrainSurfacePP_Graph' 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure' 'NNxMLP_FeatureImportanceBrainSurfacePF' 'NNxMLP_FeatureImportanceBrainSurfacePF_BB' 'NNxMLP_FeatureImportanceBrainSurfacePF_BS' 'NNxMLP_FeatureImportanceBrainSurfacePF_BU' 'NNxMLP_FeatureImportanceBrainSurfacePF_GB' 'NNxMLP_FeatureImportanceBrainSurfacePF_GS' 'NNxMLP_FeatureImportanceBrainSurfacePF_GU' 'NNxMLP_FeatureImportanceBrainSurfacePF_NB' 'NNxMLP_FeatureImportanceBrainSurfacePF_NS' 'NNxMLP_FeatureImportanceBrainSurfacePF_NU' 'NNxMLP_FeatureImportanceBSPF_xUPP_Layer' 'NNxMLP_FeatureImportanceBSPF_xSPP_Layer'}; 
% %el_class_list = {'NNxMLP_FeatureImportanceBrainSurface' 'NNxMLP_FeatureImportanceBrainSurfacePP_Data' 'NNxMLP_FeatureImportanceBrainSurfacePP_Graph' 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure'};
el_class_list = {'NNxMLP_FeatureImportanceBrainSurfacePP_Graph'}; 
regenerate(el_path, el_class_list, 'UnitTest', false);

%% /neuralnetworks
el_path = '/neuralnetworks';
%el_class_list = {'NNDataPointMLP_Shuffled' 'NNDataPoint' 'NNxMLP_FeatureImportance' 'NNxMLP_FeatureImportance_CV' 'NNxMLP_FeatureImportanceAcrossMeasures' 'NNxMLP_FeatureImportanceAcrossMeasures_CV' 'NNxMLP_FeatureImportanceBrainSurface' 'NNxMLP_FeatureImportanceBrainSurface_CV' 'NNxMLP_FeatureImportanceBrainSurfacePP_Data' 'NNxMLP_FeatureImportanceBrainSurfacePP_Graph' 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure' 'NNxMLP_FeatureImportanceBrainSurfacePF' 'NNxMLP_FeatureImportanceBrainSurfacePF_BB' 'NNxMLP_FeatureImportanceBrainSurfacePF_BS' 'NNxMLP_FeatureImportanceBrainSurfacePF_BU' 'NNxMLP_FeatureImportanceBrainSurfacePF_GB' 'NNxMLP_FeatureImportanceBrainSurfacePF_GS' 'NNxMLP_FeatureImportanceBrainSurfacePF_GU' 'NNxMLP_FeatureImportanceBrainSurfacePF_NB' 'NNxMLP_FeatureImportanceBrainSurfacePF_NS' 'NNxMLP_FeatureImportanceBrainSurfacePF_NU' 'NNxMLP_FeatureImportanceBSPF_xUPP_Layer' 'NNxMLP_FeatureImportanceBSPF_xSPP_Layer'}; 
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
    delete([fileparts(which('braph2')) filesep() 'src' filesep() 'gui' filesep() 'layouts' filesep() el_class '.layout'])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
end
%%
%el_class_list = {'NNClassifierMLP' 'NNDataPointMLP_Shuffled' 'NNxMLP_FeatureImportance' 'NNxMLP_FeatureImportance_CV' 'NNxMLP_FeatureImportanceAcrossMeasures' 'NNxMLP_FeatureImportanceAcrossMeasures_CV' 'NNxMLP_FeatureImportanceBrainSurface' 'NNxMLP_FeatureImportanceBrainSurface_CV' 'NNxMLP_FeatureImportanceBrainSurfacePP_Data' 'NNxMLP_FeatureImportanceBrainSurfacePP_Graph' 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure' 'NNxMLP_FeatureImportanceBrainSurfacePF' 'NNxMLP_FeatureImportanceBrainSurfacePF_BB' 'NNxMLP_FeatureImportanceBrainSurfacePF_BS' 'NNxMLP_FeatureImportanceBrainSurfacePF_BU' 'NNxMLP_FeatureImportanceBrainSurfacePF_GB' 'NNxMLP_FeatureImportanceBrainSurfacePF_GS' 'NNxMLP_FeatureImportanceBrainSurfacePF_GU' 'NNxMLP_FeatureImportanceBrainSurfacePF_NB' 'NNxMLP_FeatureImportanceBrainSurfacePF_NS' 'NNxMLP_FeatureImportanceBrainSurfacePF_NU' 'NNxMLP_FeatureImportanceBSPF_xUPP_Layer' 'NNxMLP_FeatureImportanceBSPF_xSPP_Layer'}; 
el_class_list = {'NNxMLP_FeatureImportanceAcrossMeasures_CV' 'NNxMLP_FeatureImportanceBrainSurface' 'NNxMLP_FeatureImportanceBrainSurface_CV' 'NNxMLP_FeatureImportanceBrainSurfacePP_Data' 'NNxMLP_FeatureImportanceBrainSurfacePP_Graph' 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure' 'NNxMLP_FeatureImportanceBrainSurfacePF' 'NNxMLP_FeatureImportanceBrainSurfacePF_BB' 'NNxMLP_FeatureImportanceBrainSurfacePF_BS' 'NNxMLP_FeatureImportanceBrainSurfacePF_BU' 'NNxMLP_FeatureImportanceBrainSurfacePF_GB' 'NNxMLP_FeatureImportanceBrainSurfacePF_GS' 'NNxMLP_FeatureImportanceBrainSurfacePF_GU' 'NNxMLP_FeatureImportanceBrainSurfacePF_NB' 'NNxMLP_FeatureImportanceBrainSurfacePF_NS' 'NNxMLP_FeatureImportanceBrainSurfacePF_NU' 'NNxMLP_FeatureImportanceBSPF_xUPP_Layer' 'NNxMLP_FeatureImportanceBSPF_xSPP_Layer'}; 
for i = 1:1:length(el_class_list)
    el_class_list = {'NNxMLP_FeatureImportanceAcrossMeasures_CV' 'NNxMLP_FeatureImportanceBrainSurface' 'NNxMLP_FeatureImportanceBrainSurface_CV' 'NNxMLP_FeatureImportanceBrainSurfacePP_Data' 'NNxMLP_FeatureImportanceBrainSurfacePP_Graph' 'NNxMLP_FeatureImportanceBrainSurfacePP_Measure' 'NNxMLP_FeatureImportanceBrainSurfacePF' 'NNxMLP_FeatureImportanceBrainSurfacePF_BB' 'NNxMLP_FeatureImportanceBrainSurfacePF_BS' 'NNxMLP_FeatureImportanceBrainSurfacePF_BU' 'NNxMLP_FeatureImportanceBrainSurfacePF_GB' 'NNxMLP_FeatureImportanceBrainSurfacePF_GS' 'NNxMLP_FeatureImportanceBrainSurfacePF_GU' 'NNxMLP_FeatureImportanceBrainSurfacePF_NB' 'NNxMLP_FeatureImportanceBrainSurfacePF_NS' 'NNxMLP_FeatureImportanceBrainSurfacePF_NU' 'NNxMLP_FeatureImportanceBSPF_xUPP_Layer' 'NNxMLP_FeatureImportanceBSPF_xSPP_Layer'}; 
    el_class = el_class_list{i};
    ['test_' el_class]
    eval(['test_' el_class])
end

%% Copy ready file for pipelines
fp = filesep;
source_dir = fileparts(which('braph2genesis'));
target_dir = [fileparts(source_dir) fp 'braph2'];
if compile_dir('pipelines')
    copydir([source_dir fp 'pipelines'], [target_dir fp 'pipelines'])

    pipelines_contents = dir([source_dir fp 'pipelines']);  % get the folder contents
    pipelines_dir_list = pipelines_contents([pipelines_contents(:).isdir] == 1);  % remove all files (isdir property is 0)
    pipelines_dir_list = pipelines_dir_list(~ismember({pipelines_dir_list(:).name}, {'.', '..'}));  % remove '.' and '..'
    for i = 1:1:length(pipelines_dir_list)
        pipeline_dir_name = pipelines_dir_list(i).name;
        if compile_pip_dir(pipeline_dir_name)
            copydir([source_dir fp 'pipelines' fp pipeline_dir_name], [target_dir fp 'pipelines' fp pipeline_dir_name], Inf)
        end
    end
    disp('¡! copied ready files - pipelines')
    disp(' ')
end

%% /pipelines/connectivity-functional multiplex NN
el_path = '/pipelines/connectivity-functional multiplex NN';
el_class_list = {'NNDataPoint_CON_FUN_MP_CLA'}; 
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
    delete([fileparts(which('braph2')) filesep() 'src' filesep() 'gui' filesep() 'layouts' filesep() el_class '.layout'])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
end
% % % for i = 1:1:length(el_class_list)
% % %     el_class_list = {'NNDataPoint_CON_FUN_MP_CLA'}; 
% % %     el_class = el_class_list{i};
% % %     ['test_' el_class]
% % %     eval(['test_' el_class])
% % % end

%% /neuralnetworks
el_path = '/neuralnetworks';
el_class_list = {'NNClassifierMLP_Evaluator' 'NNClassifierMLP_CrossValidation'}; 
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
    delete([fileparts(which('braph2')) filesep() 'src' filesep() 'gui' filesep() 'layouts' filesep() el_class '.layout'])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
end
el_class_list = {'NNClassifierMLP_Evaluator' 'NNClassifierMLP_CrossValidation'}; 
for i = 1:1:length(el_class_list)
    el_class_list = {'NNClassifierMLP_Evaluator' 'NNClassifierMLP_CrossValidation'}; 
    el_class = el_class_list{i};
    ['test_' el_class]
    eval(['test_' el_class])
end

%% /pipelines/connectivity NN
el_path = '/pipelines/connectivity NN';
el_class_list = {'NNDataPoint_CON_CLA'}; 
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
    delete([fileparts(which('braph2')) filesep() 'src' filesep() 'gui' filesep() 'layouts' filesep() el_class '.layout'])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
end
% % % for i = 1:1:length(el_class_list)
% % %     el_class_list = {'NNDataPoint_CON_CLA'}; 
% % %     el_class = el_class_list{i};
% % %     ['test_' el_class]
% % %     eval(['test_' el_class])
% % % end

%% /pipelines/functional NN
el_path = '/pipelines/functional NN';
el_class_list = {'NNDataPoint_FUN_CLA'}; 
target_dir = fileparts(which('braph2'));
source_dir = fileparts(which('braph2genesis'));
parfor i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    delete([target_dir el_path filesep() el_class '.m'])
    delete([target_dir filesep() 'src' filesep() 'gui' filesep() 'layouts' filesep() el_class '.layout'])
    create_Element([source_dir el_path filesep() '_' el_class '.gen.m'], [target_dir el_path])
    create_Element([source_dir el_path filesep() '_' el_class '.gen.m'], [target_dir el_path])
    create_layout([source_dir el_path filesep() '_' el_class '.gen.m'], [target_dir el_path])
    create_test_Element([source_dir el_path filesep() '_' el_class '.gen.m'], [target_dir el_path])
end
% % % for i = 1:1:length(el_class_list)
% % %     el_class_list = {'NNDataPoint_FUN_CLA'}; 
% % %     el_class = el_class_list{i};
% % %     ['test_' el_class]
% % %     eval(['test_' el_class])
% % % end

%% /pipelines/structural NN
el_path = '/pipelines/structural NN';
el_class_list = {'NNDataPoint_ST_CLA'}; 
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
    delete([fileparts(which('braph2')) filesep() 'src' filesep() 'gui' filesep() 'layouts' filesep() el_class '.layout'])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
end
% % % for i = 1:1:length(el_class_list)
% % %     el_class_list = {'NNDataPoint_ST_CLA'}; 
% % %     el_class = el_class_list{i};
% % %     ['test_' el_class]
% % %     eval(['test_' el_class])
% % % end

%% /pipelines/structural multi_modality NN
el_path = '/pipelines/structural multi_modality NN';
el_class_list = {'NNDataPoint_ST_MM_CLA'}; 
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
    delete([fileparts(which('braph2')) filesep() 'src' filesep() 'gui' filesep() 'layouts' filesep() el_class '.layout'])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
end
% % % for i = 1:1:length(el_class_list)
% % %     el_class_list = {'NNDataPoint_ST_MM_CLA' 'NNDataPoint_ST_MM_REG'}; 
% % %     el_class = el_class_list{i};
% % %     ['test_' el_class]
% % %     eval(['test_' el_class])
% % % end

%% /pipelines/structural
el_path = '/pipelines/structural';
el_class_list = {'AnalyzeGroup_ST_WU'}; 
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
    delete([fileparts(which('braph2')) filesep() 'src' filesep() 'gui' filesep() 'layouts' filesep() el_class '.layout'])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
end
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    ['test_' el_class]
    eval(['test_' el_class])
end

%% /pipelines/connectivity directed
el_path = '/pipelines/connectivity directed';
el_class_list = {'AnalyzeEnsemble_CON_WD'}; 
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
    delete([fileparts(which('braph2')) filesep() 'src' filesep() 'gui' filesep() 'layouts' filesep() el_class '.layout'])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
end
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    ['test_' el_class]
    eval(['test_' el_class])
end

%% analysis
el_path = '/src/analysis';
el_class_list = {'ComparisonGroupPF_NS' 'ComparisonGroupPF_NU' 'ComparisonGroupPF_NB' 'ComparisonGroupPF_GS' 'ComparisonGroupPF_GU' 'ComparisonGroupPF_GB' 'ComparisonGroupPF_BS' 'ComparisonGroupPF_BU' 'ComparisonGroupPF_BB'}; 
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
    delete([fileparts(which('braph2')) filesep() 'src' filesep() 'gui' filesep() 'layouts' filesep() el_class '.layout'])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
end
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    ['test_' el_class]
    eval(['test_' el_class])
end

%% gt
el_path = '/src/gt';
el_class_list = {'MeasurePF_NS' 'MeasurePF_NU' 'MeasurePF_NB' 'MeasurePF_GS' 'MeasurePF_GU' 'MeasurePF_GB' 'MeasurePF_BS' 'MeasurePF_BU' 'MeasurePF_BB'} % 'MeasurePF_GS' 'MeasurePF_BS'}; 
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
    delete([fileparts(which('braph2')) filesep() 'src' filesep() 'gui' filesep() 'layouts' filesep() el_class '.layout'])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
end
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    ['test_' el_class]
    eval(['test_' el_class])
end

%% general
el_path = '/src/gui';
el_class_list = {'PipelinePP_Notes' 'ImporterPipelineBRAPH2' 'ExporterPipelineBRAPH2'}; 
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
    delete([fileparts(which('braph2')) filesep() 'src' filesep() 'gui' filesep() 'layouts' filesep() el_class '.layout'])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    ['test_' el_class]
    eval(['test_' el_class])
end

%% src/nn
el_path = '/src/nn';
el_class_list = { 'NNDatasetCombine'}; 
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
    delete([fileparts(which('braph2')) filesep() 'src' filesep() 'gui' filesep() 'layouts' filesep() el_class '.layout'])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    ['test_' el_class]
    eval(['test_' el_class])
end

%% neuralnetworks
el_path = '/neuralnetworks';
%el_class_list = {'NNFeatureImportanceBrainSurfacePF_x_xSPP_Layer' 'NNFeatureImportanceBrainSurfacePF_x_xUPP_Layer' 'NNFeatureImportanceBrainSurfacePF_Measure_NS' 'NNFeatureImportanceBrainSurfacePF_Measure_NU' 'NNFeatureImportanceBrainSurface' 'NNFeatureImportanceBrainSurfacePP_Data' 'NNFeatureImportanceBrainSurfacePP_Graph' 'NNFeatureImportanceBrainSurfacePP_Measure' 'NNRegressorMLP_EvaluatorPF_Scatter' 'NNRegressorMLP_CrossValidationPF_Scatter' 'NNClassifierMLP_EvaluatorPF_ROC' 'NNClassifierMLP_CrossValidation' 'NNClassifierMLP_CrossValidationPF_ROC' 'NNClassifierMLP' 'NNClassifierMLP_Evaluator' }; 
el_class_list = {'NNFeatureImportanceBrainSurfacePF_x_xSPP_Layer' 'NNFeatureImportanceBrainSurfacePF_x_xUPP_Layer'}; 
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
    delete([fileparts(which('braph2')) filesep() 'src' filesep() 'gui' filesep() 'layouts' filesep() el_class '.layout'])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
end
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    ['test_' el_class]
    eval(['test_' el_class])
end

%% ROLLCALL FUNCTIONS
    function bool = compile_dir(dir)
        rollcall = {'+ds_examples', '+gui_examples', '-sandbox'};
        bool = any(ismember({['+' dir], ['+' dir '*']}, rollcall)) ...
            || ~any(ismember({['-' dir], ['-' dir '*']}, rollcall));
    end
    function bool = compile_el(dir, el)
        rollcall = {'+ds_examples', '+gui_examples', '-sandbox'};
        if any(ismember(['-' dir], rollcall))
            bool = false;
        elseif any(ismember(['-' el], rollcall))
            bool = false;
        elseif any(ismember(['+' dir], rollcall)) ...
                && ~any(ismember(['+' el], rollcall))
            bool = false;
        else
            bool = true;
        end
    end
    function bool = compile_pip_dir(pip_dir)
        rollcall = {'+ds_examples', '+gui_examples', '-sandbox'};
        if any(ismember('-pipelines', rollcall))
            bool = false;
        elseif any(ismember(['-' pip_dir], rollcall))
            bool = false;
        elseif any(ismember('+pipelines', rollcall)) ...
                && ~any(ismember({['+' pip_dir], ['+' pip_dir '*']}, rollcall))
            bool = false;
        else
            bool = true;
        end
    end
    function bool = compile_pip_el(pip_dir, pip_el)
        rollcall = {'+ds_examples', '+gui_examples', '-sandbox'};
        if any(ismember('-pipelines', rollcall))
            bool = false;
        elseif any(ismember(['-' pip_dir], rollcall))
            bool = false;
        elseif any(ismember(['-' pip_el], rollcall))
            bool = false;
        elseif any(ismember(['+' pip_dir], rollcall)) ...
                && ~any(ismember(['+' pip_el], rollcall))
            bool = false;
        else
            bool = true;
        end
    end