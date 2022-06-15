close all
delete(findall(0, 'type', 'figure'))
clear all
clc

el_class = 'GUI';
delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% test_code = ['test_' el_class]
% eval(test_code)

% el_class = 'PanelPropIDictTable';
% delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% el_class = 'PFBrainAtlas';
% delete([fileparts(which('braph2')) '/src/atlas/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/atlas/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/atlas'])
% create_Element([fileparts(which('braph2genesis')) '/src/atlas/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/atlas'])
% % create_test_Element([fileparts(which('braph2genesis')) '/src/atlas/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/atlas'])
% % test_code = ['test_' el_class]
% % eval(test_code)

% pf0 = PanelFig();
% gui0 = GUIFig('PF', pf0, 'FILE', 'xxx sss', 'WAITBAR', true, 'CLOSEREQ', false);
% f0 = gui0.draw('Units', 'normalized', 'Position', [.1 .5 .4 .4]);
% close(f0)
% f0new = gui0.draw('Units', 'normalized', 'Position', [.1 .5 .4 .4]);

% pf1 = PFBrainSurface('SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'));
% gui1 = GUIFig('PF', pf1, 'FILE', 'xxx sss', 'WAITBAR', true, 'CLOSEREQ', false);
% f1 = gui1.draw('Units', 'normalized', 'Position', [.1 .5 .4 .4]);

% br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
% br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
% br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
% br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
% br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
% br6 = BrainRegion('ID', 'id6', 'LABEL', 'label6', 'NOTES', 'notes6', 'X', 6, 'Y', 6, 'Z', 6);
% items = {br1, br2, br3, br4, br5, br6};
% idict = IndexedDictionary( ...
%     'id', 'idict', ...
%     'it_class', 'BrainRegion', ...
%     'it_key', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
%     'it_list', items ...
%     );
% ba0 = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'Notes', 'Notes on brain atlas.', 'br_dict', idict);
% pf0 = PFBrainAtlas(...
%     'SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'), ...
%     'BA', ba0 ...
%     );
% gui0 = GUIFig('PF', pf0, 'FILE', 'xxx sss', 'WAITBAR', true, 'CLOSEREQ', false);
% f0 = gui0.draw('Units', 'normalized', 'Position', [.1 .1 .4 .8]);

tic 
ba1 = ImporterBrainAtlasXLS('FILE', [fileparts(which('braph2')) filesep() 'atlases' filesep() 'aal90_atlas.xlsx']).get('BA');
toc 
pf1 = PFBrainAtlas(...
    'SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'), ...
    'BA', ba1 ...
    );
toc
gui1 = GUIFig('PF', pf1, 'FILE', 'xxx sss', 'WAITBAR', false, 'CLOSEREQ', true);
toc
f1 = gui1.draw('Units', 'normalized', 'Position', [.1 .1 .4 .8]);
toc
% close(f1)
% toc
% f1 = gui1.draw('Units', 'normalized', 'Position', [.1 .1 .4 .8]);
% toc

% im = ImporterPipelineBRAPH2(...
%     'FILE', [fileparts(which('Pipeline')) filesep 'pipeline_atlas.braph2'], ...
%     'WAITBAR', true ...
%     ); 
% pip = im.get('PIP');
% 
% gui = GUIElement('PE', pip, 'CLOSEREQ', false);
% f = gui.draw();

% tic 
% ba1 = ImporterBrainAtlasXLS('FILE', [fileparts(which('braph2')) filesep() 'atlases' filesep() 'aal90_atlas.xlsx']).get('BA');
% toc
% gui1 = GUIElement('PE', ba1);
% toc
% f1  = gui1.draw();
% toc

% % % ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('braph2')) filesep() 'atlases' filesep() 'aal90_atlas.xlsx']).get('BA');
% % % pf = PFBrainAtlas(...
% % %     'SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'), ...
% % %     'BA', ba ...
% % %     );
% % % triangles = pf.get('SURF').get('TRIANGLES');
% % % coordinates = pf.get('SURF').get('COORDINATES');
% % % 
% % % f = uifigure();
% % % a = uiaxes(f, 'Units', 'normalized', 'Position', [0 0 1 1]);
% % % hold(a, 'on')
% % % view(a, 3)
% % % 
% % % h1 = trisurf( ...
% % %     triangles, ...
% % %     coordinates(:, 1), ...
% % %     coordinates(:, 2), ...
% % %     coordinates(:, 3), ...
% % %     'Parent', a ...
% % %     );
% % % set(h1, 'FaceColor', [1 0 0], 'EdgeAlpha', 0)
% % % 
% % % h2 = trisurf( ...
% % %     triangles, ...
% % %     coordinates(:, 1), ...
% % %     coordinates(:, 2) + 200, ...
% % %     coordinates(:, 3), ...
% % %     'Parent', a ...
% % %     );
% % % set(h2, 'FaceColor', [0 1 0], 'EdgeAlpha', 0)
% % % 
% % % lighting(a, 'gouraud')
% % % material(a, 'dull')
% % % light = camlight(a, 'headlight');
% % % 
% % % delete(light); light = camlight(a, 'headlight');
% % % 
% % % h3 = trisurf( ...
% % %     triangles, ...
% % %     coordinates(:, 1), ...
% % %     coordinates(:, 2) + 400, ...
% % %     coordinates(:, 3), ...
% % %     'Parent', a ...
% % %     );
% % % set(h3, 'FaceColor', [0 0 1], 'EdgeAlpha', 0)
% % % 
% % % % shading(a, 'interp')
% % % % camlight(a, 'headlight')

% im = ImporterPipelineBRAPH2(...
%     'FILE', [fileparts(which('Pipeline')) filesep 'pipeline_atlas.braph2'], ...
%     'WAITBAR', true ...
%     ); 
% pip = im.get('PIP');
% 
% gui = GUIElement('PE', pip, 'CLOSEREQ', false);
% f = gui.draw();

% pip = load('pipatlas.b2', '-mat').el;
% gui = GUIElement('PE', pip, 'CLOSEREQ', true);
% f = gui.draw();

return

f = uifigure();
t = uitable(f, 'Data', randn(10));

s = uistyle('BackgroundColor', 'r');
addStyle(t, s, 'column', 2)

s.BackgroundColor = ''
s.FontWeight = 'bold'
addStyle(t, s, 'row', 2)

tab = t.StyleConfigurations

char(tab{1,1})

categories(tab.Target)
