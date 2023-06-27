# BRAPH 2.0 — For Developers

Welcome to the BRAPH 2.0 development guide! 

This section provides instructions and examples for developers who want to extend and enhance BRAPH 2.0 with new functionalities. Whether you want to adapt existing pipelines, modify example scripts, or implement completely new features, this guide will walk you through the different levels of complexity in BRAPH 2.0 development.

The software architecture of BRAPH 2.0 provides a clear structure for developers to understand and extend the functionality of the software. All objects in BRAPH 2.0 are derived from a base object called <code>Element</code>. The core code includes the compiler (<code>genesis</code>), the essential source code (<code>src</code>), and the GUI functionalities (<code>gui</code>). Developers can easily add new elements such as brain surfaces, atlases, example scripts, GUI pipelines, graphs, measures, data types, data importers, data exporters, and analyses. By writing new elements and recompiling the code, the new elements and their functionalities are immediately integrated into the GUI.

## Adapting a Pipeline Script

The simplest way to customize BRAPH 2.0 is by modifying a <code>.braph2</code> pipeline script. This allows users to define parameters and adjust the analysis steps according to their specific requirements. The developer tutorial <a href="[http://braph.org/tutorials/for-developers/new-pipeline](https://github.com/giovannivolpe/BRAPH-2-Matlab-beta/blob/develop/tutorials/developers/devdoc_pipeline.pdf)">Adapting a Pipeline Script</a> provides guidance on adapting pipeline scripts.

## Editing an Example Script

Developers can also edit the example scripts provided with the software to have more control over the analysis workflow and leverage parallel computing for faster calculations. For example, these scripts can be used to run calculations on a cluster. The developer tutorial <a href="https://github.com/giovannivolpe/BRAPH-2-Matlab-beta/blob/develop/tutorials/developers/devdoc_script_measure.pdf">Calculating Different Measures</a> demonstrates how to modify example scripts.

## Expanding BRAPH 2.0 with New Functionalities

BRAPH 2.0's object-oriented programming architecture makes it easy to expand its capabilities by introducing new elements and features. Here are some of the ways you can extend BRAPH 2.0:

- **Graphs**: Developers can implement new graph types by extending the `Graph` element. The tutorial [Implement a new Graph](link-to-tutorial) provides a step-by-step guide on how to create new graph types.

- **Measures**: New measures can be added to BRAPH 2.0 by extending the `Measure` element. The tutorial [Implement a new Measure](link-to-tutorial) explains the process of implementing custom measures.

- **Subjects**: Developers can introduce new data types by extending the `Subject` element. The tutorial [Implement a new Subject](link-to-tutorial) provides guidance on creating new data types for subjects.

- **Group-based and Ensemble-based Analyses**: New analysis pipelines can be added to BRAPH 2.0 by extending the `AnalysisGroup` or `AnalysisEnsemble` elements. The tutorials in this category demonstrate the process of implementing new analysis pipelines:
  - [Implement a new Group Analysis](link-to-tutorial)
  - [Implement a new Ensemble Analysis](link-to-tutorial)

- **Deep-learning Functionalities**: New functionalities for deep-learning analyses can be swiftly integrated into BRAPH 2.0 as well. Here are the tutorials for expanding BRAPH 2.0 with deep-learning features:
  - [Implement a new Neural Network Classifier](link-to-tutorial)
  - [Implement a new Neural Network Regressor](link-to-tutorial)
  - [Implement a new Neural Network Evaluator for Classification](link-to-tutorial)
  - [Implement a new Neural Network Evaluator for Regression](link-to-tutorial)

These tutorials provide step-by-step instructions and examples to guide developers in expanding BRAPH 2.0 with new functionalities. We encourage developers to contribute to the growth and improvement of BRAPH 2.0 by introducing new elements, measures, and analyses. Feel free to share your implementations, ask questions, and engage with the BRAPH community through the [BRAPH forum](http://braph.org/forums) and [GitHub page](https://github.com/softmatterlab/BRAPH-2-Matlab).

Happy developing!
