close all
clear all
clc

braph_path = [pwd '\braph2']
genesis_path = [pwd '\braph2genesis']

%% list the files that need to be validated for a quick check
% list the files to be directly copied to braph2 folder
files_for_copy = { ...
    }

% list the genesis files to be compiled to braph2 folder
gen_files = { ...
    '\pipelines\structural\_AnalyzeGroup_ST_WU.gen.m' ...
    '\pipelines\structural\_AnalyzeGroup_ST_BUT.gen.m' ...
    '\pipelines\structural\_AnalyzeGroup_ST_BUD.gen.m' ...
    '\pipelines\structural\_PPAnalyzeGroup_UseCovariates.gen.m' ...
    '\pipelines\structural\_PPAnalyzeGroup_CorrelationRule.gen.m' ...
    };

%% Delete the files
for i = 1:length(gen_files)
    delete([braph_path extractBefore(gen_files{i}, "\_") filesep char(extractBetween(gen_files{i}, "\_", ".gen")) '.m']);
end 

%% Compile and run the test
for i = 1:length(files_for_copy)
    status = copyfile([genesis_path files_for_copy{i}], [braph_path extractBefore(files_for_copy{i}, "\_")]);
    if status == 0
        warning([files_for_copy{i} ' copy failed'])
    end
end

for i = 1:length(gen_files)
    create_Element([genesis_path gen_files{i}], [braph_path extractBefore(gen_files{i}, "\_")])
    create_test_Element([genesis_path gen_files{i}], [braph_path extractBefore(gen_files{i}, "\_")])
   % eval(['test_' char(extractBetween(gen_files{i}, "\_", ".gen"))])
end

braph2
%% test on GUI
GUI('pe', Pipeline()).draw()


