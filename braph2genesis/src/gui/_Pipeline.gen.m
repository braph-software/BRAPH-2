%% ¡header!
Pipeline < ConcreteElement (pip, analysis pipeline) is an analysis pipeline.

%%% ¡description!
Pipeline is an analysis pipeline.

%%% ¡seealso!
PipelinePP_PSDict, PipelineSection, PipelineCode

%%% ¡_gui!

%%%% ¡_menu_importer!
% % % uimenu(menu_import, ...
% % %     'Label', 'Import BRAPH2 ...', ...
% % %     'Callback', {@cb_importer_BRAPH2});
% % % function cb_importer_BRAPH2(~, ~)
% % %     im = ImporterPipelineBRAPH2( ...
% % %         'ID', 'Import BRAPH2 Pipeline', ...
% % %         'WAITBAR', true ...
% % %         );
% % %     im.uigetfile();
% % %     try
% % %         if isfile(im.get('FILE'))
% % %             pip = pe.get('EL');
% % %             
% % %             assert( ...
% % %                 all(cellfun(@(prop) ~pip.isLocked(prop), num2cell(pip.getProps()))), ...
% % %                 [BRAPH2.STR ':Pipeline:' BRAPH2.BUG_FUNC], ...
% % %                 'To import an element, all its properties must be unlocked.' ...
% % %                 )
% % %             
% % %             pip_new = im.get('PIP');
% % %             for prop = 1:1:pip.getPropNumber()
% % %                 if pip.getPropCategory(prop) ~= Category.RESULT
% % %                     pip.set(prop, pip_new.get(prop))
% % %                 end
% % %             end
% % %             
% % %             pe.reinit(pip_new)
% % %         end
% % %     catch e
% % %         warndlg(['Please, select a valid input Pipeline in BRAPH2 format. ' newline() ...
% % %             newline() ...
% % %             'Error message:' newline() ...
% % %             newline() ...
% % %             e.message newline()], 'Warning');
% % %     end
% % % end
% % % 
% % % %%%% ¡_menu_exporter!
% % % uimenu(menu_export, ...
% % %     'Label', 'Export BRAPH2 ...', ...
% % %     'Callback', {@cb_exporter_BRAPH2});
% % % function cb_exporter_BRAPH2(~, ~)
% % %     ex = ExporterPipelineBRAPH2( ...
% % %         'ID', 'Export BRAPH2 Pipeline', ...
% % %         'PIP', el.copy(), ...
% % %         'WAITBAR', true ...
% % %         );
% % %     ex.uiputfile()
% % %     if ~strcmp(ex.get('FILE'), ExporterPipelineBRAPH2.getPropDefault('FILE'))
% % %         ex.get('SAVE');
% % %     end
% % % end

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the pipeline.
%%%% ¡default!
'Pipeline'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the pipeline.
%%%% ¡default!
'Pipeline is an analysis pipeline.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the pipeline.

%%% ¡prop!
ID (data, string) is a few-letter code for the pipeline.
%%%% ¡default!
'Pipeline ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the pipeline.
%%%% ¡default!
'Pipeline label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the pipeline.
%%%% ¡default!
'Pipeline notes'
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', pip, 'PROP', Pipeline.NOTES, 'HEIGHT', s(10), varargin{:});

%% ¡props!

%%% ¡prop!
PS_DICT (data, idict) is an indexed dictionary with the code sections.
%%%% ¡settings!
'PipelineSection'
%%%% ¡gui!
pr = PipelinePP_PSDict('EL', pip, 'PROP', Pipeline.PS_DICT, varargin{:});

