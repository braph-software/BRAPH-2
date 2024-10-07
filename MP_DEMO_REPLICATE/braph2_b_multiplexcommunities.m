%%%%%%%%%%%%%%%% CALCULATION OF MULTIPLEX COMMUNITIES %%%%%%%%%%%%%%%%

clear variables %#ok<*NASGU>

%% Load BrainAtlas
%dir_root = '/Users/anna.canal.garcia/Documents/PhD/BRAPH 2.0/HCP_100U';
dir_root = '/Users/iok-ui/Documents/GitHub/BRAPH-2/MP_DEMO_REPLICATE/HCP_100U_braph2format';
im_ba = ImporterBrainAtlasXLS('FILE', [dir_root filesep 'bna_atlas.xlsx']);
ba = im_ba.get('BA');

%% Load Groups of SubjectFUN
im_gr1 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [dir_root filesep 'fMRI/Women'], ...
    'BA', ba ...
    );

gr1_women_FUN = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [dir_root filesep 'fMRI/Men'], ...
    'BA', ba ...
    );

gr2_men_FUN = im_gr2.get('GR');

%% Load Groups of SubjectCON 
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [dir_root filesep 'DTI/fa_thresh_consistency_10/Women'], ...
    'BA', ba ...
    );

gr1_women_CON = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [dir_root filesep 'DTI/fa_thresh_consistency_10/Men'], ...
    'BA', ba ...
    );

gr2_men_CON = im_gr2.get('GR');

%% Combine Groups of SubjectCON with Groups of SubjectFUN
co_gr1 = CombineGroups_CON_FUN_MP( ...
    'GR_CON', gr1_women_CON, ...
    'GR_FUN', gr1_women_FUN ...
    );

gr1_women = co_gr1.get('GR_CON_FUN_MP');  % Women group

co_gr2 = CombineGroups_CON_FUN_MP( ...
    'GR_CON', gr2_men_CON, ...
    'GR_FUN', gr2_men_FUN ...
    );

gr2_men = co_gr2.get('GR_CON_FUN_MP');  % Men group

%% Pipeline Connectivity-Functional Multiplex Group Average Analysis WU 
% ITERATING MULTILAYER COMMUNITIES
% TRY COMBINATION OF PARAMETERS
regions = 246;
gamma = 1.1; %[1, 1.01, 1.02];
omega = 2; %[1, 1.25, 1.5, 1.75, 2];
mcs_combination_g1_l1 = zeros(regions, length(omega)*length(gamma));
mcs_combination_g2_l1 = zeros(regions, length(omega)*length(gamma));
mcs_combination_g1_l2 = zeros(regions, length(omega)*length(gamma));
mcs_combination_g2_l2 = zeros(regions, length(omega)*length(gamma));

count = 1;
for i = gamma
    for j = omega
        analysis_g1 = AnalyzeGroup_CON_FUN_MP_GA_WU( ...
            'GR', gr1_women ...
            );
        analysis_g2 = AnalyzeGroup_CON_FUN_MP_GA_WU( ...
            'GR', gr2_men ...
            );
   
        [S1,Q1,n_it1_om, analysis_g1final] = iterated_genlouvain(analysis_g1, gr1_women, i, j);
        [S2,Q2,n_it2_om, analysis_g2final] = iterated_genlouvain(analysis_g2, gr2_men, i, j);
        S1 = reshape(S1, regions, 2);
        multilayer_community_structure_g1 = cell(2, 1);
        S2 = reshape(S2, regions, 2);
        multilayer_community_structure_g2 = cell(2, 1);

        for li = 1:1:2
            multilayer_community_structure_g1(li) = {S1(:, li)};
            multilayer_community_structure_g2(li) = {S2(:, li)};
        end
        mcs_combination_g1_l1(:, count) = multilayer_community_structure_g1{1};
        mcs_combination_g2_l1(:, count) = multilayer_community_structure_g2{1};       
        mcs_combination_g1_l2(:, count) = multilayer_community_structure_g1{2};
        mcs_combination_g2_l2(:, count) = multilayer_community_structure_g2{2};
        count = count +1;
    end
end

save('MP_communities.mat')

% % % % create a pipeline
% % % pipeline = Pipeline();
% % % pipeline.set('LABEL', 'Pipeline Connectivity-Functional Multiplex Group Average WU');
% % % pipeline.set('NOTES', 'Pipeline Connectivity-Functional Multiplex Group Average WU to calculate the multiplex group communities');
% % % pipeline.set('PS_DICT', Pipeline.getPropDefault('PS_DICT'))
% % % 
% % % atlas
% % % ps1 = PipelineSection('ID', int2str(1), 'LABEL', 'Brain Atlas');
% % % pipeline.get('PS_DICT').get('ADD', ps1);
% % % ps1.set('PC_DICT', PipelineSection.getPropDefault('PC_DICT'));
% % % pc1 = PipelineCode( ...
% % %     'ID', int2str(1), ...
% % %     'MONIKER', 'ba', ...
% % %     'TEXT_BEFORE_EXEC', 'Load Brain Atlas', ...
% % %     'TEXT_AFTER_EXEC', 'Brain Atlas', ...
% % %     'EL', ba ...
% % %     );
% % % ps1.get('PC_DICT').get('ADD', pc1);
% % % 
% % % groups
% % % ps2 = PipelineSection('ID', int2str(2), 'LABEL', 'Group');
% % % 
% % % pipeline.get('PS_DICT').get('ADD', ps2);
% % % ps2.set('PC_DICT', PipelineSection.getPropDefault('PC_DICT'));
% % % pc2 = PipelineCode( ...
% % %     'ID', int2str(1), ...
% % %     'MONIKER', 'gr1', ...
% % %     'TEXT_BEFORE_EXEC', 'Load Group 1', ...
% % %     'TEXT_AFTER_EXEC', 'Women Group', ...
% % %     'EL', gr1_women ...
% % %     );
% % % ps2.get('PC_DICT').get('ADD', pc2);
% % % 
% % % pc3 = PipelineCode( ...
% % %     'ID', int2str(2), ...
% % %     'MONIKER', 'gr2', ...
% % %     'TEXT_BEFORE_EXEC', 'Load Group 2', ...
% % %     'TEXT_AFTER_EXEC', 'Men Group', ...
% % %     'EL', gr2_men ...
% % %     );
% % % ps2.get('PC_DICT').get('ADD', pc3);
% % % 
% % % analysis
% % % ps3 = PipelineSection('ID', int2str(3), 'LABEL', 'Analysis');
% % % 
% % % pipeline.get('PS_DICT').get('ADD', ps3);
% % % ps3.set('PC_DICT', PipelineSection.getPropDefault('PC_DICT'));
% % % pc4 = PipelineCode( ...
% % %     'ID', int2str(1), ...
% % %     'MONIKER', 'A1', ...
% % %     'TEXT_BEFORE_EXEC', 'Analyze Group 1', ...
% % %     'TEXT_AFTER_EXEC', 'Analysis Women', ...
% % %     'EL', analysis_g1final ...
% % %     );
% % % ps3.get('PC_DICT').get('ADD', pc4);
% % % 
% % % pc5 = PipelineCode( ...
% % %     'ID', int2str(2), ...
% % %     'MONIKER', 'A2', ...
% % %     'TEXT_BEFORE_EXEC', 'Analyze Group 2', ...
% % %     'TEXT_AFTER_EXEC', 'Analysis Men', ...
% % %     'EL', analysis_g2final ...
% % %     );
% % % ps3.get('PC_DICT').get('ADD', pc5);
% % % 
% % % % Save the pipeline
% % % Element.save(pipeline, 'pipeline_multiplexcommunities_GA_WU_beta.b2', [])
% % % 
% % % % Open the GUI with this pipeline
% % % gui = GUIElement( ...
% % %     'PE', pipeline, ...
% % %     'WAITBAR', true, ...
% % %     'CLOSEREQ', true ...
% % %     );
% % % 
% % % gui.get('DRAW')
% % % gui.get('SHOW')
% % % 
% % % % Load the pipeline
% % % [file, path, filterindex] = uigetfile(BRAPH2.EXT_PIPELINE, 'Select BRAPH2 file');
% % % if filterindex
% % %     pip_load = ImporterPipelineBRAPH2( ...
% % %         'FILE', fullfile(path, file), ...
% % %         'WAITBAR', true ...
% % %         ).get('PIP');
% % % end

% extra functions

function [S, Q, n_it, analysis] = iterated_genlouvain(analysis, group, gamma, omega)
% Optimise modularity-like quality function by iterating GenLouvain until convergence.
% (i.e., until output partition does not change between two successive iterations)
%
% Adapted from https://github.com/GenLouvain/GenLouvain/blob/master/iterated_genlouvain.m

S_old = [];
n_it = 1;

g = analysis.memorize('G');
measurement_mcs = g.get('MEASURE', 'MultilayerCommunity', 'GAMMA', gamma, 'OMEGA', omega);
S = cell2mat(measurement_mcs.memorize('M'));
measurement_mmod = g.get('MEASURE', 'MultilayerM', 'GAMMA', gamma, 'OMEGA', omega);
Q = cell2mat(measurement_mmod.memorize('M'));

Q_old=-inf;
while ~isequal(S, S_old) && (Q-Q_old)>10*eps
    n_it = n_it+1;
    S_old = S;
    Q_old = Q;
    
    analysis = AnalyzeGroup_CON_FUN_MP_GA_WU( ...
        'GR', group ...
        );
    g = analysis.memorize('G');
    measurement_mcs = g.get('MEASURE', 'MultilayerCommunity', 'GAMMA', gamma, 'OMEGA', omega, 'S0', S);
    S = cell2mat(measurement_mcs.memorize('M'));
    measurement_mmod = g.get('MEASURE', 'MultilayerM', 'GAMMA', gamma, 'OMEGA', omega, 'S0', S);
    Q = cell2mat(measurement_mmod.memorize('M'));
end

end
