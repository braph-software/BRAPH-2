close all
clear all
clc

braph2

dir = fileparts(which('braph2'));

results = runtests({ ...
    [dir '/util'], ...
    [dir '/graph'] ...
    });


results_table = table(results)