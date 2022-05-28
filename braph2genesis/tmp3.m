close all
delete(findall(0, 'type', 'figure'))
clear all
clc

el_class = 'PPPipeline_PSDict';
delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% test_code = ['test_' el_class]
% eval(test_code)

% pip = Pipeline();

im = ImporterPipelineBRAPH2(...
    'FILE', [fileparts(which('Pipeline')) filesep 'pipeline_atlas.braph2'], ...
    'WAITBAR', true ...
    ); 
pip = im.get('PIP');

gui = GUIElement('PE', pip, 'CLOSEREQ', false);
f = gui.draw();

return

% el_class = 'PPPipeline_PSDict';
% delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % test_code = ['test_' el_class]
% % eval(test_code)

im = ImporterPipelineBRAPH2(...
    'FILE', [fileparts(which('Pipeline')) filesep 'pipeline_atlas.braph2'], ...
    'WAITBAR', true ...
    ); 
pip = im.get('PIP');
% pip.tree(4)

ex= ExporterPipelineBRAPH2( ...
    'PIP', pip, ...
    'WAITBAR', true ...
    );
ex.get('SAVE');