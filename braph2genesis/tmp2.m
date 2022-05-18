close all
delete(findall(0, 'type', 'figure'))
clear all
clc

el_class = 'GUIElement';
delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% test_code = ['test_' el_class]
% eval(test_code)

gui = GUIElement('PE', ETA(), 'FILE', 'xxx sss', 'MENUBAR', true, 'TOOLBAR', true);
f = gui.draw();
% p = uipanel(f, 'Units', 'normalized', 'Position', [.01 .01 .98 .98]);


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