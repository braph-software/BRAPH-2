%% ¡header!
PipelinePP_Notes < PanelPropStringTextArea (pr, prop panel for pipeline notes) plots the panel for a pipeline notes.

%%% ¡description!
A Prop Panel for Pipeline Notes (PipelinePP_Notes) plots a text area with 
 the pipeline notes enhnaced with a popup context menu to open the web 
 tutorial and the pdf tuorial, as well as to edit or clone the pipeline.
It should be used only with the prop NOTES of the element Pipeline.

%%% ¡seealso!
uitextarea, uicontextmenu, Pipeline

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the prop panel for pipeline notes.
%%%% ¡default!
'PipelinePP_Notes'

%%% ¡prop!
NAME (constant, string) is the name of the prop panel for pipeline notes.
%%%% ¡default!
'Prop Panel for Pipeline Notes'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the prop panel for pipeline notes.
%%%% ¡default!
'A Prop Panel for Pipeline Notes (PipelinePP_Notes) plots a text area with the pipeline notes enhnaced with a popup context menu to open the web tutorial and the pdf tuorial, as well as to edit or clone the pipeline. It should be used only with the prop NOTES of the element Pipeline.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the prop panel for pipeline notes.
%%%% ¡settings!
'PipelinePP_Notes'

%%% ¡prop!
ID (data, string) is a few-letter code for the prop panel for pipeline notes.
%%%% ¡default!
'PipelinePP_Notes ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the prop panel for pipeline notes.
%%%% ¡default!
'PipelinePP_Notes label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the prop panel for pipeline notes.
%%%% ¡default!
'PipelinePP_Notes notes'

%%% ¡prop!
EL (data, item) is the element.
%%%% ¡settings!
'Pipeline'

%%% ¡prop!
PROP (data, scalar) is the property number.
%%%% ¡default!
Pipeline.NOTES

%%% ¡prop!
HEIGHT (gui, size) is the pixel height of the prop panel.
%%%% ¡default!
s(10)

%%% ¡prop!
X_DRAW (query, logical) draws the prop panel.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.X_DRAW, varargin{:}); % also warning
if value
    pr.memorize('CONTEXTMENU')
end

%%% ¡prop!
UPDATE (query, logical) updates the content and permissions of the text-area and popup context menu.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.UPDATE, varargin{:}); % also warning
if value

    pip = pr.get('EL');
    NOTES = pr.get('PROP');
    
% % %     switch el.getPropCategory(prop)
% % %         case Category.CONSTANT
% % %             set(pr.get('TEXTAREA'), ...
% % %                 'Value', el.get(prop), ...
% % %                 'Editable', 'off', ...
% % %                 'Enable', pr.get('ENABLE') ...
% % %                 )
% % %             
% % %         case Category.METADATA
            notes = pip.get(NOTES);

            pdf = regexp(notes, '/tutorials/pipelines/\\w+/\\w+\\.pdf', 'match', 'once'); % note \\ for compilation
            notes = regexprep(notes, ['PDF:.*?(' newline() '|$)'], '');
        
            md = regexp(notes, '/tutorials/pipelines/\\w+/readme\\.md', 'match', 'once'); % note \\ for compilation
            notes = regexprep(notes, ['README:.*?(' newline() '|$)'], '');

            notes = strtrim(notes);

            set(pr.get('TEXTAREA'), 'Value', strrep(notes, '\\n', char(10))) % note \\ for compilation
            if el.isLocked(prop)
                set(pr.get('TEXTAREA'), ...
                    'Editable', 'off', ...
                    'Enable', pr.get('ENABLE') ...
                    )
            end
            
% % %         case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
% % %             set(pr.get('TEXTAREA'), 'Value', strrep(el.get(prop),
% '\\n', char(10))) 
% % % 
% % %             prop_value = el.getr(prop);
% % %             if el.isLocked(prop) || isa(prop_value, 'Callback')
% % %                 set(pr.get('TEXTAREA'), ...
% % %                     'Editable', 'off', ...
% % %                     'Enable', pr.get('ENABLE') ...
% % %                     )
% % %             end
% % % 
% % %         case {Category.RESULT Category.QUERY Category.EVANESCENT}
% % %             prop_value = el.getr(prop);
% % % 
% % %             if isa(prop_value, 'NoValue')
% % %                 set(pr.get('TEXTAREA'), 'Value', strrep(el.getPropDefault(prop), '\\n', char(10))) % note \\ for compilation
% % %             else
% % %                 set(pr.get('TEXTAREA'), 'Value', strrep(el.get(prop), '\\n', char(10))) % note \\ for compilation
% % %             end
% % %             
% % %             set(pr.get('TEXTAREA'), ...
% % %                 'Editable', 'off', ...
% % %                 'Enable', pr.get('ENABLE') ...
% % %                 )
% % %     end
end

% % % TBE
% % % %%% ¡prop!
% % % REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.
% % % %%%% ¡calculate!
% % % value = calculateValue@PanelProp(pr, PanelProp.REDRAW, varargin{:}); % also warning
% % % if value
% % %     w_p = get_from_varargin(w(pr.get('H'), 'pixels'), 'Width', varargin);
% % %     
% % %     set(pr.get('TEXTAREA'), 'Position', [s(.3) s(.3) w_p-s(.6) max(1, pr.get('HEIGHT')-s(2.2))])
% % % end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel is deleted.
%%%% ¡calculate!
value = calculateValue@PanelProp(pr, PanelProp.DELETE, varargin{:}); % also warning
if value
    pr.set('CONTEXTMENU', Element.getNoValue())
end

% % % %TBE
% % % %%% ¡prop!
% % % ENABLE (gui, logical) switches the editfield between active and inactive appearance when not editable.
% % % %%%% ¡default!
% % % true

%%% ¡prop!
TEXTAREA (evanescent, handle) is the string value text-area.
%%%% ¡calculate!
pip = pr.get('EL');
NOTES = pr.get('PROP');

textarea = uitextarea( ...
    'Parent', pr.memorize('H'), ... % H = p for Panel
    'Tag', 'TEXTAREA', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Tooltip', [num2str(pip.getPropProp(NOTES)) ' ' pip.getPropDescription(NOTES)], ...
    'ValueChangedFcn', {@cb_textarea} ...
    );

value = textarea;
%%%% ¡calculate_callbacks!
function cb_textarea(~, ~)
    notes = get(pr.get('TEXTAREA'), 'Value');

    

    pr.get('EL').set(pr.get('PROP'), sprintf('%s\\\\n', value{:})) % double \\ to be converted to single \\ in compilation
end

%% ¡props!

%%% ¡prop!
CONTEXTMENU (evanescent, handle) is the context menu.
%%%% ¡calculate!
pip = pr.get('EL');
NOTES = pr.get('PROP');

% % % textarea = uitextarea( ...
% % %     'Parent', pr.memorize('H'), ... % H = p for Panel
% % %     'Tag', 'TEXTAREA', ...
% % %     'FontSize', BRAPH2.FONTSIZE, ...
% % %     'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
% % %     'ValueChangedFcn', {@cb_textarea} ...
% % %     );
% % % 
% % % value = textarea;
%%%% ¡calculate_callbacks!
% % % function cb_textarea(~, ~)
% % %     value = get(pr.get('TEXTAREA'), 'Value');
% % %     pr.get('EL').set(pr.get('PROP'), sprintf('%s\\\\n', value{:})) % double \\ to be converted to single \\ in compilation
% % % end

%% ¡tests!

%%% ¡excluded_props!
[PipelinePP_Notes.PARENT PipelinePP_Notes.H PipelinePP_Notes.LISTENER_CB PipelinePP_Notes.TEXTAREA PipelinePP_Notes.CONTEXTMENU]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':PipelinePP_Notes'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':PipelinePP_Notes'])