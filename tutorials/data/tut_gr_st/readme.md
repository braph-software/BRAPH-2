# Group of Subjects with Structural Data

[![Tutorial Group of Subjects with Structural Data](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](tut_gr_st.pdf)

For `structural data`, we will upload a file containing the structural values for different brain areas across subjects that belong to the same group. For example, the structural values could correspond to cortical thickness or gray matter volumes obtained from T1-weighted MRI data. Then a connectivity matrix is computed using correlations in structural values between each pair of brain regions. This Tutorial explains how to prepare and work with this kind of data.
<img src="fig01.jpg" alt="GUI for a group of subjects with structural data">

> **Figure 1. GUI for a group of subjects with structural data**
> Full graphical user interface to upload a group with structural data in BRAPH 2.0. 
## Generation of Example Data

If you don't have the "Example data ST XLS" folder inside "structural", then you can generate it by running the commands in `exampledata`.

**Code to generate the example data folder.**
		This code can be used in the MatLab command line to generate the "Example data ST XLS" folder to the "structural" pipeline folder.
> ```matlab
> 
> create_data_ST_XLS()  `1`
> create_data_ST_TXT
>`1` generates the example structural XLS data folder.>`2` generates the example structural TXT data folder.

()  `2`
> 
## Open the GUI

In most analyses, the group GUI is the second step after you have selected a brain atlas. You can open it by typing `braph2` in MatLab's terminal, which allows you to select a pipeline containing the steps required to perform your analysis and upload a brain atlas. After these steps have been completed you can upload your group's data directly (Figure 2c-f) after clicking "Load Group".fig{figure}
	{fig:02}
	{includegraphics{fig02.jpg}
	}
	{Upload the data of a group of subjects}
	{
	Steps to upload a group of subjects with structural data using the GUI and an example dataset: 
	**a** Open the group GUI.
	**b** Import the structural values in XLS or TXT format (see below for details on their format).
	To upload the test structural data:
	**c**-**f** navigate to the BRAPH 2.0 folder "pipelines", **d** "structural",  **e** "Example data ST XLS", and **f** select the structural values of one group "ST_Group_1_XLSX".
	}
<img src="fig04.jpg" alt="Edit the individual subject data">

> **Figure 2. Edit the individual subject data**
> **a**  Each subject's structural values can be opened by selecting the subject, right click, and select "Open selection"
	**b** In this subject GUI, it is possible to view and edit the metadata of the subject (ID, label, notes), its variables of interest (in this case, age and sex), and the structural values. 
> **GUI launch from command line**
 You can also open the GUI and upload the brain structural data using the command line (i.e., without opening an analysis pipeline) by typing the commands in `launch`. In this case, you can upload the data as shown in Figure 2a-f.
 
> ```matlab
> gr = Group('SUB_CLASS', 'SubjectST');
> 
> gui = GUIElement('PE', gr);
> gui.get('DRAW')
> gui.get('SHOW')
> ```
## Visualize the Group Data

After completing the steps described in Figure 2, you can see the data (Figure 3a), and change the Group ID, name, and notes (Figure 3b).fig{figure}
	{fig:03}
	{includegraphics{fig03.jpg}
	}
	{Edit the group metadata}
	{ 
	**a** The GUI of the group's structural data. 
	**b** The information you see on this GUI that can be changed. In this example, we have edited the ID, name, and notes of the group but can also change the subject's specific information.
	}
<img src="fig05.jpg" alt="Data preparation">

> **Figure 3. Data preparation**
> The data should be organised in the following format:
	**a** The structural values from each subject belonging to the same group should be included in a single file (for example, "ST_Group_1_xlsx"). 
	**b** This file should contain the subject's IDs, label and any relevant notes, followed by the structural values for each brain region belonging to a brain atlas. In this example, the (simulated) values correspond to the cortical thickness of 148 brain regions derived from T1-weighted MRI.
## Visualize Each Subject's Data

Finally, you can open each subject's structural values by selecting the subject, right click, and select "Open selection" (Figure 4a), which shows the structural values (Figure 4b). Here, you can also change the subject's metadata (ID, label, notes), its variables of interest, and the structural values.
<img src="fig06.jpg" alt="Edit the Covariates">

> **Figure 4. Edit the Covariates**
> Information that can be changed in the Covariates file: 
	**a** The values of the variables of interest (vois).
	**b** In case the vois are categorical, you can state which categories they have.
## Preparation of the Data to be Imported

To be able to import structural data into BRAPH 2.0, you need to include the structural values for all subjects in a single file in excel or text format. Below you can see how this file should look like.
#!FIG05

## Adding Covariates
It is very common to have `variables of interest` (i.e., `covariates` and `correlates`) in an analysis. In BRAPH 2.0, these variables of interest should be included in a separate excel file placed in the same directory as the group's structural data and with the same name as this data followed by ".vois" (Figure 6a). This file should have a specific format (Figure 6b):
> Subject IDs (column A).
Column A should contain the subject IDs starting from row 3.

> Variables of interest (column B and subsequent columns).
Column B (and subsequent columns) should contain the variables of interest (one per column). 
In this example we have "Age" and "Sex", as in the example file, as well as the additional "Education".
In each column, row 1 should contain the name of the variable of interest, row 2 should contain the categories separated by a return (only for categorical variables of interest, like "Sex" and "Education"), and the subsequent rows the values of the variable of interest for each subject.
#!FIG06
