<p align="center">
  <img width="350" src=https://github.com/softmatterlab/BRAPH-2-Matlab/blob/develop/braph2genesis/src/util/braph2icon.png>
</p>

<h3 align="center">Brain Analysis using Graph Theory.</h3>
<p align="center">
  <a href="https://twitter.com/braph2software" alt="tweeter"><img src="https://img.shields.io/twitter/url?label=BRAPH%202&style=social&url=https%3A%2F%2Ftwitter.com%2Fbraph2software"></a>
  <a href="http://braph.org/" alt="website"><img src="https://img.shields.io/website?up_message=braph.org&url=http%3A%2F%2Fbraph.org%2F"></a>
  <a href="https://doi.org/10.1371/journal.pone.01787981" alt="DOI"><img src="https://img.shields.io/badge/DOI-10.1371%2Fjournal.pone.0178798-blue">
  </a>
</p>
<p align="center">
  <a href="#installation">Installation</a> •
  <a href="#using-braph2">Examples</a> •
  <a href="#learning-braph-2">Basics</a> •
  <a href="#cite-us">Cite us</a> •
  <a href="https://github.com/softmatterlab/BRAPH-2-Matlab/blob/develop/braph2genesis/braph2license.rtf">License</a> 
</p>


An object-oriented software that provides pipelines for conventional brain connectivity analysis as well as more advanced methods, including multilayer networks and deep learning methods.

# Installation

BRAPH 2 requires at least MATLAB 2020b. BRAPH 2 requires Statistics and Machine Learning Toolbox. For deep learning analysis, Deep Learning Toolbox and Deep Learning Toolbox Converter for ONNX Model Format are also needed. We strongly recommend the Parallel Computing Toolbox to speed up BRAPH 2.

To install BRAPH 2, first clone this repository or download via zip. 
Once inside MATLAB go to the folder of BRAPH 2 and run braph2genesis (you may have to add it to the path). This will create a braph2 folder with the executable code, it may take a while.
This will be only needed once, or every time you add a new functionality to BRAPH 2.

# Using-braph2

Each provided pipeline comes with an example folder where you can run the example script that mocks the analysis/comparison of the cohort data using the desired graph measures.

# Learning-braph-2

BRAPH 2 is a powerful tool that transforms scripts to pipelines. Please check the tutorial section on our website <a href="http://braph.org/tutorials/"></a>

## Cite us!
If you use BRAPH 2 in your project, please cite us here:

```
Emiliano Gomez-Ruiz, Anna Canal-Garcia, Yu-Wei Chang, Daniel Vereb, 
Eric Westman, Mite Mijalkov, Joana Pereira, Giovanni Volpe
BRAPH 2: A software for brain connectivity analysis 
with multilayer graphs and deep learning.
```

See also:

<https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0178798>:
```
Mite Mijalkov, Ehsan Kakaei, Joana B Pereira, Eric Westman, Giovanni Volpe
BRAPH: A graph theory software for the analysis of brain connectivity.
PLOS ONE 12, e0178798 (2017)..
```
