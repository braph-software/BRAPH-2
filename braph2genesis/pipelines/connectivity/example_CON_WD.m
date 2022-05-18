%EXAMPLE_CON_WD
% Script example pipeline CON WD

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('example_CON_WD')) filesep 'example data CON (DTI)' filesep 'desikan_atlas.xlsx'], ... 
    'WAITBAR', true ...
    );
%TODO: example_CON_WD data
ba = im_ba.get('BA');

%% Load Groups of SubjectCON
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('example_CON_WD')) filesep 'example data CON (DTI)' filesep 'xls' filesep 'GroupName1'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('example_CON_WD')) filesep 'example data CON (DTI)' filesep 'xls' filesep 'GroupName2'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis CON WU
a_WD1 = AnalyzeEnsemble_CON_WD( ...
    'GR', gr1 ...
    );

a_WD2 = AnalyzeEnsemble_CON_WD( ...
    'GR', gr2 ...
    );

% measure calculation
degree_WD1 = a_WD1.getMeasureEnsemble('OutDegree').get('M');
degree_av_WD1 = a_WD1.getMeasureEnsemble('InDegreeAv').get('M');
distance_WD1 = a_WD1.getMeasureEnsemble('Distance').get('M');

degree_WD2 = a_WD2.getMeasureEnsemble('OutDegree').get('M');
degree_av_WD2 = a_WD2.getMeasureEnsemble('InDegreeAv').get('M');
distance_WD2 = a_WD2.getMeasureEnsemble('Distance').get('M');

% comparison
c_WD = CompareEnsemble( ...
    'P', 10, ...
    'A1', a_WD1, ...
    'A2', a_WD2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

out_degree_WD_diff = c_WD.getComparison('OutDegree').get('DIFF');
out_degree_WD_p1 = c_WD.getComparison('OutDegree').get('P1');
out_degree_WD_p2 = c_WD.getComparison('OutDegree').get('P2');
out_degree_WD_cil = c_WD.getComparison('OutDegree').get('CIL');
out_degree_WD_ciu = c_WD.getComparison('OutDegree').get('CIU');

in_degree_av_WD_diff = c_WD.getComparison('InDegreeAv').get('DIFF');
in_degree_av_WD_p1 = c_WD.getComparison('InDegreeAv').get('P1');
in_degree_av_WD_p2 = c_WD.getComparison('InDegreeAv').get('P2');
in_degree_av_WD_cil = c_WD.getComparison('InDegreeAv').get('CIL');
in_degree_av_WD_ciu = c_WD.getComparison('InDegreeAv').get('CIU');

distance_WU_diff = c_WD.getComparison('Distance').get('DIFF');
distance_WU_p1 = c_WD.getComparison('Distance').get('P1');
distance_WU_p2 = c_WD.getComparison('Distance').get('P2');
distance_WU_cil = c_WD.getComparison('Distance').get('CIL');
distance_WU_ciu = c_WD.getComparison('Distance').get('CIU');