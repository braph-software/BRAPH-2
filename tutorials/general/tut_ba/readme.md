# Brain Atlas

This Tutorial explains how to work with the Graphical User Interface (GUI) to manage brain atlases. This is typically the first step required to perform a graph analysis in BRAPH 2.0. In this Tutorial, we will explain how to upload a brain atlas, how to visualize it, and how to export publication-ready brain figures.

> ![Brain Atlas GUI](fig02.png)
> **Brain Atlas GUI.** Full graphical user interface to work with a brain atlas in BRAPH~2.0.

## Open the GUI

The brain atlas GUI is the first step in most BRAPH 2.0 pipelines. You can open it by typing `braph2` in the MatLab's terminal, which allows you to select a pipeline containing the steps required to perform your analysis. The initial step is typically to upload the brain atlas, as shown in the figure below.

> ![Upload a brain atlas](fig03.png)
> **The different steps you need to follow to open a brain atlas using the GUI:**
> **a** Open the brain atlas GUI.
> **b** Import a brain atlas from an XLS or TXT file.
> **c** Navigate to the BRAPH 2.0 folder `atlases`.
> **d** Select the desired atlas.

To open the GUI and upload the brain atlas, you can also do it from the command line (i.e., without opening an analysis pipeline) by typing the following commands:

```matlab
ba = BrainAtlas();  % creates a new object `BrainAtlas`.

gui = GUIElement('PE', ba);  % creates a GUI to upload the brain atlas.
gui.get('DRAW');  % draws the GUI.
gui.get('SHOW');  % shows the GUI.
```

## Upload the Brain Atlas

In the GUI launched in the previous step, you have a menu that can be used to import a brain atlas (see figure below) either by loading one of the already-available atlases in the BRAPH 2.0 folder `atlases` (Figure 3c) or by loading a file you have created. In this example, we are uploading the Desikan atlas (Figure 3d).

You can change the ID, name, and notes of the brain atlas (as shown in Figure 4a) as well as the IDs, labels, coordinates, and notes of the brain regions (Figure 4b).

> ![Edit the brain atlas information](tut_ba/fig04.png)
Information that can be changed in the brain atlas GUI: 
**a** The ID, name, and notes of the brain atlas.
**b** The IDs, labels, coordinates, and notes of the brain regions.

## Ready Brain Atlases

![Brain Atlases](tut_ba/fig05.png)

Some brain atlases provided by BRAPH 2.0:

- AAL90: Automated Anatomical Labelling atlas with 90 cortical and subcortical regions.
- AAL116: Automated Anatomical Labelling atlas with 116 cortical and subcortical regions, including cerebellar areas.
- BNA: Brainnetome atlas with 246 cortical and subcortical regions.
- Craddock: Functional atlas with 200 cortical and subcortical regions, including cerebellar areas.
- Desikan: Anatomical atlas with 68 cortical from the FreeSurfer software.
- Destrieux: Anatomical atlas with 148 cortical from the FreeSurfer software.
- Schaefer: Functional brain atlas with 200 cortical regions that belong to 7 different resting-state fMRI networks.
- Subcortical FreeSurfer: Anatomical atlas with 14 subcortical gray matter regions from the FreeSurfer software.

Currently, we provide several brain atlases that are commonly used in the field of brain connectomics, some of which are shown in the figure above. They are available in the BRAPH 2.0 folder `atlases` in XLS and TXT formats, and they can also be downloaded from our website [here](http://braph.org/software/brain-atlases/).


