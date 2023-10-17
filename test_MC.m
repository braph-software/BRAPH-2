%% test script
% I dont testd this since I dont have the data. Please make sure Mite
% in my opinion it needs a pipeline since theres no way to place the data
% into a multilayer and all importers average or ensemble
% have to run braph2genesis first

%% clear
clear;
clc;

%% Load data
density = 1;
load_name = 'TestData_Emiliano.mat';
load(load_name)
data = data_test;

%% Create graph
g = MultiplexWU('B', data);

%% create measures
mc_global = g.get('MEASURE', 'GlobalMC');
mc_nodal = g.get('MEASURE', 'NodalMC');

%% change parameters
mc_global.set('TRAINING_SAMPLES', 20000); % for example

%% calculate
mc_global_result = mc_global.get('M');
mc_nodal_result = mc_nodal.get('M');