% Script to load atlas and create cohort (saved in workflows\MultiplexMRI
% folder)

% Load atlas from desikan excel file
atlas = BrainAtlas.load_from_xls('File', 'desikan_atlas_braph2.xlsx');
% Load cohort from data excel files
subject_class = Measurement.getSubjectClass('MeasurementMultiplexMRI');
filename1 = 'Group1_MRI_data_layer1.xlsx';
filename2 = 'Group1_MRI_data_layer2.xlsx';
load_cohort = SubjectMultiplexMRI.load_from_xls(subject_class, atlas, 'File1', filename1, 'File2', filename2);