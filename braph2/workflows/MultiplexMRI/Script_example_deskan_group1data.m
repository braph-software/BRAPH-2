% Script to load atlas and create cohort (saved in workflows\MultiplexMRI
% folder)

% Load atlas from desikan excel file
atlas = BrainAtlas.load_from_xls('File', 'desikan_atlas_braph2.xlsx');
% Load cohort from data excel files
subject_class = Measurement.getSubjectClass('MeasurementMultiplexMRI');
save_dir_path1 = [fileparts(which('SubjectMultiplexMRI')) filesep 'Group1_MRI_data_layer1.xlsx'];
save_dir_path2 = [fileparts(which('SubjectMultiplexMRI')) filesep 'Group1_MRI_data_layer2.xlsx'];
cohort_info_path1 = [fileparts(which('test_braph2')) filesep 'trial_cohort_to_be_erased.txt'];
filename1 = 'Group1_MRI_data_layer1.xlsx';
filename2 = 'Group1_MRI_data_layer2.xlsx';
load_cohort = SubjectMultiplexMRI.load_from_xls(subject_class, atlas, 'File1', save_dir_path1, 'File2', save_dir_path2);