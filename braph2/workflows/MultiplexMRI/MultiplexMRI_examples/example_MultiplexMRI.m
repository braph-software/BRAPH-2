% Example MultiplexMRI Workflow

%% Load Atlas
atlas_path = [fileparts(which('AnalysisMultiplexMRI')) filesep 'MultiplexMRI_examples\exampleAtlas.xlsx'];
atlas = BrainAtlas.load_from_xls('File', atlas_path);

%% Load Subject Data
% Data from group 1 
cohort_group1_layer1 = [fileparts(which('AnalysisMultiplexMRI')) filesep 'MultiplexMRI_examples\xls\Group1_MRI_data_layer1.xlsx'];
cohort_group1_layer2 = [fileparts(which('AnalysisMultiplexMRI')) filesep 'MultiplexMRI_examples\xls\Group1_MRI_data_layer2.xlsx'];
cohort_group1 = SubjectMultiplexMRI.load_from_xls('SubjectMultiplexMRI', atlas, 'File1', cohort_group1_layer1, 'File2', cohort_group1_layer2);
% Data from group 2
cohort_group2_layer1 = [fileparts(which('AnalysisMultiplexMRI')) filesep 'MultiplexMRI_examples\xls\Group2_MRI_data_layer1.xlsx'];
cohort_group2_layer2 = [fileparts(which('AnalysisMultiplexMRI')) filesep 'MultiplexMRI_examples\xls\Group2_MRI_data_layer2.xlsx'];
cohort_group2 = SubjectMultiplexMRI.load_from_xls('SubjectMultiplexMRI', atlas, 'File1', cohort_group2_layer1, 'File2', cohort_group2_layer2);


% Init Cohort 
cohort = Cohort('Cohort Multiplex MRI', 'Cohort Label', 'Cohort notes' , 'SubjectMultiplexMRI', atlas, {});

% Integrating both cohort groups to Cohort
for i = 1:1:cohort_group1.getSubjects().length()
    subject = cohort_group1.getSubjects().getValue(i);
    cohort.getSubjects().add(subject.getID(), subject);
end
group1 = cohort_group1.getGroups().getValue(1);
cohort.getGroups().add(group1.getID(), group1)

for i = 1:1:cohort_group2.getSubjects().length()
    subject = cohort_group2.getSubjects().getValue(i);
    cohort.getSubjects().add(subject.getID(), subject);
end
group2 = cohort_group2.getGroups().getValue(1);
cohort.getGroups().add(group2.getID(), group2)

%% Show groups data
groups = cohort.getGroups().getValues();
group = groups{1}
group = groups{2}

%% Create Analysis
% analysis = AnalysisMultiplexMRI('analysis id', 'analysis label', 'analysis notes', cohort, {}, {}, {});
% 
% analysis.getSettings()