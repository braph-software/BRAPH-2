# Adapt an Example Script

[![Tutorial Adapt an Example Script](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](dev_script.pdf)

This is the developer tutorial for adapting a script to calculate different graph measures. In this tutorial, you will learn how to edit an example script to calculate different graph measures. Here, you will use the scrip in file "example\_ST\_MP\_WU.m" as an example to learn how to edit this script to calculate different graph measures for structural data using a multiplex weighted undirected graph.


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

The header section of the script in "example\_ST\_MP\_WU.m" is shown in Code 1.

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
im_ba = ImporterBrainAtlasXLS( ...  % [1]
    'FILE', [fileparts(which('example_ST_MP_WU')) filesep 'Example data ST_MP XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');
````

[1] First, the script loads the brain atlas from the file "atlas.xlsx".


<a id="Data-Loading"></a>
## Data Loading  [⬆](#Table-of-Contents)

This step is to load the data of two groups. In this section, we use "ImporterGroupSubjectST\_MP\_XLS" as an example, Users can define the path to the group data in XLS/XLSX files contained in a folder.
**Code 3.** **Group Subject Data Importer.**
		The group data importer section provides the code for loading group subject data.
````matlab
im_gr1 = ImporterGroupSubjectST_MP_XLS( ... % [1]
    'DIRECTORY', [fileparts(which('SubjectST_MP')) filesep 'Example data ST_MP XLS' filesep 'ST_MP_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectST_MP_XLS( ... % [2]
    'DIRECTORY', [fileparts(which('SubjectST_MP')) filesep 'Example data ST_MP XLS' filesep 'ST_MP_Group_2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');
````

[1] ImporterGroupSubjectST\_MP\_XLS imports a group of subjects with structural data and their covariates (optional) from another XLS/XLSX file.

[2] imports a second group of subjects with structural data and their covariates (optional) from another XLS/XLSX file.



<a id="Group-Analysis"></a>
## Group Analysis  [⬆](#Table-of-Contents)
This step is to initialize the group data analysis. Users are allowed to specify the correlation type and "NEGATIVE\_WEIGHT\_RULE"  in this section, the script will perform the group analysis automatically for each group loaded from previous step.
**Code 4.** **Group Subject Data Analysis.**
		The group data analysis provides code for initialization of group data analysis.
````matlab
a_WU1 = AnalyzeGroup_ST_MP_WU( ... % [1]
    'GR', gr1, ...
    'CORRELATION_RULE', Correlation.PEARSON ...
    );

a_WU2 = AnalyzeGroup_ST_MP_WU( ... % [1]
    'TEMPLATE', a_WU1, ...
    'GR', gr2 ...
    );
````

[1] creation of the group analysis with the loaded atlas and groups data.

%
<a id="Measure-Calculation"></a>
## Measure Calculation  [⬆](#Table-of-Contents)
This step is to calculate graph measures with data loaded in the previous step. Here we use "overlapping strength" as an example.
**Code 5.** **Group Subject Data Analysis.**
		The group data analysis provides code for initialization of group data analysis.
````matlab
g_WU1 = a_WU1.memorize('G'); % [1]
ovstrength_WU2 = g_WU2.get('MEASURE', 'OverlappingS').get('M'); % [2]
ovstrength_av_WU2 = g_WU2.get('MEASURE', 'OverlappingSAv').get('M');  % [3]

g_WU2 = a_WU2.get('G');
ovstrength_WU2 = g_WU2.get('MEASURE', 'OverlappingS').get('M'); % [2]
ovstrength_av_WU2 = g_WU2.get('MEASURE', 'OverlappingSAv').get('M'); % [3]
````

[1] memorize in case there are measures with non-default rules.

[2] The function calculates graph measure. In this case, "overlapping strength" is calculated.

[3] Other measures can also be calculated by changing the measure name. For example, "OverlappingS" calculates overlapping strength and "OverlappingSAv" calculates overlapping strength average




<a id="Group-Comparison"></a>
## Group Comparison  [⬆](#Table-of-Contents)
The last step is to perform group comparison. "CompareGroup" contains the results of a group-based comparison for a given measure.
Specifically, it contains the one-tailed and two-tailed p-values and the 95\% confidence interval.
**Code 6.** **Group Subject Data Analysis.**
		The group data analysis provides code for initialization of group data analysis.
````matlab
% comparison
c_WU = CompareGroup( ... % [1]
    'P', 10, ...
    'A1', a_WU1, ...
    'A2', a_WU2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

ovstrength_WU_diff = c_WU.get('COMPARISON', 'OverlappingS').get('DIFF'); % [2]
ovstrength_WU_p1 = c_WU.get('COMPARISON', 'OverlappingS').get('P1'); % [3]
ovstrength_WU_p2 = c_WU.get('COMPARISON', 'OverlappingS').get('P2'); % [4]
ovstrength_WU_cil = c_WU.get('COMPARISON', 'OverlappingS').get('CIL'); % [5]
ovstrength_WU_ciu = c_WU.get('COMPARISON', 'OverlappingS').get('CIU'); % [6]
````

[1] Creation of group comparison based on previous group analysis.

[2] "DIFF" calculates the difference of group comparison.

[3] "P1"  calculates the one-tailed p-value.

[4] "P1" calculates the two-tailed p-value.

[5] "CIL" calculates the lower value of the 95\% confidence interval.

[6] "CIU" calculates the upper value of the 95\% confidence interval.



%%%%% %%%%% %%%%% %%%%% %%%%%
%
