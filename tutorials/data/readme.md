# BRAPH 2.0 — General Tutorials

This section provides a comprehensive introduction to get started with BRAPH 2.0, including preparing your data and using the graphical user interfaces (GUIs). If you have any questions or need further assistance, feel free to reach out to the BRAPH community through the [BRAPH forum](http://braph.org/forums).

## Getting Started

The [Getting Started Tutorial](tut_braph2/tut_braph2.pdf) provides a comprehensive introduction to help you get started with BRAPH 2.0. This tutorial covers the essential steps and features of the software, guiding you through the process of installing BRAPH 2.0 and familiarizing yourself with its functionalities and analysis pipelines. Whether you are new to BRAPH or upgrading from a previous version, this tutorial will provide you with the necessary knowledge to begin your analyses.

## Tutorials to Prepare Your Data in BRAPH 2

To get started with BRAPH 2.0, it is important to organize and format your data correctly. Follow these tutorials to organize your data in the correct format for use with BRAPH 2. These tutorials cover various types of data, including atlas, single-layer data, and multiplex data.

### Brain Atlas

Learn how to prepare your atlas in BRAPH 2 format, which is essential for brain connectivity analysis. The [Brain Atlas Tutorial](tut_ba) guides you through the process of organizing and formatting your atlas data.

### Single-layer Data

These tutorials provide step-by-step instructions for organizing and formatting single-layer data types. 
- [Connectivity Data](tut_gr_con): For connectivity data, a connectivity matrix per subject is already available and can be directly imported into the relative analysis pipeline. This type of data represents the connections between brain regions, such as white matter tracts obtained from diffusion magnetic resonance imaging (dMRI) or pre-calculated coactivation maps obtained from functional magnetic resonance imaging (fMRI) data.
- [Functional Data](tut_gr_fun): Functional data consists of a time series representing brain function over time for each brain region of each subject. This data can include brain activation signals from fMRI or electrophysiological signals from electroencephalography (EEG) or magnetoencephalography (MEG). The time series capture the dynamics of brain activity and can be used to investigate functional connectivity patterns.
- [Structural Data](tut_gr_st): Structural data provides a scalar value for each brain region of each subject. This type of data can include measurements such as gray matter volume or thickness obtained from T1-weighted MRI, brain perfusion from arterial spin labeling (ASL) imaging, or abnormal protein deposition from static positron emission tomography (PET) data. Structural data allows for the exploration of anatomical characteristics and their potential correlations with brain function.

### Multilayer Data

These tutorials explain how to organize and format the multilayer data types currently available in BRAPH 2.0.
- [Multilayer Connectivity Data](tut_gr_con_mp): Multilayer connectivity data involves multiple layers of connectivity information. Each layer represents a distinct aspect of connectivity, such as different frequency bands or connectivity at different time points. This type of data allows for the investigation of time-varying or multiplex brain networks.
- [Multilayer Functional Data](tut_gr_fun_mp): Multilayer functional data captures functional connectivity patterns across multiple layers. Each layer represents functional activity at different conditions, tasks, or time intervals. This type of data enables the study of dynamic functional connectivity and the exploration of how functional networks change over time or under different circumstances.
- [Multilayer Structural Data](tut_gr_st_mp): Multilayer structural data involves multiple layers of structural measurements. Each layer represents a different modality or imaging technique, such as multiple types of MRI scans or a combination of MRI and PET data. This data type allows for the examination of structural variations across different imaging modalities.
- Connectivity-Functional Data: Connectivity-functional data combines connectivity and functional information across multiple layers. It integrates the connectivity patterns between brain regions with the corresponding functional activity. This type of data facilitates the investigation of the relationship between brain structure and function, offering insights into the underlying mechanisms of brain connectivity and its functional implications. It is implemented by combining a [Connectivity Data](tut_gr_con) and [Functional Data](tut_gr_fun).

### New Data Types

Additionally, BRAPH 2.0 allows users to incorporate new data types by following the provided guidelines, expanding the range of analyses and insights that can be achieved. However, note that if your specific data format is not currently supported by BRAPH 2.0, you may need to further develop the necessary functionalities (following the [Tutorial to Implement a new Subject](../developers/dev_subject/dev_subject.pdf)) or consider opening an issue asking for the new functionality at [Feature Request](../../../../issues/new/choose).
