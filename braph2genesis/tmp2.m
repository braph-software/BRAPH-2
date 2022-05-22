close all
delete(findall(0, 'type', 'figure'))
clear all
clc

el_class = 'PanelPropClassList';
delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% test_code = ['test_' el_class]
% eval(test_code)

% fig1 = uifigure();
% et = ETA();
% props = [et.PROP_CLASSLIST_M et.PROP_CLASSLIST_P et.PROP_CLASSLIST_D et.PROP_CLASSLIST_F et.PROP_CLASSLIST_G et.PROP_CLASSLIST_R et.PROP_CLASSLIST_R_CALC];
% for i = 1:1:length(props)
%     pr{i} = PanelPropClassList('EL', et, 'PROP', props(i));
%     pr{i}.draw( ...
%         'Parent', fig1, ...
%         'BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)] ...
%         )
%     pr{i}.update()
%     pr{i}.redraw('Y0', (length(props) - i)/length(props) * h(fig1, 'pixels'))
% end
% 
% return

% % % complete with CELL and NET
et1 = ETA( ...
    'PROP_STRING_P', 'prova', ...
    'PROP_LOGICAL_P', true, ...
    'PROP_OPTION_P', 'three', ...
    'PROP_CLASS_P', 'ETA', ...
    'PROP_CLASSLIST_P', {'ETA', 'Panel', 'GUI'}, ...
    'PROP_ITEM_P', BRAPH2Constants(), ...
    'PROP_ITEMLIST_P', {BRAPH2Constants(), ETA()}, ...
    'PROP_IDICT_P', IndexedDictionary(), ...
    'PROP_SCALAR_P', pi, ...
    'PROP_RVECTOR_P', [1 2 3], ...
    'PROP_CVECTOR_P', [1 2 3]', ...
    'PROP_MATRIX_P', [1 2 3; 4 5 6], ...
    'PROP_SMATRIX_P', eye(3), ...
    'PROP_COLOR_P', [.1 .6 1], ...
    'PROP_ALPHA_P', .5, ...
    'PROP_SIZE_P', 10, ...
    'PROP_MARKER_P', 's', ...
    'PROP_LINE_P', '--' ...
    );
et2 = ETA( ...
    'PROP_STRING_P', Callback('EL', et1, 'TAG', 'PROP_STRING_P'), ...
    'PROP_LOGICAL_P', Callback('EL', et1, 'TAG', 'PROP_LOGICAL_P'), ...
    'PROP_OPTION_P', Callback('EL', et1, 'TAG', 'PROP_OPTION_P'), ...
    'PROP_CLASS_P', Callback('EL', et1, 'TAG', 'PROP_CLASS_P'), ...
    'PROP_CLASSLIST_P', Callback('EL', et1, 'TAG', 'PROP_CLASSLIST_P'), ...
    'PROP_ITEM_P', Callback('EL', et1, 'TAG', 'PROP_ITEM_P'), ...
    'PROP_ITEMLIST_P', Callback('EL', et1, 'TAG', 'PROP_ITEMLIST_P'), ...
    'PROP_IDICT_P', Callback('EL', et1, 'TAG', 'PROP_IDICT_P'), ...
    'PROP_SCALAR_P', Callback('EL', et1, 'TAG', 'PROP_SCALAR_P'), ...
    'PROP_RVECTOR_P', Callback('EL', et1, 'TAG', 'PROP_RVECTOR_P'), ...
    'PROP_CVECTOR_P', Callback('EL', et1, 'TAG', 'PROP_CVECTOR_P'), ...
    'PROP_MATRIX_P', Callback('EL', et1, 'TAG', 'PROP_MATRIX_P'), ...
    'PROP_SMATRIX_P', Callback('EL', et1, 'TAG', 'PROP_SMATRIX_P'), ...
    'PROP_COLOR_P', Callback('EL', et1, 'TAG', 'PROP_COLOR_P'), ...
    'PROP_ALPHA_P', Callback('EL', et1, 'TAG', 'PROP_ALPHA_P'), ...
    'PROP_SIZE_P', Callback('EL', et1, 'TAG', 'PROP_SIZE_P'), ...
    'PROP_MARKER_P', Callback('EL', et1, 'TAG', 'PROP_MARKER_P'), ...
    'PROP_LINE_P', Callback('EL', et1, 'TAG', 'PROP_LINE_P') ...
    );
gui1 = GUIElement('PE', et2, 'FILE', 'xxx sss', 'MENUBAR', true, 'TOOLBAR', true, 'CLOSEREQ', false);
fig1 = gui1.draw();
close(fig1)

% gui2 = GUIElement('PE', BRAPH2Constants(), 'FILE', 'xxx sss', 'MENUBAR', true, 'TOOLBAR', true, 'POSITION', [.1 0 .2 1], 'CLOSEREQ', false);
% f2 = gui2.draw();

% gui3 = GUIElement('PE', ETA(), 'FILE', 'xxx sss', 'MENUBAR', true, 'TOOLBAR', true, 'POSITION', [.2 .2 .2 .78], 'CLOSEREQ', false);
% f3 = gui3.draw();

% gui4 = GUIElement('PE', BRAPH2Constants(), 'FILE', 'xxx sss', 'MENUBAR', true, 'TOOLBAR', true, 'POSITION', [.3 .2 .2 .78], 'CLOSEREQ', false);
% f4 = gui4.draw();

% gui5 = GUIElement('PE', ETA(), 'FILE', 'xxx sss', 'MENUBAR', true, 'TOOLBAR', true, 'POSITION', [.4 .2 .2 .5], 'CLOSEREQ', false);
% f5 = gui5.draw();

% gui6 = GUIElement('PE', BRAPH2Constants(), 'FILE', 'xxx sss', 'MENUBAR', true, 'TOOLBAR', true, 'POSITION', [.5 .2 .2 .5], 'CLOSEREQ', false);
% f6 = gui6.draw();

% gui = GUI('MENUBAR', true, 'TOOLBAR', true);
% f = gui.draw();
% p = uipanel(f, 'Units', 'normalized', 'Position', [.01 .01 .98 .98]);


% f = uifigure('Visible', 'off', 'Units', 'Normalized', 'Position', [0 0 .2 .5]);
% drawnow()
% set(f, 'Position', [0 0 .2 1]);
% drawnow()
% pause(1)
% h_title = h(0, 'pixels') - h(f, 'pixels')
% 
% set(f, 'Position', [0 0 .2 .5]);
% menubar = uimenu(f);
% drawnow()
% set(f, 'Position', [0 0 .2 1]);
% drawnow()
% pause(1)
% h_menubar = h(0, 'pixels') - h(f, 'pixels') - h_title
% 
% set(f, 'Position', [0 0 .2 .5]);
% toolbar = uitoolbar(f);
% drawnow()
% set(f, 'Position', [0 0 .2 1]);
% drawnow()
% pause(1)
% h_toolbar = h(0, 'pixels') - h(f, 'pixels') - h_title - h_menubar
% 
% delete(f)


% f = uifigure('Visible', 'off', 'Units', 'Normalized', 'Position', [0 0 .2 .8]);
% menubar = uimenu(f);
% toolbar = uitoolbar(f);
% drawnow()
% set(f, 'Position', [0 0 .2 1]);
% drawnow()
% pause(1)
% h_title = h(f, 'pixels') % h(0, 'pixels') - h(f, 'pixels')
% 
% delete(f)



% f = uifigure('Units', 'Normalized', 'Position', [0 0 .2 .8]);
% menubar = uimenu(f);
% toolbar = uitoolbar(f);
% drawnow()
% set(f, 'Position', [0 0 .2 1]);
% drawnow()
% pause(1)
% h_title = h(f, 'pixels') % h(0, 'pixels') - h(f, 'pixels')


% f = uifigure('Units', 'Normalized', 'Position', [0 0 .2 .8]);
% pause(1)
% h_title = h(f, 'pixels') % h(0, 'pixels') - h(f, 'pixels')
% 
% menubar = uimenu(f);
% p = uipanel(f, 'Units', 'normalized', 'Position', [.01 .01 .98 .98], 'BackgroundColor', 'k');
% pause(1)
% h_menubar = h(f, 'pixels') % (h(0, 'pixels') - h_title) - h(f, 'pixels')
% 
% toolbar = uitoolbar(f);
% pause(1)
% h_toolbar = h(f, 'pixels') % (h(0, 'pixels') - h_title - h_menubar) - h(f, 'pixels')

% f = uifigure('units', 'pixels', 'position', [0 0 300 900], 'AutoResizeChildren', 'off', 'Color', 'r');
% toolbar = uitoolbar(f);
% menubar = uimenu(f);
% p = uipanel(f, 'Units', 'pixels', 'Position', [10 10 280 880-BRAPH2.FONTSIZE*6], 'BackgroundColor', 'k');
% drawnow()
% get(f, 'Position')


% gui = GUI('MENUBAR', true, 'TOOLBAR', true);
% f = gui.draw();
% get(f, 'Position')
% p = uipanel(f, 'Units', 'normalized', 'Position', [.01 .01 .98 .98]);

% et = ETA();
% gui = GUIElement('PE', et);
% f1 = gui.draw();
% f2 = gui.draw();
% close(f2)

% gui = GUIElement('PE', BRAPH2Constants);
% f = gui.draw();