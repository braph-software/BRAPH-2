function GUIAnalysis(ga)

%% General Constants
APPNAME = GUI.GA_NAME;
BUILD = BRAPH2.BUILD;

% Panels Dimensions
MARGIN_X = .01;
MARGIN_Y = .01;
LEFTCOLUMN_WIDTH = .19;
COHORT_HEIGHT = .11;
TAB_HEIGHT = .20;
FILENAME_HEIGHT = .02;

MAINPANEL_X0 = LEFTCOLUMN_WIDTH + 2 * MARGIN_X;
MAINPANEL_Y0 = FILENAME_HEIGHT + TAB_HEIGHT + 3 * MARGIN_Y;
MAINPANEL_WIDTH = 1 - LEFTCOLUMN_WIDTH - 3 * MARGIN_X;
MAINPANEL_HEIGHT = 1 - TAB_HEIGHT - FILENAME_HEIGHT - 4 * MARGIN_Y;
MAINPANEL_POSITION = [MAINPANEL_X0 MAINPANEL_Y0 MAINPANEL_WIDTH MAINPANEL_HEIGHT];

% Commands
OPEN_CMD = GUI.OPEN_CMD;
OPEN_SC = GUI.OPEN_SC;
OPEN_TP = ['Open Analysis. Shortcut: ' GUI.ACCELERATOR '+' OPEN_SC];

SAVE_CMD = GUI.SAVE_CMD;
SAVE_SC = GUI.SAVE_SC;
SAVE_TP = ['Save current Analysis. Shortcut: ' GUI.ACCELERATOR '+' SAVE_SC];

SAVEAS_CMD = GUI.SAVEAS_CMD;

CLOSE_CMD = GUI.CLOSE_CMD;
CLOSE_SC = GUI.CLOSE_SC;

FIGURE_CMD = GUI.FIGURE_CMD;
FIGURE_SC = GUI.FIGURE_SC;

CLOSE_TP = ['Close ' APPNAME '. Shortcut: ' GUI.ACCELERATOR '+' CLOSE_SC];

initial_number_childs = 0;

%% Application Data
analysis_list = Analysis.getList();
assert(ismember(ga.getClass(), analysis_list), ...
    [BRAPH2.STR ':GUIAnalysis:' BRAPH2.WRONG_INPUT], ...
    'Input is not subclass of Analysis.')

cohort = ga.getCohort();
selected_calc = [];
selected_regionmeasures = [];
selected_brainmeasures = [];
selected_groups = [];

    function cb_open(~, ~)
        % select file
        [file,path,filterindex] = uigetfile(GUI.GA_EXTENSION, GUI.GA_MSG_GETFILE);
        % load file
        if filterindex
            filename = fullfile(path, file);
            temp = load(filename, '-mat', 'ga', 'selected_calc', 'selected_brainmeasures', 'selected_regionmeasures', 'BUILD');
            if isfield(temp, 'BUILD') && temp.BUILD >= 2020 && ...
                    isfield(temp, 'ga') && ...
                    ismember(temp.getClass(), analysis_list)
                ga = temp;
                selected_calc = temp.select_measure;
                setup()
            end
        end
    end
    function cb_save(~, ~)
        filename = get(ui_text_filename, 'String');
        if isempty(filename)
            cb_saveas();
        else
            save(filename, 'ga', 'selected_calc', 'selected_brainmeasures', 'selected_regionmeasures','BUILD');  % prob not cohort
        end
    end
    function cb_saveas(~, ~)
        % select file
        [file, path, filterindex] = uiputfile(GUI.GA_EXTENSION, GUI.GA_MSG_PUTFILE);
        % save file
        if filterindex
            filename = fullfile(path, file);
            save(filename, 'ga', 'selected_calc','selected_calc','selected_regionmeasures', 'BUILD');
            update_filename(filename)
        end
    end


%% GUI Init
f = GUI.init_figure(APPNAME, .9, .9, 'center');
    function init_disable()
        
    end
    function init_enable()
        
    end

%% Text File Name
FILENAME_WIDTH = 1 - 2 * MARGIN_X;
FILENAME_POSITION = [MARGIN_X MARGIN_Y FILENAME_WIDTH FILENAME_HEIGHT];

ui_text_filename = uicontrol('Style', 'text');
init_filename()
    function init_filename()
        GUI.setUnits(ui_text_filename)
        GUI.setBackgroundColor(ui_text_filename)
        
        set(ui_text_filename, 'Position', FILENAME_POSITION)
        set(ui_text_filename, 'HorizontalAlignment', 'left')
    end
    function update_filename(filename)
        set(ui_text_filename, 'String', [filename ' Settings'])
    end

%% Panel Cohort
COHORT_NAME = 'Cohort';
COHORT_WIDTH = LEFTCOLUMN_WIDTH;
COHORT_X0 = MARGIN_X;
COHORT_Y0 = 1 - MARGIN_Y - COHORT_HEIGHT;
COHORT_POSITION = [COHORT_X0 COHORT_Y0+0.01 COHORT_WIDTH COHORT_HEIGHT];

COHORT_BUTTON_SELECT_CMD = 'Select Cohort';
COHORT_BUTTON_SELECT_TP = 'Select file (*.cohort) from where to load a Cohort';

COHORT_BUTTON_VIEW_CMD = 'View Cohort';
COHORT_BUTTON_VIEW_TP = ['Open Cohort with ' GUI.CE_NAME '.'];

SELECTALL_CALC_CMD = GUI.SELECTALL_CMD;
SELECTALL_CALC_TP = 'Select all measures';

CLEARSELECTION_CALC_CMD = GUI.CLEARSELECTION_CMD;
CLEARSELECTION_CALC_TP = 'Clear measure selection';

SELECTGLOBAL_CALC_CMD = 'Select Global';
SELECTGLOBAL_CALC_TP = 'Select all global measures';

SELECTNODAL_CALC_CMD = 'Select Nodal';
SELECTNODAL_CALC_TP = 'Select all nodal measures';

SELECTBINODAL_CALC_CMD = 'Select Binodal';
SELECTBINODAL_CALC_TP = 'Select all Binodal measures';

CALCULATE_CALC_CMD = 'Calculate Group Measures';
CALCULATE_CALC_TP = 'Calculates selected measures for a group';

COMPARE_CALC_CMD = 'Compare Group Measures';
COMPARE_CALC_TP = 'Compares selected measures for two group';

RANDOM_CALC_CMD = 'Compare With Random Graph';
RANDOM_CALC_TP = 'Compares selected measures with a random graph';

ui_panel_cohort = uipanel();
ui_text_cohort_name = uicontrol(ui_panel_cohort, 'Style', 'text');
ui_text_cohort_subjectnumber = uicontrol(ui_panel_cohort, 'Style', 'text');
ui_text_cohort_groupnumber = uicontrol(ui_panel_cohort, 'Style', 'text');
ui_button_cohort = uicontrol(ui_panel_cohort, 'Style', 'pushbutton');
init_cohort()
    function init_cohort()
        GUI.setUnits(ui_panel_cohort)
        GUI.setBackgroundColor(ui_panel_cohort)
        
        set(ui_panel_cohort, 'Position', COHORT_POSITION)
        set(ui_panel_cohort, 'Title', COHORT_NAME)
        
        set(ui_text_cohort_name, 'Position', [.05 .60 .50 .20])
        set(ui_text_cohort_name, 'HorizontalAlignment', 'left')
        set(ui_text_cohort_name, 'FontWeight', 'bold')
        
        set(ui_text_cohort_subjectnumber, 'Position', [.05 .40 .50 .20])
        set(ui_text_cohort_subjectnumber, 'HorizontalAlignment', 'left')
        
        set(ui_text_cohort_groupnumber, 'Position', [.05 .20 .50 .20])
        set(ui_text_cohort_groupnumber, 'HorizontalAlignment', 'left')
        
        set(ui_button_cohort, 'Position', [.55 .30 .40 .40])
        set(ui_button_cohort, 'Callback', {@cb_cohort})
    end
    function update_cohort()
        if ~isempty(cohort) && ~isequal(cohort.getID(), '')
            set(ui_text_cohort_name, 'String', cohort.getID())
            set(ui_text_cohort_subjectnumber, 'String', ['subject number = ' num2str(cohort.getSubjects().length())])
            set(ui_text_cohort_groupnumber, 'String', ['group number = ' num2str(cohort.getGroups().length())])
            set(ui_button_cohort, 'String', COHORT_BUTTON_VIEW_CMD)
            set(ui_button_cohort, 'TooltipString', COHORT_BUTTON_VIEW_TP);
            init_enable()
        else
            set(ui_text_cohort_name, 'String', '- - -')
            set(ui_text_cohort_subjectnumber, 'String', 'subject number = 0')
            set(ui_text_cohort_groupnumber, 'String', 'group number = 0')
            set(ui_button_cohort, 'String', COHORT_BUTTON_SELECT_CMD)
            set(ui_button_cohort, 'TooltipString', COHORT_BUTTON_SELECT_TP);
            init_disable()
        end
    end
    function cb_cohort(src, ~)  % (src,event)
        % missing BUD and BUT compatibility
        if strcmp(get(src, 'String'), COHORT_BUTTON_VIEW_CMD)
            GUICohort(ga.getCohort(), true)  % open atlas with restricted permissions
        else
            try
                % select file
                [file,path,filterindex] = uigetfile(GUI.CE_EXTENSION, GUI.CE_MSG_GETFILE);
                % load file
                if filterindex
                    filename = fullfile(path, file);
                    temp = load(filename, '-mat', 'cohort', 'selected_group', 'selected_subjects', 'BUILD');
                    if isfield(temp, 'BUILD') && temp.BUILD >= 2020 && ...
                            isfield(temp, 'cohort') && isa(temp.cohort, 'Cohort') && ...
                            isfield(temp, 'selected_group') && isfield(temp, 'selected_subjects')
                        cohort = temp.cohort;
                        analysis = ga.getClass();
                        ga = Analysis.getAnalysis(analysis, ['Empty GA with ' cohort.getID()], '', '', cohort, {}, {}, {});
                    end
                    setup()
                end
            catch ME
                errordlg(ME.error)
                %                 errordlg('The file is not a valid Cohort file. Please load a valid .cohort file');
            end
        end
    end

%% Panel - Calculation panel
SET_WIDTH = LEFTCOLUMN_WIDTH;
SET_HEIGHT = 1 - COHORT_HEIGHT - MARGIN_Y;
SET_X0 = MARGIN_X;
SET_Y0 =  MARGIN_Y;
CALC_POSITION = [SET_X0 SET_Y0 SET_WIDTH SET_HEIGHT];

TAB_NODAL = 'Global';
TAB_GLOBAL = 'Nodal';
TAB_BINODAL = 'Binodal';

TAB_UNILAYER = 'Unilayer';
TAB_BILAYER = 'Bilayer';
TAB_SUPERGLOBAL = 'Super Global';

ui_calc_panel = uipanel();
ui_calc_analysis_id = uicontrol(ui_calc_panel, 'Style', 'edit');
ui_calc_analysis_label = uicontrol(ui_calc_panel, 'Style', 'edit');
ui_calc_analysis_notes = uicontrol(ui_calc_panel, 'Style', 'edit');
ui_calc_settings_panel = uipanel(ui_calc_panel);
ui_calc_table = uitable(ui_calc_panel);
ui_calc_selectall_button = uicontrol(ui_calc_panel, 'Style', 'pushbutton');
ui_calc_clear_button = uicontrol(ui_calc_panel, 'Style', 'pushbutton');
ui_calc_global_button = uicontrol(ui_calc_panel, 'Style', 'pushbutton');
ui_calc_nodal_button = uicontrol(ui_calc_panel, 'Style', 'pushbutton');
ui_calc_binodal_button = uicontrol(ui_calc_panel, 'Style', 'pushbutton');
ui_calc_comparison_button = uicontrol(ui_calc_panel, 'Style', 'pushbutton');
ui_calc_randomcomparison_button = uicontrol(ui_calc_panel, 'Style', 'pushbutton');
ui_calc_measurement_button = uicontrol(ui_calc_panel, 'Style', 'pushbutton');
init_calc()
    function init_calc()
        GUI.setUnits(ui_calc_panel)
        GUI.setBackgroundColor(ui_calc_panel)
        
        set(ui_calc_panel, 'Position', CALC_POSITION)
        set(ui_calc_panel, 'BorderType', 'none')
        
        set(ui_calc_analysis_id, 'Position', [0 .95 .36 .03])
        set(ui_calc_analysis_id, 'HorizontalAlignment', 'left')
        set(ui_calc_analysis_id, 'FontWeight', 'bold')
        set(ui_calc_analysis_id, 'Callback', {@cb_calc_ga_id})
        
        set(ui_calc_analysis_label, 'Position', [.42 .95 .56 .03])
        set(ui_calc_analysis_label, 'HorizontalAlignment', 'left')
        set(ui_calc_analysis_label, 'FontWeight', 'bold')
        set(ui_calc_analysis_label, 'Callback', {@cb_calc_ga_label})
        
        set(ui_calc_analysis_notes, 'Position', [.42 .90 .56 .03])
        set(ui_calc_analysis_notes, 'HorizontalAlignment', 'left')
        set(ui_calc_analysis_notes, 'FontWeight', 'bold')
        set(ui_calc_analysis_notes, 'Callback', {@cb_calc_ga_notes})
        
        set(ui_calc_settings_panel, 'Position', [0 0.64 0.98 .25])
        set(ui_calc_settings_panel, 'Title', 'Analysis Settings')
        set(ui_calc_settings_panel, 'Units', 'normalized')
        
        set(ui_calc_table, 'Position', [0 0.27 0.98 .35])
        set(ui_calc_table, 'Units', 'normalized')
        set(ui_calc_table, 'ColumnName', {'', '   Brain Measure   ',' Format ', ' Scope ', '   Notes   '})
        set(ui_calc_table, 'ColumnFormat', {'logical', 'char', {TAB_NODAL TAB_GLOBAL TAB_BINODAL}, {TAB_UNILAYER TAB_BILAYER TAB_SUPERGLOBAL} , 'char'})
        set(ui_calc_table, 'ColumnEditable', [true false false false false])
        set(ui_calc_table, 'CellEditCallback', {@cb_calc_edit});
        
        set(ui_calc_selectall_button, 'Position', [.02 .23 .47 .03])
        set(ui_calc_selectall_button, 'String', SELECTALL_CALC_CMD)
        set(ui_calc_selectall_button, 'TooltipString', SELECTALL_CALC_TP)
        set(ui_calc_selectall_button, 'Callback', {@cb_calc_selectall})
        
        set(ui_calc_clear_button, 'Position', [.51 .23 .47 .03])
        set(ui_calc_clear_button, 'String', CLEARSELECTION_CALC_CMD)
        set(ui_calc_clear_button, 'TooltipString', CLEARSELECTION_CALC_TP)
        set(ui_calc_clear_button, 'Callback', {@cb_calc_clearselection})
        
        set(ui_calc_global_button, 'Position', [.02 .20 .47 .03])
        set(ui_calc_global_button, 'String', SELECTGLOBAL_CALC_CMD)
        set(ui_calc_global_button, 'TooltipString', SELECTGLOBAL_CALC_TP)
        set(ui_calc_global_button, 'Callback', {@cb_calc_global})
        
        set(ui_calc_nodal_button, 'Position', [.51 .20 .47 .03])
        set(ui_calc_nodal_button, 'String', SELECTNODAL_CALC_CMD)
        set(ui_calc_nodal_button, 'TooltipString', SELECTNODAL_CALC_TP)
        set(ui_calc_nodal_button, 'Callback', {@cb_calc_nodal})
        
        set(ui_calc_binodal_button, 'Position', [.51 .17 .47 .03])
        set(ui_calc_binodal_button, 'String', SELECTBINODAL_CALC_CMD)
        set(ui_calc_binodal_button, 'TooltipString', SELECTBINODAL_CALC_TP)
        set(ui_calc_binodal_button, 'Callback', {@cb_calc_binodal})
        
        set(ui_calc_measurement_button, 'Position', [.02 .12 .96 .045])
        set(ui_calc_measurement_button, 'String', CALCULATE_CALC_CMD)
        set(ui_calc_measurement_button, 'TooltipString', CALCULATE_CALC_TP)
        set(ui_calc_measurement_button, 'Callback', {@cb_calc_calculate})
        
        set(ui_calc_comparison_button, 'Position', [.02 .08 .96 .045])
        set(ui_calc_comparison_button, 'String', COMPARE_CALC_CMD)
        set(ui_calc_comparison_button, 'TooltipString', COMPARE_CALC_TP)
        set(ui_calc_comparison_button, 'Callback', {@cb_calc_compare})
        
        set(ui_calc_randomcomparison_button, 'Position', [.02 .04 .96 .045])
        set(ui_calc_randomcomparison_button, 'String', RANDOM_CALC_CMD)
        set(ui_calc_randomcomparison_button, 'TooltipString', RANDOM_CALC_TP)
        set(ui_calc_randomcomparison_button, 'Callback', {@cb_calc_random})
        
        available_settings = ga.getAvailableSettings();
        texts = zeros(length(available_settings), 1);
        fields =  zeros(length(available_settings), 1);
        inner_panel_height = 1/length(available_settings);
        subject = ga.getSubjectClass();
        dc = Subject.getDataCodes(subject);
        
        for j = 1:1:length(available_settings)
            as = available_settings{j};
            y_correction = 0.2;
            inner_panel_y = 1 - j * inner_panel_height + y_correction;
            
            texts(j, 1) = uicontrol('Parent', ui_calc_settings_panel, 'Style', 'text', ...
                'Units', 'normalized', 'FontSize', 10, 'HorizontalAlignment', 'left', 'Position', [0.01 inner_panel_y-0.02 0.50 0.1], ...
                'String', erase(as{1,1}, ['Analysis' dc{1} '.']), 'enable', 'off');
            
            fields(j, 1) = uicontrol('Parent', ui_calc_settings_panel,  ...
                'Units', 'normalized', 'Position', [0.58 inner_panel_y+0.04 0.40 0.03] );
            
            if isequal(as{1, 2}, 1) % string
                set(fields(j, 1), 'Style', 'popup');
                set(fields(j, 1), 'String', ga.getSettings(as{1,1}))
                set(fields(j, 1), 'HorizontalAlignment', 'left')
                set(fields(j, 1), 'FontWeight', 'bold')
                set(fields(j, 1), 'enable', 'off')
                
            elseif isequal(as{1, 2}, 2) % numerical
                set(fields(j, 1), 'Style', 'edit');
                set(fields(j, 1), 'String', ga.getSettings(as{1,1}))  % put default
                set(fields(j, 1), 'enable', 'off')
            else % logical
                set(fields(j, 1), 'Style', 'popup');
                set(fields(j, 1), 'String', ga.getSettings(as{1,1}))
                set(fields(j, 1), 'enable', 'off')
            end
        end
        
    end
    function update_set_ga_id()
        if isempty(ga.getID())
            set(f, 'Name', GUI.GA_NAME)
        else
            set(f, 'Name', [GUI.GA_NAME ' - ' ga.getID()])
        end
        set(ui_calc_analysis_id, 'String', ga.getID())
    end
    function cb_calc_ga_id(~, ~)
        ga.setID(get(ui_calc_analysis_id, 'String'))
        update_set_ga_id()
    end
    function cb_calc_ga_label(~, ~)
        ga.setLabel(get(ui_calc_analysis_label, 'String'))
    end
    function cb_calc_ga_notes(~, ~)
        ga.setNotes(get(ui_calc_analysis_notes, 'String'))
    end
    function update_tab()
        mlist = measurelist();
        
        data = cell(length(mlist), 3);
        for mi = 1:1:length(mlist)
            if any(selected_calc == mi)
                data{mi, 1} = true;
            else
                data{mi, 1} = false;
            end
            data{mi, 2} = Measure.getName(mlist{mi});
            if Measure.is_nodal(mlist{mi})
                data{mi, 3} = TAB_NODAL;
            elseif Measure.is_global(mlist{mi})
                data{mi, 3} = TAB_GLOBAL;
            else
                data{mi, 3} = TAB_BINODAL;
            end
            
            if Measure.is_superglobal(mlist{mi})
                data{mi, 4} = TAB_SUPERGLOBAL;
            elseif Measure.is_unilayer(mlist{mi})
                data{mi, 4} = TAB_UNILAYER;
            else
                data{mi, 4} = TAB_BILAYER;
            end
            
            data{mi, 5} = Measure.getDescription(mlist{mi});
        end
        set(ui_calc_table, 'Data', data)
    end
    function mlist = measurelist()
        mlist = Graph.getCompatibleMeasureList(ga.getGraphType());
    end
    function cb_calc_edit(~, event)
    end
    function cb_calc_selectall(~, ~)
        mlist = measurelist();
        selected_calc = (1:1:length(mlist))';
        update_tab()
    end
    function cb_calc_clearselection(~, ~)
        selected_calc = [];
        update_tab()
    end
    function cb_calc_global(~, ~)
        selected_calc = [];
        mlist = measurelist();
        for mi = 1:1:length(mlist)
            if Measure.is_global(mlist{mi})
                selected_calc = [selected_calc; mi]; %#ok<AGROW>
            end
        end
        update_tab()
    end
    function cb_calc_nodal(~, ~)
        selected_calc = [];
        mlist = measurelist();
        for mi = 1:1:length(mlist)
            if Measure.is_nodal(mlist{mi})
                selected_calc = [selected_calc; mi]; %#ok<AGROW>
            end
        end
        update_tab()
    end
    function cb_calc_binodal(~, ~)
        selected_calc = [];
        mlist = measurelist();
        for mi = 1:1:length(mlist)
            if Measure.is_binodal(mlist{mi})
                selected_calc = [selected_calc; mi]; %#ok<AGROW>
            end
        end
        update_tab()
    end
    function cb_calc_calculate(~, ~)
        group = ga.getCohort().getGroups().getValue(selected_groups);
        mlist = measurelist();
        mlist = mlist(selected_calc);
        for j = 1:1:length(selected_calc)
            measure_code = mlist{j};
            ga.getMeasure(measure_code, group);
        end
    end
    function cb_calc_compare(~, ~)
        groups = cell(length(seleted_groups), 1);
        for j = 1:1:length(selected_groups)
            groups{j} = ga.getCohort().getGroups().getValue(selected_groups{j});
        end
        
        mlist = measurelist();
        mlist = mlist(selected_calc);
        for j  = 1:1:length(selected_calc)
            measure_code = mlist{j};
            ga.getComparison(measure_code, groups);
        end
    end
    function cb_calc_random(~, ~)
        group = ga.getCohort().getGroups().getValue(selected_groups);
        mlist = measurelist();
        mlist = mlist(selected_calc);
        for j = 1:1:length(selected_calc)
            measure_code = mlist{j};
            ga.getRandomComparison(measure_code, group);
        end
    end

%% Menus
MENU_FILE = GUI.MENU_FILE;
MENU_FIGURE = 'Figure';

ui_menu_file = uimenu(f, 'Label', MENU_FILE);
ui_menu_file_open = uimenu(ui_menu_file);
ui_menu_file_save = uimenu(ui_menu_file);
ui_menu_file_saveas = uimenu(ui_menu_file);
ui_menu_file_close = uimenu(ui_menu_file);
ui_menu_plotview = uimenu(f,  'Label',  'Plot View');
ui_menu_plotview_figure = uimenu(ui_menu_plotview);
init_menu()
    function init_menu()
        set(ui_menu_file_open, 'Label', OPEN_CMD)
        set(ui_menu_file_open, 'Accelerator', OPEN_SC)
        set(ui_menu_file_open, 'Callback', {@cb_open})
        
        set(ui_menu_file_save, 'Separator', 'on')
        set(ui_menu_file_save, 'Label', SAVE_CMD)
        set(ui_menu_file_save, 'Accelerator', SAVE_SC)
        set(ui_menu_file_save, 'Callback', {@cb_save})
        
        set(ui_menu_file_saveas, 'Label', SAVEAS_CMD)
        set(ui_menu_file_saveas, 'Callback', {@cb_saveas});
        
        set(ui_menu_file_close, 'Separator', 'on')
        set(ui_menu_file_close, 'Label', CLOSE_CMD)
        set(ui_menu_file_close, 'Accelerator', CLOSE_SC);
        set(ui_menu_file_close, 'Callback', ['GUI.close(''' APPNAME ''',  gcf)'])
        
        set(ui_menu_plotview_figure, 'Label', FIGURE_CMD)
        set(ui_menu_plotview_figure, 'Accelerator', FIGURE_SC)
        set(ui_menu_plotview_figure, 'Callback', {@cb_menu_figure})
        
    end
[ui_menu_about,  ui_menu_about_about] = GUI.setMenuAbout(f, APPNAME);
    function cb_menu_figure(~,  ~)  % (src,  event)
        h = figure('Name', ['Correlation Matrix - ' ga.getName()]);
        set(gcf, 'Color', 'w')
        copyobj(ui_matrix_axes, h)
        set(gca, 'Units', 'normalized')
        set(gca, 'OuterPosition', [0 0 1 1])
    end

%% Toolbar
set(f,  'Toolbar', 'figure')
ui_toolbar = findall(f, 'Tag', 'FigureToolBar');
ui_toolbar_open = findall(ui_toolbar, 'Tag', 'Standard.FileOpen');
ui_toolbar_save = findall(ui_toolbar, 'Tag', 'Standard.SaveFigure');
init_toolbar()
    function init_toolbar()
        delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
        % delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))
        % delete(findall(ui_toolbar, 'Tag', 'Standard.SaveFigure'))
        delete(findall(ui_toolbar, 'Tag', 'Standard.PrintFigure'))
        delete(findall(ui_toolbar, 'Tag', 'Standard.EditPlot'))
        %delete(findall(ui_toolbar, 'Tag', 'Exploration.ZoomIn'))
        %delete(findall(ui_toolbar, 'Tag', 'Exploration.ZoomOut'))
        %delete(findall(ui_toolbar, 'Tag', 'Exploration.Pan'))
        delete(findall(ui_toolbar, 'Tag', 'Exploration.Rotate'))
        %delete(findall(ui_toolbar, 'Tag', 'Exploration.DataCursor'))
        delete(findall(ui_toolbar, 'Tag', 'Exploration.Brushing'))
        delete(findall(ui_toolbar, 'Tag', 'DataManager.Linking'))
        %delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertColorbar'))
        delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertLegend'))
        delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOff'))
        delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOn'))
        
        set(ui_toolbar_open, 'TooltipString', OPEN_TP);
        set(ui_toolbar_open, 'ClickedCallback', {@cb_open})
        set(ui_toolbar_save, 'TooltipString', SAVE_TP);
        set(ui_toolbar_save, 'ClickedCallback', {@cb_save})
    end

%% Make the GUI visible.
setup()
set(f, 'Visible', 'on');

%% Auxiliary functions
    function setup()
        % setup cohort
        update_cohort()
        
        %         % setup graph analysis
        update_tab()
        %         update_matrix()
        
        %         % setup data
        %         update_set_ga_id()
    end
end