%% ¡header!
Pipeline < Element (pip, analysis pipeline) is an analysis pipeline.

%%% ¡description!
Pipeline is an analysis pipeline.

%%% ¡seealso!
PipelineGUI, PipelineSection, PipelineCode

%%% ¡gui!

%%%% ¡menu_importer!
uimenu(ui_menu_import, ...
    'Label', 'Import BRAPH2 ...', ...
    'Callback', {@cb_importer_BRAPH2});
function cb_importer_BRAPH2(~, ~)
    im = ImporterPipelineBRAPH2( ...
        'ID', 'Import BRAPH2 Pipeline', ...
        'WAITBAR', true ...
        );
    im.uigetfile();
    try
        if isfile(im.get('FILE'))
            pl.set('EL', im.get('PIP')); 
            pl.reinit();
        end
    catch e
        warndlg(['Please, select a valid input Pipeline in BRAPH2 format. ' newline() ...
            newline() ...
            'Error message:' newline() ...
            newline() ...
            e.message newline()], 'Warning');
    end
end

%%%% ¡menu_exporter!
uimenu(ui_menu_export, ...
    'Label', 'Export BRAPH2 ...', ...
    'Callback', {@cb_exporter_BRAPH2});
function cb_exporter_BRAPH2(~, ~)
    ex = ExporterPipelineBRAPH2( ...
        'ID', 'Export BRAPH2 Pipeline', ...
        'PIP', el.copy(), ...
        'WAITBAR', true ...
        );
    ex.uiputfile()
    if ~strcmp(ex.get('FILE'), ExporterPipelineBRAPH2.getPropDefault('FILE'))
        ex.get('SAVE');
    end
end

%% ¡props!

%%% ¡prop!
ID (data, string) is a code for the pipeline (typically its file name).

%%% ¡prop!
LABEL (metadata, string) is an extended label of the pipeline.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the pipeline.
%%%% ¡gui!
pl = PlotPropText('EL', pip, 'PROP', Pipeline.NOTES, varargin{:}); % multiline text

%%% ¡prop!
PS_DICT (data, idict) is an indexed dictionary with the code sections.
%%%% ¡settings!
'PipelineSection'
%%%% ¡gui!
pl = PPPipeline_PSDict('EL', pip, 'PROP', Pipeline.PS_DICT, varargin{:});

