function GUICohort(tmp, sub_class, restricted)
% GUICohort Cohort Editor
%
% GUICOHORT(SUBJECT_CLASS) opens an empty cohort with empty atlas for SUBJECT_CLASS type 
%
% GUICOHORT(COHORT) opens a cohort
%
% GUICOHORT(COHORT, TRUE) opens a cohort with only reading and basic writing

APPNAME  = GUI.CE_NAME;  % application name
BUILD = BRAPH2.BUILD;

% Dimensions
MARGIN_X = .01;
MARGIN_Y = .01;
LEFTCOLUMN_WIDTH = .29;
HEADING_HEIGHT = .12;
FILENAME_HEIGHT = .02;

ATLAS_WIDTH = LEFTCOLUMN_WIDTH;
ATLAS_HEIGHT = HEADING_HEIGHT;
ATLAS_X0 = MARGIN_X;
ATLAS_Y0 = 1 - MARGIN_Y - ATLAS_HEIGHT;
ATLAS_POSITION = [ATLAS_X0 ATLAS_Y0 ATLAS_WIDTH ATLAS_HEIGHT];

CONSOLE_X0 = LEFTCOLUMN_WIDTH + (2 * MARGIN_X);
CONSOLE_Y0 = ATLAS_Y0 + 0.06;
CONSOLE_WIDTH = 1 - LEFTCOLUMN_WIDTH - 3 * MARGIN_X;
CONSOLE_HEIGHT = HEADING_HEIGHT / 2 ;
CONSOLE_POSITION = [CONSOLE_X0 CONSOLE_Y0 CONSOLE_WIDTH CONSOLE_HEIGHT];


GROUPPANEL_X0 = LEFTCOLUMN_WIDTH + (2 * MARGIN_X);
GROUPPANEL_Y0 = FILENAME_HEIGHT + MARGIN_Y; % 1 - CONSOLE_Y0 + CONSOLE_HEIGHT; 
GROUPPANEL_WIDTH = 1 - LEFTCOLUMN_WIDTH - 3 * MARGIN_X;
GROUPPANEL_HEIGHT = 1 - CONSOLE_HEIGHT - FILENAME_HEIGHT - 3*MARGIN_Y;  % must be 9 1 - FILENAME_HEIGHT - (2 * MARGIN_Y)
GROUPPANEL_POSITION = [GROUPPANEL_X0 GROUPPANEL_Y0 GROUPPANEL_WIDTH GROUPPANEL_HEIGHT];

% Commands
OPEN_CMD = GUI.OPEN_CMD; 
OPEN_SC = GUI.OPEN_SC;
OPEN_TP = ['Open Cohort. Shortcut: ' GUI.ACCELERATOR '+' OPEN_SC];

SAVE_CMD = GUI.SAVE_CMD;
SAVE_SC = GUI.SAVE_SC;
SAVE_TP = ['Save current Cohort. Shortcut: ' GUI.ACCELERATOR '+' SAVE_SC];

SAVEAS_CMD = GUI.SAVEAS_CMD;

IMPORT_TXT_CMD = GUI.IMPORT_TXT_CMD;
IMPORT_TXT_TP = 'Import cohort from a txt file (tab-delimited text file)';

IMPORT_XLS_CMD = GUI.IMPORT_XLS_CMD;
IMPORT_XLS_TP = 'Import cohort from an Excel file';

IMPORT_JSON_CMD = GUI.IMPORT_JSON_CMD;
IMPORT_JSON_TP = 'Import cohort from a json file.';

EXPORT_TXT_CMD = GUI.EXPORT_TXT_CMD;
EXPORT_TXT_TP = 'Export cohort as a txt file (tab-delimited text file)';

EXPORT_XLS_CMD = GUI.EXPORT_XLS_CMD;
EXPORT_XLS_TP = 'Export cohort as a xls file.';

EXPORT_JSON_CMD = GUI.EXPORT_JSON_CMD;
EXPRT_JSON_TP = 'Export cohort as a json file.';

CLOSE_CMD = GUI.CLOSE_CMD;
CLOSE_SC = GUI.CLOSE_SC;
CLOSE_TP = ['Close ' APPNAME '. Shortcut: ' GUI.ACCELERATOR '+' CLOSE_SC];
ADD_GR_CMD = GUI.ADD_CMD;
ADD_GR_TP = 'Add group at the end of table';

REMOVE_GR_CMD = GUI.REMOVE_CMD;
REMOVE_GR_TP = 'Remove selected group';

MOVEUP_GR_CMD = GUI.MOVEUP_CMD;
MOVEUP_GR_TP = 'Move selected group up';

MOVEDOWN_GR_CMD = GUI.MOVEDOWN_CMD;
MOVEDOWN_GR_TP = 'Move selected group down';

GROUPPANEL_CMD = 'Subjects';
SELECTALL_SUB_CMD = 'Select all';
SELECTALL_SUB_TP = 'Select all subjects';

CLEARSELECTION_SUB_CMD = 'Clear selection';
CLEARSELECTION_SUB_TP = 'Clear subject selection';

ADD_SUB_CMD = 'Add subject';
ADD_SUBJECTS_TP = 'Add subject at the end of table';

CREATE_GRP_FROM_SUBS_CMD = 'Create group';
CREATE_GRP_FROM_SUBS_TP = 'Create group from selection of subjects';

REMOVE_SUB_CMD = 'Remove';
REMOVE_SUB_TP = 'Remove selected subjects from the cohort and all groups';

MOVEUP_SUB_CMD = 'Move up';
MOVEUP_SUB_TP = 'Move selected subjects up';

MOVEDOWN_SUB_CMD = 'Move down';
MOVEDOWN_SUB_TP = 'Move selected subjects down';

MOVE2TOP_SUB_CMD = 'Move to top';
MOVE2TOP_SUB_TP = 'Move selected subjects to top of table';

MOVE2BOTTOM_SUB_CMD = 'Move to bottom';
MOVE2BOTTOM_SUB_TP = 'Move selected subjects to bottom of table';

%% Application Data
if exist('tmp', 'var') && isa(tmp, 'Cohort')
    cohort = tmp;
elseif exist('tmp', 'var') && isa(tmp,'BrainAtlas')  && exist('sub_class', 'var')  % case with atlas  
    atlas = tmp;
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', sub_class, atlas, {});    
else % case with string corresponding to subject class
    assert(ismember(tmp, Subject.getList()));
    atlas = BrainAtlas('Empty BA', 'Brain Atlas Label', 'Brain atlas notes.', 'BrainMesh_ICBM152.nv', {});
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', tmp, atlas, {});
end

selected_group = [];
selected_subjects = [];

% Callbacks to manage application data
    function cb_open(~, ~)  % (src, event)
        % select file
        [file, path, filterindex] = uigetfile(GUI.CE_EXTENSION, GUI.CE_MSG_GETFILE);
        % load file
        if filterindex
            filename = fullfile(path, file);
            tmp = load(filename, '-mat', 'cohort', 'selected_group', 'selected_subjects', 'BUILD');
            if isfield(tmp, 'BUILD') && tmp.BUILD >= 2020 && ...
                    isfield(tmp, 'cohort') && isa(tmp.cohort, 'Cohort') && ...
                    isfield(tmp, 'selected_group') && isfield(tmp, 'selected_subjects')
                cohort = tmp.cohort;
                selected_group = tmp.selected_group;
                selected_subjects = tmp.selected_subjects;
                setup()
                update_filename(filename)
            end
        end
    end
    function cb_save(~, ~)  % (src, event)
        filename = get(ui_text_filename, 'String');
        if isempty(filename)
            cb_saveas();
        else
            save(filename, 'cohort', 'selected_group', 'selected_subjects', 'BUILD');
        end
    end
    function cb_saveas(~, ~)  % (src, event)
        % select file
        [file, path, filterindex] = uiputfile(GUI.CE_EXTENSION, GUI.CE_MSG_PUTFILE);
        % save file
        if filterindex
            filename = fullfile(path, file);
            save(filename, 'cohort', 'selected_group', 'selected_subjects', 'BUILD');
            update_filename(filename)
        end
    end
    function cb_import_txt(~, ~)  % (scr, event)
        cohortstmp = eval([cohort.getSubjectClass()  '.load_from_txt(cohort)']);
        if ~isempty(cohortstmp)
            cohort = cohortstmp;
            selected_group = [];
            selected_subjects = [];
            setup()
            update_filename('')
            init_enable()
        end
    end
    function cb_import_xls(~, ~)  % (scr, event)
        cohortstmp = eval([cohort.getSubjectClass()  '.load_from_xls(cohort)']);
        if  ~isempty(cohortstmp)
            cohort = cohortstmp;
            selected_group = [];            
            selected_subjects = [];
            setup()
            update_filename('')
            init_enable()
        end
    end
    function cb_import_json(~, ~)  % (src, event)
        cohortstmp = eval([cohort.getSubjectClass()  '.load_from_json(cohort)']);
        if ~isempty(cohortstmp)
            cohort = cohortstmp;
            selected_group = [];
            selected_subjects = [];
            setup()
            update_filename('')
            init_enable()
        end
    end
    function cb_export_txt(~, ~)  % (scr, event)
        eval([cohort.getSubjectClass() '.save_to_txt(cohort)']);
    end
    function cb_export_xls(~, ~)  % (src, event)
        eval([cohort.getSubjectClass() '.save_to_xls(cohort)']);
    end
    function cb_export_json(~, ~)  % (src, event)
        eval([cohort.getSubjectClass() '.save_to_json(cohort)']);
    end

%% GUI Initialization
f = GUI.init_figure(APPNAME, .8, .9, 'center');

    function init_disable()
        GUI.disable(ui_panel_grtab)
        GUI.disable(ui_panel_groups)
        GUI.disable(ui_panel_console)
        set(ui_menu_groups, 'enable', 'off')
        set(ui_menu_subjects, 'enable', 'off')         
    end
    function init_enable()
        GUI.enable(ui_panel_grtab)        
        set(ui_menu_groups, 'enable', 'on')
        set(ui_menu_subjects, 'enable', 'on')
        if cohort.getSubjects().length() > 0
            GUI.enable(ui_panel_console)
            GUI.enable(ui_panel_groups)
        end
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
        set(ui_text_filename, 'String', filename)
    end

%% Panel Atlas
ATLAS_NAME = 'Brain Atlas';

ATLAS_BUTTON_SELECT_CMD = 'Select Atlas';
ATLAS_BUTTON_SELECT_TP = 'Select brain atlas';
ATLAS_BUTTON_SELECT_MSG = 'Select file (*.atlas) from where to load brain atlas.';

ATLAS_BUTTON_VIEW_CMD = 'View Atlas';
ATLAS_BUTTON_VIEW_TP = ['Open brain atlas with ' GUI.BAE_NAME];

ui_panel_atlas = uipanel();
ui_text_atlas_name = uicontrol(ui_panel_atlas, 'Style', 'text');
ui_text_atlas_brnumber = uicontrol(ui_panel_atlas, 'Style', 'text');
ui_button_atlas = uicontrol(ui_panel_atlas, 'Style', 'pushbutton');
init_atlas()
    function init_atlas()
        GUI.setUnits(ui_panel_atlas)
        GUI.setBackgroundColor(ui_panel_atlas)
        
        set(ui_panel_atlas, 'Position', ATLAS_POSITION)
        set(ui_panel_atlas, 'Title', ATLAS_NAME)
        
        set(ui_text_atlas_name, 'Position', [.10 .50 .40 .20])
        set(ui_text_atlas_name, 'HorizontalAlignment', 'left')
        set(ui_text_atlas_name, 'FontWeight', 'bold')
        
        set(ui_text_atlas_brnumber, 'Position', [.10 .30 .40 .20])
        set(ui_text_atlas_brnumber, 'HorizontalAlignment', 'left')

        set(ui_button_atlas, 'Position', [.55 .30 .40 .40])
        set(ui_button_atlas, 'Callback', {@cb_atlas})
    end
    function update_atlas()
        atlastmp_array = cohort.getBrainAtlases();
        atlastmp = atlastmp_array{1};
        if ~isequal(atlastmp.getID(), 'Empty BA') 
            atlases = cohort.getBrainAtlases();
            atlas_hold = atlases{1};
            set(ui_text_atlas_name, 'String', atlas_hold.getID())
            set(ui_text_atlas_brnumber, 'String', ['brain region number = ' int2str(atlas_hold.getBrainRegions().length())])
            set(ui_button_atlas, 'String', ATLAS_BUTTON_VIEW_CMD)
            set(ui_button_atlas, 'TooltipString', ATLAS_BUTTON_VIEW_TP);
            init_enable()
        else
            set(ui_text_atlas_name, 'String', '- - -')
            set(ui_text_atlas_brnumber, 'String', 'brain region number = 0')
            set(ui_button_atlas, 'String', ATLAS_BUTTON_SELECT_CMD)
            set(ui_button_atlas, 'TooltipString', ATLAS_BUTTON_SELECT_TP);
            init_disable()
        end
    end
    function cb_atlas(src, ~)  % (src,event)
        if strcmp(get(src, 'String'), ATLAS_BUTTON_VIEW_CMD)
            atlases = cohort.getBrainAtlases();
            atlas_hold = atlases{1};
            GUIBrainAtlas(atlas_hold, true)  % open atlas with restricted permissions
        else  % clears also the cohort
            % select file
            [file, path, filterindex] = uigetfile(GUI.BAE_EXTENSION, GUI.BAE_MSG_GETFILE);
            
            % load file
            if filterindex
                filename = fullfile(path, file);
                temp = load(filename, '-mat', 'atlas');
                if isa(temp.atlas, 'BrainAtlas')
                    atlas = temp.atlas;
                    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', tmp, atlas, {});
                    setup()
                end
            end
        end
    end

%% Panel Groups Table
GRTAB_SELECTED_COL = 1;
GRTAB_NAME_COL = 2;
GRTAB_SUBN_COL = 3;
GRTAB_LBL_COL = 4;
GRTAB_NOTES_COL = 5;

GRTAB_WIDTH = LEFTCOLUMN_WIDTH;
GRTAB_HEIGHT = .947 - ATLAS_HEIGHT;
GRTAB_X0 = MARGIN_X;
GRTAB_Y0 = FILENAME_HEIGHT + 2 * MARGIN_Y;
GRTAB_POSITION = [GRTAB_X0 GRTAB_Y0 GRTAB_WIDTH GRTAB_HEIGHT];

GRTAB_LOAD_XLS_CMD = 'Load subject group from xls ...';
GRTAB_LOAD_XLS_TP = 'Load subjects from XLS file. All subjects will be in the same (new) group';

GRTAB_LOAD_TXT_CMD = 'Load subject group from txt ...';
GRTAB_LOAD_TXT_TP = 'Load subjects from TXT file. All subjects will be in the same (new) group';

GRTAB_LOAD_JSON_CMD = 'Load subject group from json ...';
GRTAB_LOAD_JSON_TP = 'Load subjects from JSON file. All subjects will be in the same (new) group';

GRTAB_NOT_CMD = 'Complementary';
GRTAB_NOT_TP = 'Complementary of group';

GRTAB_MERGE_CMD = 'Merge';
GRTAB_MERGE_TP = 'Merge two groups';

GRTAB_INTERSECT_CMD = 'Intersect';
GRTAB_INTERSECT_TP = 'Intersect two groups';

ui_panel_grtab = uipanel();
ui_edit_grtab_cohortid = uicontrol(ui_panel_grtab, 'Style', 'edit');
ui_edit_grtab_cohortlabel = uicontrol(ui_panel_grtab, 'Style', 'edit');
ui_edit_grtab_cohortnotes = uicontrol(ui_panel_grtab, 'Style', 'edit');
ui_label_grtab_subject = uicontrol(ui_panel_grtab, 'Style', 'text');
ui_button_grtab_load_xls = uicontrol(ui_panel_grtab, 'Style', 'pushbutton');
ui_button_grtab_load_txt = uicontrol(ui_panel_grtab, 'Style', 'pushbutton');
ui_button_grtab_load_json = uicontrol(ui_panel_grtab, 'Style', 'pushbutton');
ui_table_grtab = uitable(ui_panel_grtab);
ui_button_grtab_add_gr = uicontrol(ui_panel_grtab, 'Style', 'pushbutton');
ui_button_grtab_remove_gr = uicontrol(ui_panel_grtab, 'Style', 'pushbutton');
ui_button_grtab_moveup_gr = uicontrol(ui_panel_grtab, 'Style', 'pushbutton');
ui_button_grtab_movedown_gr = uicontrol(ui_panel_grtab, 'Style', 'pushbutton');
ui_popup_grtab_invert = uicontrol(ui_panel_grtab,'Style', 'popup', 'String', {''});
ui_button_grtab_invert = uicontrol(ui_panel_grtab,'Style', 'pushbutton');
ui_popup_grtab_merge1 = uicontrol(ui_panel_grtab,'Style', 'popup', 'String', {''});
ui_popup_grtab_merge2 = uicontrol(ui_panel_grtab, 'Style', 'popup', 'String', {''});
ui_button_grtab_merge = uicontrol(ui_panel_grtab, 'Style', 'pushbutton');
ui_popup_grtab_intersect1 = uicontrol(ui_panel_grtab, 'Style', 'popup', 'String', {''});
ui_popup_grtab_intersect2 = uicontrol(ui_panel_grtab, 'Style', 'popup', 'String', {''});
ui_button_grtab_intersect = uicontrol(ui_panel_grtab, 'Style', 'pushbutton');
init_grtab()
    function init_grtab()
        GUI.setUnits(ui_panel_grtab)
        GUI.setBackgroundColor(ui_panel_grtab)

        set(ui_panel_grtab, 'Position',GRTAB_POSITION)
        set(ui_panel_grtab, 'BorderType', 'none')

        set(ui_edit_grtab_cohortid, 'Position', [.02 .95 .36 .03])
        set(ui_edit_grtab_cohortid, 'HorizontalAlignment', 'left')
        set(ui_edit_grtab_cohortid, 'FontWeight', 'bold')
        set(ui_edit_grtab_cohortid, 'Callback', {@cb_grtab_cohortname})
        
        set(ui_edit_grtab_cohortlabel, 'Position', [.42 .95 .56 .03])
        set(ui_edit_grtab_cohortlabel, 'HorizontalAlignment', 'left')
        set(ui_edit_grtab_cohortlabel, 'FontWeight', 'bold')
        set(ui_edit_grtab_cohortlabel, 'Callback', {@cb_grtab_cohortlabel})
        
        set(ui_edit_grtab_cohortnotes, 'Position', [.42 .90 .56 .03])
        set(ui_edit_grtab_cohortnotes, 'HorizontalAlignment', 'left')
        set(ui_edit_grtab_cohortnotes, 'FontWeight', 'bold')
        set(ui_edit_grtab_cohortnotes, 'Callback', {@cb_grtab_cohortnotes})
        
        set(ui_label_grtab_subject, 'Position', [.02 .90 .36 .03])
        set(ui_label_grtab_subject, 'HorizontalAlignment', 'left')
        set(ui_label_grtab_subject, 'TooltipString', eval([cohort.getSubjectClass() '.getDescription()']))
        set(ui_label_grtab_subject, 'enable', 'off')

        set(ui_button_grtab_load_xls, 'Position',[.02 .86 .96 .035])
        set(ui_button_grtab_load_xls, 'String', GRTAB_LOAD_XLS_CMD)
        set(ui_button_grtab_load_xls, 'TooltipString', GRTAB_LOAD_XLS_TP)
        set(ui_button_grtab_load_xls, 'Callback', {@cb_grtab_load_xls})

        set(ui_button_grtab_load_txt, 'Position', [.02 .82 0.96 .035])
        set(ui_button_grtab_load_txt, 'String' ,GRTAB_LOAD_TXT_CMD)
        set(ui_button_grtab_load_txt, 'TooltipString', GRTAB_LOAD_TXT_TP)
        set(ui_button_grtab_load_txt, 'Callback', {@cb_grtab_load_txt})

        set(ui_button_grtab_load_json, 'Position', [.02 .78 .96 .035])
        set(ui_button_grtab_load_json, 'String', GRTAB_LOAD_JSON_CMD)
        set(ui_button_grtab_load_json, 'TooltipString', GRTAB_LOAD_JSON_TP)
        set(ui_button_grtab_load_json, 'Callback', {@cb_grtab_load_json})

        set(ui_table_grtab, 'Position', [.02 .21 .96 .55])
        set(ui_table_grtab, 'ColumnName', {'', ' Group ID ', ' Number of Subjects ', ' Group Label ', ' Group Notes '})
        set(ui_table_grtab, 'ColumnFormat', {'logical', 'char', 'numeric', 'char', 'char'})
        set(ui_table_grtab, 'ColumnEditable',[true true false true true])
        set(ui_table_grtab, 'CellEditCallback',{@cb_grtab_edit_gr});

        set(ui_button_grtab_add_gr, 'Position', [.02 .16 .21 .03])
        set(ui_button_grtab_add_gr, 'String', ADD_GR_CMD)
        set(ui_button_grtab_add_gr, 'TooltipString', ADD_GR_TP);
        set(ui_button_grtab_add_gr, 'Callback', {@cb_grtab_add_gr})
        
        set(ui_button_grtab_remove_gr, 'Position', [.27 .16 .21 .03])
        set(ui_button_grtab_remove_gr, 'String', REMOVE_GR_CMD)
        set(ui_button_grtab_remove_gr, 'TooltipString', REMOVE_GR_TP);
        set(ui_button_grtab_remove_gr, 'Callback', {@cb_grtab_remove_gr})
        
        set(ui_button_grtab_moveup_gr, 'Position', [.52 .16 .21 .03])
        set(ui_button_grtab_moveup_gr, 'String', MOVEUP_GR_CMD)
        set(ui_button_grtab_moveup_gr, 'TooltipString', MOVEUP_GR_TP);
        set(ui_button_grtab_moveup_gr, 'Callback', {@cb_grtab_moveup_gr})
        
        set(ui_button_grtab_movedown_gr, 'Position', [.77 .16 .21 .03])
        set(ui_button_grtab_movedown_gr, 'String', MOVEDOWN_GR_CMD)
        set(ui_button_grtab_movedown_gr, 'TooltipString', MOVEDOWN_GR_TP);
        set(ui_button_grtab_movedown_gr, 'Callback', {@cb_grtab_movedown_gr})
    
        set(ui_popup_grtab_invert, 'Position', [.39 .10 .35 .03])
        set(ui_popup_grtab_invert, 'TooltipString', 'Select group.');

        set(ui_button_grtab_invert, 'Position', [.77 .10 .21 .03])
        set(ui_button_grtab_invert, 'String', GRTAB_NOT_CMD)
        set(ui_button_grtab_invert, 'TooltipString', GRTAB_NOT_TP)
        set(ui_button_grtab_invert, 'Callback', {@cb_grtab_complementary})

        set(ui_popup_grtab_merge1, 'Position', [.02 .06 .35 .03])
        set(ui_popup_grtab_merge1, 'TooltipString', 'Select group.');

        set(ui_popup_grtab_merge2, 'Position', [.39 .06 .35 .03])
        set(ui_popup_grtab_merge2, 'TooltipString', 'Select group.');

        set(ui_button_grtab_merge, 'Position', [.77 .06 .21 .03])
        set(ui_button_grtab_merge, 'String', GRTAB_MERGE_CMD)
        set(ui_button_grtab_merge, 'TooltipString', GRTAB_MERGE_TP)
        set(ui_button_grtab_merge, 'Callback', {@cb_grtab_merge})

        set(ui_popup_grtab_intersect1, 'Position', [.02 .02 .35 .03])
        set(ui_popup_grtab_intersect1, 'TooltipString', 'Select group.');

        set(ui_popup_grtab_intersect2, 'Position', [.39 .02 .35 .03])
        set(ui_popup_grtab_intersect2, 'TooltipString', 'Select group.');

        set(ui_button_grtab_intersect, 'Position', [.77 .02 .21 .03])
        set(ui_button_grtab_intersect, 'String', GRTAB_INTERSECT_CMD)
        set(ui_button_grtab_intersect, 'TooltipString', GRTAB_INTERSECT_TP)
        set(ui_button_grtab_intersect, 'Callback', {@cb_grtab_intersect})
    end
    function update_grtab_cohortname()
        cohortname = cohort.getID();
        if isempty(cohortname)
            set(f, 'Name', [GUI.CE_NAME ' - ' BRAPH2.VERSION])
        else
            set(f, 'Name', [GUI.CE_NAME ' - ' BRAPH2.VERSION ' - ' cohortname])
        end
        set(ui_edit_grtab_cohortid, 'String', cohortname)
    end
    function update_grtab_table()
        groups_idict = cohort.getGroups();
        data = cell(groups_idict.length(), 4);
        for g = 1:1:groups_idict.length()
            if any(selected_group == g)
                data{g, GRTAB_SELECTED_COL} = true;
            else
                data{g, GRTAB_SELECTED_COL} = false;
            end
            data{g, GRTAB_NAME_COL} = groups_idict.getValue(g).getID();
            data{g, GRTAB_SUBN_COL} = groups_idict.getValue(g).subjectnumber();
            data{g, GRTAB_LBL_COL} = groups_idict.getValue(g).getLabel();
            data{g, GRTAB_NOTES_COL} = groups_idict.getValue(g).getNotes();
        end
        set(ui_table_grtab, 'Data', data)
        set(ui_label_grtab_subject, 'String', [cohort.getSubjectClass() ' (' num2str(cohort.getSubjects().length()) ')'])
        
        if groups_idict.length() < 1
            disable_group_intersect_buttons()
        else            
            enable_group_intersect_buttons()
        end
    end
    function cb_grtab_cohortname(~, ~)  % (src,event)
        cohort.setID(get(ui_edit_grtab_cohortid, 'String'));
        update_grtab_cohortname()
    end
    function cb_grtab_cohortlabel(~, ~)  % (src,event)
        cohort.setLabel(get(ui_edit_grtab_cohortid, 'String'));
    end
    function cb_grtab_cohortnotes(~, ~)  % (src,event)
        cohort.setNotes(get(ui_edit_grtab_cohortid, 'String'));
    end
    function cb_grtab_load_xls(~, ~)  % (src,event)
        try
        sub_class = cohort.getSubjectClass();
        cohort = eval([sub_class '.load_from_xls(cohort)']);             
        % update
        update_grtab_table() 
        update_groups()
        update_group_popups()
        update_console_panel_visibility(CONSOLE_GROUPS_CMD)
        init_enable()
        catch error
            if isequal(error.identifier(), 'MATLAB:unassignedOutputs')
                errordlg('No file/directory selected. Please choose a file/directory.');
            else
                errordlg(['The file is not a valid ' sub_class ' Subjects file. Please load a valid XLS file']);
            end
        end
    end
    function cb_grtab_load_txt(~, ~)  % (src,event)
        try
        sub_class = cohort.getSubjectClass();
        cohort = eval([sub_class '.load_from_txt(cohort)']);         
        % update
        update_grtab_table() 
        update_groups()
        update_group_popups()
        update_console_panel_visibility(CONSOLE_GROUPS_CMD)
        init_enable()
        catch error
            if isequal(error.identifier(), 'MATLAB:unassignedOutputs')
                errordlg('No file/directory selected. Please choose a file/directory.');
            else
                errordlg(['The file is not a valid ' sub_class ' Subjects file. Please load a valid TXT file']);
            end
        end
    end
    function cb_grtab_load_json(~, ~)  % (src,event)
        try
        sub_class = cohort.getSubjectClass();
        cohort = eval([sub_class '.load_from_json(cohort)']);
       % update
        update_grtab_table()
        update_groups()
        update_group_popups()
        update_console_panel_visibility(CONSOLE_GROUPS_CMD)
        init_enable()
        catch error
            if isequal(error.identifier(), 'MATLAB:unassignedOutputs')
                errordlg('No file/directory selected. Please choose a file/directory.');
            else
                errordlg(['The file is not a valid ' sub_class ' Subjects file. Please load a valid JSON file']);
            end
        end
    end
    function cb_grtab_edit_gr(~, event)  % (src,event)
        g = event.Indices(1);
        col = event.Indices(2);
        newdata = event.NewData;
        switch col
            case GRTAB_SELECTED_COL
                if newdata==1
                    selected_group = g;
                else
                    selected_group = [];
                end
            case GRTAB_NAME_COL
                if ~cohort.getGroups().contains(newdata)
                    cohort.getGroups().getValue(g).setID(newdata)
                    oldkey = cohort.getGroups().getKey(g);
                    cohort.getGroups().replaceKey(oldkey, newdata);
                end
            case GRTAB_LBL_COL
                cohort.getGroups().getValue(g).setLabel(newdata)
            case GRTAB_NOTES_COL
                cohort.getGroups().getValue(g).setNotes(newdata)
        end
        update_grtab_table()   
        update_console_panel()        
    end
    function cb_grtab_add_gr(~, ~)  % (src,event)        
        group = Group(cohort.getSubjectClass(), ['GroupID ' num2str(cohort.getGroups().length())], 'Label 1', 'Notes 1', {});
        cohort.getGroups().add(group.getID(), group);
        update_grtab_table()
        update_console_panel()
        update_group_popups()
    end
    function cb_grtab_remove_gr(~, ~)  % (src,event)
        selected_group = cohort.getGroups().remove_all(selected_group);
        update_grtab_table()
        update_console_panel()
        update_group_popups()
    end
    function cb_grtab_moveup_gr(~, ~)  % (src,event)
        selected_group = cohort.getGroups().move_up(selected_group);
        update_grtab_table()
        update_console_panel()
        update_group_popups()
    end
    function cb_grtab_movedown_gr(~, ~)  % (src,event)
        selected_group = cohort.getGroups().move_down(selected_group);
        update_grtab_table()
        update_console_panel()
        update_group_popups()
    end
    function cb_grtab_complementary(~, ~)  % (src,event)
        g = get(ui_popup_grtab_invert, 'Value');
        group = cohort.getGroups().getValue(g);
        complementary = cohort.notGroup(group);
        if ~cohort.getGroups().contains(complementary.getID())
            cohort.getGroups().add(complementary.getID(), complementary);
        end
        update_grtab_table()
        update_console_panel()
        update_group_popups()
    end
    function cb_grtab_merge(~, ~)  % (src,event)
        g1 = get(ui_popup_grtab_merge1,'Value');
        g2 = get(ui_popup_grtab_merge2,'Value');
        group1 = cohort.getGroups().getValue(g1);
        group2 = cohort.getGroups().getValue(g2);
        union = cohort.orGroup(group1,group2);
        if ~cohort.getGroups().contains(union.getID())
            cohort.getGroups().add(union.getID(), union);
        end
        update_grtab_table()
        update_console_panel()
        update_group_popups()
    end
    function cb_grtab_intersect(~, ~)  % (src,event)
        g1 = get(ui_popup_grtab_intersect1, 'Value');
        g2 = get(ui_popup_grtab_intersect2, 'Value');
        group1 = cohort.getGroups().getValue(g1);
        group2 = cohort.getGroups().getValue(g2);
        and_group = cohort.andGroup(group1, group2);
        if ~cohort.getGroups().contains(and_group.getID())
            cohort.getGroups().add(and_group.getID(), and_group);
        end
        update_grtab_table()  
        update_console_panel()
        update_group_popups()
    end

    function disable_group_intersect_buttons()
        set(ui_button_grtab_invert, 'enable', 'off')
        set(ui_button_grtab_merge, 'enable', 'off')
        set(ui_button_grtab_intersect, 'enable', 'off')      
    end
    function enable_group_intersect_buttons()
        set(ui_button_grtab_invert, 'enable', 'on')
        set(ui_button_grtab_merge, 'enable', 'on')
        set(ui_button_grtab_intersect, 'enable', 'on')
    end

%% Consoles
CONSOLE_GROUPS_CMD = 'Groups';
CONSOLE_GROUPS_SC = '1';
CONSOLE_GROUPS_TP = ['List of groups with sujects. Shortcut: ' GUI.ACCELERATOR '+' CONSOLE_GROUPS_SC];

CONSOLE_SUBJECTS_CMD = 'Subject Data';
CONSOLE_SUBJECTS_SC = '2';
CONSOLE_SUBJECTS_TP = ['List of subjects with their measures. Shortcut: ' GUI.ACCELERATOR '+' CONSOLE_SUBJECTS_SC];

ui_panel_console = uipanel();
ui_button_console_groups = uicontrol(ui_panel_console,'Style', 'pushbutton');
ui_button_console_subjects = uicontrol(ui_panel_console,'Style', 'pushbutton');
init_console()
    function init_console()
        GUI.setUnits(ui_panel_console)
        GUI.setBackgroundColor(ui_panel_console)

        set(ui_panel_console, 'Position', CONSOLE_POSITION)
        set(ui_panel_console, 'BorderType', 'none')

        set(ui_button_console_groups, 'Position', [.02 .05 .24 .6])
        set(ui_button_console_groups, 'String', CONSOLE_GROUPS_CMD)
        set(ui_button_console_groups, 'TooltipString', CONSOLE_GROUPS_TP)
        set(ui_button_console_groups, 'Callback', {@cb_console_groups})
        
        set(ui_button_console_subjects, 'Position', [.26 .05 .24 .6])
        set(ui_button_console_subjects, 'String', CONSOLE_SUBJECTS_CMD)
        set(ui_button_console_subjects, 'TooltipString', CONSOLE_SUBJECTS_TP)
        set(ui_button_console_subjects, 'Callback', {@cb_console_subjects})

    end
    function update_console_panel_visibility(console_panel_cmd)
        switch console_panel_cmd
            case CONSOLE_SUBJECTS_CMD
                set(ui_panel_groups, 'Visible', 'off')
                set(ui_panel_subjects, 'Visible', 'on')           
                
                set(ui_button_console_groups, 'FontWeight', 'normal')
                set(ui_button_console_subjects, 'FontWeight', 'bold')             
           
            otherwise % CONSOLE_GROUPS_CMD
                set(ui_panel_groups, 'Visible', 'on')
                set(ui_panel_subjects, 'Visible', 'off')
                
                set(ui_button_console_groups, 'FontWeight', 'bold')
                set(ui_button_console_subjects, 'FontWeight', 'normal')
             
        end
    end
    function update_console_panel()
        if strcmpi(get(ui_panel_groups, 'Visible'), 'on')
            update_groups()
        end
        if strcmpi(get(ui_panel_subjects, 'Visible'), 'on')            
            update_subjects()
        end
    end
    function cb_console_groups(~, ~)  % (src,event)
        update_groups()
        update_console_panel_visibility(CONSOLE_GROUPS_CMD)
    end
    function cb_console_subjects(~, ~)  % (src,event)        
        update_subjects()
        update_subtab_subjectinfo()
        update_console_panel_visibility(CONSOLE_SUBJECTS_CMD)
    end

%% Groups Subject demographic data
TAB_GROUPS_SELECTED_COL = 1;
TAB_GROUPS_SUBID_COL = 2;
TAB_GROUPS_SUBLABEL_COL = 3;
TAB_GROUPS_SUBNOTES_COL = 4;
ui_panel_groups = uipanel();

ui_table_groups = uitable(ui_panel_groups);
ui_button_groups_selectall_subs = uicontrol(ui_panel_groups, 'Style', 'pushbutton');
ui_button_groups_clearselection_subs = uicontrol(ui_panel_groups, 'Style', 'pushbutton');
ui_button_groups_add_subs = uicontrol(ui_panel_groups, 'Style', 'pushbutton');
ui_button_groups_remove_subs = uicontrol(ui_panel_groups, 'Style', 'pushbutton');
ui_button_groups_moveup_subs = uicontrol(ui_panel_groups, 'Style', 'pushbutton');
ui_button_groups_movedown_subs = uicontrol(ui_panel_groups, 'Style', 'pushbutton');
ui_button_groups_move2top_subs = uicontrol(ui_panel_groups, 'Style', 'pushbutton');
ui_button_groups_move2bottom_subs = uicontrol(ui_panel_groups, 'Style', 'pushbutton');
ui_button_create_group_from_subject = uicontrol(ui_panel_groups, 'Style', 'pushbutton');
init_groups()
    function init_groups()
        GUI.setUnits(ui_panel_groups)
        GUI.setBackgroundColor(ui_panel_groups)
        
        set(ui_panel_groups, 'Position', GROUPPANEL_POSITION)
        set(ui_panel_groups, 'Title', GROUPPANEL_CMD)
        
        set(ui_table_groups, 'Position', [.02 .16 .96 .82])
        set(ui_table_groups, 'ColumnEditable', true)
        set(ui_table_groups, 'CellEditCallback', {@cb_groups_edit_sub});
        
        set(ui_button_groups_selectall_subs, 'Position', [.02 .11 .18 .03])
        set(ui_button_groups_selectall_subs, 'String' ,SELECTALL_SUB_CMD)
        set(ui_button_groups_selectall_subs, 'TooltipString', SELECTALL_SUB_TP)
        set(ui_button_groups_selectall_subs, 'Callback', {@cb_groups_selectall_sub})
        
        set(ui_button_groups_clearselection_subs, 'Position', [.02 .08 .18 .03])
        set(ui_button_groups_clearselection_subs, 'String', CLEARSELECTION_SUB_CMD)
        set(ui_button_groups_clearselection_subs, 'TooltipString', CLEARSELECTION_SUB_TP)
        set(ui_button_groups_clearselection_subs, 'Callback', {@cb_groups_clearselection_sub})
        
        set(ui_button_groups_add_subs, 'Position', [.22 .11 .18 .03])
        set(ui_button_groups_add_subs, 'String', ADD_SUB_CMD)
        set(ui_button_groups_add_subs, 'TooltipString', ADD_SUBJECTS_TP);
        set(ui_button_groups_add_subs, 'Callback', {@cb_groups_add_sub})        
        
        set(ui_button_groups_remove_subs, 'Position', [.41 .11 .18 .03])
        set(ui_button_groups_remove_subs, 'String' , REMOVE_SUB_CMD)
        set(ui_button_groups_remove_subs, 'TooltipString', REMOVE_SUB_TP);
        set(ui_button_groups_remove_subs, 'Callback', {@cb_groups_remove_sub})       

        set(ui_button_groups_moveup_subs, 'Position', [.60 .11 .18 .03])
        set(ui_button_groups_moveup_subs, 'String', MOVEUP_SUB_CMD)
        set(ui_button_groups_moveup_subs, 'TooltipString', MOVEUP_SUB_TP);
        set(ui_button_groups_moveup_subs, 'Callback', {@cb_groups_moveup_sub})
        
        set(ui_button_groups_movedown_subs, 'Position', [.60 .08 .18 .03])
        set(ui_button_groups_movedown_subs, 'String', MOVEDOWN_SUB_CMD)
        set(ui_button_groups_movedown_subs, 'TooltipString', MOVEDOWN_SUB_TP);
        set(ui_button_groups_movedown_subs, 'Callback', {@cb_groups_movedown_sub})
        
        set(ui_button_groups_move2top_subs, 'Position', [.60 .05 .18 .03])
        set(ui_button_groups_move2top_subs, 'String', MOVE2TOP_SUB_CMD)
        set(ui_button_groups_move2top_subs, 'TooltipString', MOVE2TOP_SUB_TP);
        set(ui_button_groups_move2top_subs, 'Callback', {@cb_groups_move2top_sub})
        
        set(ui_button_groups_move2bottom_subs, 'Position', [.60 .02 .18 .03])
        set(ui_button_groups_move2bottom_subs, 'String', MOVE2BOTTOM_SUB_CMD)
        set(ui_button_groups_move2bottom_subs, 'TooltipString', MOVE2BOTTOM_SUB_TP);
        set(ui_button_groups_move2bottom_subs, 'Callback', {@cb_groups_move2bottom_sub})
        
        set(ui_button_create_group_from_subject, 'Position', [.80 .11 .18 .03])
        set(ui_button_create_group_from_subject, 'String', CREATE_GRP_FROM_SUBS_CMD)
        set(ui_button_create_group_from_subject, 'TooltipString', CREATE_GRP_FROM_SUBS_TP);
        set(ui_button_create_group_from_subject, 'Callback', {@cb_groups_create_group_from_subjects})   

    end
    function update_groups(varargin)         
        
        % subjects of the selected group data table
        ColumnName = {'', ' Subject ID ', ' Label ', ' Notes '};
        ColumnFormat = {'logical', 'char', 'char', 'char'};
        groups = cohort.getGroups().getValues();
        for g = 1:1:length(groups)
            group = groups{g};
            ColumnName{4 + g} = group.getID();
            ColumnFormat{4 + g} = 'logical';
        end
        set(ui_table_groups, 'ColumnName', ColumnName)
        set(ui_table_groups, 'ColumnFormat', ColumnFormat)
        
        if exist('restricted', 'var') && restricted
            set(ui_table_groups, 'ColumnEditable', [true(1, 5)]) %#ok<NBRAK>
        end
        
        if isempty(selected_group) && ~isempty(cohort)
            subjects = cohort.getSubjects().getValues();
            data = cell(length(subjects), 5);
            for i = 1:1:length(subjects)
                sub = subjects{i};
                if any(selected_subjects==i)
                    data{i, TAB_GROUPS_SELECTED_COL} = true;
                else
                    data{i, TAB_GROUPS_SELECTED_COL} = false;
                end                
                data{i, TAB_GROUPS_SUBID_COL} = sub.getID();
                data{i, TAB_GROUPS_SUBLABEL_COL} = sub.getLabel();
                data{i, TAB_GROUPS_SUBNOTES_COL} = sub.getNotes();               
                for g = 1:1:length(groups)
                    group = groups{g};                    
                    if group.contains_subject(sub)
                        data{i, TAB_GROUPS_SUBNOTES_COL + g} = true;
                    else
                        data{i, TAB_GROUPS_SUBNOTES_COL + g} = false;
                    end
                end
            end             
        elseif ~isempty(selected_group)
            group = cohort.getGroups().getValue(selected_group);
            data = cell(group.subjectnumber(), 4);
            subjects = group.getSubjects();
            for i = 1:1:group.subjectnumber()
                if any(selected_subjects==i)
                    data{i, TAB_GROUPS_SELECTED_COL} = true;
                else
                    data{i, TAB_GROUPS_SELECTED_COL} = false;
                end
                sub = subjects{i};                
                data{i, TAB_GROUPS_SUBID_COL} = sub.getID();
                data{i, TAB_GROUPS_SUBLABEL_COL} = sub.getLabel();
                data{i, TAB_GROUPS_SUBNOTES_COL} = sub.getNotes();
                 for g = 1:1:length(groups)
                    group = groups{g};                    
                    if group.contains_subject(sub)
                        data{i, TAB_GROUPS_SUBNOTES_COL + g} = true;
                    else
                        data{i, TAB_GROUPS_SUBNOTES_COL + g} = false;
                    end
                end
            end
        else
            data = cell(0, 0);
        end       
       
        set(ui_table_groups, 'Data', data)       
        update_group_popups()
    end
    function update_group_popups()
        groups = cohort.getGroups().getValues();
        GroupList = cellfun(@(x) x.getID(), groups, 'UniformOutPut', false);
        
        if isempty(GroupList)
            GroupList = {''};
        end
        set(ui_popup_grtab_invert, 'String', GroupList)
        if get(ui_popup_grtab_invert, 'Value') > cohort.getGroups().length() || get(ui_popup_grtab_invert, 'Value') < 1
            set(ui_popup_grtab_invert, 'Value', 1)
        end
        set(ui_popup_grtab_merge1, 'String', GroupList)
        if get(ui_popup_grtab_merge1, 'Value') > cohort.getGroups().length() || get(ui_popup_grtab_merge1, 'Value') < 1
            set(ui_popup_grtab_merge1, 'Value', 1)
        end
        set(ui_popup_grtab_merge2, 'String', GroupList)
        if get(ui_popup_grtab_merge2, 'Value') > cohort.getGroups().length() || get(ui_popup_grtab_merge2, 'Value') < 1
            set(ui_popup_grtab_merge2, 'Value', 1)
        end
        set(ui_popup_grtab_intersect1, 'String', GroupList)
        if get(ui_popup_grtab_intersect1, 'Value') > cohort.getGroups().length() || get(ui_popup_grtab_intersect1, 'Value') < 1
            set(ui_popup_grtab_intersect1, 'Value', 1)
        end
        set(ui_popup_grtab_intersect2, 'String', GroupList)
        if get(ui_popup_grtab_intersect2, 'Value') > cohort.getGroups().length() || get(ui_popup_grtab_intersect2, 'Value') < 1
            set(ui_popup_grtab_intersect2, 'Value', 1)
        end
    end
    function cb_groups_edit_sub(~, event)  % (src,event)
        i = event.Indices(1);
        col = event.Indices(2);
        newdata = event.NewData;
        if ~isempty(selected_group)
            group = cohort.getGroups().getValue(selected_group);
            subjects = group.getSubjects();
            subject = subjects{i};
        else
            subjects = cohort.getSubjects().getValues();
            subject = subjects{i};
        end
        switch col
            case TAB_GROUPS_SELECTED_COL
                if newdata == 1
                    selected_subjects = sort(unique([selected_subjects(:); i]));
                else
                    selected_subjects = selected_subjects(selected_subjects ~= i);
                end
            case TAB_GROUPS_SUBID_COL
                if ~cohort.getSubjects().contains(newdata)
                    subject.setID(newdata)
                    oldkey = cohort.getSubjects().getKey(subject);
                    cohort.getSubjects().replaceKey(oldkey, newdata);
                end
            case TAB_GROUPS_SUBLABEL_COL
                subject.setLabel(newdata)
            case TAB_GROUPS_SUBNOTES_COL
                subject.setNotes(newdata)
            otherwise
                g = col - 4;
                group = cohort.getGroups().getValue(g);
                if newdata == 1 
                    if ~group.contains_subject(subject)
                        group.addSubject(subject)
                    end                    
                else
                    if group.contains_subject(subject)
                        group.removeSubject(subject)
                    end 
                end
        end
        update_grtab_table()
        update_groups()
    end
    function cb_groups_selectall_sub(~, ~)  % (src,event)
        if ~isempty(selected_group)
            group = cohort.getGroups().getValue(selected_group);
            selected_subjects = (1:1:group.subjectnumber());
        else
            subjects = cohort.getSubjects().getValues();
            selected_subjects = (1:1:length(subjects));
        end
        update_groups()        
    end
    function cb_groups_clearselection_sub(~, ~)  % (src,event)
        selected_subjects = [];
        update_groups()        
    end
    function cb_groups_add_sub(~, ~)  % (src,event)   
        if ~isempty(selected_group)
            group = cohort.getGroups().getValue(selected_group);
            sub = Subject.getSubject(cohort.getSubjectClass(), ['New Subject ' group.getID() ' ' num2str(group.subjectnumber() + 1)], 'Label', 'Notes', cohort.getBrainAtlases());
            cohort.getSubjects().add(sub.getID(), sub);
            group.addSubject(sub);
        else
            sub = Subject.getSubject(cohort.getSubjectClass(), ['New Subject' num2str(cohort.getSubjects().length() + 1)], 'Label', 'Notes', cohort.getBrainAtlases());
            cohort.getSubjects().add(sub.getID(), sub);
        end
        
        update_grtab_table()
        update_groups()
        enable_subjects_button()
    end
    function cb_groups_remove_sub(~, ~)  % (src,event)
        if ~isempty(selected_group)
            % remove from cohort
            group = cohort.getGroups().getValue(selected_group);
            subjects = group.getSubjects();
            subjects = subjects(selected_subjects);
        else
            subjects = cohort.getSubjects().getValues();
            subjects = subjects(selected_subjects);
        end
        % remove from all the groups
        groups = cohort.getGroups().getValues();
        for i = 1:1:length(groups)
            group = groups{i};
            cellfun(@(x) group.removeSubject(x) , subjects);
        end
        selected_subjects = cohort.getSubjects().remove_all(selected_subjects);
        update_grtab_table()
        update_groups()
        
        if cohort.getSubjects().length() < 1
            disable_subjects_button()
        end
        
    end
    function cb_groups_moveup_sub(~, ~)  % (src,event)
        selected_subjects = cohort.getSubjects().move_up(selected_subjects);
        
        update_grtab_table()
        update_groups()
    end
    function cb_groups_movedown_sub(~, ~)  % (src,event)
        selected_subjects = cohort.getSubjects().move_down(selected_subjects);
        update_grtab_table()
        update_groups()
    end
    function cb_groups_move2top_sub(~, ~)  % (src,event)
        selected_subjects = cohort.getSubjects().move_to_top(selected_subjects);
        update_grtab_table()
        update_groups()
    end
    function cb_groups_move2bottom_sub(~, ~)  % (src,event)
        selected_subjects = cohort.getSubjects().move_to_bottom(selected_subjects);
        update_grtab_table()
        update_groups()
    end
    function cb_groups_create_group_from_subjects(~, ~)
        all_subjects = cohort.getSubjects().getValues();
        subjects = all_subjects(selected_subjects); 
        n = cohort.getGroups().length()+1;
        ids_string = '';
                for j = 1:1:length(subjects)
                    sub = subjects{j};
                    ids_string = [ids_string ' ' sub.getID()]; %#ok<AGROW>
                end
        group = Group(cohort.getSubjectClass(), ['Group created with: ' ids_string ' ' num2str(n)], 'Label', 'Notes', subjects);
        cohort.getGroups().add(group.getID(), group);
        update_grtab_table()
        update_groups()
    end
    function disable_subjects_button()
        set(ui_button_console_subjects, 'enable', 'off')
    end
    function enable_subjects_button()
        set(ui_button_console_subjects, 'enable', 'on')
    end

%% Panel 2 - Subjects
ui_panel_subjects = uipanel();
ui_tablepanel_subjects = uipanel(ui_panel_subjects);
ui_label_subtab_id_text = uicontrol(ui_panel_subjects, 'Style', 'text');
ui_label_subtab_label_text = uicontrol(ui_panel_subjects, 'Style', 'text');
ui_label_subtab_notes_text = uicontrol(ui_panel_subjects, 'Style', 'text');
ui_edit_subtab_subjectid = uicontrol(ui_panel_subjects, 'Style', 'edit');
ui_edit_subtab_subjectlabel = uicontrol(ui_panel_subjects, 'Style', 'edit');
ui_edit_subtab_subjectnotes = uicontrol(ui_panel_subjects, 'Style', 'edit');
ui_list_subjects = uicontrol(ui_panel_subjects, 'Style', 'listbox');
init_subjects()
    function init_subjects()
        GUI.setUnits(ui_panel_subjects)
        GUI.setBackgroundColor(ui_panel_subjects)

        set(ui_panel_subjects, 'Position', GROUPPANEL_POSITION)
        set(ui_panel_subjects, 'Title', CONSOLE_SUBJECTS_CMD)
        
        set(ui_tablepanel_subjects, 'Parent', ui_panel_subjects)
        set(ui_tablepanel_subjects, 'Position', [.25 .02 .74 .85])
        
        set(ui_label_subtab_id_text, 'Position', [.25 .96 .36 .04])
        set(ui_label_subtab_id_text, 'HorizontalAlignment', 'left')
        set(ui_label_subtab_id_text, 'FontWeight', 'bold')
        set(ui_label_subtab_id_text, 'FontSize', 12)
        set(ui_label_subtab_id_text, 'ForegroundColor', 'black')
        set(ui_label_subtab_id_text, 'String', 'SUBJECT ID')
        set(ui_label_subtab_id_text, 'enable', 'off')
        
        set(ui_edit_subtab_subjectid, 'Position', [.50 .96 0.49 .04])
        set(ui_edit_subtab_subjectid, 'HorizontalAlignment', 'left')
        set(ui_edit_subtab_subjectid, 'FontWeight', 'bold')
        set(ui_edit_subtab_subjectid, 'Callback', {@cb_subtab_subjectid})
        
        set(ui_label_subtab_label_text, 'Position', [.25 .92 0.49 .04])
        set(ui_label_subtab_label_text, 'HorizontalAlignment', 'left')
        set(ui_label_subtab_label_text, 'FontWeight', 'bold')
        set(ui_label_subtab_label_text, 'FontSize', 12)
        set(ui_label_subtab_label_text, 'ForegroundColor', 'black')
        set(ui_label_subtab_label_text, 'String', 'SUBJECT LABEL')
        set(ui_label_subtab_label_text, 'enable', 'off')
        
        set(ui_edit_subtab_subjectlabel, 'Position', [.5 .92 0.49 .04])
        set(ui_edit_subtab_subjectlabel, 'HorizontalAlignment', 'left')
        set(ui_edit_subtab_subjectlabel, 'FontWeight', 'bold')
        set(ui_edit_subtab_subjectlabel, 'Callback', {@cb_subtab_subjectlabel})
        
        set(ui_label_subtab_notes_text, 'Position', [.25 .88 .36 .04])
        set(ui_label_subtab_notes_text, 'HorizontalAlignment', 'left')
        set(ui_label_subtab_notes_text, 'FontWeight', 'bold')
        set(ui_label_subtab_notes_text, 'FontSize', 12)
        set(ui_label_subtab_notes_text, 'ForegroundColor', 'black')
        set(ui_label_subtab_notes_text, 'String', 'SUBJECT NOTES')
        set(ui_label_subtab_notes_text, 'enable', 'off')
        
        set(ui_edit_subtab_subjectnotes, 'Position', [.5 .88 .49 .04])
        set(ui_edit_subtab_subjectnotes, 'HorizontalAlignment', 'left')
        set(ui_edit_subtab_subjectnotes, 'FontWeight', 'bold')
        set(ui_edit_subtab_subjectnotes, 'Callback', {@cb_subtab_subjectnotes})

        set(ui_list_subjects, 'Position', [.03 .02 .2 .97])
        set(ui_list_subjects, 'String', '')
        set(ui_list_subjects, 'TooltipString', 'Select subject');
        set(ui_list_subjects, 'Value', 1)
        set(ui_list_subjects, 'Max', -1, 'Min', 0)
        set(ui_list_subjects, 'Callback', {@cb_subjects_list});
    end
    function update_subjects()
        update_subjects_list()
        update_subjects_table()
    end
    function update_subjects_list()
        if isempty(selected_group) && ~isempty(cohort)
            subjects = cohort.getSubjects().getValues();
            if length(subjects) < 1
                set(ui_list_subjects, 'Value', 1)
                set(ui_list_subjects, 'String', 'empty')
            else
                for i = 1:1:length(subjects)
                    sub = subjects{i};
                    subjects_ids{i} = sub.getID(); %#ok<AGROW>
                end
                set(ui_list_subjects, 'String', subjects_ids)
            end
        elseif ~isempty(selected_group)
            group = cohort.getGroups().getValue(selected_group);            
            subjects = group.getSubjects();
            if length(subjects) < 1
                set(ui_list_subjects, 'Value', 1)
                set(ui_list_subjects, 'String', 'empty')
            else                
                for i = 1:1:length(subjects)
                    sub = subjects{i};
                    subjects_ids{i} = sub.getID(); %#ok<AGROW>
                end
                set(ui_list_subjects, 'Value', 1)
                set(ui_list_subjects, 'String', subjects_ids)
            end
        else
            set(ui_list_subjects, 'Value', 1)
            set(ui_list_subjects, 'String', 'empty')
        end  
    end
    function update_subjects_table()
        value = get(ui_list_subjects, 'Value');         
        subject = cohort.getSubjects().getValue(value);        
        if ~isempty(subject)
            subject.getDataPanel(ui_tablepanel_subjects);
        else 
            
        end             
    end 
    function cb_subjects_list(~, ~)  % (src,event)
        update_subjects_table()
        update_subtab_subjectinfo()
    end
    function cb_subtab_subjectid(~, ~)  % (src,event)
        newdata = get(ui_edit_subtab_subjectid, 'String');
        value = get(ui_list_subjects, 'Value');         
        subject = cohort.getSubjects().getValue(value);
        if ~cohort.getSubjects().contains(newdata)
            subject.setID(newdata)
            oldkey = cohort.getSubjects().getKey(subject);
            cohort.getSubjects().replaceKey(oldkey, newdata);
        end        
        update_subjects_list()
    end
    function cb_subtab_subjectlabel(~, ~)  % (src,event)
        newdata = get(ui_edit_subtab_subjectlabel, 'String');
        value = get(ui_list_subjects, 'Value');         
        subject = cohort.getSubjects().getValue(value);
        subject.setLabel(newdata)            
        update_grtab_cohortname()
    end
    function cb_subtab_subjectnotes(~, ~)  % (src,event)
        newdata = get(ui_edit_subtab_subjectnotes, 'String');
        value = get(ui_list_subjects, 'Value');         
        subject = cohort.getSubjects().getValue(value);
        subject.setNotes(newdata)            
        update_grtab_cohortname()
    end
    function update_subtab_subjectinfo()
        value = get(ui_list_subjects, 'Value');         
        subject = cohort.getSubjects().getValue(value);
        
        set(ui_edit_subtab_subjectid, 'String', subject.getID())
        set(ui_edit_subtab_subjectlabel, 'String', subject.getLabel())
        set(ui_edit_subtab_subjectnotes, 'String', subject.getNotes())
    end

%% Menus
MENU_FILE = GUI.MENU_FILE;
MENU_GROUPS = 'Groups';
MENU_SUBJECTS = 'Subjects';

ui_menu_file = uimenu(f, 'Label',MENU_FILE);
ui_menu_file_open = uimenu(ui_menu_file);
ui_menu_file_save = uimenu(ui_menu_file);
ui_menu_file_saveas = uimenu(ui_menu_file);
ui_menu_file_import_xls = uimenu(ui_menu_file);
ui_menu_file_export_xls = uimenu(ui_menu_file);
ui_menu_file_import_txt = uimenu(ui_menu_file);
ui_menu_file_export_txt = uimenu(ui_menu_file);
ui_menu_file_import_json = uimenu(ui_menu_file);
ui_menu_file_export_json = uimenu(ui_menu_file);
ui_menu_file_close = uimenu(ui_menu_file);
ui_menu_groups = uimenu(f, 'Label' ,MENU_GROUPS);
ui_menu_groups_load_xls = uimenu(ui_menu_groups);
ui_menu_groups_load_txt = uimenu(ui_menu_groups);
ui_menu_groups_load_json = uimenu(ui_menu_groups);
ui_menu_groups_add = uimenu(ui_menu_groups);
ui_menu_groups_remove = uimenu(ui_menu_groups);
ui_menu_groups_moveup = uimenu(ui_menu_groups);
ui_menu_groups_movedown = uimenu(ui_menu_groups);
ui_menu_subjects = uimenu(f, 'Label', MENU_SUBJECTS);
ui_menu_subjects_selectall = uimenu(ui_menu_subjects);
ui_menu_subjects_clearselection = uimenu(ui_menu_subjects);
ui_menu_subjects_add = uimenu(ui_menu_subjects);
ui_menu_subjects_remove = uimenu(ui_menu_subjects);
ui_menu_subjects_moveup = uimenu(ui_menu_subjects);
ui_menu_subjects_movedown = uimenu(ui_menu_subjects);
ui_menu_subjects_move2top = uimenu(ui_menu_subjects);
ui_menu_subjects_move2bottom = uimenu(ui_menu_subjects);
ui_menu_analysis = uimenu(f, 'Label', 'Analysis');

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
        
        set(ui_menu_file_import_xls, 'Separator', 'on')
        set(ui_menu_file_import_xls, 'Label', IMPORT_XLS_CMD)
        set(ui_menu_file_import_xls, 'Callback', {@cb_import_xls})

        set(ui_menu_file_export_xls, 'Label', EXPORT_XLS_CMD)
        set(ui_menu_file_export_xls, 'Callback', {@cb_export_xls})
        
        set(ui_menu_file_import_txt, 'Separator', 'on')
        set(ui_menu_file_import_txt, 'Label', IMPORT_TXT_CMD)
        set(ui_menu_file_import_txt, 'Callback', {@cb_import_txt})

        set(ui_menu_file_export_txt, 'Label', EXPORT_TXT_CMD)
        set(ui_menu_file_export_txt, 'Callback', {@cb_export_txt})

        set(ui_menu_file_import_json, 'Separator', 'on')
        set(ui_menu_file_import_json, 'Label', IMPORT_JSON_CMD)
        set(ui_menu_file_import_json, 'Callback', {@cb_import_json})

        set(ui_menu_file_export_json, 'Label', EXPORT_JSON_CMD)
        set(ui_menu_file_export_json, 'Callback', {@cb_export_json})

        set(ui_menu_file_close, 'Separator', 'on')
        set(ui_menu_file_close, 'Label', CLOSE_CMD)
        set(ui_menu_file_close, 'Accelerator', CLOSE_SC);
        set(ui_menu_file_close, 'Callback', ['GUI.close(''' APPNAME ''', gcf)'])        

        set(ui_menu_groups_load_xls, 'Label', GRTAB_LOAD_XLS_CMD)
        set(ui_menu_groups_load_xls, 'Callback', {@cb_grtab_load_xls})

        set(ui_menu_groups_load_txt, 'Label', GRTAB_LOAD_TXT_CMD)
        set(ui_menu_groups_load_txt, 'Callback', {@cb_grtab_load_txt})
        
        set(ui_menu_groups_load_json, 'Label', GRTAB_LOAD_TXT_CMD)
        set(ui_menu_groups_load_json, 'Callback', {@cb_grtab_load_json})
                
        set(ui_menu_groups_add, 'Separator', 'on')
        set(ui_menu_groups_add, 'Label', ADD_GR_CMD)
        set(ui_menu_groups_add, 'Callback', {@cb_grtab_add_gr})
        
        set(ui_menu_groups_remove, 'Label', REMOVE_GR_CMD)
        set(ui_menu_groups_remove, 'Callback', {@cb_grtab_remove_gr})
            
        set(ui_menu_groups_moveup, 'Label', MOVEUP_GR_CMD)
        set(ui_menu_groups_moveup, 'Callback', {@cb_grtab_moveup_gr})
            
        set(ui_menu_groups_movedown, 'Label', MOVEDOWN_GR_CMD)
        set(ui_menu_groups_movedown, 'Callback', {@cb_grtab_movedown_gr})
        
        set(ui_menu_subjects_selectall, 'Separator', 'on')
        set(ui_menu_subjects_selectall, 'Label',SELECTALL_SUB_CMD)
        set(ui_menu_subjects_selectall, 'Callback', {@cb_groups_selectall_sub})
            
        set(ui_menu_subjects_clearselection, 'Label',CLEARSELECTION_SUB_CMD)
        set(ui_menu_subjects_clearselection, 'Callback', {@cb_groups_clearselection_sub})
        
        set(ui_menu_subjects_add, 'Separator', 'on')
        set(ui_menu_subjects_add, 'Label',ADD_SUB_CMD)
        set(ui_menu_subjects_add, 'Callback', {@cb_groups_add_sub})         

        set(ui_menu_subjects_remove, 'Separator', 'on')
        set(ui_menu_subjects_remove, 'Label',REMOVE_SUB_CMD)
        set(ui_menu_subjects_remove, 'Callback', {@cb_groups_remove_sub})
            
        set(ui_menu_subjects_moveup, 'Separator', 'on')
        set(ui_menu_subjects_moveup, 'Label',MOVEUP_SUB_CMD)
        set(ui_menu_subjects_moveup, 'Callback', {@cb_groups_moveup_sub})
            
        set(ui_menu_subjects_movedown, 'Label',MOVEDOWN_SUB_CMD)
        set(ui_menu_subjects_movedown, 'Callback', {@cb_groups_movedown_sub})
            
        set(ui_menu_subjects_move2top, 'Label',MOVE2TOP_SUB_CMD)
        set(ui_menu_subjects_move2top, 'Callback', {@cb_groups_move2top_sub})
            
        set(ui_menu_subjects_move2bottom, 'Label',MOVE2BOTTOM_SUB_CMD)
        set(ui_menu_subjects_move2bottom, 'Callback', {@cb_groups_move2bottom_sub})
        
        analysis_list = Analysis.getList();
        for i = 1:1:length(analysis_list)
            analysis = analysis_list{i};
            cohort_analysis_menu = uimenu(ui_menu_analysis);
            set(cohort_analysis_menu, 'Label', analysis)
            set(cohort_analysis_menu, 'Callback', {@cb_menu_analysis})            
        end
        
        function cb_menu_analysis(src, ~)
            analysis_label_chr_array = get(src, 'Label');
            for j = 1:1:length(analysis_list)
                analysis = analysis_list{j};
                if isequal(analysis_label_chr_array, Analysis.getClass(analysis))
                    GUIAnalysis(cohort.copy(), Analysis.getClass(analysis));
                end
            end  
        end


    end

[ui_menu_about, ui_menu_about_about] = GUI.setMenuAbout(f, APPNAME); %#ok<ASGLU>

% Toolbar
set(f, 'Toolbar', 'figure')
ui_toolbar = findall(f, 'Tag', 'FigureToolBar');
ui_toolbar_open = findall(ui_toolbar, 'Tag', 'Standard.FileOpen');
ui_toolbar_save = findall(ui_toolbar, 'Tag', 'Standard.SaveFigure');

init_toolbar()
      function init_toolbar()
        delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
        delete(findall(ui_toolbar, 'Tag', 'Standard.PrintFigure'))
        delete(findall(ui_toolbar, 'Tag', 'Standard.EditPlot'))       
        delete(findall(ui_toolbar, 'Tag', 'Exploration.Brushing'))
        delete(findall(ui_toolbar, 'Tag', 'DataManager.Linking'))
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

setup_restrictions()
    function setup_restrictions()
        if exist('restricted', 'var') && restricted
        end
    end

%% Auxiliary functions
    function setup()      
        % setup atlas
        update_atlas()
        
        % setup table
        update_grtab_cohortname()
        update_grtab_table()
              
        update_console_panel_visibility(CONSOLE_GROUPS_CMD)
        
        % setup group
        update_groups()
        update_group_popups()     

    end
end