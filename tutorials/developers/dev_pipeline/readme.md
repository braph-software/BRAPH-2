# Adapt a Pipeline Script

[![Tutorial Adapt a Pipeline Script](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](dev_pipeline.pdf)

This is the developer tutorial for adapting a pipeline script. 
In this tutorial, you will learn how to edit a "*.braph2" file to change the steps of a pipeline in braph2genesis. Here, you will use as an example the pipeline `Pipeline Structural Multiplex Comparison BUD` (the pipeline for comparing two groups of subjects using structural multiplex data and binary undirected graphs at fixed densities) and adapt it in order to add a third group for structural multiplex.


## Table of Contents
> [Adaption of the pipeline](#Adaption-of-the-pipeline)
>

%%%%% %%%%% %%%%% %%%%% %%%%%

<a id=Adaption-of-the-pipeline></a>
## Adaption of the pipeline  [⬆](#Table-of-Contents)

You will adapt in `Pipeline Structural Multiplex Comparison BUD` as shown in Code 1.

**Code 1.** Adapted pipeline to compare three groups of subjects using structural multiplex data and binary undirected graphs at fixed densities.
````matlab
%% Pipeline Structural Multiplex Comparison BUD  % [1]

% This is the pipeline script to compare two groups of subjects using structural multiplex data and binary undirected graphs at fixed densities.  % [2]
% 1. It loads a brain atlas from an XLS file (e.g., desikan_atlas.xlsx).
% 2. It loads the data of two groups of subjects from two directories (e.g., ST_MP_group_1_XLS and ST_MP_group_2_XLS).
% 3. It analyzes the first group using structural multiplex analyses (ST_MP) based on binary unidrected graphs at fixed densities (BUD).
% 4. It analyzes the second group using the same parameters selected for the first group.
% 5. It compares the results of the two analyses.

%% Brain Atlas
ba = ImporterBrainAtlasXLS('WAITBAR', true).get('GET_FILE').get('BA');  % [3]

%% Groups
gr1 = ImporterGroupSubjectST_MP_XLS('BA', ba, 'WAITBAR', true).get('GET_DIR').get('GR');  % [4]
gr2 = ImporterGroupSubjectST_MP_XLS('BA', ba, 'WAITBAR', true).get('GET_DIR').get('GR');  % [5]
gr3 = ImporterGroupSubjectST_MP_XLS('BA', ba, 'WAITBAR', true).get('GET_DIR').get('GR');  % [6]

%% Analysis 1
a_BUD1 = AnalyzeGroup_ST_MP_BUD('GR', gr1, 'DENSITIES', [10 20 30 40 50]);  % [7]

%% Analysis 2
a_BUD2 = AnalyzeGroup_ST_MP_BUD('GR', gr2, 'TEMPLATE', a_BUD1);  % [8]

%% Analysis 3
a_BUD3 = AnalyzeGroup_ST_MP_BUD('GR', gr3, 'TEMPLATE', a_BUD1);  % [9]

%% Comparison
c_BUD1 = CompareGroup('P', 1000, 'A1', a_BUD1, 'A2', a_BUD2, 'MEMORIZE', true);  % [10]
c_BUD2 = CompareGroup('P', 1000, 'A1', a_BUD1, 'A3', a_BUD3, 'MEMORIZE', true);  % [11]
c_BUD3 = CompareGroup('P', 1000, 'A2', a_BUD2, 'A3', a_BUD3, 'MEMORIZE', true);  % [12]
````

[1] specifies the name of the pipeline.

[2] provides descriptions for the overall pipeline as well as for each step.

[3] loads the brain atlas.

[4] loads group 1 from XLS.

[5] loads group 2 from XLS.

[6] loads group 3 from XLS.

[7] performs the graph analysis for group 1. The default value of `'DENSITIES'` is set to `[10 20 30 40 50]`.

[8] performs the graph analysis for group 2 with the same analysis template as with group 1.

[9] performs the graph analysis for group 3 with the same analysis template as with group 1.

[10] compares graph measures between groups 1 group 2. The default value of the number of permutations is `'P'` set to `1000`.

[11] compares graph measures between groups 1 and 3.

[12] compares graph measures between groups 2 and 3.
