% Test BRAPH by running all unit tests

close all
clear all 
clc

dir = fileparts(which('braph2'));

results = runtests({ ...
    [dir filesep 'util'], ...
    [dir filesep 'graph'] ...
    [dir filesep 'graph' filesep 'graphs'] ...
    [dir filesep 'graph' filesep 'graphs'] ...
    });


results_table = table(results)