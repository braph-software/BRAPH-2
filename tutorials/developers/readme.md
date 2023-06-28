# BRAPH 2.0 — For Developers

Welcome to the BRAPH 2.0 development guide! 

This section provides instructions and examples for developers who want to extend and enhance BRAPH 2.0 with new functionalities. Whether you want to adapt existing pipelines, modify example scripts, or implement completely new features, this guide will walk you through the different levels of complexity in BRAPH 2.0 development.

The software architecture of BRAPH 2.0 provides a clear structure for developers to understand and extend the functionalities of the software. All objects in BRAPH 2.0 are derived from a base object called `Element`. The core code includes the compiler (`genesis`), the essential source code (`src`), and the GUI functionalities (`gui`). Developers can easily add new elements such as brain surfaces, atlases, example scripts, GUI pipelines, graphs, measures, data types, data importers, data exporters, and analyses. By writing new elements and recompiling the code, the new elements and their functionalities are immediately integrated into the GUI.

> ![BRAPH 2.0 software architecture](https://github.com/giovannivolpe/BRAPH-2-Matlab-beta/blob/develop/figures/braph2genesis.png)
> **BRAPH 2.0 software architecture.**
Directory structure of BRAPH 2.0 GENESIS (left) and BRAPH 2.0 (right).
All objects are derived from a base object called `Element` and written in a simplified pseudocode (files *.gen.m) that is compiled into the actual elements (files *.m) by the command `braph2genesis` (some examples of these elements are shown).
The compiled code can be launched by the command `braph2`.
The core of BRAPH 2.0 (gray shaded area) includes the compiler (`genesis`), the essential source code (`src`), and the essential functionalities for the GUI (`gui`, yellow-shaded area).
The users can easily add new brain surfaces (`brainsurfs`), atlases (`atlases`), example scripts and GUI pipelines (in the corresponding folder under `pipelines`).
Furthermore, the users can add new elements such as new graphs (e.g., `GraphWU` in `graphs`), measures (e.g., `Strength` in `measures`), data types (e.g., `SubjectCON` in `pipelines/connectivity`), data importers (e.g., `ImporterGroupSubjectCON_XLS` in `pipelines/connectivity`), data exporters (e.g., `ExporterGroupSubjectCON_XLS` in `pipelines/connectivity`), and analyses (e.g., `AnalyzeEnsemble_CON_WU` in `pipelines/connectivity`) by writing new elements and recompiling the whole code: the new elements and their functionalities will be immediately available also in the GUI.
Finally, BRAPH 2.0 is provided with a set of unit tests (executable by the command `test_braph2`) that ensure the formal correctness of the code, including that of any newly added elements.

## Adapting a Pipeline Script

The simplest way to customize BRAPH 2.0 is by modifying a .braph2 pipeline script. This permits on to define parameters and adjust the analysis steps according to their specific requirements. The [Developer Tutorial to Adapt a Pipeline Script](tutorials/developers/devdoc_pipeline.pdf) provides guidance on adapting pipeline scripts.

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
