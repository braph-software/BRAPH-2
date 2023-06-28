# BRAPH 2.0 - Pipelines

Welcome to the pipelines tutorials of BRAPH 2.0! This section provides detailed instructions on using the available pipelines in BRAPH 2.0 using Graphical User Interfaces (GUIs).

## Single Layer Connectivity Pipelines

These tutorials provide step-by-step instructions for analyzing and comparing connectivity measures using different single layer connectivity pipelines:

- **Pipelines analyzing connectivity data (CON).** For connectivity data, a connectivity matrix per subject is already available and can be directly imported into the relative analysis pipeline. For example, the connectivity matrix could correspond to white matter tracts obtained from dMRI or pre-calculated coactivations maps obtained from fMRI data.
  - [Pipeline Connectivity Comparison WU](tutotials/pipelines/tut_CON_WU.pdf): Tutorial to compare two groups of subjects with connectivity data (CON) using weighted undirected graphs.
  - [Pipeline Connectivity Comparison BUD](tutotials/pipelines/tut_CON_BUT.pdf): Tutorial to compare two groups of subjects with connectivity data (CON) using binary undirected graphs at fixed densities (BUD).
  - [Pipeline Connectivity Comparison BUT](tutotials/pipelines/tut_CON_BUT.pdf): Tutorial to compare two groups of subjects with connectivity data (CON) using binary undirected graphs at fixed thresholds (BUT).

- **Pipelines analyzing functional data (FUN).** In functional data, a time series representing brain function over time is available for each brain region of each subject. For example, these time series could be brain activation signals in fMRI or electrophysiological signals in electroencephalography (EEG) or magnetoencephalography (MEG). 
  -  [Pipeline Functional Comparison WU](tutotials/pipelines/tut_FUN_WU.pdf): Tutorial to compare two groups of subjects with functional data (FUN) using weighted undirected graphs.
  - [Pipeline Functional Comparison BUD](tutotials/pipelines/tut_FUN_BUT.pdf): Tutorial to compare two groups of subjects with functional data (FUN) using binary undirected graphs at fixed densities (BUD).
  - [Pipeline Functional Comparison BUT](tutotials/pipelines/tut_FUN_BUT.pdf): Tutorial to compare two groups of subjects with functional data (FUN) using binary undirected graphs at fixed thresholds (BUT).

- **Pipelines analyzing structural data (ST).** In structural data, a scalar value is available for each brain region of each subject. For example, these could correspond to gray matter volume or thickness in T1-weighted MRI, brain perfusion in ASL or abnormal protein deposition in static PET data.
  - [Pipeline Structural Comparison WU](tutotials/pipelines/tut_ST_WU.pdf): Tutorial to compare two groups of subjects with structural data (ST) using weighted undirected graphs.
  - [Pipeline Structural Comparison BUD](tutotials/pipelines/tut_ST_BUT.pdf): Tutorial to compare two groups of subjects with structural data (ST) using binary undirected graphs at fixed densities (BUD).
  - [Pipeline Structural Comparison BUT](tutotials/pipelines/tut_ST_BUT.pdf): Tutorial to compare two groups of subjects with structural data (ST) using binary undirected graphs at fixed thresholds (BUT).

> ![Advances in brain connectivity analysis](../../figures/pipeline-graph.png)
> **BRAPH~2.0 graph analysis pipeline.**
> **a** Main graphical user interface (GUI) for BRAPH 2.0, which is launched by the command `braph2`, where an analysis pipeline can be selected.
> **b** GUI of the *Pipeline Comparison Connectivity WU*, which allows the user to import weighted undirected (WU) adjacency matrices corresponding to two subject groups and compare the distributions of the subjects' graph measures. This pipeline consists of sequential steps: 
> **c** Load the brain atlas.
> **d** Load the two groups of subject data.
> **e** Analyze the first group.
> **f** Analyze the second group.
> **g** Compare the two groups to identify statistically significant differences.

## Multiplex Connectivity Pipelines

These tutorials guide you through the analysis and comparison steps of multiplex connectivity pipelines. Explore the following pipelines to analyze and compare multiplex connectivity measures:
- Pipeline Connectivity-Functional Multiplex Comparison WU: Tutorial on connectivity-functional multiplex comparison using the weighted undirected (WU) connectivity measure. [Tutorial Link](https://github.com/giovannivolpe/BRAPH-2-Matlab-beta/tree/develop/tutorials/pipelines/multiplex_connectivity/pipeline_connectivity_functional_multiplex_comparison_WU)
- Pipeline Functional Multiplex Comparison BUD: Tutorial on functional multiplex comparison using the binary undirected (BUD) connectivity measure. [Tutorial Link](https://github.com/giovannivolpe/BRAPH-2-Matlab-beta/tree/develop/tutorials/pipelines/multiplex_connectivity/pipeline_functional_multiplex_comparison_BUD)
- Pipeline Structural Multiplex Comparison BUT: Tutorial on structural multiplex comparison using the binary undirected (BUT) connectivity measure. [Tutorial Link](https://github.com/giovannivolpe/BRAPH-2-Matlab-beta/tree/develop/tutorials/pipelines/multiplex_connectivity/pipeline_structural_multiplex_comparison_BUT)

## Deep Learning Pipelines

Explore the deep learning pipelines in BRAPH 2.0. These tutorials demonstrate the usage of neural networks for regression and classification tasks on different types of data:
- Pipeline Neural Networks Regression Structural Data: Tutorial on using neural networks for regression on structural data. [Tutorial Link](https://github.com/giovannivolpe/BRAPH-2-Matlab-beta/tree/develop/tutorials/pipelines/deep_learning/pipeline_neural_networks_regression_structural_data)
- Pipeline Neural Networks Classification Connectivity WU: Tutorial on using neural networks for classification on weighted undirected (WU) connectivity data. [Tutorial Link](https://github.com/giovannivolpe/BRAPH-2-Matlab-beta/tree/develop/tutorials/pipelines/deep_learning/pipeline_neural_networks_classification_connectivity_WU)
- Pipeline Neural Networks Classification Cross Validation Functional WU: Tutorial on using neural networks for classification with cross-validation on weighted undirected (WU) functional connectivity data. [Tutorial Link](https://github.com/giovannivolpe/BRAPH-2-Matlab-beta/tree/develop/tutorials/pipelines/deep_learning/pipeline_neural_networks_classification_connectivity_WU)

> ![Advances in brain connectivity analysis](https://github.com/giovannivolpe/BRAPH-2-Matlab-beta/blob/develop/figures/pipeline-nn.png)
> **BRAPH 2.0 deep-learning analysis pipeline.**
> **a** Main graphical user interface (GUI) for BRAPH 2.0, which is launched by the command `braph2`, where an analysis pipeline can be selected.
> **b** GUI of the *Pipeline Neural Networks Classification Connectivity WU*, which permits the user to import weighted undirected (WU) adjacency matrices corresponding to two subject groups and perform classification using either the subjects' graph measures or their adjacency matrices. This pipeline consists of sequential steps:
> **c** Load the brain atlas.
> **d** Load the two groups of subject data.
> **e** Construct the dataset.
> **f** Split the dataset.
> **g** Train the neural network model.
> **h** Evaluate the performance of the model using confusion matrices, the area under the receiver operating characteristic curve, and a feature importance analysis.

### Custom Analysis Pipelines

In addition to the existing analysis pipelines, BRAPH 2.0 allows users to develop custom analysis pipelines tailored to their specific research needs. This flexibility expands the range of brain analysis techniques that can be implemented using BRAPH.

If the specific analysis you wish to perform is not currently supported by BRAPH 2.0, you have two options:

1. **Further Development**: You can develop the necessary functionalities to implement your custom analysis pipeline by following the [Tutorial to Implement a New Analysis Pipeline](tutorials/general/devdoc_new_pipeline.pdf). This tutorial provides guidance on extending BRAPH 2.0 to accommodate new analysis techniques, enabling you to seamlessly integrate your pipeline into the BRAPH framework.

2. **Feature Request**: If you prefer not to develop the functionalities yourself, you can consider opening an issue on the BRAPH GitHub repository. Use the [Feature Request](../../issues/new?template=feature_request.md) template to describe your specific analysis requirements and the desired functionality. The BRAPH development team and community can review your request and potentially incorporate it into future updates of BRAPH.

By offering the ability to create custom analysis pipelines, BRAPH 2.0 empowers users to explore innovative approaches and advance the field of brain connectivity analysis.

