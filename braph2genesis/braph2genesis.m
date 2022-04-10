%BRAPH2GENESIS 
% This script generates and tests BRAPH2. The various subfolders contain
% the files necessary to generate the various parts of BRAPH2.
%
% BRAPH2GENESIS packages:
%  <a href="matlab:help genesis     ">genesis</a>       - code to generate BRAPH2
%  <a href="matlab:help braph2      ">braph2</a>        - BRAPH2 loader
%  <a href="matlab:help src         ">src</a>           - BRAPH2 core
%  <a href="matlab:help brainsurfs  ">brainsurfs</a>    - BRAPH2 brainsurfs
%  <a href="matlab:help graphs      ">graphs</a>        - BRAPH2 graphs
%  <a href="matlab:help measures    ">measures</a>      - BRAPH2 measures
%  <a href="matlab:help pipelines   ">pipelines</a>     - BRAPH2 pipelines
%  <a href="matlab:help test        ">test</a>          - BRAPH2 test

close all
clear all %#ok<CLALL>
clc

addpath(fileparts(which('braph2genesis')))
addpath([fileparts(which('braph2genesis')) filesep 'genesis'])

target_dir = [fileparts(fileparts(which('braph2genesis'))) filesep 'braph2'];
if exist(target_dir, 'dir') 
    warning('off', 'MATLAB:RMDIR:RemovedFromPath')
    rmdir(target_dir, 's')
    warning('on', 'MATLAB:RMDIR:RemovedFromPath')
end
[target_dir, source_dir] = genesis(target_dir, [], 2);

addpath(target_dir)

disp('BRAPH 2.0 is now fully compiled and ready to be used')

braph2

test_braph2