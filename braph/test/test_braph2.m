% Test BRAPH by running all unit tests

close all
clear all 
clc

dir = fileparts(which('braph2'));

results = runtests({ ...
    [dir '/util'], ...
    [dir '/graph'] ...
    [dir '/graph/graphs'] ...
    });


results_table = table(results)