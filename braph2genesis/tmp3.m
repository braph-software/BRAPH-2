close all
delete(findall(0, 'type', 'figure'))
clear all
clc

el_class = 'BrainAtlas';
delete([fileparts(which('braph2')) '/src/atlas/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/src/atlas/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/atlas'])
create_Element([fileparts(which('braph2genesis')) '/src/atlas/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/atlas'])
create_test_Element([fileparts(which('braph2genesis')) '/src/atlas/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/atlas'])
% test_code = ['test_' el_class]
% eval(test_code)

el_class = 'PanelPropIDictTable';
delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% test_code = ['test_' el_class]
% eval(test_code)

br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
br6 = BrainRegion('ID', 'id6', 'LABEL', 'label6', 'NOTES', 'notes6', 'X', 6, 'Y', 6, 'Z', 6);

items = {br1, br2, br3, br4, br5, br6};

idict_1 = IndexedDictionary( ...
    'id', 'idict', ...
    'it_class', 'BrainRegion', ...
    'it_key', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'it_list', items ...
    );
ba = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'Notes', 'Notes on brain atlas.', 'br_dict', idict_1);
gui = GUIElement('PE', ba, 'CLOSEREQ', false);
f = gui.draw();

return

% el_class = 'GUI';
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