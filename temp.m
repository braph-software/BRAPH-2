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
% el_class_list = {'SettingsPP'}; % 'PanelPropIDictTable' 'PanelPropItemList' 'PanelPropStringTextArea' 'SettingsPosition' 'PanelPropCell'
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/gui';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end
% el_class_list = {'BrainAtlasPF'}; % 'BrainSurfacePF' 'BrainAtlasPF'
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
% 
% el_class_list = {'RichClub'}; {'MultiplexKCor' 'RichClub'}
% %el_class_list = Measure.getSubclasses();
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/measures';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) filesep() 'src' filesep() 'gui' filesep() 'layouts' filesep()])
%     eval(['test_' el_class])
% end

%% Graphs
% el_class_list = {'Graph'} % 'Graph' 'Measure' 'MeasurePF' 'MeasurePF_GU' 'MeasurePF_NU' 'MeasurePF_BU' 'GraphPP_MDict'
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/gt';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end
% el_class_list = {'SettingsTextPP'} % 'SettingsLine' 'SettingsArea' 'SettingsLinePP' 'SettingsAreaPP' 'PanelPropStringList' 'PanelPropIDictTable'
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/gui';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end
% el_class_list = {'GraphPP_MDict'} % 'Graph' 'GraphAdjPF' 'GraphHistPF' 'LayersPP' 'GraphPP_MDict'
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/gt';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end
% el_class_list = {'MultigraphBUT'} % {'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexBD' 'MultiplexBU' 'MultiplexWD' 'MultiplexWU' 'OrdMultiWU' 'MultiplexBUD' 'MultiplexBUT'};
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/graphs';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
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
% g1 = GraphBD();
% gui1 = GUIElement( ...
%     'PE', g1, ...
%     'WAITBAR', true, ...
%     'CLOSEREQ', false ...
%     );
% gui1.get('DRAW')
% gui1.get('SHOW')
% 
% g2 = GraphBD( ...
%     'B', randn(50) ...
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
% 
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
% 
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
% g1 = OrdMultiWU();
% gui1 = GUIElement( ...
%     'PE', g1, ...
%     'WAITBAR', true ...
%     );
% gui1.get('DRAW')
% gui1.get('SHOW')
% 
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
% g3 = MultiplexBUT( ...
%     'THRESHOLDS', [-1:.5:1], ...
%     'NODELABELS', ba, ...
%     'B', {randn(5) randn(5) randn(5)} ... % , ... 'LAYERLABELS', {'A' 'B' 'C'} ...
%     );
% gui3 = GUIElement( ...
%     'PE', g3, ...
%     'WAITBAR', true, ...
%     'CLOSEREQ', false ...
%     );
% gui3.get('DRAW')
% gui3.get('SHOW')


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
% el_class_list = {'ImporterBrainAtlasXLS'}; % {'BrainRegion' 'BrainAtlasPF' 'BrainAtlas' 'ImporterBrainAtlasXLS' 'ImporterBrainAtlasTXT' 'ExporterBrainAtlasXLS' 'ExporterBrainAtlasTXT'};
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
% gui = GUIElement('PE', ba0, 'CLOSEREQ', false);
% gui.get('DRAW')
% gui.get('SHOW')

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
% el_class_list = {'GUIElement'}; % {'Settings' 'SettingsPosition' 'PanelFig' 'GUIFig' 'GTA_IT' 'PanelPropItem' 'SettingsPositionPP' 'ViewPP'};
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
% el_class = 'GUILayout';
% el_path = '/src/gui/';
% delete([fileparts(which('braph2')) el_path el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% create_test_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% eval(['test_' el_class])

% gui = GUILayout( ...
%     'EL_CLASS', IndexedDictionary(), ...
%     'POSITION', [.3 .3 .4 .4], ...
%     'BKGCOLOR', [1 0 0] ...
%     );
% assert(strcmp(gui.get('EL_CLASS'), 'IndexedDictionary'))
% 
% gui.get('DRAW')
% gui.get('SHOW')

%% create_layout
% el_class = 'BrainAtlas';
% el_path = '/src/atlas/';
% delete([fileparts(which('braph2')) el_path el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% create_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% create_test_Element([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
% create_layout([fileparts(which('braph2genesis')) el_path '_' el_class '.gen.m'], [fileparts(which('braph2')) filesep() 'src' filesep() 'gui' filesep() 'layouts' filesep()])
% eval(['test_' el_class])
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
% 
% gui = GUIElement( ...
%     'PE', ba, ...
%     'WAITBAR', true, ...
%     'CLOSEREQ', false ...
%     );
% gui.get('DRAW')
% gui.get('SHOW')

%% Subjects
% el_class_list = {'Subject'} 
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/cohort';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'ImporterGroupSubjectCON_XLS' 'ExporterGroupSubjectCON_XLS' 'ImporterGroupSubjectCON_TXT' 'ExporterGroupSubjectCON_TXT'} % {'SubjectCON' 'ImporterGroupSubjectCON_XLS' 'ExporterGroupSubjectCON_XLS' 'ImporterGroupSubjectCON_TXT' 'ExporterGroupSubjectCON_TXT'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/connectivity';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% ba = ImporterBrainAtlasXLS('FILE', 'desikan_atlas.xlsx');
% ba = ba.get('BA');
% 
% gr = Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'));
% for i = 1:1:50
%     sub = SubjectCON( ...
%         'ID', ['SUB CON ' int2str(i)], ...
%         'LABEL', ['Subejct CON ' int2str(i)], ...
%         'NOTES', ['Notes on subject CON ' int2str(i)], ...
%         'BA', ba, ...
%         'CON', rand(ba.get('BR_DICT').get('LENGTH')) ...
%         );
%     sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
%     sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
%     gr.get('SUB_DICT').get('ADD', sub)
% end
% 
% gui = GUIElement('PE', gr, 'CLOSEREQ', false);
% gui.get('DRAW')
% gui.get('SHOW')

% % % % % data_dir = [fileparts(which('SubjectCON')) filesep 'Example data CON XLS'];
% % % % % mkdir(data_dir);
% % % % % 
% % % % % % Brain Atlas
% % % % % im_ba = ImporterBrainAtlasXLS('FILE', 'desikan_atlas.xlsx');
% % % % % ba = im_ba.get('BA');
% % % % % ex_ba = ExporterBrainAtlasXLS( ...
% % % % %     'BA', ba, ...
% % % % %     'FILE', [data_dir filesep() 'desikan_atlas.xlsx'] ...
% % % % %     );
% % % % % ex_ba.get('SAVE')
% % % % % N = ba.get('BR_DICT').get('LENGTH');
% % % % % 
% % % % % % saves RNG
% % % % % rng_settings_ = rng(); rng('default')
% % % % % 
% % % % % sex_options = {'Female' 'Male'};
% % % % % 
% % % % % % Group 1
% % % % % K1 = 2; % degree (mean node degree is 2K) - group 1
% % % % % beta1 = 0.3; % Rewiring probability - group 1
% % % % % gr1_name = 'CON_Group_1_XLS';
% % % % % gr1_dir = [data_dir filesep() gr1_name];
% % % % % mkdir(gr1_dir);
% % % % % vois1 = [
% % % % %     {{'Subject ID'} {'Age'} {'Sex'}}
% % % % %     {{} {} cell2str(sex_options)}
% % % % %     ];
% % % % % for i = 1:1:50 % subject number
% % % % %     sub_id = ['SubjectCON_' num2str(i)];
% % % % %     
% % % % %     h1 = WattsStrogatz(N, K1, beta1); % create two WS graph
% % % % %     % figure(1) % Plot the two graphs to double-check
% % % % %     % plot(h1, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
% % % % %     % title(['Group 1: Graph with $N = $ ' num2str(N_nodes) ...
% % % % %     %     ' nodes, $K = $ ' num2str(K1) ', and $\beta = $ ' num2str(beta1)], ...
% % % % %     %     'Interpreter','latex')
% % % % %     % axis equal
% % % % % 
% % % % %     A1 = full(adjacency(h1)); A1(1:length(A1)+1:numel(A1)) = 0; % extract the adjacency matrix
% % % % %     r = 0 + (0.5 - 0)*rand(size(A1)); diffA = A1 - r; A1(A1 ~= 0) = diffA(A1 ~= 0); % make the adjacency matrix weighted
% % % % %     A1 = max(A1, transpose(A1)); % make the adjacency matrix symmetric
% % % % % 
% % % % %     writetable(array2table(A1), [gr1_dir filesep() sub_id '.xlsx'], 'WriteRowNames', false, 'WriteVariableNames', false)
% % % % %     
% % % % %     % variables of interest
% % % % %     vois1 = [vois1; {sub_id, randi(90), sex_options(randi(2))}];
% % % % % end
% % % % % writetable(table(vois1), [data_dir filesep() gr1_name '_vois.xlsx'], 'WriteRowNames', false, 'WriteVariableNames', false)
% % % % % 
% % % % % % Group 2
% % % % % K2 = 2; % degree (mean node degree is 2K) - group 2
% % % % % beta2 = 0.85; % Rewiring probability - group 2
% % % % % gr2_name = 'CON_Group_2_XLS';
% % % % % gr2_dir = [data_dir filesep() gr2_name];
% % % % % mkdir(gr2_dir);
% % % % % vois2 = [
% % % % %     {{'Subject ID'} {'Age'} {'Sex'}}
% % % % %     {{} {} cell2str(sex_options)}
% % % % %     ];
% % % % % for i = 51:1:100
% % % % %     sub_id = ['SubjectCON_' num2str(i)];
% % % % % 
% % % % %     h2 = WattsStrogatz(N, K2, beta2);
% % % % %     % figure(2)
% % % % %     % plot(h2, 'NodeColor',[1 0 0], 'EdgeColor',[0 0 0], 'EdgeAlpha',0.1, 'Layout','circle');
% % % % %     % title(['Group 2: Graph with $N = $ ' num2str(N_nodes) ...
% % % % %     %     ' nodes, $K = $ ' num2str(K2) ', and $\beta = $ ' num2str(beta2)], ...
% % % % %     %     'Interpreter','latex')
% % % % %     % axis equal
% % % % % 
% % % % %     A2 = full(adjacency(h2)); A2(1:length(A2)+1:numel(A2)) = 0;
% % % % %     r = 0 + (0.5 - 0)*rand(size(A2)); diffA = A2 - r; A2(A2 ~= 0) = diffA(A2 ~= 0);
% % % % %     A2 = max(A2, transpose(A2));
% % % % % 
% % % % %     writetable(array2table(A2), [gr2_dir filesep() 'SubjectCON_' num2str(i) '.xlsx'], 'WriteRowNames', false, 'WriteVariableNames', false)
% % % % %     
% % % % %     % variables of interest
% % % % %     vois2 = [vois2; {sub_id, randi(90), sex_options(randi(2))}];
% % % % % end
% % % % % writetable(table(vois2), [data_dir filesep() gr2_name '_vois.xlsx'], 'WriteRowNames', false, 'WriteVariableNames', false)
% % % % % 
% % % % % % reset RNG
% % % % % rng(rng_settings_)

% el_class_list = {'ImporterGroupSubjectFUN_XLS' 'ImporterGroupSubjectFUN_TXT' 'ExporterGroupSubjectFUN_XLS' 'ExporterGroupSubjectFUN_TXT'} % {'SubjectFUN' 'ImporterGroupSubjectFUN_XLS' 'ImporterGroupSubjectFUN_TXT' 'ExporterGroupSubjectFUN_XLS' 'ExporterGroupSubjectFUN_TXT'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/functional';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% gr = Group(); gui = GUIElement('PE', gr); gui.get('DRAW'), gui.get('SHOW')

% im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('SubjectFUN')) filesep 'example data FUN' filesep 'aal90_atlas.xlsx']);
% ba = im_ba.get('BA');
% im_gr = ImporterGroupSubjectFUN_XLS( ...
%     'DIRECTORY', [fileparts(which('SubjectFUN')) filesep 'example data FUN' filesep 'xls' filesep 'FUN_Group_1'], ...
%     'BA', ba, ...
%     'WAITBAR', true ...
%     );
% gr = im_gr.get('GR');
% 
% gui = GUIElement('PE', gr, 'CLOSEREQ', false);
% gui.get('DRAW')
% gui.get('SHOW')

% el_class_list = {'ImporterGroupSubjectST_XLS' 'ImporterGroupSubjectST_TXT' 'ExporterGroupSubjectST_XLS' 'ExporterGroupSubjectST_TXT'} % {'SubjectST' 'ImporterGroupSubjectST_XLS' 'ImporterGroupSubjectST_TXT' 'ExporterGroupSubjectST_XLS' 'ExporterGroupSubjectST_TXT'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/structural';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('SubjectST')) filesep 'example data ST' filesep 'destrieux_atlas.xlsx']);
% ba = im_ba.get('BA');
% im_gr = ImporterGroupSubjectST_XLS( ...
%     'FILE', [fileparts(which('SubjectST')) filesep 'example data ST' filesep 'xls' filesep 'ST_Group_1.xlsx'], ...
%     'BA', ba, ...
%     'WAITBAR', true ...
%     );
% gr = im_gr.get('GR');
% 
% gui = GUIElement('PE', gr, 'CLOSEREQ', false);
% gui.get('DRAW')
% gui.get('SHOW')

% el_class_list = {'ImporterGroupSubjectCON_MP_XLS' 'ImporterGroupSubjectCON_MP_TXT' 'ExporterGroupSubjectCON_MP_XLS' 'ExporterGroupSubjectCON_MP_TXT'} % {'SubjectCON_MP' 'ImporterGroupSubjectCON_MP_XLS' 'ImporterGroupSubjectCON_MP_TXT' 'ExporterGroupSubjectCON_MP_XLS' 'ExporterGroupSubjectCON_MP_TXT'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/connectivity multiplex';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'ImporterGroupSubjectFUN_MP_XLS' 'ImporterGroupSubjectFUN_MP_TXT' 'ExporterGroupSubjectFUN_MP_XLS' 'ExporterGroupSubjectFUN_MP_TXT'} % {'SubjectFUN_MP' 'ImporterGroupSubjectFUN_MP_XLS' 'ImporterGroupSubjectFUN_MP_TXT' 'ExporterGroupSubjectFUN_MP_XLS' 'ExporterGroupSubjectFUN_MP_TXT'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/functional multiplex';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'ExporterGroupSubjectST_MP_TXT'} % {'SubjectST_MP' 'ImporterGroupSubjectST_MP_XLS' 'ImporterGroupSubjectST_MP_TXT' 'ExporterGroupSubjectST_MP_XLS' 'ExporterGroupSubjectST_MP_TXT'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/structural multiplex';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'SeparateGroups_CON_FUN_MP'} % {'SubjectCON_FUN_MP' 'CombineGroups_CON_FUN_MP' 'SeparateGroups_CON_FUN_MP'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/connectivity-functional multiplex';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

%% AnalyzeGroup
% el_class_list = {'Graph'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/gt';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'AnalyzeGroupPP_G' 'CompareGroupPP_CpDict'} % {'AnalyzeGroup' 'CompareGroup' 'ComparisonGroup' 'AnalyzeGroupPP_G' 'CompareGroupPP_CpDict'}
% % el_class_list = {'ComparisonGroupPF_NU'} % {'ComparisonGroupPF' 'ComparisonGroupPF_BB' 'ComparisonGroupPF_BS' 'ComparisonGroupPF_BU' 'ComparisonGroupPF_GB' 'ComparisonGroupPF_GS' 'ComparisonGroupPF_GU' 'ComparisonGroupPF_NB' 'ComparisonGroupPF_NS' 'ComparisonGroupPF_NU' }
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/analysis';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'AnalyzeGroup_ST_BUD'} % {'AnalyzeGroup_ST_WU' 'AnalyzeGroup_ST_BUD' 'AnalyzeGroup_ST_BUT'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/structural';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end


% im_ba = ImporterBrainAtlasXLS('FILE', 'destrieux_atlas.xlsx');
% ba = im_ba.get('BA');
% 
% gr = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
% for i = 1:1:50
%     sub = SubjectST( ...
%         'ID', ['SUB ST ' int2str(i)], ...
%         'LABEL', ['Subejct ST ' int2str(i)], ...
%         'NOTES', ['Notes on subject ST ' int2str(i)], ...
%         'BA', ba, ...
%         'ST', rand(ba.get('BR_DICT').get('LENGTH'), 1) ...
%         );
%     sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
%     sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
%     gr.get('SUB_DICT').get('ADD', sub)
% end
% 
% a = AnalyzeGroup_ST_BUD('GR', gr, 'CORRELATION_RULE', Correlation.PEARSON);
% 
% gui = GUIElement('PE', a, 'CLOSEREQ', false);
% gui.get('DRAW')
% gui.get('SHOW')


% im_ba = ImporterBrainAtlasXLS('FILE', 'destrieux_atlas.xlsx');
% ba = im_ba.get('BA');
% 
% gr1 = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
% for i = 1:1:50
%     sub = SubjectST( ...
%         'ID', ['SUB ST ' int2str(i)], ...
%         'LABEL', ['Subejct ST ' int2str(i)], ...
%         'NOTES', ['Notes on subject ST ' int2str(i)], ...
%         'BA', ba, ...
%         'ST', rand(ba.get('BR_DICT').get('LENGTH'), 1) ...
%         );
%     sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
%     sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
%     gr1.get('SUB_DICT').get('ADD', sub)
% end
% 
% gr2 = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
% for i = 1:1:50
%     sub = SubjectST( ...
%         'ID', ['SUB ST ' int2str(i)], ...
%         'LABEL', ['Subejct ST ' int2str(i)], ...
%         'NOTES', ['Notes on subject ST ' int2str(i)], ...
%         'BA', ba, ...
%         'ST', rand(ba.get('BR_DICT').get('LENGTH'), 1) ...
%         );
%     sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
%     sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
%     gr2.get('SUB_DICT').get('ADD', sub)
% end
% 
% a1 = AnalyzeGroup_ST_WU('GR', gr1, 'CORRELATION_RULE', Correlation.PEARSON);
% a2 = AnalyzeGroup_ST_WU('GR', gr2, 'TEMPLATE', a1);
% 
% c = CompareGroup( ...
%     'P', 10, ...
%     'A1', a1, ...
%     'A2', a2, ...
%     'WAITBAR', true, ...
%     'VERBOSE', false, ...
%     'MEMORIZE', true ...
%     );
% 
% gui = GUIElement('PE', c, 'CLOSEREQ', false);
% gui.get('DRAW')
% gui.get('SHOW')


% el_class_list = {'AnalyzeGroup_ST_MP_BUT'} % {'AnalyzeGroup_ST_MP_WU' 'AnalyzeGroup_ST_MP_BUD' 'AnalyzeGroup_ST_MP_BUT'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/structural multiplex';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'AnalyzeGroup_FUN_OMP_GA_WU'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/functional ordered_multiplex group_average';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'AnalyzeGroup_FUN_MP_GA_WU'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/functional multiplex group_average';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'AnalyzeGroup_FUN_GA_WU'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/functional group_average';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'AnalyzeGroup_CON_OMP_GA_WU'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/connectivity ordered_multiplex group_average';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'AnalyzeGroup_CON_MP_GA_WU'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/connectivity multiplex group_average';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'AnalyzeGroup_CON_GA_WU'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/connectivity group_average';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'AnalyzeGroup_CON_FUN_MP_GA_BUD'} % {'AnalyzeGroup_CON_FUN_MP_GA_WU' 'AnalyzeGroup_CON_FUN_MP_GA_BUD'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/connectivity-functional multiplex group_average';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

%% AnalyzeEnsemble

% el_class_list = {'Callback'} % {'IndexedDictionary' 'ConcreteElement' 'NoValue'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/ds';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'MeasureEnsemblePF_NU' 'MeasureEnsemblePF_GU' 'MeasureEnsemblePF_BU' 'MeasureEnsemblePF_GS'} % {'AnalyzeEnsemblePP_MeDict' 'CompareEnsemblePP_CpDict'} % {'AnalyzeEnsemble' 'MeasureEnsemble' 'CompareEnsemble' 'ComparisonEnsemble' 'MeasureEnsemblePF' 'MeasureEnsemblePF_BS' 'MeasureEnsemblePF_NB' 'MeasureEnsemblePF_GB' 'MeasureEnsemblePF_BB' 'MeasureEnsemblePF_NS' 'MeasureEnsemblePF_NU' 'MeasureEnsemblePF_GU' 'MeasureEnsemblePF_BU' 'MeasureEnsemblePF_GS'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/analysis';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'AnalyzeEnsemble_CON_BUT'} % {'AnalyzeEnsemble_CON_WU' 'AnalyzeEnsemble_CON_BUT' 'AnalyzeEnsemble_CON_BUD'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/connectivity';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'AnalyzeEnsemble_CON_MP_BUT'} % {'AnalyzeEnsemble_CON_MP_WU' 'AnalyzeEnsemble_CON_MP_BUT' 'AnalyzeEnsemble_CON_MP_BUT'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/connectivity multiplex';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'AnalyzeEnsemble_CON_OMP_WU'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/connectivity ordered_multiplex';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'AnalyzeEnsemble_FUN_WU'} % {'AnalyzeEnsemble_FUN_WU' 'AnalyzeEnsemble_FUN_BUT' 'AnalyzeEnsemble_FUN_BUD'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/functional';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'AnalyzeEnsemble_FUN_MP_BUD'} % {'AnalyzeEnsemble_FUN_MP_WU' 'AnalyzeEnsemble_FUN_MP_BUT' 'AnalyzeEnsemble_FUN_MP_BUD'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/functional multiplex';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'AnalyzeEnsemble_FUN_OMP_WU'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/functional ordered_multiplex';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'AnalyzeEnsemble_CON_FUN_MP_BUT'} % {'AnalyzeEnsemble_CON_FUN_MP_WU' 'AnalyzeEnsemble_CON_FUN_MP_BUT' 'AnalyzeEnsemble_CON_FUN_MP_BUD'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/pipelines/connectivity-functional multiplex';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

%% Settings Layout
% el_class_list = {'BrainSurfacePF'} % {'BrainAtlasPF' 'BrainSurfacePF'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/atlas';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'GUIFig'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/gui';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% el_class_list = {'GraphAdjPF'} % {'GraphAdjPF' 'GraphHistPF' 'MeasurePF' 'MeasurePF_GS' 'MeasurePF_GU' 'MeasurePF_GB' 'MeasurePF_NS' 'MeasurePF_NU' 'MeasurePF_NB' 'MeasurePF_BS' 'MeasurePF_BU' 'MeasurePF_BB'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/atlas';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% ba = BrainAtlas();
% pf = BrainAtlasPF('BA', ba);

% gui_pf = GUIElement('PE', pf);
% gui_pf.get('DRAW')
% gui_pf.get('SHOW')

% gui = GUIFig('PF', pf);
% gui.get('DRAW')
% gui.get('SHOW')

% gui_settings = gui.memorize('GUI_SETTINGS');
% gui_settings.get('DRAW')
% gui_settings.get('SHOW')

%% Group & Subjects interface
% el_class_list = {'SubjectPP_VOIDict'} % {'Group' 'SubjectPP_VOIDict' 'Subject'} 
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/src/cohort';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     eval(['test_' el_class])
% end

% im_ba = ImporterBrainAtlasXLS('FILE', 'destrieux_atlas.xlsx');
% ba = im_ba.get('BA');
% 
% gr = Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'));
% for i = 1:1:50
%     sub = SubjectST( ...
%         'ID', ['SUB ST ' int2str(i)], ...
%         'LABEL', ['Subejct ST ' int2str(i)], ...
%         'NOTES', ['Notes on subject ST ' int2str(i)], ...
%         'BA', ba, ...
%         'ST', rand(ba.get('BR_DICT').get('LENGTH'), 1) ...
%         );
%     sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
%     sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
%     gr.get('SUB_DICT').get('ADD', sub)
% end
% 
% gui = GUIElement('PE', gr, 'CLOSEREQ', false);
% gui.get('DRAW')
% gui.get('SHOW')

% sub = SubjectST();
% voi_dict = sub.memorize('VOI_DICT');
% voi_dict.get('ADD', VOINumeric('ID', 'Age', 'V', 25))
% voi_age = voi_dict.get('IT', 1);
% voi_dict.get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', 2))
% voi_sex = voi_dict.get('IT', 2);
% gui = GUIElement('PE', sub, 'CLOSEREQ', false);
% gui.get('DRAW')
% gui.get('SHOW')

%% Pipelines Analysis Group
% im = ImporterPipelineBRAPH2(...
%     'FILE', [fileparts(which('braph2')) filesep 'pipelines' filesep 'structural' filesep 'pipeline_structural_comparison_wu.braph2'], ...
%     'WAITBAR', true ...
%     ); 
% pip = im.get('PIP');
% % 
% % pip = Element.load('ST_WU.b2');
% % % pip = Element.load('ST_WU_a1_a2.b2');
% % 
% gui = GUIElement( ...
%     'PE', pip, ...
%     'WAITBAR', true, ...
%     'CLOSEREQ', false ...
%     );
% gui.get('DRAW')
% gui.get('SHOW')
% 
% % % a1 = pip.get('PS_DICT').get('IT', 3).get('PC_DICT').get('IT', 1).get('EL')
% % % a1g = pip.get('PS_DICT').get('IT', 3).get('PC_DICT').get('IT', 1).get('EL').get('G')

%% NN
% el_class_list = {'NNRegressorMLP'} % {'NNRegressorMLP' 'NNClassifierMLP'}
% for i = 1:1:length(el_class_list)
%     el_class = el_class_list{i};
%     el_path = '/neuralnetworks';
%     delete([fileparts(which('braph2')) el_path filesep() el_class '.m'])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_layout([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     create_test_Element([fileparts(which('braph2genesis')) el_path filesep() '_' el_class '.gen.m'], [fileparts(which('braph2')) el_path])
%     % eval(['test_' el_class])
% end
