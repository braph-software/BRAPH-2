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

delete(findall(0, 'type', 'figure'))
close all
clear all %#ok<CLALL>
clc

fprintf([ ...
    '\n' ...
	' ████   ████    ███   ████   █   █     ▓▓▓▓   ▓▓▓▓     █████ ████ █   █ ████  ████  █   ████\n' ...
	' █   █  █   █  █   █  █   █  █   █        ▓   ▓  ▓     █     █    ██  █ █    █      █  █    \n' ...
	' ████   ████   █████  █████  █████     ▓▓▓▓   ▓  ▓     █  ██ ███  █ █ █ ███   ███   █   ███ \n' ...
	' █   █  █  █   █   █  █      █   █     ▓      ▓  ▓     █   █ █    █  ██ █        █  █      █\n' ...
	' ████   █   █  █   █  █      █   █     ▓▓▓▓ ▓ ▓▓▓▓     █████ ████ █   █ ████ ████   █  ████ \n' ...
    '\n' ...
    ' version ' BRAPH2.VERSION ' build ' int2str(BRAPH2.BUILD) '\n' ...
    ' <a href="matlab:BRAPH2GUI()">Open BRAPH GUI</a> <a href="http://' BRAPH2.WEB '">' BRAPH2.WEB '</a>\n' ...
    ' ' BRAPH2.COPYRIGHT '\n' ...
    '\n' ...
    ]);

addpath(fileparts(which('braph2genesis')))
addpath([fileparts(which('braph2genesis')) filesep 'genesis'])

target_dir = [fileparts(fileparts(which('braph2genesis'))) filesep 'braph2'];
if exist(target_dir, 'dir') 
    if input([ ...
        'The target directory already exists:\n' ...
        target_dir '\n'...
        'It will be erased with all its content.\n' ...
        'Proceed anyways? (y/n)\n'
        ], 's') == 'y'
    
        backup_warning_state = warning('off', 'MATLAB:RMDIR:RemovedFromPath');
        rmdir(target_dir, 's')
        warning(backup_warning_state)
    else
        disp('Compilation interrupted.')
    end
end
if ~exist(target_dir, 'dir') 
    time_start = tic;

    [target_dir, source_dir] = genesis(target_dir, [], 2, false);

    addpath(target_dir)

    time_end = toc(time_start);

    disp(['BRAPH 2 is now fully compiled and ready to be used.'])
    disp(['Its compilation has taken ' int2str(time_end) '.' int2str(mod(time_end, 1) * 10) 's'])
    disp('')
    
    braph2(false)

%     test_braph2 % % % ON RELEASE: uncomment
end