function [target_dir, source_dir] = genesis(target_dir, source_dir, run_number)
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
%  RUN_NUMBER times. RUN_NUMBER = 2 improves the computational efficiency
%  of the code  mainly by hardcoding some intermediate values.
%
% See also braph2genesis, create_Element, create_test_Element.

fp = filesep();

if nargin < 3
    run_number = 1;
end

if nargin < 2 || isempty(source_dir)
    source_dir = fileparts(which('braph2genesis'));
end

if nargin < 1 || isempty(target_dir)
    target_dir = [fileparts(source_dir) fp 'braph2'];
end

disp('¡ BRAPH 2.0 Genesis')
disp(['¡ source dir: ' source_dir])
disp(['¡ target dir: ' target_dir])
disp(' ')

%% CREATE DIR STRUCTURE
% braph2
mkdir(target_dir)

disp('¡! created target dir')

% src
mkdir([target_dir fp 'src' fp 'util'])
mkdir([target_dir fp 'src' fp 'ds'])
mkdir([target_dir fp 'src' fp 'atlas'])
mkdir([target_dir fp 'src' fp 'cohort'])
mkdir([target_dir fp 'src' fp 'gt'])
mkdir([target_dir fp 'src' fp 'analysis'])
mkdir([target_dir fp 'src' fp 'gui'])

disp('¡! created dir structure - SRC')

% brainsurfs
mkdir([target_dir fp 'brainsurfs'])

disp('¡! created dir structure - BRAINGRAPHS')

% graphs
mkdir([target_dir fp 'graphs'])

disp('¡! created dir structure - GRAPHS')

% measures
mkdir([target_dir fp 'measures'])
mkdir([target_dir fp 'measures' fp 'MEX_SRC'])
mkdir([target_dir fp 'measures' fp 'MEX_SRC' fp 'matlab_matrix'])
mkdir([target_dir fp 'measures' fp 'private'])

disp('¡! created dir structure - MEASURES')

% workflows
mkdir([target_dir fp 'workflows'])
mkdir([target_dir fp 'workflows' fp 'structural'])
mkdir([target_dir fp 'workflows' fp 'functional'])
mkdir([target_dir fp 'workflows' fp 'connectivity'])

disp('¡! created dir structure - WORKFLOWS')

% test
mkdir([target_dir fp 'test'])

disp('¡! created dir structure - TEST')

disp(' ')

%% COPY READY FILES
% braph2.m and license.rtf
copyfile([source_dir fp 'braph2' fp 'braph2.m'], [target_dir fp 'braph2.m'])
copyfile([source_dir fp 'license.rtf'], [target_dir fp 'license.rtf'])
disp('¡! copied ready files - braph2')

% src
copyfile([source_dir fp 'src' fp 'util' fp 'BRAPH2.m'], [target_dir fp 'src' fp 'util' fp 'BRAPH2.m'])
copyfile([source_dir fp 'src' fp 'util' fp 'tostring.m'], [target_dir fp 'src' fp 'util' fp 'tostring.m'])
copyfile([source_dir fp 'src' fp 'util' fp 'subclasses.m'], [target_dir fp 'src' fp 'util' fp 'subclasses.m'])
copyfile([source_dir fp 'src' fp 'util' fp 'clean_varargin.m'], [target_dir fp 'src' fp 'util' fp 'clean_varargin.m'])
copyfile([source_dir fp 'src' fp 'util' fp 'test_clean_varargin.m'], [target_dir fp 'src' fp 'util' fp 'test_clean_varargin.m'])
copyfile([source_dir fp 'src' fp 'util' fp 'copy_varargin.m'], [target_dir fp 'src' fp 'util' fp 'copy_varargin.m'])
copyfile([source_dir fp 'src' fp 'util' fp 'test_copy_varargin.m'], [target_dir fp 'src' fp 'util' fp 'test_copy_varargin.m'])
copyfile([source_dir fp 'src' fp 'util' fp 'get_from_varargin.m'], [target_dir fp 'src' fp 'util' fp 'get_from_varargin.m'])
copyfile([source_dir fp 'src' fp 'util' fp 'test_get_from_varargin.m'], [target_dir fp 'src' fp 'util' fp 'test_get_from_varargin.m'])
copyfile([source_dir fp 'src' fp 'util' fp 'icon_axis.png'], [target_dir fp 'src' fp 'util' fp 'icon_axis.png'])
copyfile([source_dir fp 'src' fp 'util' fp 'icon_br.png'], [target_dir fp 'src' fp 'util' fp 'icon_br.png'])
copyfile([source_dir fp 'src' fp 'util' fp 'icon_brain.png'], [target_dir fp 'src' fp 'util' fp 'icon_brain.png'])
copyfile([source_dir fp 'src' fp 'util' fp 'icon_grid.png'], [target_dir fp 'src' fp 'util' fp 'icon_grid.png'])
copyfile([source_dir fp 'src' fp 'util' fp 'icon_id.png'], [target_dir fp 'src' fp 'util' fp 'icon_id.png'])
copyfile([source_dir fp 'src' fp 'util' fp 'icon_label.png'], [target_dir fp 'src' fp 'util' fp 'icon_label.png'])
copyfile([source_dir fp 'src' fp 'util' fp 'icon_settings.png'], [target_dir fp 'src' fp 'util' fp 'icon_settings.png'])
copyfile([source_dir fp 'src' fp 'util' fp 'icon_sphere.png'], [target_dir fp 'src' fp 'util' fp 'icon_sphere.png'])
copyfile([source_dir fp 'src' fp 'util' fp 'icon_symbol.png'], [target_dir fp 'src' fp 'util' fp 'icon_symbol.png'])
copyfile([source_dir fp 'src' fp 'util' fp 'icon_view_3d.png'], [target_dir fp 'src' fp 'util' fp 'icon_view_3d.png'])
copyfile([source_dir fp 'src' fp 'util' fp 'icon_view_ad.png'], [target_dir fp 'src' fp 'util' fp 'icon_view_ad.png'])
copyfile([source_dir fp 'src' fp 'util' fp 'icon_view_av.png'], [target_dir fp 'src' fp 'util' fp 'icon_view_av.png'])
copyfile([source_dir fp 'src' fp 'util' fp 'icon_view_ca.png'], [target_dir fp 'src' fp 'util' fp 'icon_view_ca.png'])
copyfile([source_dir fp 'src' fp 'util' fp 'icon_view_cp.png'], [target_dir fp 'src' fp 'util' fp 'icon_view_cp.png'])
copyfile([source_dir fp 'src' fp 'util' fp 'icon_view_sl.png'], [target_dir fp 'src' fp 'util' fp 'icon_view_sl.png'])
copyfile([source_dir fp 'src' fp 'util' fp 'icon_view_sr.png'], [target_dir fp 'src' fp 'util' fp 'icon_view_sr.png'])

disp('¡! copied ready files - util')

copyfile([source_dir fp 'src' fp 'ds' fp 'Category.m'], [target_dir fp 'src' fp 'ds' fp 'Category.m'])
copyfile([source_dir fp 'src' fp 'ds' fp 'test_Category.m'], [target_dir fp 'src' fp 'ds' fp 'test_Category.m'])
copyfile([source_dir fp 'src' fp 'ds' fp 'Format.m'], [target_dir fp 'src' fp 'ds' fp 'Format.m'])
copyfile([source_dir fp 'src' fp 'ds' fp 'test_Format.m'], [target_dir fp 'src' fp 'ds' fp 'test_Format.m'])
copyfile([source_dir fp 'src' fp 'ds' fp 'Element.m'], [target_dir fp 'src' fp 'ds' fp 'Element.m'])
copyfile([source_dir fp 'src' fp 'ds' fp 'test_Element.m'], [target_dir fp 'src' fp 'ds' fp 'test_Element.m'])
disp('¡! copied ready files - ds')

copyfile([source_dir fp 'src' fp 'gt' fp 'histogram.m'], [target_dir fp 'src' fp 'gt' fp 'histogram.m'])
copyfile([source_dir fp 'src' fp 'gt' fp 'binarize.m'], [target_dir fp 'src' fp 'gt' fp 'binarize.m'])
copyfile([source_dir fp 'src' fp 'gt' fp 'test_binarize.m'], [target_dir fp 'src' fp 'gt' fp 'test_binarize.m'])
copyfile([source_dir fp 'src' fp 'gt' fp 'dediagonalize.m'], [target_dir fp 'src' fp 'gt' fp 'dediagonalize.m'])
copyfile([source_dir fp 'src' fp 'gt' fp 'test_dediagonalize.m'], [target_dir fp 'src' fp 'gt' fp 'test_dediagonalize.m'])
copyfile([source_dir fp 'src' fp 'gt' fp 'diagonalize.m'], [target_dir fp 'src' fp 'gt' fp 'diagonalize.m'])
copyfile([source_dir fp 'src' fp 'gt' fp 'test_diagonalize.m'], [target_dir fp 'src' fp 'gt' fp 'test_diagonalize.m'])
copyfile([source_dir fp 'src' fp 'gt' fp 'semipositivize.m'], [target_dir fp 'src' fp 'gt' fp 'semipositivize.m'])
copyfile([source_dir fp 'src' fp 'gt' fp 'test_semipositivize.m'], [target_dir fp 'src' fp 'gt' fp 'test_semipositivize.m'])
copyfile([source_dir fp 'src' fp 'gt' fp 'standardize.m'], [target_dir fp 'src' fp 'gt' fp 'standardize.m'])
copyfile([source_dir fp 'src' fp 'gt' fp 'test_standardize.m'], [target_dir fp 'src' fp 'gt' fp 'test_standardize.m'])
copyfile([source_dir fp 'src' fp 'gt' fp 'symmetrize.m'], [target_dir fp 'src' fp 'gt' fp 'symmetrize.m'])
copyfile([source_dir fp 'src' fp 'gt' fp 'test_symmetrize.m'], [target_dir fp 'src' fp 'gt' fp 'test_symmetrize.m'])
disp('¡! copied ready files - gt')

copyfile([source_dir fp 'measures' fp 'MEX_SRC' fp 'group_handler.cpp'], [target_dir fp 'measures' fp 'MEX_SRC' fp 'group_handler.cpp'])
copyfile([source_dir fp 'measures' fp 'MEX_SRC' fp 'group_handler.h'], [target_dir fp 'measures' fp 'MEX_SRC' fp 'group_handler.h'])
copyfile([source_dir fp 'measures' fp 'MEX_SRC' fp 'group_index.cpp'], [target_dir fp 'measures' fp 'MEX_SRC' fp 'group_index.cpp'])
copyfile([source_dir fp 'measures' fp 'MEX_SRC' fp 'group_index.h'], [target_dir fp 'measures' fp 'MEX_SRC' fp 'group_index.h'])
copyfile([source_dir fp 'measures' fp 'MEX_SRC' fp 'metanetwork_reduce.cpp'], [target_dir fp 'measures' fp 'MEX_SRC' fp 'metanetwork_reduce.cpp'])
copyfile([source_dir fp 'measures' fp 'MEX_SRC' fp 'mex.xcconfig'], [target_dir fp 'measures' fp 'MEX_SRC' fp 'mex.xcconfig'])
copyfile([source_dir fp 'measures' fp 'MEX_SRC' fp 'matlab_matrix' fp 'full.cpp'], [target_dir fp 'measures' fp 'MEX_SRC' fp 'matlab_matrix' fp 'full.cpp'])
copyfile([source_dir fp 'measures' fp 'MEX_SRC' fp 'matlab_matrix' fp 'matlab_matrix.h'], [target_dir fp 'measures' fp 'MEX_SRC' fp 'matlab_matrix' fp 'matlab_matrix.h'])
copyfile([source_dir fp 'measures' fp 'MEX_SRC' fp 'matlab_matrix' fp 'sparse.cpp'], [target_dir fp 'measures' fp 'MEX_SRC' fp 'matlab_matrix' fp 'sparse.cpp'])
copyfile([source_dir fp 'measures' fp 'private' fp 'group_handler.mexa64'], [target_dir fp 'measures' fp 'private' fp 'group_handler.mexa64'])
copyfile([source_dir fp 'measures' fp 'private' fp 'group_handler.mexmaci64'], [target_dir fp 'measures' fp 'private' fp 'group_handler.mexmaci64'])
copyfile([source_dir fp 'measures' fp 'private' fp 'group_handler.mexw64'], [target_dir fp 'measures' fp 'private' fp 'group_handler.mexw64'])
copyfile([source_dir fp 'measures' fp 'private' fp 'metanetwork_reduce.mexa64'], [target_dir fp 'measures' fp 'private' fp 'metanetwork_reduce.mexa64'])
copyfile([source_dir fp 'measures' fp 'private' fp 'metanetwork_reduce.mexmaci64'], [target_dir fp 'measures' fp 'private' fp 'metanetwork_reduce.mexmaci64'])
copyfile([source_dir fp 'measures' fp 'private' fp 'metanetwork_reduce.mexw64'], [target_dir fp 'measures' fp 'private' fp 'metanetwork_reduce.mexw64'])
disp('¡! copied ready files - measures')

copyfile([source_dir fp 'src' fp 'analysis' fp 'Correlation.m'], [target_dir fp 'src' fp 'analysis' fp 'Correlation.m'])
copyfile([source_dir fp 'src' fp 'analysis' fp 'test_Correlation.m'], [target_dir fp 'src' fp 'analysis' fp 'test_Correlation.m'])
copyfile([source_dir fp 'src' fp 'analysis' fp 'permutation.m'], [target_dir fp 'src' fp 'analysis' fp 'permutation.m'])
copyfile([source_dir fp 'src' fp 'analysis' fp 'test_permutation.m'], [target_dir fp 'src' fp 'analysis' fp 'test_permutation.m'])
copyfile([source_dir fp 'src' fp 'analysis' fp 'pvalue1.m'], [target_dir fp 'src' fp 'analysis' fp 'pvalue1.m'])
copyfile([source_dir fp 'src' fp 'analysis' fp 'test_pvalue1.m'], [target_dir fp 'src' fp 'analysis' fp 'test_pvalue1.m'])
copyfile([source_dir fp 'src' fp 'analysis' fp 'pvalue2.m'], [target_dir fp 'src' fp 'analysis' fp 'pvalue2.m'])
copyfile([source_dir fp 'src' fp 'analysis' fp 'test_pvalue2.m'], [target_dir fp 'src' fp 'analysis' fp 'test_pvalue2.m'])
copyfile([source_dir fp 'src' fp 'analysis' fp 'bonferroni.m'], [target_dir fp 'src' fp 'analysis' fp 'bonferroni.m'])
copyfile([source_dir fp 'src' fp 'analysis' fp 'test_bonferroni.m'], [target_dir fp 'src' fp 'analysis' fp 'test_bonferroni.m'])
copyfile([source_dir fp 'src' fp 'analysis' fp 'fdr.m'], [target_dir fp 'src' fp 'analysis' fp 'fdr.m'])
copyfile([source_dir fp 'src' fp 'analysis' fp 'test_fdr.m'], [target_dir fp 'src' fp 'analysis' fp 'test_fdr.m'])
copyfile([source_dir fp 'src' fp 'analysis' fp 'quantiles.m'], [target_dir fp 'src' fp 'analysis' fp 'quantiles.m'])
copyfile([source_dir fp 'src' fp 'analysis' fp 'test_quantiles.m'], [target_dir fp 'src' fp 'analysis' fp 'test_quantiles.m'])
disp('¡! copied ready files - analysis')

copyfile([source_dir fp 'src' fp 'gui' fp 'GUI.m'], [target_dir fp 'src' fp 'gui' fp 'GUI.m'])
disp('¡! copied ready files - gt')

disp(' ')

copyfile([source_dir fp 'brainsurfs' fp 'human_Cerebellum.nv'], [target_dir fp 'brainsurfs' fp 'human_Cerebellum.nv'])
copyfile([source_dir fp 'brainsurfs' fp 'human_Ch2_smoothed.nv'], [target_dir fp 'brainsurfs' fp 'human_Ch2_smoothed.nv'])
copyfile([source_dir fp 'brainsurfs' fp 'human_Ch2.nv'], [target_dir fp 'brainsurfs' fp 'human_Ch2.nv'])
copyfile([source_dir fp 'brainsurfs' fp 'human_Ch2withCerebellum.nv'], [target_dir fp 'brainsurfs' fp 'human_Ch2withCerebellum.nv'])
copyfile([source_dir fp 'brainsurfs' fp 'human_ICBM152_smoothed.nv'], [target_dir fp 'brainsurfs' fp 'human_ICBM152_smoothed.nv'])
copyfile([source_dir fp 'brainsurfs' fp 'human_ICBM152_smoothed_tal.nv'], [target_dir fp 'brainsurfs' fp 'human_ICBM152_smoothed_tal.nv'])
copyfile([source_dir fp 'brainsurfs' fp 'human_ICBM152_tal.nv'], [target_dir fp 'brainsurfs' fp 'human_ICBM152_tal.nv'])
copyfile([source_dir fp 'brainsurfs' fp 'human_ICBM152.nv'], [target_dir fp 'brainsurfs' fp 'human_ICBM152.nv'])
copyfile([source_dir fp 'brainsurfs' fp 'human_ICBM152Left.nv'], [target_dir fp 'brainsurfs' fp 'human_ICBM152Left.nv'])
copyfile([source_dir fp 'brainsurfs' fp 'human_ICBM152Left_smoothed.nv'], [target_dir fp 'brainsurfs' fp 'human_ICBM152Left_smoothed.nv'])
copyfile([source_dir fp 'brainsurfs' fp 'human_ICBM152Right.nv'], [target_dir fp 'brainsurfs' fp 'human_ICBM152Right.nv'])
copyfile([source_dir fp 'brainsurfs' fp 'ferret.nv'], [target_dir fp 'brainsurfs' fp 'ferret.nv'])
copyfile([source_dir fp 'brainsurfs' fp 'human.nv'], [target_dir fp 'brainsurfs' fp 'human.nv'])
copyfile([source_dir fp 'brainsurfs' fp 'macaque.nv'], [target_dir fp 'brainsurfs' fp 'macaque.nv'])
copyfile([source_dir fp 'brainsurfs' fp 'mouse.nv'], [target_dir fp 'brainsurfs' fp 'mouse.nv'])
copyfile([source_dir fp 'brainsurfs' fp 'rat.nv'], [target_dir fp 'brainsurfs' fp 'rat.nv'])
disp('¡! copied ready files - brainsurf')

disp(' ')

% workflows
copyfile([source_dir fp 'workflows' fp 'structural' fp 'example_ST_WU.m'], [target_dir fp 'workflows' fp 'structural' fp 'example_ST_WU.m'])
% copyfile([source_dir fp 'workflows' fp 'structural' fp 'example_ST_BUT.m'], [target_dir fp 'workflows' fp 'structural' fp 'example_ST_BUT.m'])
copyfile([source_dir fp 'workflows' fp 'structural' fp 'example_ST_BUD.m'], [target_dir fp 'workflows' fp 'structural' fp 'example_ST_BUD.m'])
mkdir([target_dir fp 'workflows' fp 'structural' fp 'example data ST (MRI)'])
copyfile([source_dir fp 'workflows' fp 'structural' fp 'example data ST (MRI)' fp 'desikan_atlas.xlsx'], [target_dir fp 'workflows' fp 'structural' fp 'example data ST (MRI)' fp 'desikan_atlas.xlsx'])
mkdir([target_dir fp 'workflows' fp 'structural' fp 'example data ST (MRI)' fp 'xls'])
copyfile([source_dir fp 'workflows' fp 'structural' fp 'example data ST (MRI)' fp 'xls' fp 'ST_group1.xlsx'], [target_dir fp 'workflows' fp 'structural' fp 'example data ST (MRI)' fp 'xls' fp 'ST_group1.xlsx'])
copyfile([source_dir fp 'workflows' fp 'structural' fp 'example data ST (MRI)' fp 'xls' fp 'ST_group2.xlsx'], [target_dir fp 'workflows' fp 'structural' fp 'example data ST (MRI)' fp 'xls' fp 'ST_group2.xlsx'])
mkdir([target_dir fp 'workflows' fp 'structural' fp 'example data ST (MRI)' fp 'txt'])
copyfile([source_dir fp 'workflows' fp 'structural' fp 'example data ST (MRI)' fp 'txt' fp 'ST_group1.txt'], [target_dir fp 'workflows' fp 'structural' fp 'example data ST (MRI)' fp 'txt' fp 'ST_group1.txt'])
copyfile([source_dir fp 'workflows' fp 'structural' fp 'example data ST (MRI)' fp 'txt' fp 'ST_group2.txt'], [target_dir fp 'workflows' fp 'structural' fp 'example data ST (MRI)' fp 'txt' fp 'ST_group2.txt'])
disp('¡! copied ready files - workflow structural')

% copyfile([source_dir fp 'workflows' fp 'functional' fp 'example_FUN_WU.m'], [target_dir fp 'workflows' fp 'functional' fp 'example_FUN_WU.m'])
% copyfile([source_dir fp 'workflows' fp 'functional' fp 'example_FUN_BUT.m'], [target_dir fp 'workflows' fp 'functional' fp 'example_FUN_BUT.m'])
% copyfile([source_dir fp 'workflows' fp 'functional' fp 'example_FUN_BUD.m'], [target_dir fp 'workflows' fp 'functional' fp 'example_FUN_BUD.m'])
mkdir([target_dir fp 'workflows' fp 'functional' fp 'example data FUN (fMRI)'])
copyfile([source_dir fp 'workflows' fp 'functional' fp 'example data FUN (fMRI)' fp 'desikan_atlas.xlsx'], [target_dir fp 'workflows' fp 'functional' fp 'example data FUN (fMRI)' fp 'desikan_atlas.xlsx'])
mkdir([target_dir fp 'workflows' fp 'functional' fp 'example data FUN (fMRI)' fp 'xls'])
mkdir([target_dir fp 'workflows' fp 'functional' fp 'example data FUN (fMRI)' fp 'xls' fp 'GroupName1'])
for i = 1:1:10
    copyfile([source_dir fp 'workflows' fp 'functional' fp 'example data FUN (fMRI)' fp 'xls' fp 'GroupName1' fp 'subject' int2str(i) '.xlsx'], [target_dir fp 'workflows' fp 'functional' fp 'example data FUN (fMRI)' fp 'xls' fp 'GroupName1' fp 'subject' int2str(i) '.xlsx'])
end
mkdir([target_dir fp 'workflows' fp 'functional' fp 'example data FUN (fMRI)' fp 'xls' fp 'GroupName2'])
for i = 11:1:20
    copyfile([source_dir fp 'workflows' fp 'functional' fp 'example data FUN (fMRI)' fp 'xls' fp 'GroupName2' fp 'subject' int2str(i) '.xlsx'], [target_dir fp 'workflows' fp 'functional' fp 'example data FUN (fMRI)' fp 'xls' fp 'GroupName2' fp 'subject' int2str(i) '.xlsx'])
end
mkdir([target_dir fp 'workflows' fp 'functional' fp 'example data FUN (fMRI)' fp 'txt'])
mkdir([target_dir fp 'workflows' fp 'functional' fp 'example data FUN (fMRI)' fp 'txt' fp 'GroupName1'])
for i = 1:1:10
    copyfile([source_dir fp 'workflows' fp 'functional' fp 'example data FUN (fMRI)' fp 'txt' fp 'GroupName1' fp 'subject' int2str(i) '.txt'], [target_dir fp 'workflows' fp 'functional' fp 'example data FUN (fMRI)' fp 'txt' fp 'GroupName1' fp 'subject' int2str(i) '.txt'])
end
mkdir([target_dir fp 'workflows' fp 'functional' fp 'example data FUN (fMRI)' fp 'txt' fp 'GroupName2'])
for i = 11:1:20
    copyfile([source_dir fp 'workflows' fp 'functional' fp 'example data FUN (fMRI)' fp 'txt' fp 'GroupName2' fp 'subject' int2str(i) '.txt'], [target_dir fp 'workflows' fp 'functional' fp 'example data FUN (fMRI)' fp 'txt' fp 'GroupName2' fp 'subject' int2str(i) '.txt'])
end
disp('¡! copied ready files - workflow functional')

copyfile([source_dir fp 'workflows' fp 'connectivity' fp 'example_CON_WU.m'], [target_dir fp 'workflows' fp 'connectivity' fp 'example_CON_WU.m'])
% copyfile([source_dir fp 'workflows' fp 'connectivity' fp 'example_CON_BUT.m'], [target_dir fp 'workflows' fp 'connectivity' fp 'example_CON_BUT.m'])
% copyfile([source_dir fp 'workflows' fp 'connectivity' fp 'example_CON_BUD.m'], [target_dir fp 'workflows' fp 'connectivity' fp 'example_CON_BUD.m'])
mkdir([target_dir fp 'workflows' fp 'connectivity' fp 'example data CON (DTI)'])
copyfile([source_dir fp 'workflows' fp 'connectivity' fp 'example data CON (DTI)' fp 'desikan_atlas.xlsx'], [target_dir fp 'workflows' fp 'connectivity' fp 'example data CON (DTI)' fp 'desikan_atlas.xlsx'])
mkdir([target_dir fp 'workflows' fp 'connectivity' fp 'example data CON (DTI)' fp 'xls'])
mkdir([target_dir fp 'workflows' fp 'connectivity' fp 'example data CON (DTI)' fp 'xls' fp 'GroupName1'])
for i = 1:1:5
    copyfile([source_dir fp 'workflows' fp 'connectivity' fp 'example data CON (DTI)' fp 'xls' fp 'GroupName1' fp 'SubjectID' int2str(i) '.xlsx'], [target_dir fp 'workflows' fp 'connectivity' fp 'example data CON (DTI)' fp 'xls' fp 'GroupName1' fp 'SubjectID' int2str(i) '.xlsx'])
end
mkdir([target_dir fp 'workflows' fp 'connectivity' fp 'example data CON (DTI)' fp 'xls' fp 'GroupName2'])
for i = 1:1:5
    copyfile([source_dir fp 'workflows' fp 'connectivity' fp 'example data CON (DTI)' fp 'xls' fp 'GroupName2' fp 'subject_' int2str(i) '.xlsx'], [target_dir fp 'workflows' fp 'connectivity' fp 'example data CON (DTI)' fp 'xls' fp 'GroupName2' fp 'subject_' int2str(i) '.xlsx'])
end
mkdir([target_dir fp 'workflows' fp 'connectivity' fp 'example data CON (DTI)' fp 'txt'])
mkdir([target_dir fp 'workflows' fp 'connectivity' fp 'example data CON (DTI)' fp 'txt' fp 'GroupName1'])
for i = 1:1:5
    copyfile([source_dir fp 'workflows' fp 'connectivity' fp 'example data CON (DTI)' fp 'txt' fp 'GroupName1' fp 'SubjectID' int2str(i) '.txt'], [target_dir fp 'workflows' fp 'connectivity' fp 'example data CON (DTI)' fp 'txt' fp 'GroupName1' fp 'SubjectID' int2str(i) '.txt'])
end
mkdir([target_dir fp 'workflows' fp 'connectivity' fp 'example data CON (DTI)' fp 'txt' fp 'GroupName2'])
for i = 1:1:5
    copyfile([source_dir fp 'workflows' fp 'connectivity' fp 'example data CON (DTI)' fp 'txt' fp 'GroupName2' fp 'subject_' int2str(i) '.txt'], [target_dir fp 'workflows' fp 'connectivity' fp 'example data CON (DTI)' fp 'txt' fp 'GroupName2' fp 'subject_' int2str(i) '.txt'])
end
disp('¡! copied ready files - workflow connectivity')

disp(' ')

% test
copyfile([source_dir fp 'test' fp 'test_braph2.m'], [target_dir fp 'test' fp 'test_braph2.m'])
copyfile([source_dir fp 'test' fp 'assert_with_error.m'], [target_dir fp 'test' fp 'assert_with_error.m'])
copyfile([source_dir fp 'test' fp 'DummyObject.m'], [target_dir fp 'test' fp 'DummyObject.m'])
copyfile([source_dir fp 'test' fp 'DummyCopiableObject.m'], [target_dir fp 'test' fp 'DummyCopiableObject.m'])
disp('¡! copied ready files - test')

disp(' ')

%% CREATE ELEMENTS
for run = 1:1:run_number
    
    disp(['¡! started run number ' int2str(run)])
    
    % src
    ds_gen_list = getGenerators([source_dir fp 'src' fp 'ds']);
    for i = 1:1:numel(ds_gen_list)
        create_Element([source_dir fp 'src' fp 'ds' fp ds_gen_list{i}], [target_dir fp 'src' fp 'ds'])
    end

    util_gen_list = getGenerators([source_dir fp 'src' fp 'util']);
    for i = 1:1:numel(util_gen_list)
        create_Element([source_dir fp 'src' fp 'util' fp util_gen_list{i}], [target_dir fp 'src' fp 'util'])
    end

    atlas_gen_list = getGenerators([source_dir fp 'src' fp 'atlas']);
    for i = 1:1:numel(atlas_gen_list)
        create_Element([source_dir fp 'src' fp 'atlas' fp atlas_gen_list{i}], [target_dir fp 'src' fp 'atlas'])
    end
    
    cohort_gen_list = getGenerators([source_dir fp 'src' fp 'cohort']);
    for i = 1:1:numel(cohort_gen_list)
        create_Element([source_dir fp 'src' fp 'cohort' fp cohort_gen_list{i}], [target_dir fp 'src' fp 'cohort'])
    end
    
    gt_gen_list = getGenerators([source_dir fp 'src' fp 'gt']);
    for i = 1:1:numel(gt_gen_list)
        create_Element([source_dir fp 'src' fp 'gt' fp gt_gen_list{i}], [target_dir fp 'src' fp 'gt'])
    end
    
    analysis_gen_list = getGenerators([source_dir fp 'src' fp 'analysis']);
    for i = 1:1:numel(analysis_gen_list)
        create_Element([source_dir fp 'src' fp 'analysis' fp analysis_gen_list{i}], [target_dir fp 'src' fp 'analysis'])
    end
    
    % graphs
    graphs_gen_list = getGenerators([source_dir fp 'graphs']);
    for i = 1:1:numel(graphs_gen_list)
        create_Element([source_dir fp 'graphs' fp graphs_gen_list{i}], [target_dir fp 'graphs'])
    end
    
    % measures
    measures_gen_list = getGenerators([source_dir fp 'measures']);
    for i = 1:1:numel(measures_gen_list)
        create_Element([source_dir fp 'measures' fp measures_gen_list{i}], [target_dir fp 'measures'])
    end

    gui_gen_list = getGenerators([source_dir fp 'src' fp 'gui']);
    for i = 1:1:numel(gui_gen_list)
        create_Element([source_dir fp 'src' fp 'gui' fp gui_gen_list{i}], [target_dir fp 'src' fp 'gui'])
    end
    
    % workflows
    wf_structural_gen_list = getGenerators([source_dir fp 'workflows' fp 'structural']);
    for i = 1:1:numel(wf_structural_gen_list)
        create_Element([source_dir fp 'workflows' fp 'structural' fp wf_structural_gen_list{i}], [target_dir fp 'workflows' fp 'structural'])
    end
    
    wf_functional_gen_list = getGenerators([source_dir fp 'workflows' fp 'functional']);
    for i = 1:1:numel(wf_functional_gen_list)
        create_Element([source_dir fp 'workflows' fp 'functional' fp wf_functional_gen_list{i}], [target_dir fp 'workflows' fp 'functional'])
    end
    
    wf_connectivity_gen_list = getGenerators([source_dir fp 'workflows' fp 'connectivity']);
    for i = 1:1:numel(wf_connectivity_gen_list)
        create_Element([source_dir fp 'workflows' fp 'connectivity' fp wf_connectivity_gen_list{i}], [target_dir fp 'workflows' fp 'connectivity'])
    end
    
    % LOAD BRAPH2
    addpath(target_dir)
    braph2

    disp('¡! loaded BRAPH2')
    disp(' ')
    
    disp(['¡! completed run number ' int2str(run)])
    disp(' ')
end

%% CREATE TEST
% src
ds_gen_list = getGenerators([source_dir fp 'src' fp 'ds']);
for i = 1:1:numel(ds_gen_list)
    create_test_Element([source_dir fp 'src' fp 'ds' fp ds_gen_list{i}], [target_dir fp 'src' fp 'ds'])
end

util_gen_list = getGenerators([source_dir fp 'src' fp 'util']);
for i = 1:1:numel(util_gen_list)
    create_test_Element([source_dir fp 'src' fp 'util' fp util_gen_list{i}], [target_dir fp 'src' fp 'util'])
end

atlas_gen_list = getGenerators([source_dir fp 'src' fp 'atlas']);
for i = 1:1:numel(atlas_gen_list)
    create_test_Element([source_dir fp 'src' fp 'atlas' fp atlas_gen_list{i}], [target_dir fp 'src' fp 'atlas'])
end

cohort_gen_list = getGenerators([source_dir fp 'src' fp 'cohort']);
for i = 1:1:numel(cohort_gen_list)
    create_test_Element([source_dir fp 'src' fp 'cohort' fp cohort_gen_list{i}], [target_dir fp 'src' fp 'cohort'])
end

gt_gen_list = getGenerators([source_dir fp 'src' fp 'gt']);
for i = 1:1:numel(gt_gen_list)
    create_test_Element([source_dir fp 'src' fp 'gt' fp gt_gen_list{i}], [target_dir fp 'src' fp 'gt'])
end

analysis_gen_list = getGenerators([source_dir fp 'src' fp 'analysis']);
for i = 1:1:numel(analysis_gen_list)
    create_test_Element([source_dir fp 'src' fp 'analysis' fp analysis_gen_list{i}], [target_dir fp 'src' fp 'analysis'])
end

% graphs
graphs_gen_list = getGenerators([source_dir fp 'graphs']);
for i = 1:1:numel(graphs_gen_list)
    create_test_Element([source_dir fp 'graphs' fp graphs_gen_list{i}], [target_dir fp 'graphs'])
end

% measures
measures_gen_list = getGenerators([source_dir fp 'measures']);
for i = 1:1:numel(measures_gen_list)
    create_test_Element([source_dir fp 'measures' fp measures_gen_list{i}], [target_dir fp 'measures'])
end

gui_gen_list = getGenerators([source_dir fp 'src' fp 'gui']);
for i = 1:1:numel(gui_gen_list)
    create_test_Element([source_dir fp 'src' fp 'gui' fp gui_gen_list{i}], [target_dir fp 'src' fp 'gui'])
end

% workflows
wf_structural_gen_list = getGenerators([source_dir fp 'workflows' fp 'structural']);
for i = 1:1:numel(wf_structural_gen_list)
    create_test_Element([source_dir fp 'workflows' fp 'structural' fp wf_structural_gen_list{i}], [target_dir fp 'workflows' fp 'structural'])
end

wf_functional_gen_list = getGenerators([source_dir fp 'workflows' fp 'functional']);
for i = 1:1:numel(wf_functional_gen_list)
    create_test_Element([source_dir fp 'workflows' fp 'functional' fp wf_functional_gen_list{i}], [target_dir fp 'workflows' fp 'functional'])
end

wf_connectivity_gen_list = getGenerators([source_dir fp 'workflows' fp 'connectivity']);
for i = 1:1:numel(wf_connectivity_gen_list)
    create_test_Element([source_dir fp 'workflows' fp 'connectivity' fp wf_connectivity_gen_list{i}], [target_dir fp 'workflows' fp 'connectivity'])
end

end