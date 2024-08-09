close all; delete(findall(0, 'type', 'figure')); clear all; clc

%% neural network
el_path = '/neuralnetworks';
%el_class_list = {'NNDataPoint_Shuffled' 'NNxMLP_FeatureImportance' 'NNxMLP_FeatureImportance_CV' 'NNxMLP_FeatureImportanceAcrossMeasures' 'NNxMLP_FeatureImportanceAcrossMeasures_CV'}; 
el_class_list = { 'NNxMLP_FeatureImportance_CV' 'NNxMLP_FeatureImportanceAcrossMeasures' 'NNxMLP_FeatureImportanceAcrossMeasures_CV'}; 
%el_class_list = {'NNDataPoint_Shuffled' 'NNxMLP_FeatureImportance' 'NNxMLP_FeatureImportanceBrainSurface' 'NNFeatureImportanceBrainSurfacePF_Measure_NU' 'NNFeatureImportanceBrainSurfacePF_Measure_NS' 'NNxMLP_FeatureImportanceAcrossMeasures' 'NNxMLP_FeatureImportance_CrossValidation' 'NNxMLP_FeatureImportanceAcrossMeasures_CrossValidation' 'NNxMLP_FeatureImportanceBrainSurface_CrossValidation' 'NNFeatureImportanceBrainSurfacePP_Measure'}; 
%el_class_list = {'NNDataPoint_Measure_CLA' 'NNDataPoint_Measure_REG' 'NNFeatureImportanceMeasure', 'NNFeatureImportanceBrainSurface', 'NNFeatureImportanceBrainSurfacePP_Data', 'NNFeatureImportanceBrainSurfacePP_Graph', 'NNFeatureImportanceBrainSurfacePP_Measure', 'NNFeatureImportanceBrainSurfacePF_Measure', 'NNFeatureImportanceBrainSurfacePF_Measure_NU', 'NNFeatureImportanceBrainSurfacePF_Measure_NS', 'NNFeatureImportanceBrainSurfacePF_Measure_NB', 'NNFeatureImportanceBrainSurfacePF_Measure_GU', 'NNFeatureImportanceBrainSurfacePF_Measure_GS', 'NNFeatureImportanceBrainSurfacePF_Measure_GB', 'NNFeatureImportanceBrainSurfacePF_Measure_BU', 'NNFeatureImportanceBrainSurfacePF_Measure_BS', 'NNFeatureImportanceBrainSurfacePF_Measure_BB', 'NNFeatureImportanceBrainSurfacePF_x_xUPP_Layer', 'NNFeatureImportanceBrainSurfacePF_x_xSPP_Layer'}; 
%el_class_list = {'NNFeatureImportanceBrainSurfacePP_Graph', 'NNFeatureImportanceBrainSurfacePP_Measure', 'NNFeatureImportanceBrainSurfacePF_Measure', 'NNFeatureImportanceBrainSurfacePF_Measure_NU', 'NNFeatureImportanceBrainSurfacePF_Measure_NS', 'NNFeatureImportanceBrainSurfacePF_Measure_NB', 'NNFeatureImportanceBrainSurfacePF_Measure_GU', 'NNFeatureImportanceBrainSurfacePF_Measure_GS', 'NNFeatureImportanceBrainSurfacePF_Measure_GB', 'NNFeatureImportanceBrainSurfacePF_Measure_BU', 'NNFeatureImportanceBrainSurfacePF_Measure_BS', 'NNFeatureImportanceBrainSurfacePF_Measure_BB', 'NNFeatureImportanceBrainSurfacePF_x_xUPP_Layer', 'NNFeatureImportanceBrainSurfacePF_x_xSPP_Layer'}; 
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