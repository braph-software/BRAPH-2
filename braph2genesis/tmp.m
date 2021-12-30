close all
clear all
clc

% create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotPropText.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')

im = ImporterPipelineBRAPH2(...
    'FILE', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/pipelines/structural/pipeline_structural_comparison_wu.braph2', ...
    'WAITBAR', false ...
    ); 
pl = im.get('PL');

GUI(pl)

% create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_Pipeline.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_ImporterPipelineBRAPH2.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_ExporterPipelineBRAPH2.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% 
% im = ImporterPipelineBRAPH2(...
%     'FILE', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/pipelines/structural/pipeline_structural_comparison_wu.braph2', ...
%     'WAITBAR', true ...
%     ); 
% pl = im.get('PL');
% % pl.tree(4)
% 
% ex= ExporterPipelineBRAPH2( ...
%     'PL', pl, ...
%     'WAITBAR', true ...
%     );
% ex.get('SAVE');