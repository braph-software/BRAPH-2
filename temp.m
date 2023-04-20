close all; delete(findall(0, 'type', 'figure')); clear all

%% PanelProp Callback
% el_class_list = {'ViewPP'} % 'PanelProp'
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/gui';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el0 = GraphWU('ID', '0');
% el1 = GraphWU('ID', '1', 'TEMPLATE', el0);
% el2 = GraphWU('ID', '2', 'TEMPLATE', el1);
% el3 = GraphWU('ID', '3', 'TEMPLATE', el2);
% 
% gui = GUIElement('PE', el3);
% gui.get('DRAW')
% gui.get('SHOW')

%% ETx - GTx
% el_class_list = {'ETA_DI' 'ETA_NN' 'ETA_NR' 'ETA_NC' 'ETA_NM' 'ETA_NS' 'ETA_LL' 'ETA_ML' 'ETA_HA' 'ETA_HL' 'ETA_CO' 'ETA_AL' 'ETA_SZ' 'ETA_MR' 'ETA_LN'}; % 'ETA_IT' 'ETA_IL' 
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/ds/examples';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end
% el_class_list = {'GTA_DI'} 
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/gui/examples';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

%% waitbar
% el_class_list = {'PanelElement'}; % 'PanelElement' 'ImporterPipelineBRAPH2' 'ExporterPipelineBRAPH2'
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/gui';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end
% el_class_list = {'ImporterBrainAtlasXLS' 'ExporterBrainAtlasXLS' 'ImporterBrainAtlasTXT' 'ExporterBrainAtlasTXT'};
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/atlas';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el = ConcreteElement();
% pe = PanelElement( ...
%     'EL', el ...
%     );
% gui2 = GUIElement( ...
%     'PE', pe, ...
%     'WAITBAR', true, ...    
%     'CLOSEREQ', false ...
%     );
% gui2.get('DRAW')
% gui2.get('SHOW')
% f2 = gui2.get('H');

% el = ConcreteElement('ID', 'ELEMENT');
% pe = PanelElement( ...
%     'ID', 'PANEL', ...
%     'EL', el ...
%     );
% gui = GUIElement( ...
%     'ID', 'GUI', ...
%     'PE', pe, ...
%     'WAITBAR', true, ...    
%     'CLOSEREQ', false ...
%     );
% 
% pe.set('WAITBAR', gui.getCallback('WAITBAR'))
% 
% gui_copy = gui.copy();
% 
% isequal(gui_copy, gui)

%% GUI
% el_class_list = {'SettingsPosition'}; % 'PanelPropIDictTable' 'PanelPropItemList' 'PanelPropStringTextArea'
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/gui';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end
% el_class_list = {'BrainSurfacePF'}; % 'BrainSurfacePF' 'BrainAtlasPF'
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/atlas';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% gui1 = GUI( ...
%     'TITLE', 'Figure Title', ...
%     'MENUBAR', true, ...
%     'MENU_ABOUT', true, ...
%     'TOOLBAR', true, ...
%     'TOOL_ABOUT', true, ...
%     'POSITION', [0 .6 .2 .4], ...
%     'BKGCOLOR', [1 0 0], ...
%     'CLOSEREQ', false ...
%     );
% gui1.get('DRAW')
% gui1.get('SHOW')
% f1 = gui1.get('H');

% el = ConcreteElement();
% gui2 = GUIElement( ...
%     'PE', el, ...
%     'CLOSEREQ', false ...
%     );
% gui2.get('DRAW')
% gui2.get('SHOW')
% f2 = gui2.get('H');

% ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('braph2')) filesep() 'atlases' filesep() 'aal90_atlas.xlsx']).get('BA');
% pf = BrainAtlasPF(...
%     'SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'), ...
%     'BA', ba ...
%     );
% gui3 = GUIFig('PF', pf, 'FILE', 'xxx sss', 'POSITION', [.1 .1 .4 .8], 'CLOSEREQ', false); % % % %TODO add 'WAITBAR', false,
% gui3.get('DRAW')
% gui3.get('SHOW')
% gui3_settings = gui3.memorize('GUI_SETTINGS');
% gui3_settings.set('POSITION', [0 0 .3 .5])
% gui3_settings.get('DRAW')
% gui3_settings.get('SHOW')

%% Measures
% el_class_list = {'Measure'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/gt';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end
% el_class_list = {'Degree' 'DegreeAv' 'Distance'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/measures';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

%% Graphs
% el_class_list = {'MeasurePF'} % 'Graph' 'Measure' 'MeasurePF' 'MeasurePF_GU' 'MeasurePF_NU' 'MeasurePF_BU' 'GraphPP_MDict'
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/gt';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end
el_class_list = {'PanelPropClassList'} % 'SettingsLine' 'SettingsArea' 'SettingsLinePP' 'SettingsAreaPP' 'SettingsTextPP' 'PanelPropStringList' 'PanelPropIDictTable'
for i = 1:1:length(el_class_list)
    el_class = el_class_list{i};
    el_path = '/src/gui';
    delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
    eval(['test_' el_class])
end
% el_class_list = {'GraphPP_MDict'} % 'Graph' 'GraphAdjPF' 'GraphHistPF' 'LayersPP' 'GraphPP_MDict'
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/gt';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end
% el_class_list = {'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexBD' 'MultiplexBU' 'MultiplexWD' 'MultiplexWU' 'OrdMultiWU' 'MultiplexBUD' 'MultiplexBUT'};
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/graphs';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% Graph
% g = Graph();
% gui = GUIElement( ...
%     'PE', g, ...
%     'WAITBAR', true, ...
%     'CLOSEREQ', false ...
%     );
% gui.get('DRAW')
% gui.get('SHOW')

% GraphBD GraphBU GraphWD GraphWU
% g1 = GraphWU();
% gui1 = GUIElement( ...
%     'PE', g1, ...
%     'WAITBAR', true, ...
%     'CLOSEREQ', false ...
%     );
% gui1.get('DRAW')
% gui1.get('SHOW')

% g2 = GraphWU( ...
%     'B', randn(5) ...
%     );
% gui2 = GUIElement( ...
%     'PE', g2, ...
%     'WAITBAR', true, ...
%     'CLOSEREQ', false ...
%     );
% gui2.get('DRAW')
% gui2.get('SHOW')
 
% g1 = MultigraphBUD( ...
%     'DENSITIES', [0 55 100] ...
%     );
% gui1 = GUIElement( ...
%     'PE', g1, ...
%     'WAITBAR', true ...
%     );
% gui1.get('DRAW')
% gui1.get('SHOW')

% g2 = MultigraphBUD( ...
%     'DENSITIES', [0 55 100], ...
%     'B', randn(5) ...
%     );
% gui2 = GUIElement( ...
%     'PE', g2, ...
%     'WAITBAR', true, ...
%     'CLOSEREQ', false ...
%     );
% gui2.get('DRAW')
% gui2.get('SHOW')

% br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
% br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
% br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
% br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
% br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
% items = {br1, br2, br3, br4, br5};
% idict_1 = IndexedDictionary( ...
%     'ID', 'idict', ...
%     'IT_CLASS', 'BrainRegion', ...
%     'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
%     'IT_LIST', items ...
%     );
% ba = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'NOTES', 'Notes on brain atlas.', 'BR_DICT', idict_1);
% g3 = MultigraphBUD( ...
%     'DENSITIES', [0 55 100], ...
%     'LAYERLABELS', {'a' 'b' 'c'}, ...
%     'NODELABELS', ba, ...
%     'B', randn(5) ...
%     );
% gui3 = GUIElement( ...
%     'PE', g3, ...
%     'WAITBAR', true ...
%     );
% gui3.get('DRAW')
% gui3.get('SHOW')


% g1 = MultigraphBUT( ...
%     'THRESHOLDS', [-1:.5:1] ...
%     );
% gui1 = GUIElement( ...
%     'PE', g1, ...
%     'WAITBAR', true ...
%     );
% gui1.get('DRAW')
% gui1.get('SHOW')

% g2 = MultigraphBUT( ...
%     'THRESHOLDS', [-1:.5:1], ...
%     'B', randn(5) ...
%     );
% gui2 = GUIElement( ...
%     'PE', g2, ...
%     'WAITBAR', true ...
%     );
% gui2.get('DRAW')
% gui2.get('SHOW')

% br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
% br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
% br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
% br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
% br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
% items = {br1, br2, br3, br4, br5};
% idict_1 = IndexedDictionary( ...
%     'ID', 'idict', ...
%     'IT_CLASS', 'BrainRegion', ...
%     'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
%     'IT_LIST', items ...
%     );
% ba = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'NOTES', 'Notes on brain atlas.', 'BR_DICT', idict_1);
% g3 = MultigraphBUT( ...
%     'THRESHOLDS', [-1:.5:1], ...
%     'LAYERLABELS', {'-c' '-b' 'a' 'b' 'c'}, ...
%     'NODELABELS', ba, ...
%     'B', randn(5) ...
%     );
% gui3 = GUIElement( ...
%     'PE', g3, ...
%     'WAITBAR', true, ...
%     'CLOSEREQ', false ...
%     );
% gui3.get('DRAW')
% gui3.get('SHOW')

% % 'MultiplexBD' 'MultiplexBU' 'MultiplexWD' 'MultiplexWU' 'OrdMultiWU'
B1 = rand(randi(10));
B2 = rand(randi(10));
B3 = rand(randi(10));
B12 = rand(size(B1,1),size(B2,2));
B13 = rand(size(B1,1),size(B3,2));
B23 = rand(size(B2,1),size(B3,2));
B = {
    B1                           B12                            B13
    B12'                         B2                             B23
    B13'                         B23'                           B3
    };
g1 = MultilayerWU('B', B);
gui1 = GUIElement( ...
    'PE', g1, ...
    'WAITBAR', true ...
    );
gui1.get('DRAW')
gui1.get('SHOW')

% g2 = OrdMultiWU( ...
%     'B', {randn(5) randn(5) randn(5)} ...
%     );
% gui2 = GUIElement( ...
%     'PE', g2, ...
%     'WAITBAR', true ...
%     );
% gui2.get('DRAW')
% gui2.get('SHOW')
% 
% br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
% br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
% br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
% br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
% br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
% items = {br1, br2, br3, br4, br5};
% idict_1 = IndexedDictionary( ...
%     'ID', 'idict', ...
%     'IT_CLASS', 'BrainRegion', ...
%     'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
%     'IT_LIST', items ...
%     );
% ba = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'NOTES', 'Notes on brain atlas.', 'BR_DICT', idict_1);
% g3 = OrdMultiWU( ...
%     'NODELABELS', ba, ...
%     'B', {randn(5) randn(5) randn(5)}, ...
%     'LAYERLABELS', {'L1' 'L2' 'L3'} ...
%     );
% gui3 = GUIElement( ...
%     'PE', g3, ...
%     'WAITBAR', true ...
%     );
% gui3.get('DRAW')
% gui3.get('SHOW')


% g1 = MultiplexBUT( ...
%     'THRESHOLDS', [-1:.5:1] ...
%     );
% gui1 = GUIElement( ...
%     'PE', g1, ...
%     'WAITBAR', true ...
%     );
% gui1.get('DRAW')
% gui1.get('SHOW')
% 
% g2 = MultiplexBUT( ...
%     'THRESHOLDS', [-1:.5:1], ...
%     'B', {randn(5) randn(5) randn(5)} ...
%     );
% gui2 = GUIElement( ...
%     'PE', g2, ...
%     'WAITBAR', true ...
%     );
% gui2.get('DRAW')
% gui2.get('SHOW')

br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
items = {br1, br2, br3, br4, br5};
idict_1 = IndexedDictionary( ...
    'ID', 'idict', ...
    'IT_CLASS', 'BrainRegion', ...
    'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'IT_LIST', items ...
    );
ba = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'NOTES', 'Notes on brain atlas.', 'BR_DICT', idict_1);
g3 = MultiplexBUT( ...
    'THRESHOLDS', [-1:.5:1], ...
    'NODELABELS', ba, ...
    'B', {randn(5) randn(5) randn(5)} ... % , ... 'LAYERLABELS', {'A' 'B' 'C'} ...
    );
gui3 = GUIElement( ...
    'PE', g3, ...
    'WAITBAR', true, ...
    'CLOSEREQ', false ...
    );
gui3.get('DRAW')
gui3.get('SHOW')

% g1 = MultiplexBUD( ...
%     'DENSITIES', [0 20 30 100] ...
%     );
% gui1 = GUIElement( ...
%     'PE', g1, ...
%     'WAITBAR', true ...
%     );
% gui1.get('DRAW')
% gui1.get('SHOW')

% g2 = MultiplexBUD( ...
%     'DENSITIES', [0 20 30 100], ...
%     'B', {randn(5) randn(5) randn(5)} ...
%     );
% gui2 = GUIElement( ...
%     'PE', g2, ...
%     'WAITBAR', true ...
%     );
% gui2.get('DRAW')
% gui2.get('SHOW')
% 
% br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
% br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
% br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
% br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
% br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
% items = {br1, br2, br3, br4, br5};
% idict_1 = IndexedDictionary( ...
%     'ID', 'idict', ...
%     'IT_CLASS', 'BrainRegion', ...
%     'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
%     'IT_LIST', items ...
%     );
% ba = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'NOTES', 'Notes on brain atlas.', 'BR_DICT', idict_1);
% g3 = MultiplexBUD( ...
%     'DENSITIES', [0 20 30 100], ...
%     'NODELABELS', ba, ...
%     'B', {randn(5) randn(5) randn(5)}, ...
%     'LAYERLABELS', {'A' 'B' 'C'} ...
%     );
% gui3 = GUIElement( ...
%     'PE', g3, ...
%     'WAITBAR', true ...
%     );
% gui3.get('DRAW')
% gui3.get('SHOW')

%% Hard code constants
% el_class_list = {'PanelPropIDictTable'};
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/gui';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

%% Pipeline
% el_class_list = {'PipelinePP_PSDict'}; % {'Pipeline' 'ImporterPipelineBRAPH2' 'ExporterPipelineBRAPH2' 'PipelinePP_PSDict'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/gui/';
%     delete([fileparts(which('braph2')) el_path el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end


% im = ImporterPipelineBRAPH2(...
%     'FILE', [fileparts(which('Pipeline')) filesep 'examples' filesep 'pipeline_atlas.braph2'], ...
%     'WAITBAR', true ...
%     ); 
% pip = im.get('PIP');
% gui = GUIElement( ...
%     'PE', pip, ...
%     'WAITBAR', true, ...
%     'CLOSEREQ', false ...
%     );
% gui.get('DRAW')
% gui.get('SHOW')


% im = ImporterPipelineBRAPH2(...
%     'FILE', [fileparts(which('Pipeline')) filesep 'examples' filesep 'pipeline_atlas.braph2'], ...
%     'WAITBAR', true ...
%     ); 
% pip = im.get('PIP');
% gui = GUIElement( ...
%     'PE', pip, ...
%     'WAITBAR', true, ...
%     'CLOSEREQ', false ...
%     );
% gui.get('DRAW')
% gui.get('SHOW')

%% BrainRegion, BrainAtlasPF, BrainAtlas
% el_class_list = {'BrainAtlas'}; % {'BrainRegion' 'BrainAtlasPF' 'BrainAtlas' 'ImporterBrainAtlasXLS' 'ImporterBrainAtlasTXT' 'ExporterBrainAtlasXLS' 'ExporterBrainAtlasTXT'};
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/atlas/';
%     delete([fileparts(which('braph2')) el_path el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end
% el_class_list = {'PanelPropIDictTable'}; % {'PanelPropItem' 'GTA_DI' 'Settings' 'SettingsSurface'};
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/gui/';
%     delete([fileparts(which('braph2')) el_path el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
% br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
% br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
% br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
% br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
% br6 = BrainRegion('ID', 'id6', 'LABEL', 'label6', 'NOTES', 'notes6', 'X', 6, 'Y', 6, 'Z', 6);
% items = {br1, br2, br3, br4, br5, br6};
% idict = IndexedDictionary( ...
%     'ID', 'idict', ...
%     'IT_CLASS', 'BrainRegion', ...
%     'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
%     'IT_LIST', items ...
%     );
% ba0 = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'NOTES', 'Notes on brain atlas.', 'BR_DICT', idict);
% pf0 = BrainAtlasPF(...
%     'SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'), ...
%     'BA', ba0 ...
%     );
% gui0 = GUIFig('PF', pf0, 'FILE', 'xxx sss', 'POSITION', [.1 .1 .4 .8], 'CLOSEREQ', false); % % % gui0 = GUIFig('PF', pf0, 'FILE', 'xxx sss', 'WAITBAR', true, 'CLOSEREQ', false); %TODO add waitbar
% gui0.get('DRAW')
% gui0.get('SHOW')
% 
% gui0_settings = gui0.memorize('GUI_SETTINGS');
% gui0_settings.set('POSITION', [0 0 .3 .5])
% gui0_settings.get('DRAW')
% gui0_settings.get('SHOW')
% 
% % gui0.get('CLOSE')

% ba1 = ImporterBrainAtlasXLS('FILE', [fileparts(which('braph2')) filesep() 'atlases' filesep() 'aal90_atlas.xlsx']).get('BA');
% pf1 = BrainAtlasPF(...
%     'SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'), ...
%     'BA', ba1 ...
%     );
% gui1 = GUIFig('PF', pf1, 'FILE', 'xxx sss', 'POSITION', [.1 .1 .4 .8], 'CLOSEREQ', false); % % % %TODO add 'WAITBAR', false,
% gui1.get('DRAW')
% gui1.get('SHOW')
% 
% gui1_settings = gui1.memorize('GUI_SETTINGS');
% gui1_settings.set('POSITION', [0 0 .3 .5])
% gui1_settings.get('DRAW')
% gui1_settings.get('SHOW')

% gui1.get('CLOSE')


% br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
% br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
% br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
% br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
% br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
% br6 = BrainRegion('ID', 'id6', 'LABEL', 'label6', 'NOTES', 'notes6', 'X', 6, 'Y', 6, 'Z', 6);
% 
% items = {br1, br2, br3, br4, br5, br6};
% 
% idict_1 = IndexedDictionary( ...
%     'ID', 'idict', ...
%     'IT_CLASS', 'BrainRegion', ...
%     'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
%     'IT_LIST', items ...
%     );
% ba = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'NOTES', 'Notes on brain atlas.', 'BR_DICT', idict_1);
% gui = GUIElement('PE', ba, 'CLOSEREQ', false);
% gui.get('DRAW')
% gui.get('SHOW')


% br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
% br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
% br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
% br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
% br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
% items = {br1, br2, br3, br4, br5};
% idict_1 = IndexedDictionary( ...
%     'ID', 'idict', ...
%     'IT_CLASS', 'BrainRegion', ...
%     'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
%     'IT_LIST', items ...
%     );
% ba = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'NOTES', 'Notes on brain atlas.', 'BR_DICT', idict_1);
% gui = GUIElement( ...
%     'PE', ba, ...
%     'WAITBAR', true, ...
%     'CLOSEREQ', false ...
%     );
% gui.get('DRAW')
% gui.get('SHOW')

%% BrainSurface, ImporterBrainSurfaceNV, BrainSurfacePF
% el_class_list = {'BrainSurfacePF'}; % {'BrainSurface' 'ImporterBrainSurfaceNV' 'BrainSurfacePF'};
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/atlas/';
%     delete([fileparts(which('braph2')) el_path el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% %     eval(['test_' el_class])
% end
% 
% pf = BrainSurfacePF();
% gui = GUIFig('PF', pf, 'POSITION', [0 .5 .5 .5], 'CLOSEREQ', false);
% gui.get('DRAW')
% gui.get('SHOW')
% f = gui.get('H');
% assert(check_graphics(f, 'figure'))
% 
% gui_settings = gui.memorize('GUI_SETTINGS');
% gui_settings.set('POSITION', [0 0 .3 .5])
% gui_settings.get('DRAW')
% gui_settings.get('SHOW')
% f_settings = gui_settings.get('H');
% assert(check_graphics(f_settings, 'figure'))

%% GUIFig, PanelFig, Settings, SettingsPosition, PanelPropItem, SettingsPositionPP, ViewPP, SettingsAxis, SettingsAxisPP, SettingsAmbient, SettingsAmbientPP, SettingsSurface, SettingsSurfacePP
% el_class_list = {'PanelPropIDictTable'}; % {'Settings' 'SettingsPosition' 'PanelFig' 'GUIFig' 'GTA_IT' 'PanelPropItem' 'SettingsPositionPP' 'ViewPP'};
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/gui/';
%     delete([fileparts(which('braph2')) el_path el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% pf = BrainSurfacePF();
% gui = GUIFig('PF', pf, 'POSITION', [0 .5 .5 .5], 'CLOSEREQ', false);
% gui.get('DRAW')
% gui.get('SHOW')
% f = gui.get('H');
% assert(check_graphics(f, 'figure'))
% 
% gui_settings = gui.memorize('GUI_SETTINGS');
% gui_settings.set('POSITION', [0 0 .3 .5])
% gui_settings.get('DRAW')
% gui_settings.get('SHOW')
% f_settings = gui_settings.get('H');
% assert(check_graphics(f_settings, 'figure'))
% 
% pf = PanelFig();
% gui = GUIFig('PF', pf, 'POSITION', [0 .5 .1 .5], 'CLOSEREQ', false);
% gui.get('DRAW')
% gui.get('SHOW')
% f = gui.get('H');
% assert(check_graphics(f, 'figure'))
% 
% % gui_layout = gui.memorize('GUI_LAYOUT');
% % gui_layout.get('DRAW')
% % gui_layout.get('SHOW')
% % f_layout = gui_layout.get('H');
% % assert(check_graphics(f_layout, 'figure'))
% 
% % gui_settings = gui.memorize('GUI_SETTINGS');
% % gui_settings.get('DRAW')
% % gui_settings.get('SHOW')
% % f_settings = gui_settings.get('H');
% % assert(check_graphics(f_settings, 'figure'))
% 
% % gui_item_1 = gui_settings.get('PE').get('PR_DICT').get('IT', 2).memorize('GUI_ITEM');
% % gui_item_1.get('DRAW')
% % gui_item_1.get('SHOW')
% % 
% % gui_item_2 = gui_item_1.get('PE').get('PR_DICT').get('IT', 3).memorize('GUI_ITEM');
% % gui_item_2.get('DRAW')
% % gui_item_2.get('SHOW')
% % 
% % gui_item_3 = gui_item_2.get('PE').get('PR_DICT').get('IT', 3).memorize('GUI_ITEM');
% % gui_item_3.get('DRAW')
% % gui_item_3.get('SHOW')
% % 
% % gui_item_4 = gui_item_3.get('PE').get('PR_DICT').get('IT', 3).memorize('GUI_ITEM');
% % gui_item_4.get('DRAW')
% % gui_item_4.get('SHOW')
% % 
% % gui_item_5 = gui_item_4.get('PE').get('PR_DICT').get('IT', 3).memorize('GUI_ITEM');
% % gui_item_5.get('DRAW')
% % gui_item_5.get('SHOW')
% % 
% % gui.get('CLOSE')

%% PanelPropX
% % el_class = 'GTA_DI';
% el_class = 'GTA_IT';
% % el_class = 'GTA_LL';
% % el_class = 'GTA_OP';
% % el_class = 'GTA_NM';
% % el_class = 'GTA_NS';
% % el_class = 'GTA_NR';
% % el_class = 'GTA_NC';
% % el_class = 'GTA_ST_TA';
% el_path = '/src/gui/examples/';
% delete([fileparts(which('braph2')) el_path el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% create_test_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% eval(['test_' el_class])
% 
% % el_class = 'PanelPropIDict';
% el_class = 'PanelPropItem';
% % el_class = 'PanelPropCell';
% % el_class = 'PanelPropMatrix';
% el_path = '/src/gui/';
% delete([fileparts(which('braph2')) el_path el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% create_test_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% eval(['test_' el_class])
% 
% gt = GTA_LL();
% gui = GUI('POSITION', [0 0 1 1], 'CLOSEREQ', false);
% 
% pr_C = gt.getPanelProp(GTA_LL.LL_C, 'PARENT', gui, 'TABLE_HEIGHT', 200, ...
%     'XSLIDERSHOW', false, 'YSLIDERSHOW', false, ...
%     'ROWNAME', {'numbered'}, 'COLUMNNAME', {'numbered'});
% pr_C.get('DRAW', 'Units', 'normalized', 'Position', [.05 .70 .40 .25])
% 
% pr_M = gt.getPanelProp(GTA_LL.LL_M, 'PARENT', gui, 'TABLE_HEIGHT', 200, ...
%     'XSLIDERSHOW', true, 'YSLIDERSHOW', false, ...
%     'XSLIDERLABELS', {'a' 'b' 'c'}, ...
%     'ROWNAME', {}, 'COLUMNNAME', {});
% pr_M.get('DRAW', 'Units', 'normalized', 'Position', [.55 .70 .40 .25])
% 
% pr_P = gt.getPanelProp(GTA_LL.LL_P, 'PARENT', gui, 'TABLE_HEIGHT', 200, ...
%     'XSLIDERSHOW', false, 'YSLIDERSHOW', true, 'YSLIDERLABELS', {'1' '2' '3'}, ...
%     'ROWNAME', {'_1_' '_2_' '_3_'}, 'COLUMNNAME', {'a' 'b' 'c'});
% pr_P.get('DRAW', 'Units', 'normalized', 'Position', [.05 .40 .20 .25])
% 
% pr_D = gt.getPanelProp(GTA_LL.LL_D, 'PARENT', gui, 'TABLE_HEIGHT', 200, ...
%     'XSLIDERSHOW', true, 'YSLIDERSHOW', true, 'XSLIDERLABELS', {'a' 'b' 'c'}, ...
%     'YSLIDERLABELS', {'1' '2' '3'});
% pr_D.get('DRAW', 'Units', 'normalized', 'Position', [.25 .40 .20 .25])
% 
% pr_R = gt.getPanelProp(GTA_LL.LL_R, 'PARENT', gui, 'TABLE_HEIGHT', 200);
% pr_R.get('DRAW', 'Units', 'normalized', 'Position', [.05 .10 .25 .25])
% 
% pr_Q = gt.getPanelProp(GTA_LL.LL_Q, 'PARENT', gui, 'TABLE_HEIGHT', 200);
% pr_Q.get('DRAW', 'Units', 'normalized', 'Position', [.35 .10 .25 .25])
% 
% pr_E = gt.getPanelProp(GTA_LL.LL_E, 'PARENT', gui, 'TABLE_HEIGHT', 200);
% pr_E.get('DRAW', 'Units', 'normalized', 'Position', [.65 .10 .25 .25])
% 
% pr_F = gt.getPanelProp(GTA_LL.LL_F, 'PARENT', gui, 'TABLE_HEIGHT', 200, ...
%     'XYSLIDERLOCK', true, ...
%     'XSLIDERLABELS', {'a' 'b' 'c'}, 'YSLIDERLABELS', {'1' '2' '3'});
% pr_F.get('DRAW', 'Units', 'normalized', 'Position', [.50 .40 .20 .25])
% 
% pr_G = gt.getPanelProp(GTA_LL.LL_G, 'PARENT', gui, 'TABLE_HEIGHT', 200);
% pr_G.get('DRAW', 'Units', 'normalized', 'Position', [.75 .40 .20 .25])
% 
% pr_C.get('SHOW') % shows all

%% PanelElement
% el_class = 'PanelElement';
% el_path = '/src/gui/';
% delete([fileparts(which('braph2')) el_path el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% create_test_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% eval(['test_' el_class])

% el = GUIElement();
% gui = GUIElement('PE', el, 'CLOSEREQ', false);
% gui.get('DRAW')
% gui.get('SHOW')

%% GUIElement
% el_class = 'GUIElement';
% el_path = '/src/gui/';
% delete([fileparts(which('braph2')) el_path el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% create_test_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% eval(['test_' el_class])
% 
% el = ConcreteElement();
% gui = GUIElement('PE', el, 'CLOSEREQ', false);
% gui.get('DRAW')
% gui.get('SHOW')
% f = gui.get('H');
% assert(check_graphics(f, 'figure'))
% 
% gui_layout = gui.memorize('LAYOUT');
% gui_layout.get('DRAW')
% gui_layout.get('SHOW')
% f_layout = gui_layout.get('H');
% assert(check_graphics(f_layout, 'figure'))
% 
% gui.get('HIDE')
% gui.get('CLOSE')
% assert(isa(gui.getr('H'), 'NoValue'))
% assert(~check_graphics(f, 'figure'))
% assert(isa(gui_layout.getr('H'), 'NoValue'))
% assert(~check_graphics(f_layout, 'figure'))

%% GUILayout
% % el_class = 'GUILayout';
% % el_path = '/src/gui/';
% % delete([fileparts(which('braph2')) el_path el_class '.m'])
% % create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% % create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% % create_test_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% % eval(['test_' el_class])
% 
% % gui = GUILayout( ...
% %     'EL_CLASS', IndexedDictionary(), ...
% %     'POSITION', [.3 .3 .4 .4], ...
% %     'BKGCOLOR', [1 0 0] ...
% %     );
% % assert(strcmp(gui.get('EL_CLASS'), 'IndexedDictionary'))
% % 
% % gui.get('DRAW')
% % gui.get('SHOW')
