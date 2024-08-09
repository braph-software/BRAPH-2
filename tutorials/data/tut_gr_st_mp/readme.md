# Group of Subjects with Structural Multiplex Data

[![Tutorial Group of Subjects with Structural Multiplex Data](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](tut_gr_st_mp.pdf)

For *structural multiplex data*, we will upload a folder containing the structural files from different modalities (layers) for different brain areas across subjects that belong to the same group. For example, the structural values could correspond to cortical thickness or gray matter volumes obtained from T1-weighted MRI data, brain perfusion in ASL, or abnormal protein deposition in static PET data. Then a connectivity matrix is computed using correlations in structural values between each pair of brain regions for each layer, and then the layers will be integrated in a multiplex graph. This Tutorial explains how to prepare and work with this kind of data.


<img src="fig01.jpg" alt="GUI for a group of subjects with structural multiplex data">

> **Figure 1. GUI for a group of subjects with structural multiplex data**
> Full graphical user interface to upload a group with structural multiplex data in BRAPH 2.

## Table of Contents
> [Generation of Example Data](#Generation-of-Example-Data)
>
> [Open the GUI](#Open-the-GUI)
>
> [Visualize the Group Data](#Visualize-the-Group-Data)
>
> [Visualize Each Subject's Data](#Visualize-Each-Subject's-Data)
>
> [Preparation of the Data to Be Imported](#Preparation-of-the-Data-to-Be-Imported)
>
> [Adding Covariates](#Adding-Covariates)
>




## Generation of Example Data  [⬆](#Table-of-Contents)

If you do not have the "Example data ST\_MP XLS" folder inside "structural multiplex", then you can generate it by running the commands in Code 1.

**Code 1.** **Code to generate the example data folder.**
		This code can be used in the MatLab command line to generate the "Example data ST\_MP XLS" folder to the "structural multiplex" pipeline folder.
````matlab
create_data_ST_MP_XLS()  % [1]
create_data_ST_MP_TXT()  % [2]
````

[1] generates the example structural multiplex XLS data folder.

[2] generates the example structural multiplex TXT data folder.


## Open the GUI  [⬆](#Table-of-Contents)

In most analyses, the group GUI is the second step after you have selected a brain atlas. You can open it by typing `braph2` in MatLab's terminal, which allows you to select a pipeline containing the steps required to perform your analysis and upload a brain atlas. After these steps have been completed you can upload your group's data directly (Figure 2c-f) after clicking "Load Group". 



<img src="fig02.jpg" alt="Upload the data of a group of subjects">

> **Figure 2. Upload the data of a group of subjects**
> Steps to upload a group of subjects with structural multiplex data using the GUI and an example dataset: 
> 	**a** Open the group GUI.
> 	**b** Import the folder with the structural multiplex files in XLS or TXT format (see below for details on their format).
> 	To upload the test structural multiplex data:
> 	**c**-**f** navigate to the BRAPH 2 folder "pipelines", **d** "structural multiplex",  **e** "Example data ST_MP XLS", and **f** select the folder with structural multiplex values of one group "ST_MP_Group_1_XLS".


> **GUI launch from command line**
> You can also open the GUI and upload the brain structural multiplex data using the command line (i.e., without opening an analysis pipeline) by typing the commands in Code 2. In this case, you can upload the data as shown in Figure 2a-f.
> %
> **Code 2.** **Code to launch the GUI to upload a group of subjects with structural multiplex data.**
> 		This code can be used in the MatLab command line to launch the GUI to upload a group of subjects with structural multiplex data without having to open a pipeline.
> ````matlab
> gr = Group('SUB_CLASS', 'SubjectST_MP');
> 
> gui = GUIElement('PE', gr);
> gui.get('DRAW')
> gui.get('SHOW'
> ````

## Visualize the Group Data  [⬆](#Table-of-Contents)

After completing the steps described in Figure 2, you can see the data (Figure 3a), and change the Group ID, name, and notes (Figure 3b). 



<img src="fig03.jpg" alt="Edit the group metadata">

> **Figure 3. Edit the group metadata**
> **a** The GUI of the group's structural multiplex data. 
> 	**b** The information you see on this GUI that can be changed. In this example, we have edited the ID, name, and notes of the group but can also change the subject's specific information.

## Visualize Each Subject's Data  [⬆](#Table-of-Contents)

Finally, you can open each subject's structural multiplex values by selecting the subject, right click, and select "Open selection" (Figure 4a), which shows the structural values from layer 1 (Figure 4b). Here, you can also change the subject's metadata (ID, label, notes), its variables of interest, and the structural multiplex values.



<img src="fig04.jpg" alt="Edit the individual subject data">

> **Figure 4. Edit the individual subject data**
> **a**  Each subject's structural multiplex values can be opened by selecting the subject, right click, and select "Open selection".
> 	**b** In this subject GUI, it is possible to view and edit the metadata of the subject (ID, label, notes), its variables of interest (in this case, age and sex), and the structural multiplex values.


## Preparation of the Data to Be Imported  [⬆](#Table-of-Contents)

To be able to import structural multiplex data into BRAPH 2, you need to include the structural values of each layer for all subjects in a single file in excel or text format. All structural layers' files should be inside one group folder. Below you can see how this file should look like.



<img src="fig05.jpg" alt="Data preparation">

> **Figure 5. Data preparation**
> The data should be organised in the following format:
> 	**a** The structural values of one layer from each subject belonging to the same group should be included in a single file (for example, "ST_MP_Group_1_xlsx"). 
> 	**b** This file should contain the subject's IDs, label and any relevant notes, followed by the structural values for each brain region belonging to a brain atlas. In this example, the (simulated) values correspond to the cortical thickness of 68 brain regions derived from T1-weighted MRI.

## Adding Covariates  [⬆](#Table-of-Contents)


	
It is very common to have *variables of interest* (i.e., *covariates* and *correlates*) in an analysis. In BRAPH 2, 
these variables of interest should be included in a separate excel file placed just outside the group's folder and with the same name as the folder followed by ".vois" (Figure 6a). This file should have a specific format (Figure 6b):


- **Subject IDs (column A).**
Column A should contain the subject IDs starting from row 3.

- **Variables of interest (column B and subsequent columns).**
Column B (and subsequent columns) should contain the variables of interest (one per column). 
In this example we have "Age" and "Sex", as in the example file, as well as the additional "Education".
In each column, row 1 should contain the name of the variable of interest, row 2 should contain the categories separated by a return (only for categorical variables of interest, like "Sex" and "Education"), and the subsequent rows the values of the variable of interest for each subject.



<img src="fig06.jpg" alt="Edit the Covariates">

> **Figure 6. Edit the Covariates**
> Information that can be changed in the Covariates file: 
> 	**a** The values of the variables of interest (vois).
> 	**b** In case the vois are categorical, you can state which categories they have.