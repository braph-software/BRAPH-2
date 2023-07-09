%% ¡header!
SubjectPP_VOIDict < PanelProp (pr, VOI plot) plots the panel for a VOI dictionary.

%%% ¡description!
SubjectPP_VOIDict plots a VOI (variables of interest) dictionary using 
numeric editfields and drop-down lists.
It is intended to be used with the property VOI_DICT of Subject.

%%% ¡seealso!
Subject, uieditfield, uidropdown

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the VOI plot.
%%%% ¡default!
'SubjectPP_VOIDict'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the VOI plot.
%%%% ¡default!
'SubjectPP_VOIDict plots a VOI (variables of interest) dictionary using numeric editfields and drop-down lists.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the VOI plot.
%%%% ¡settings!
'SubjectPP_VOIDict'

%%% ¡prop!
ID (data, string) is a few-letter code for the VOI plot.
%%%% ¡default!
'SubjectPP_VOIDict ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the VOI plot.
%%%% ¡default!
'SubjectPP_VOIDict label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the VOI plot.
%%%% ¡default!
'SubjectPP_VOIDict notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡settings!
'Subject'

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
Subject.VOI_DICT

%%% ¡prop!
X_DRAW (query, logical) draws the property panel.
% % % %%%% ¡calculate!
% % % value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
% % % if value
% % %     pr.memorize('HANDLES')
% % % end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the table.
% % % %%%% ¡calculate!
% % % value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
% % % if value
% % %     pip = pr.get('EL');
% % % 
% % %     ps_dict = pip.get('PS_DICT');
% % %     ps_number = ps_dict.get('LENGTH');
% % %     pc_numbers = cellfun(@(ps) ps.get('PC_DICT').get('LENGTH'), ps_dict.get('IT_LIST'));
% % %     pr.set('HEIGHT', pr.get('HEIGHT_MIN') + (pr.get('HEIGHT_PS_MARGIN') + pr.get('HEIGHT_PS_HEADER') + pr.get('HEIGHT_PS_FOOTER')) * ps_number + pr.get('HEIGHT_PC') * sum(pc_numbers));
% % %     
% % %     s_selected = get_from_varargin(0, 'Section', varargin); % selected section
% % %     c_selected = get_from_varargin(0, 'Code', varargin); % selected code
% % % 
% % %     to_be_executed = {};
% % %     
% % %     s_to_be_calculated = 1;
% % %     s_dict = pip.get('PS_DICT');
% % %     for sec = 1:1:s_dict.get('LENGTH')
% % %         section = s_dict.get('IT', sec);
% % %         
% % %         code_dict = section.get('PC_DICT');
% % %         for cl = 1:1:code_dict.get('LENGTH')
% % %             code = code_dict.get('IT', cl);
% % %             moniker = code.get('MONIKER');
% % %             if strcmpi(moniker, 'varargin')
% % %                 error( ...
% % %                     [BRAPH2.STR ':' pr.getClass() ':' BRAPH2.WRONG_INPUT], ...
% % %                     [BRAPH2.STR ':' pr.getClass() ':' BRAPH2.WRONG_INPUT '\\n' ...
% % %                     'The moniker should not be ''varagin''.'] ...
% % %                     )
% % %             end
% % %             
% % %             % callback code
% % %             if sec == s_selected && cl == c_selected
% % %                 if isa(code.getr('EL'), 'NoValue') % the code has not been calculated yet -- CALCULATE
% % %                     try
% % %                         set(pr.get('PC_BTN', sec, cl), 'Enable', 'off')
% % %                         x_pip_update(to_be_executed{:}, ...
% % %                             {moniker, code, [moniker ' = ' code.get('CODE') ';']}, ... % varargin{1}{2} = code
% % %                             {moniker, code, ['varargin{1}{2}.set(''EL'', ' moniker ');']}) % varargin{1}{2} = code
% % %                     catch e
% % %                         set(pr.get('PC_BTN', sec, cl), 'Enable', 'on')
% % % 
% % %                         if isempty(regexp(e.message, ['^' BRAPH2.STR ':.*:' BRAPH2.CANCEL_IO '$'], 'once'))
% % %                             %TODO make this with braph2message
% % %                             warndlg(['An error occurred while trying to execute the code:' newline() ...
% % %                                 newline() ...
% % %                                 moniker ' = ' code.get('CODE') ';' newline() ...
% % %                                 newline() ...
% % %                                 'Error message:' newline() ...
% % %                                 newline() ...
% % %                                 e.message newline()], 'Warning');
% % %                         end
% % %                     end
% % %                 end
% % %                     
% % %                 if ~isa(code.getr('EL'), 'NoValue') % the code has already been calculated -- GUI
% % %                     key = [int2str(sec) '.' int2str(cl)];
% % %                     gui_pc_dict = pr.memorize('GUI_PC_DICT');
% % %                     if ~gui_pc_dict.get('CONTAINS_KEY', key)
% % %                         f_pip = ancestor(pr.get('H'), 'Figure'); % Pipeline GUI
% % %                         
% % %                         gui = GUIElement( ...
% % %                             'ID', key, ... % this is the dictionary key
% % %                             'PE', code.get('EL'), ...
% % %                             'POSITION', [ ...
% % %                                 x0(f_pip, 'normalized') + .20 ...
% % %                                 y0(f_pip, 'normalized') ...
% % %                                 .20 ...
% % %                                 h(f_pip, 'normalized') ...
% % %                                 ], ...
% % %                             'WAITBAR', pr.getCallback('WAITBAR'), ...
% % %                             'CLOSEREQ', false ...
% % %                             );
% % %                         gui_pc_dict.get('ADD', gui)
% % %                     end
% % %                     
% % %                     gui = gui_pc_dict.get('IT', key);
% % %                     if ~gui.get('DRAWN')
% % %                         gui.get('DRAW')
% % %                     end
% % %                     if get(gui.get('H'), 'Visible')
% % %                         gui.get('HIDE')
% % %                     else
% % %                         gui.get('SHOW')
% % %                     end
% % %                 end
% % %             end
% % % 
% % %             % If a code has already been executed and the relative element exists, 
% % %             % 1. loads the calculated element to the workspace
% % %             % 2. updates the ID in the btn
% % %             % 3. calculates whether to move to the next section
% % %             if ~isa(code.getr('EL'), 'NoValue')
% % %                 to_be_executed = {to_be_executed{:}, {moniker, code, [moniker ' = varargin{1}{2}.get(''EL'');']}}; % varargin{1}{2} = code
% % % 
% % %                 set(pr.get('PC_BTN', sec, cl), ...
% % %                     'Enable', 'on', ...
% % %                     'Text', [code.get('TEXT_AFTER_EXEC') ' / ' code.get('EL').get('ID')], ...
% % %                     'FontAngle', 'normal', ...
% % %                     'FontWeight', 'normal' ...
% % %                     )
% % %                 set(pr.get('PC_CLEAR_BTN', sec, cl), 'Enable', 'on')
% % % 
% % %                 % if all section codes calculated, updates the section to be calculated
% % %                 if all(cellfun(@(pc) ~isa(pc.getr('EL'), 'NoValue'), code_dict.get('IT_LIST')))
% % %                     s_to_be_calculated = sec + 1;
% % %                 end
% % %                 
% % %                 % disables clear buttons of previous section
% % %                 if sec > 1
% % %                     for cl_tmp = 1:1:s_dict.get('IT', sec - 1).get('PC_DICT').get('LENGTH')
% % %                         set(pr.get('PC_CLEAR_BTN', sec - 1, cl_tmp), 'Enable', 'off')
% % %                     end
% % %                 end
% % %             end
% % %             
% % %             % activates the next section that can be calculated
% % %             % (only the codes that have not been calculated yet)
% % %             if sec == s_to_be_calculated && isa(code.getr('EL'), 'NoValue')
% % %                 set(pr.get('PC_BTN', sec, cl), ...
% % %                     'Enable', 'on', ...
% % %                     'Text', code.get('TEXT_BEFORE_EXEC'), ...
% % %                     'FontAngle', 'normal', ...
% % %                     'FontWeight', 'bold' ...
% % %                     )
% % %                 set(pr.get('PC_CLEAR_BTN', sec, cl), 'Enable', 'off')
% % %             end
% % %             
% % %             % deactivates the subsequent sections
% % %             if sec > s_to_be_calculated 
% % %                 set(pr.get('PC_BTN', sec, cl), ...
% % %                     'Enable', 'off', ...
% % %                     'Text', code.get('TEXT_BEFORE_EXEC'), ...
% % %                     'FontAngle', 'italic', ...
% % %                     'FontWeight', 'normal' ...
% % %                     )
% % %                 set(pr.get('PC_CLEAR_BTN', sec, cl), 'Enable', 'off')
% % %             end
% % %         end
% % %     end
% % % end

%%% ¡prop!
REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
% % % %%%% ¡calculate!
% % % value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
% % % if value
% % %     w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
% % %     
% % %     pip = pr.get('EL');
% % %     ps_dict = pip.get('PS_DICT');
% % %         
% % %     ps_number = ps_dict.get('LENGTH');
% % %     pc_numbers = cellfun(@(ps) ps.get('PC_DICT').get('LENGTH'), ps_dict.get('IT_LIST'));
% % %     
% % %     for sec = 1:1:ps_number
% % %         ps_y = pr.get('HEIGHT_PS_HEADER') * (ps_number - sec) ...
% % %             + pr.get('HEIGHT_PC') * sum(pc_numbers(sec+1:end)) ...
% % %             + pr.get('HEIGHT_PS_FOOTER') * (ps_number - sec) ...
% % %             + pr.get('HEIGHT_PS_MARGIN') * (ps_number - sec + 1);
% % %         ps_h = pr.get('HEIGHT_PS_HEADER') + pr.get('HEIGHT_PC') * pc_numbers(sec) + pr.get('HEIGHT_PS_FOOTER');
% % %         
% % %         set(pr.get('PS_PANEL', sec), ...
% % %             'Units', 'pixels', ...
% % %             'Position', [s(.3) ps_y w_p-s(.6) ps_h] ...
% % %             )
% % %         
% % %         for cl = 1:1:pc_numbers(sec)
% % %             set(pr.get('PC_BTN', sec, cl), 'Position', [s(.3) (pr.get('HEIGHT_PS_FOOTER')+(pc_numbers(sec)-cl)*pr.get('HEIGHT_PC')) w(pr.get('PS_PANEL', sec), 'pixels')-pr.get('HEIGHT_PC')-s(.9) pr.get('HEIGHT_PC')])
% % %             set(pr.get('PC_CLEAR_BTN', sec, cl), 'Position', [w(pr.get('PS_PANEL', sec), 'pixels')-pr.get('HEIGHT_PC')-s(.3) (pr.get('HEIGHT_PS_FOOTER')+(pc_numbers(sec)-cl)*pr.get('HEIGHT_PC')) pr.get('HEIGHT_PC') pr.get('HEIGHT_PC')])
% % %         end
% % %     end
% % % end

%%% ¡prop!
SHOW (query, logical) shows the figures of the elements/buttons.
% % % %%%% ¡calculate!
% % % value = calculateValue@PanelProp(pr, PanelProp.SHOW, varargin{:}); % also warning
% % % if value
% % %     % % figures for elements/buttons, currently not in use
% % %     % gui_pc_dict = pr.get('GUI_PC_DICT');
% % %     % for i = 1:1:gui_pc_dict.get('LENGTH')
% % %     %     gui = gui_pc_dict.get('IT', i);
% % %     %     if gui.get('DRAWN')
% % %     %         gui.get('SHOW')
% % %     %     end
% % %     % end
% % % end

%%% ¡prop!
HIDE (query, logical) hides the figures of the elements/buttons.
% % % %%%% ¡calculate!
% % % value = calculateValue@PanelProp(pr, PanelProp.HIDE, varargin{:}); % also warning
% % % if value
% % %     % figures for items
% % %     gui_pc_dict = pr.get('GUI_PC_DICT');
% % %     for i = 1:1:gui_pc_dict.get('LENGTH')
% % %         gui = gui_pc_dict.get('IT', i);
% % %         if gui.get('DRAWN')
% % %             gui.get('HIDE')
% % %         end
% % %     end
% % % end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
% % % %%%% ¡calculate!
% % % value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
% % % if value
% % %     pr.set('HANDLES', Element.getNoValue())
% % % end

%%% ¡prop!
CLOSE (query, logical) closes the figure containing the panel and, possibly, the item figures.
% % % %%%% ¡calculate!
% % % value = calculateValue@PanelProp(pr, PanelProp.CLOSE, varargin{:}); % also warning
% % % if value
% % %     % figures for items
% % %     gui_pc_dict = pr.get('GUI_PC_DICT');
% % %     for i = 1:1:gui_pc_dict.get('LENGTH')
% % %         gui = gui_pc_dict.get('IT', i);
% % %         if gui.get('DRAWN')
% % %             gui.get('CLOSE')
% % %         end
% % %     end
% % % end

%% ¡props!

%%% ¡prop!
HEIGHT_MIN (gui, scalar) is the default (minumum) height.
%%%% ¡default!
s(2)
 
%%% ¡prop!
HEIGHT_VOI_EDITFIELD (gui, scalar) is the height of each VOI editfield.
%%%% ¡default!
s(2)

%%% ¡prop!
HEIGHT_VOI_DROPDOWN (gui, scalar) is the height of each VOI drop-down list.
%%%% ¡default!
s(2)

%%% ¡prop!
ENABLE (gui, logical) switches the editfields between active and inactive appearance when not editable.
%%%% ¡default!
true

%%% ¡prop!
HANDLES (evanescent, handlelist) is the list of VOI numeric editfields and drop-down lists.
% % % %%%% ¡calculate!
% % % pip = pr.get('EL');
% % % 
% % % ps_dict = pip.get('PS_DICT');
% % % ps_panels = cell(1, ps_dict.get('LENGTH'));
% % % pc_btns = cell(1, ps_dict.get('LENGTH'));
% % % for sec = 1:1:ps_dict.get('LENGTH')
% % %     ps = ps_dict.get('IT', sec);
% % % 
% % %     ps_panels{sec} = uipanel( ...
% % %         'Parent', pr.get('H'), ...
% % %         'Tag', int2str(sec), ... % Tag used by PS_PANEL
% % %         'Title', [ps.get('ID') '. ' ps.get('LABEL')], ... 
% % %         'Tooltip', ps.get('DESCRIPTION'), ...
% % %         'FontSize', BRAPH2.FONTSIZE, ...
% % %         'BorderType', 'none' ...
% % %         );
% % % 
% % %         pc_dict = ps.get('PC_DICT');
% % %         pc_btns{sec} = cell(1, pc_dict.get('LENGTH'));
% % %         for cl = 1:1:pc_dict.get('LENGTH')
% % %             pc = pc_dict.get('IT', cl);
% % % 
% % %             pc_btns{sec}{cl} = uibutton( ...
% % %                 'Parent', ps_panels{sec}, ... 
% % %                 'Tag', [int2str(sec) '.' int2str(cl)], ... % Tag used by PC_CLEAR_BTN 
% % %                 'Tooltip', pc.get('DESCRIPTION'), ...
% % %                 'Enable', 'off', ...
% % %                 'Text', pc.get('TEXT_BEFORE_EXEC'), ...
% % %                 'FontAngle', 'italic', ...
% % %                 'FontSize', BRAPH2.FONTSIZE, ...
% % %                 'UserData', [sec cl], ...
% % %                 'ButtonPushedFcn', {@cb_pc_btn}, ...
% % %                 'Interruptible', 'off', ...
% % %                 'BusyAction', 'cancel' ...
% % %                 );
% % % 
% % %             pc_clear_btns{sec}{cl} = uibutton( ...
% % %                 'Parent', ps_panels{sec}, ... 
% % %                 'Tag', ['clear ' int2str(sec) '.' int2str(cl)], ... % Tag used by PC_CLEAR_BTN
% % %                 'Tooltip', ['Clear ' pc.get('MONIKER')], ...
% % %                 'Enable', 'off', ...
% % %                 'Text', 'C', ...
% % %                 'FontSize', BRAPH2.FONTSIZE, ...
% % %                 'FontWeight', 'bold', ...
% % %                 'UserData', [sec cl], ...
% % %                 'ButtonPushedFcn', {@cb_pc_clear_btn}, ...
% % %                 'Interruptible', 'off', ...
% % %                 'BusyAction', 'cancel' ...
% % %                 );
% % %         end
% % % end
% % % 
% % % % output value
% % % handles = {};
% % % for sec = 1:1:length(ps_panels)
% % %     handles = [handles ps_panels(sec) pc_btns{sec}(:)' pc_clear_btns{sec}(:)'];
% % % end
% % % value = handles;
% % % %%%% ¡calculate_callbacks!
% % % function cb_pc_btn(src, ~)
% % %     userdata = get(src, 'UserData');
% % %     sec = userdata(1);
% % %     cl = userdata(2);
% % % 
% % %     pr.get('UPDATE', 'Section', sec, 'Code', cl)
% % % end
% % % function cb_pc_clear_btn(src, ~)
% % % 
% % %     userdata = get(src, 'UserData');
% % %     sec = userdata(1);
% % %     cl = userdata(2);
% % %     
% % %     % resets the code eliminating element
% % %     pc_dict = pip.get('PS_DICT').get('IT', sec).get('PC_DICT');
% % %     code = pc_dict.get('IT', cl);
% % %     code_new = PipelineCode( ...
% % %         'TEMPLATE', code.get('TEMPLATE'), ...
% % %         'ID', code.get('ID'), ...
% % %         'LABEL', code.get('LABEL'), ...
% % %         'NOTES', code.get('NOTES'), ...
% % %         'TEMPLATE', code.get('TEMPLATE'), ...
% % %         'TEXT_BEFORE_EXEC', code.get('TEXT_BEFORE_EXEC'), ...
% % %         'TEXT_AFTER_EXEC', code.get('TEXT_AFTER_EXEC'), ...
% % %         'MONIKER', code.get('MONIKER'), ...
% % %         'CODE', code.get('CODE') ...
% % %         );
% % %     pc_dict.get('REPLACE_IT', code, code_new)
% % %     
% % %     % closes and removes the GUI
% % %     key = [int2str(sec) '.' int2str(cl)];
% % %     gui_pc_dict = pr.get('GUI_PC_DICT');
% % %     if gui_pc_dict.get('CONTAINS_KEY', key)
% % %         gui_pc = gui_pc_dict.get('IT', key);
% % %         if gui_pc.get('DRAWN')
% % %             gui_pc.get('CLOSE')
% % %         end
% % %         gui_pc_dict.get('REMOVE', key)
% % %     end
% % %     
% % %     pr.get('UPDATE')
% % % end

%% ¡tests!

% % % %%% ¡excluded_props!
% % % [PipelinePP_PSDict.PARENT PipelinePP_PSDict.H PipelinePP_PSDict.HANDLES]
% % % 
% % % %%% ¡warning_off!
% % % true

% % % %%% ¡test!
% % % %%%% ¡name!
% % % Remove Figures
% % % %%%% ¡parallel!
% % % false
% % % %%%% ¡code!
% % % warning('off', [BRAPH2.STR ':PipelinePP_PSDict'])
% % % assert(length(findall(0, 'type', 'figure')) == 1)
% % % delete(findall(0, 'type', 'figure'))
% % % warning('on', [BRAPH2.STR ':PipelinePP_PSDict'])
