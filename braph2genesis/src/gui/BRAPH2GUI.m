function f_out = BRAPH2GUI()
%BRAPH2GUI opens the initial GUI for BRAPH 2. 
% It provides a list of all available pipelines with search functionalities.
%
% BRAPH2GUI() opens the initial GUI for BRAPH 2.
%
% F = BRAPH2GUI(TITLE, MESSAGE) returns a handle to the uifigure.
%
% See also braph2, uifigure.

%% Initialization
f = uifigure( ...
    'Tag', 'F', ...
    'Visible', 'off', ...
    'WindowStyle', 'normal', ...
    'Resize', 'off', ...
    'Icon', 'braph2icon_64px.png', ...
    'Name', BRAPH2.NAME, ...
    'Color', BRAPH2.COL_BKG, ...
    'Units', 'pixels', ...
    'Position', [(w(0)-s(72))/2 (h(0)-s(45))/2 s(72) s(45)] ...
    );

%% Left Column - Logo& Info
icon = rgb2gray(imread('braph2icon.png'));
h_axes = uiaxes( ...
    'Parent', f,  ...
    'Tag', 'H_AXES', ...
    'Visible', 'off', ...
    'InnerPosition', [s(1) s(20) s(24) s(24)], ...
    'XLim', [0 size(icon, 1)], ...
    'YLim', [0 size(icon, 2)], ...
    'YDir', 'reverse', ...
    'Colormap', [BRAPH2.COL_BKG; repmat(BRAPH2.COL, 254, 1); 1 1 1] ...
    );
h_image = image( ...
    'Parent', h_axes, ...
    'Tag', 'H_IMAGE', ...
    'CData', icon ...
    ); %#ok<NASGU>
h_axes.Toolbar.Visible = 'off';
h_axes.Interactions = [];
            
h_text_braph2 = text( ...
    'Parent', h_axes, ...
    'Tag', 'H_TEXT_BRAPH2', ...
    'String', ['{\bf\color{orange}' BRAPH2.NAME '}'], ...
    'FontSize', BRAPH2.FONTSIZE * 2.5, ...
    'Position', [size(icon, 1)/2 size(icon, 2)], ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'top' ...
    ); %#ok<NASGU>

h_text_credits = text( ...
    'Parent', h_axes, ...
    'Tag', 'H_TEXT_CREDITS', ...
    'String', {
        ['{\color{gray}version ' BRAPH2.VERSION '}']
        ['{\color{gray}build ' int2str(BRAPH2.BUILD) '}']
        ['{\color{gray}released ' BRAPH2.RELEASE '}']
        ['{\color{gray}' lower(BRAPH2.COPYRIGHT) '}']
        }, ...
    'FontSize', BRAPH2.FONTSIZE * 1.5, ...
    'Position', [size(icon, 1)/2 1.2*size(icon, 2)], ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'top' ...
    ); %#ok<NASGU>

%% Bottom Buttons

dw = 1; % horizonthal spacing around buttons
bw =  w(f) / 7 - 2 * dw; % button width

dh = 5; % vertical spacing around buttons
bh = h(f) / 10; % button height

h_button_pip = uibutton( ...
    'Parent', f, ...
    'Tag', 'H_BUTTON_PIP', ...
    'Tooltip', 'Open a Pipeline (*.braph2) ...', ...
    'Text', '', ...
    'Icon', imread('icon_load_pip_32px.png'), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Position', [dw dh bw bh], ...
    'BackgroundColor', [1 1 1], ...    
    'ButtonPushedFcn', {@cb_button_pip}, ...
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    ); %#ok<NASGU>
    function cb_button_pip(~, ~)
        [file, path, filterindex] = uigetfile(BRAPH2.EXT_PIPELINE, 'Select BRAPH2 file');
        if filterindex
            pip = ImporterPipelineBRAPH2( ...
                'FILE', fullfile(path, file), ...
                'WAITBAR', true ...
                ).get('PIP');

            gui = GUIElement( ...
                'PE', pip, ...
                'WAITBAR', true, ...
                'CLOSEREQ', true ...
                );
            gui.get('DRAW')
            gui.get('SHOW')
        end
    end

h_button_el = uibutton( ...
    'Parent', f, ...
    'Tag', 'H_BUTTON_EL', ...
    'Tooltip', 'Load an Element (*.b2) into MatLab workspace ...', ...
    'Text', '', ...
    'Icon', imread('icon_load_el_32px.png'), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Position', [dw+(2*dw+bw) dh bw bh], ...
    'BackgroundColor', [1 1 1], ...    
    'ButtonPushedFcn', {@cb_button_el}, ...
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    ); %#ok<NASGU>
    function cb_button_el(~, ~)
        [file, path, filterindex] = uigetfile(BRAPH2.EXT_ELEMENT, 'Select B2 file');
        if filterindex
            filename = fullfile(path, file);
            el = Element.load(filename, true);
            %TODO: add checks for BRAPH2 version
            if isa(el, 'PanelFig')
                gui = GUIFig( ...
                    'PF', el, ...
                    'FILE', filename, ...
                    'WAITBAR', true ...
                    );
            else
                gui = GUIElement( ...
                    'PE', el, ...
                    'FILE', filename, ...
                    'WAITBAR', true ...
                    );
            end
            gui.get('DRAW')
            gui.get('SHOW')
        end
    end

h_button_web = uibutton( ...
    'Parent', f, ...
    'Tag', 'H_BUTTON_WEB', ...
    'Tooltip', 'Open braph.org ...', ...
    'Text', '', ...
    'Icon', imread('icon_web_32px.png'), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Position', [dw+2*(2*dw+bw) dh bw bh], ...
    'ButtonPushedFcn', {@cb_web}, ...
    'BackgroundColor', [1 1 1], ...    
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    ); %#ok<NASGU>
    function cb_web(~, ~)
        BRAPH2.web()
    end

h_button_forum = uibutton( ...
    'Parent', f, ...
    'Tag', 'H_BUTTON_FORUM', ...
    'Tooltip', 'Open BRAPH2 forum ...', ...
    'Text', '', ...
    'Icon', imread('icon_forum_32px.png'), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Position', [dw+3*(2*dw+bw) dh bw bh], ...
    'ButtonPushedFcn', {@cb_forum}, ...
    'BackgroundColor', [1 1 1], ...    
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    ); %#ok<NASGU>
    function cb_forum(~, ~)
        BRAPH2.forum()
    end

h_button_twitter = uibutton( ...
    'Parent', f, ...
    'Tag', 'H_BUTTON_TWITTER', ...
    'Tooltip', 'Open BRAPH2 twitter ...', ...
    'Text', '', ...
    'Icon', imread('icon_twitter_32px.png'), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Position', [dw+4*(2*dw+bw) dh bw bh], ...
    'ButtonPushedFcn', {@cb_twitter}, ...
    'BackgroundColor', [1 1 1], ...    
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    ); %#ok<NASGU>
    function cb_twitter(~, ~)
        BRAPH2.twitter()
    end

h_button_license = uibutton( ...
    'Parent', f, ...
    'Tag', 'H_BUTTON_LICENSE', ...
    'Tooltip', 'BRAPH2 license ...', ...
    'Text', '', ...
    'Icon', imread('icon_license_32px.png'), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Position', [dw+5*(2*dw+bw) dh bw bh], ...
    'ButtonPushedFcn', {@cb_license}, ...
    'BackgroundColor', [1 1 1], ...    
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    ); %#ok<NASGU>
    function cb_license(~, ~)
        BRAPH2.license()
    end

h_button_about = uibutton( ...
    'Parent', f, ...
    'Tag', 'H_BUTTON_ABOUT', ...
    'Tooltip', 'About BRAPH2 ...', ...
    'Text', '', ...
    'Icon', imread('icon_about_32px.png'), ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Position', [dw+6*(2*dw+bw) dh bw bh], ...
    'ButtonPushedFcn', {@cb_about}, ...
    'BackgroundColor', [1 1 1], ...    
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    ); %#ok<NASGU>
    function cb_about(~, ~)
        BRAPH2.credits();
    end

%% Right Column - Pipelines

h_editfield = uieditfield( ...
    'Parent', f, ...
    'Tag', 'H_EDITFIELD', ...
    'Tooltip', 'Write the keywords describing the pipeline you are looking for (use * as a wildcard)', ...
    'Placeholder', 'insert keywords', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Position', [w(h_axes) .9*h(f) .95*w(f)-w(h_axes) 2*BRAPH2.FONTSIZE], ...
    'ValueChangedFcn', {@cb_editfield} ...
    );
    function cb_editfield(~, ~)
        pipelines = get_pipelines();
        update_listbox()
    end

h_listbox = uilistbox( ...
    'Parent', f, ...
    'Tag', 'H_LISTBOX', ...
    'Tooltip', 'Available pipelines', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Position', [w(h_axes) .4*h(f) .95*w(f)-w(h_axes) .5*h(f)], ...
    'ValueChangedFcn', {@cb_listbox_selected} ...
    ); 
    function cb_listbox_selected(~, ~)
        pipeline = pipelines{get(h_listbox, 'Value')};

        set(h_label, ... 
            'Text', sprintf('%s\n', ['<strong>' pipeline.label '</strong>'], '', regexprep(pipeline.notes, newline(), [newline() newline()])), ...
            'Position', [5 0 w(h_panel)-10 max(2*h(h_panel), (2+2*length(regexp(pipeline.notes, newline()))+length(pipeline.notes)/40)*BRAPH2.FONTSIZE)] ...
            )

        set(h_menu_tut_web, 'Enable', ~isempty(pipeline.pdf))
        set(h_menu_tut_pdf, 'Enable', ~isempty(pipeline.md))
        set(h_menu_pip_edit, 'Enable', 'on')
        set(h_menu_pip_clone, 'Enable', 'on')
        
        set(h_button, ...
            'Enable', 'on', ...
            'Text', ['Open ' pipeline.label  ' ...'] ...
            )
    end

h_panel = uipanel( ...
    'Parent', f, ...
    'Position', [w(h_axes) .2*h(f) .95*w(f)-w(h_axes) .2*h(f)], ...
    'Scrollable', 'on' ...
    ); 

h_contextmenu = uicontextmenu( ...
    'Parent', f, ...
    'TAG', 'H_CONTEXTMENU' ...
    );
h_menu_tut_web = uimenu( ...
    'Parent', h_contextmenu, ...
    'Tag', 'MENU_TUT_WEB', ...
    'Text', 'Web Tutorial ...', ...
    'Enable', 'off', ...
    'MenuSelectedFcn', {@cb_tut_web} ...
    );
h_menu_tut_pdf = uimenu( ...
    'Parent', h_contextmenu, ...
    'Tag', 'MENU_TUT_PDF', ...
    'Text', 'PDF Tutorial ...', ...
    'Enable', 'off', ...
    'MenuSelectedFcn', {@cb_tut_pdf} ...
    );
h_menu_pip_edit = uimenu( ...
    'Separator', 'on', ...
    'Parent', h_contextmenu, ...
    'Tag', 'MENU_PIP_EDIT', ...
    'Text', 'Edit Pipeline ...', ...
    'Enable', 'off', ...
    'MenuSelectedFcn', {@cb_pip_edit} ...
    );
h_menu_pip_clone = uimenu( ...
    'Separator', 'on', ...
    'Parent', h_contextmenu, ...
    'Tag', 'MENU_PIP_CLONE', ...
    'Text', 'Clone Pipeline ...', ...
    'Enable', 'off', ...
    'MenuSelectedFcn', {@cb_pip_clone} ...
    );
    function cb_tut_web(~, ~)
        pipeline = pipelines{get(h_listbox, 'Value')}; %#ok<NASGU> 

disp('TUT WEB')
    end
    function cb_tut_pdf(~, ~)
        pipeline = pipelines{get(h_listbox, 'Value')}; %#ok<NASGU> 

disp('TUT PDF')
    end
    function cb_pip_edit(~, ~)
        pipeline = pipelines{get(h_listbox, 'Value')};

        edit(pipeline.file_name)
    end
    function cb_pip_clone(~, ~)
        pipeline = pipelines{get(h_listbox, 'Value')};


        pip = ImporterPipelineBRAPH2( ...
            'FILE', pipeline.file_name, ...
            'WAITBAR', true ...
            ).get('PIP');

        [path, name, ext] = fileparts(pipeline.file_name);
        cloned_name = ['cloned_' name];

        pip.set( ...
            'ID', cloned_name, ...
            'LABEL', ['Clone of ' pip.get('LABEL')], ...
            'NOTES', ['This is a clone of another pipeline!' newline() ' ' newline() pip.get('NOTES')] ...
            )
        
        cloned_file_name = [path filesep() cloned_name ext];
        ExporterPipelineBRAPH2( ...
            'PIP', pip, ...
            'FILE', cloned_file_name, ...
            'WAITBAR', true ...
            ).get('SAVE')

        edit(cloned_file_name)

        % ensures that the nre pipeline is loaded
        pipelines = get_pipelines();
        update_listbox()
    end

h_label = uilabel( ...
    'Parent', h_panel, ...
    'Tag', 'H_LABEL', ...
    'Tooltip', 'Selected pipeline info', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Text', '', ...
    'Position', [5 0 w(h_panel)-10 h(h_panel)], ...
    'Interpreter', 'html', ...
    'VerticalAlignment', 'top', ...
    'WordWrap', 'on', ...
    'ContextMenu', h_contextmenu ...
    );

h_button = uibutton( ...
    'Parent', f, ...
    'Tag', 'H_BUTTON', ...
    'Tooltip', 'Open selected pipeline ...', ...
    'Enable', 'off', ...
    'Text', 'No selected pipeline', ...
    'FontSize', BRAPH2.FONTSIZE, ...
    'Position', [w(h_axes) .15*h(f) .95*w(f)-w(h_axes) .05*h(f)], ...
    'ButtonPushedFcn', {@cb_button}, ...
    'Interruptible', 'off', ...
    'BusyAction', 'cancel' ...
    ); 
    function cb_button(~, ~)
        pipeline = pipelines{get(h_listbox, 'Value')};

        im = ImporterPipelineBRAPH2(...
            'FILE', pipeline.file_name, ...
            'WAITBAR', true ...
            ); 
        
        pip = im.get('PIP');
        
        gui = GUIElement( ...
            'PE', pip, ...
            'WAITBAR', true, ...
            'CLOSEREQ', true ...
            );
        gui.get('DRAW')
        gui.get('SHOW')
    end

% pipelines
braph2_dir = fileparts(which('braph2'));
pipelines_contents = dir(fullfile(braph2_dir, 'pipelines'));  % get the folder contents
pipelines_dir_list = pipelines_contents([pipelines_contents(:).isdir] == 1);  % remove all files (isdir property is 0)
pipelines_dir_list = pipelines_dir_list(~ismember({pipelines_dir_list(:).name}, {'.', '..'}));  % remove '.' and '..'

pipelines = get_pipelines();
    function pipelines = get_pipelines()
        pipelines = {};

        for dir_number = 1:1:length(pipelines_dir_list)
        
            pipeline_dir = fullfile(pipelines_dir_list(dir_number).folder, pipelines_dir_list(dir_number).name);
            
            files = dir(pipeline_dir); % retrieves all files inside source directory
            for j = 1:1:length(files) % selects all files *.braph2
                file_name = fullfile(files(j).folder, files(j).name);
                if length(file_name) > 7 && strcmp(file_name(end-6:end), '.braph2')
                    p = length(pipelines) + 1;
                    
                    pipelines{p}.index = p; %#ok<*AGROW>
                    pipelines{p}.file_name = file_name;
                    pipelines{p}.id = fileparts(file_name);
                   
                    txt = fileread(file_name);
                    pipelines{p}.txt = txt;
                    
                    header_marks = regexp(txt, '%%', 'all');
                    header_txt = txt(header_marks(1):header_marks(2));
                    header_newlines = regexp(header_txt, newline(), 'all');
                    
                    pipelines{p}.label = strtrim(header_txt(3:header_newlines(1))); % eliminates %%
                    
                    notes = strtrim(header_txt(header_newlines(1) + 4:end - 1));
                    notes_newlines = regexp(notes, newline(), 'all');
                    for k = length(notes_newlines):-1:1
                        notes = [notes(1:notes_newlines(k)) strtrim(notes(notes_newlines(k) + 2:end))]; % eliminates % but not newline
                    end
                    
                    pipelines{p}.pdf = regexp(notes, '/tutorials/pipelines/\w+/\w+\.pdf', 'match', 'once');
                    notes = regexprep(notes, 'PDF:.*$', '');
        % notes = regexprep(notes, 'PDF: (/tutorials/pipelines/\w+/\w+\.pdf)', ['<a href="' BRAPH2.GITHUB '/tree/develop/$1">' which('braph2.m') '$1</a>']);
        % system('open -a Preview /Users/giovannivolpe/Documents/GitHub/Braph-2-Matlab/tutorials/pipelines/tut_a_con_but/tut_a_con_but.pdf')
        % system(['start "" "' pdfPath '"']);
        
                    pipelines{p}.md = regexp(notes, 'README: /tutorials/pipelines/\w+/\w+\.md', 'match', 'once');
                    notes = regexprep(notes, 'README: /tutorials/pipelines/\w+/\w+\.md', '');
        % notes = regexprep(notes, 'README: (/tutorials/pipelines/\w+/\w+\.md)', ['<a href="' BRAPH2.GITHUB '/tree/develop/$1">GitHub Tutorial</a>']);
                
        % notes = [notes newline() '<a href="matlab:edit ' file_name '">Open pipeline in MatLab Editor</a>'];

                    pipelines{p}.notes = strtrim(notes);
                end
            end
        end
    end

update_listbox()
    function update_listbox()
        
        pipeline_labels = cellfun(@(pipeline) pipeline.label, pipelines, 'UniformOutput', false);
        pipeline_indexes = cellfun(@(pipeline) pipeline.index, pipelines);

        input = get(h_editfield, 'Value');
        keywords = cellfun(@(keyword) strrep(keyword, '*', '.*'), strsplit(strtrim(input), ' '), 'UniformOutput', false); % also convert * to its regex equivalent .*
        keywords(cellfun('isempty', keywords)) = [];

        present_all_keywords = true(length(pipeline_labels), 1);
        for dir_number = 1:1:length(pipelines)
            pipeline_txt = lower(pipelines{dir_number}.txt);
            for k = 1:1:length(keywords)
                keyword = lower(keywords{k});
                
                if isempty(regexp(pipeline_txt, keyword, 'once'))
                    present_all_keywords(dir_number) = false;
                    break
                end
            end
        end

        set(h_listbox, ...
            'Value', {}, ...
            'Items', pipeline_labels(present_all_keywords), ...
            'ItemsData', pipeline_indexes(present_all_keywords) ...
            )

        set(h_menu_tut_web, 'Enable', 'off')
        set(h_menu_tut_pdf, 'Enable', 'off')
        set(h_menu_pip_edit, 'Enable', 'off')
        set(h_menu_pip_clone, 'Enable', 'off')

        set(h_label, ...
            'Text', '', ...
            'Position', [5 0 w(h_panel)-10 h(h_panel)] ...
            ); 

        set(h_button, ...
            'Enable', 'off', ...
            'Text', 'No selected pipeline' ...
            )
    end

%% Finalization
drawnow()
set(f, 'Visible', 'on')

if nargout > 0
    f_out = f;
end

end