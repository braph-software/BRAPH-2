%% ¡header!
ImporterPipelineBRAPH2 < Importer (im, importer of pipeline from BRAPH2) imports a brain atlas from a braph2 file.

%%% ¡description!
ImporterPipelineBRAPH2 imports a pipeline from a BRAPH2 file.
The format of the BRAPH2 file should include the label, description and at least one code section.

%%% ¡seealso!
Importer, Pipeline, ExporterPipelineBRAPH2.

%% ¡props!

%%% ¡prop!
FILE (data, string) is the BRAPH2 file from where to load the pipeline.

%%% ¡prop!
PIP (result, item) is a pipeline.
%%%% ¡settings!
'Pipeline'
%%%% ¡default!
Pipeline()
%%%% ¡calculate!
% creates empty Pipeline
pip = Pipeline();
% analyzes file
file = im.get('FILE');
if ~isfile(file) && ~braph2_testing()
    im.uigetfile()
    file = im.memorize('FILE');
end
if isfile(file)
    if im.get('WAITBAR')
        wb = waitbar(0, 'Reading pipeline file ...', 'Name', BRAPH2.NAME);
        set_braph2_icon(wb)
    end

    try
        txt = fileread(file);

        % Pipeline
        header_marks = regexp(txt, '%%', 'all');
        header_txt = txt(header_marks(1):header_marks(2));
        header_newlines = regexp(header_txt, newline(), 'all');

        [~, id] = fileparts(file);
        pip.set('ID', id)

        label = strtrim(header_txt(3:header_newlines(1))); % eliminates %%
        pip.set('LABEL', label)
        
        notes = strtrim(header_txt(header_newlines(1) + 4:end - 1));
        notes_newlines = regexp(notes, newline(), 'all');
        for i = length(notes_newlines):-1:1
            notes = [notes(1:notes_newlines(i)) strtrim(notes(notes_newlines(i) + 2:end))]; % eliminates % but not newline
        end
        pip.set('NOTES', notes)
        
        % PipelineSection Dictionary
        pip.set('PS_DICT', Pipeline.getPropDefault('PS_DICT'))
        
        txt = txt(header_marks(2):end);
        section_marks = [regexp(txt, '%%', 'all') length(txt) + 1];
        for s = 1:1:length(section_marks) - 1
            section_txt = strtrim(txt(section_marks(s) + 2:section_marks(s + 1) - 1));
            section_newlines = regexp(section_txt, newline(), 'all');

            ps = PipelineSection( ...
                'ID', int2str(s), ...
                'Label', strtrim(section_txt(1:section_newlines(1))) ...
                );
            pip.get('PS_DICT').add(ps)
            
            % PipelineCode Dictionary
            ps.set('PC_DICT', PipelineSection.getPropDefault('PC_DICT'))
            
            section_txt = section_txt(section_newlines(1):end);
            code_marks = [regexp(section_txt, newline(), 'all') length(section_txt) + 1];
            for c = 1:1:length(code_marks) - 1
                if im.get('WAITBAR')
                    waitbar(.00 + 1.00 * (s - 1 + c / (length(code_marks) - 1)) / (length(section_marks) - 1), wb, ...
                        ['Loading pipeline section ' num2str(s) ' of ' num2str(length(section_marks) - 1) ...
                        ', code line ' num2str(c) ' of ' num2str(length(code_marks) - 1) ' ...'])
                end
                
                code_txt = strtrim(section_txt(code_marks(c):code_marks(c + 1) - 1));

                text = strtrim(code_txt(regexp(code_txt, ';', 'once') + 1:end));
                text = text(2:end); % removes initial %
                text_before_exec = strtrim(text(1:regexp(text, '%', 'once') - 1));
                text_after_exec = strtrim(text(regexp(text, '%', 'once') + 1:end));
                
                pc = PipelineCode( ...
                    'ID', int2str(c), ...
                    'MONIKER', strtrim(code_txt(1:regexp(code_txt, '=', 'once') - 1)), ...
                    'TEXT_BEFORE_EXEC', text_before_exec, ...
                    'TEXT_AFTER_EXEC', text_after_exec, ...
                    'CODE', strtrim(code_txt(regexp(code_txt, '=', 'once') + 1:regexp(code_txt, ';', 'once'))) ...
                    );
                ps.get('PC_DICT').add(pc)
            end
        end
    catch e
        % warndlg('Please select a valid input.', 'Warning');
        rethrow(e)
    end
    
    if im.get('WAITBAR')
        close(wb)
    end
elseif ~braph2_testing()
    error(BRAPH2.BUG_IO);
end

value = pip;

%% ¡methods!
function uigetfile(im)
    % UIGETFILE opens a dialog box to get the BRAPH2 file from where to load the pipeline.
    
    [filename, filepath, filterindex] = uigetfile(BRAPH2.EXT_PIPELINE, 'Select TXT file');
    if filterindex
        file = [filepath filename];
        im.set('FILE', file);
    end
end