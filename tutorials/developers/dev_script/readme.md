# Adapt an Example Script

[![Tutorial Adapt an Example Script](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](dev_script.pdf)

This is the developer tutorial for adapting a script to calculate different graph measures. In this tutorial, you will learn how to edit an example script to calculate different graph measures. Here, you will use the scrip in file "example_ST_MP_WU.m" as an example to learn how to edit this script to calculate different graph measures for structural data using a multiplex weighted undirected graph.


## Table of Contents
> [Header](#Header)
>
> [Atlas Loading](#Atlas-Loading)
>
> [Data Loading](#Data-Loading)
>
> [Group Analysis](#Group-Analysis)
>
> [Measure Calculation](#Measure-Calculation)
>
> [Group Comparison](#Group-Comparison)
>



<a id="Header"></a>
## Header  [⬆](#Table-of-Contents)

The header section of the script in "example_ST_MP_WU.m" is shown in Code 1.

**Code 1.** **Script header.**
		The header section of the pipeline names and describes the script.
````matlab
% EXAMPLE_ST_MP_WU  % [1]
% Script example pipeline ST MP WU  % [2]

clear variables %#ok<*NASGU>  % [3]
````

[1] defines the name of the script.

[2] provides a brief description of the script.

[3] clears the workspace.


<a id="Atlas-Loading"></a>
## Atlas Loading  [⬆](#Table-of-Contents)

The script starts by importing the brain atlas. For this, it uses the element `ImporterBrainAtlasXLS` to import the atlas from an "*.xlsx" file, as shown in Code 2.
 
**Code 2.** **Load brain atlas.**
		This section defines the importer to load the brain atlas.
````matlab
%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('example_ST_MP_WU')) filesep 'Example data ST_MP XLS' filesep 'atlas.xlsx'], ...  % [1]
    'WAITBAR', true ...  % [2]
    );

ba = im_ba.get('BA');
````

[1] loads the brain atlas from the file "atlas.xlsx".

[2] shows a waitbar during the loading process.


<a id="Data-Loading"></a>
## Data Loading  [⬆](#Table-of-Contents)

The next step is to load the data of the two groups from the folders where the relative "*.xlsx" files are stored. It uses the element `ImporterGroupSubjectST_MP_XLS` to load the `SubjectST_MP` subjects, as shown in Code 3.

**Code 3.** **Load groups of subjects.**
		The group data importer section provides the code for loading the data corresponding to the groups of subjects.
````matlab
%% Load Groups of SubjectST_MP
im_gr1 = ImporterGroupSubjectST_MP_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectST_MP')) filesep 'Example data ST_MP XLS' filesep 'ST_MP_Group_1_XLS'], ...  % [1]
    'BA', ba, ...  % [1]
    'WAITBAR', true ...  % [3]
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectST_MP_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectST_MP')) filesep 'Example data ST_MP XLS' filesep 'ST_MP_Group_2_XLS'], ...  % [4]
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');
````

[1] imports the first group of subjects with structural data and their (optional) covariates from the files contained in the folder.

[1] uses the previously loaded brain atlas.

[3] shows a waitbar during the loading process.

[4] imports the first group of subjects.


<a id="Group-Analysis"></a>
## Group Analysis  [⬆](#Table-of-Contents)

The next step is to perform the group data analysis using the element ``, as shown in Code 4.

**Code 4.** **Analysis.**
		The group data analysis sections provides code to perform the analyses for the two groups.
````matlab
%% Analysis ST MP WU
a_WU1 = AnalyzeGroup_ST_MP_WU( ...
    'GR', gr1, ...  % [1]
    'CORRELATION_RULE', Correlation.PEARSON ...  % [2]
    );

a_WU2 = AnalyzeGroup_ST_MP_WU( ...
    'TEMPLATE', a_WU1, ...  % [3]
    'GR', gr2 ...  % [4]
    );
````

[1] uses the previously defined group `gr1` for the first analysis.

[2] defines the correlation rule to be used.

[3] uses the same parameters as in the analysis `a_WU1`.

[4] uses the previously defined group `gr2` for the second analysis.


<a id="Measure-Calculation"></a>
## Measure Calculation  [⬆](#Table-of-Contents)

You can now calculate graph measures with the analyses defined in the previous step, as shown in Code 5.

**Code 5.** **Within-group measure calculation.**
		The measure calculation section calculates the measures for each group independently.
````matlab
% measure calculation
g_WU1 = a_WU1.memorize('G');  % [1]
ovstrength_WU2 = g_WU2.get('MEASURE', 'OverlappingS').get('M');  % [2]
ovstrength_av_WU2 = g_WU2.get('MEASURE', 'OverlappingSAv').get('M');  % [3]

g_WU2 = a_WU2.get('G');  % [4]
ovstrength_WU2 = g_WU2.get('MEASURE', 'OverlappingS').get('M');
ovstrength_av_WU2 = g_WU2.get('MEASURE', 'OverlappingSAv').get('M');
````

[1] memorizes the graphs to ensure consistency if there are measures with non-default rules.

[2] calculates the *overlapping strength* measure for the analysis `a_WU1`.

[3] calculates the *overlapping strength average* measure for the analysis `a_WU1`.

[4] calcualtes the same measures for the analysis `a_WU2`.


<a id="Group-Comparison"></a>
## Group Comparison  [⬆](#Table-of-Contents)

The last step is to perform the group comparison. This uses the element `CompareGroup` as shown in Code 6.

Specifically, it contains the one-tailed and two-tailed p-values and the 95\% confidence interval.

**Code 6.** **Between-group measure comparison.**
		The comparison section performs the comparison of the measures between the two groups.
````matlab
% comparison
c_WU = CompareGroup( ...
    'P', 1000, ...  % [1]
    'A1', a_WU1, ...  % [2]
    'A2', a_WU2, ...  % [3]
    'WAITBAR', true, ...  % [4]
    'VERBOSE', false, ...  % [5]
    'MEMORIZE', true ...  % [6]
    );

ovstrength_WU_diff = c_WU.get('COMPARISON', 'OverlappingS').get('DIFF');  % [7]
ovstrength_WU_p1 = c_WU.get('COMPARISON', 'OverlappingS').get('P1');  % [8]
ovstrength_WU_p2 = c_WU.get('COMPARISON', 'OverlappingS').get('P2');  % [9]
ovstrength_WU_cil = c_WU.get('COMPARISON', 'OverlappingS').get('CIL');  % [10]
ovstrength_WU_ciu = c_WU.get('COMPARISON', 'OverlappingS').get('CIU');  % [11]
````

[1] uses 1000 permutations in the false-discovery-rate (FDR) test.

[2] and [3] define the two analyses to be compared.

[4] shows a waitbar during the comparison.

[5] does not print updates during the comparison.

[6] memorizes the intermediate results of the comparison. This speeds up the comparison at the cost of estra memory requirements.

[7] -[11] calculate the difference of group comparison (`'DIFF'`), the one-tailed p-value (`'P1'`), the two-tailed p-value (`'P2'`), the lower value of the 95\% confidence interval (`'CIL'`), and the upper value of the 95\% confidence interval (`'CIU'`) for the overlapping strength measure (`'OverlappingS'`).
