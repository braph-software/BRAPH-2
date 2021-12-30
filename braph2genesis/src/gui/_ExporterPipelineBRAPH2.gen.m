%% ¡header!
ExporterPipelineBRAPH2 < Exporter (ex, exporter of pipeline in BRAPH2) exports a pipeline in a BRAPH2 file.

%%% ¡description!
ExporterPipelineBRAPH2 exports a pipeline to a BRAPH2 file.

%%% ¡seealso!
Exporter, Pipeline, ImporterPipelineBRAPH2.

%% ¡props!

%%% ¡prop!
PL (data, item) is a pipeline.
%%%% ¡settings!
'Pipeline'

%%% ¡prop!
FILE (data, string) is the BRAPH2 file where to save the pipeline.
%%%% ¡default!
[fileparts(which('test_braph2')) filesep 'default_braph2_file_to_save_pipeline_most_likely_to_be_erased.braph2']

%%% ¡prop!
SAVE (result, empty) saves the pipeline in the selected BRAPH2 file.
%%%% ¡calculate!
file = ex.get('FILE');

if isfolder(fileparts(file))
    if ex.get('WAITBAR')
        wb = waitbar(0, 'Retrieving path ...', 'Name', BRAPH2.NAME);
        set_braph2_icon(wb)
    end
    
    pl = ex.get('PL');
    
    txt = [ ...
        '%% ' pl.get('LABEL') newline()  ...
        '%' newline() ...
        ];

    notes = cellfun(@(x) ['% ' strtrim(x) newline()], cellstr(pl.get('NOTES')), 'UniformOutput', false);
    for i = 1:1:length(notes)
        txt = [txt notes{i}];
    end

    ps_dict = pl.get('PS_DICT');
    for s = 1:1:ps_dict.length()
        ps = ps_dict.getItem(s);
        
        txt = [ txt ...
            newline() ...
            '%% ' ps.get('LABEL') newline() ...
            ];
        
        pc_dict = ps.get('PC_DICT');
        for c = 1:1:pc_dict.length()
            if ex.get('WAITBAR')
                waitbar(.00 + 1.00 * (s - 1 + c / pc_dict.length()) / ps_dict.length(), wb, ...
                    ['Saving pipeline section ' num2str(s) ' of ' num2str(ps_dict.length()) ...
                    ', code line ' num2str(c) ' of ' num2str(pc_dict.length()) ' ...'])
            end
                
            pc = pc_dict.getItem(c);
            
            txt = [ txt ...
                pc.get('MONIKER') ' = ' pc.get('CODE') ' % ' pc.get('TEXT_BEFORE_EXEC') ' % ' pc.get('TEXT_AFTER_EXEC') newline() ...
                ];
        end
    end
    
    txt = regexprep(txt, '%', '%%');
    
    object_file = fopen(ex.get('FILE'), 'w');
    fprintf(object_file, txt);
    fclose(object_file);
    
    % sets value to empty    
    value = [];
    
    if ex.get('WAITBAR')
        close(wb)
    end
else
    value = ex.getr('SAVE');
end

%% ¡methods!
function uiputfile(ex)
    % UIPUTFILE (result, empty) opens a dialog box to set the BRAPH2 file where to save the brain atlas.

    [filename, filepath, filterindex] = uiputfile(BRAPH2.EXT_PIPELINE, 'Select BRAPH2 Pipeline file');
    if filterindex
        file = [filepath filename];
        ex.set('FILE', file);
    end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Delete file TBE
%%%% ¡code!
delete([fileparts(which('test_braph2')) filesep 'default_braph2_file_to_save_pipeline_most_likely_to_be_erased.braph2'])