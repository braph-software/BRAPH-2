function GUICohort(tmp, restricted)
% GUICohort Cohort Editor
%
% GUICOHORT(SUBJECT_CLASS) opens an empty cohort with empty atlas for SUBJECT_CLASS type 
%
% GUICOHORT(COHORT) opens a cohort
%
% GUICOHORT(COHORT, TRUE) opens a cohort with only reading and basic writing

APPNAME  = GUI.MCE_NAME;  % application name
BUILD = BRAPH2.BUILD;

% Dimensions
MARGIN_X = .01;
MARGIN_Y = .01;
LEFTCOLUMN_WIDTH = .29;
HEADING_HEIGHT = .12;
FILENAME_HEIGHT = .02;

MAINPANEL_X0 = LEFTCOLUMN_WIDTH + 2 * MARGIN_X;
MAINPANEL_Y0 = FILENAME_HEIGHT + 2 * MARGIN_Y;
MAINPANEL_WIDTH = 1 - LEFTCOLUMN_WIDTH - 3 * MARGIN_X;
MAINPANEL_HEIGHT = 1 - FILENAME_HEIGHT - 4 * MARGIN_Y;
MAINPANEL_POSITION = [MAINPANEL_X0 MAINPANEL_Y0 MAINPANEL_WIDTH MAINPANEL_HEIGHT];

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

%% Application Data
if exist('tmp', 'var') && isa(tmp, 'Cohort')
    cohort = tmp;
else
    assert(ismember(tmp, Subject.getList()));
    atlas = BrainAtlas('Empty BA', 'Brain Atlas Label', 'Brain atlas notes.', 'BrainMesh_ICBM152.nv', {});
    cohort = Cohort('cohort id', 'cohort label', 'cohort notes', tmp, atlas, {});
end

selected_group = [];
selected_subjects = [];

% Callbacks to manage application data
    function cb_open(~, ~)  % (src, event)
        % select file
        [file, path, filterindex] = uigetfile(GUI.BAE_EXTENSION, GUI.BAE_MSG_GETFILE);
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
        [file, path, filterindex] = uiputfile(GUI.BAE_EXTENSION, GUI.BAE_MSG_PUTFILE);
        % save file
        if filterindex
            filename = fullfile(path, file);
            save(filename, 'cohort', 'selected_group', 'selected_subjects', 'BUILD');
            update_filename(filename)
        end
    end
    function cb_import_txt(~, ~)  % (scr, event)
        cohortstmp = eval([cohort.getSubjectClass()  '.load_from_txt()']);
        if ~isempty(cohortstmp)
            cohort = cohortstmp;
            selected_group = [];
            selected_subjects = [];
            setup()
            update_filename('')
        end
    end
    function cb_import_xls(~, ~)  % (scr, event)
        cohortstmp = eval([cohort.getSubjectClass()  '.load_from_xls()']);
        if  ~isempty(cohortstmp)
            cohort = cohortstmp;
            selected_group = [];
            selected_subjects = [];
            setup()
            update_filename('')
        end
    end
    function cb_import_json(~, ~)  % (src, event)
        cohortstmp = eval([cohort.getSubjectClass()  '.load_from_json()']);
        if ~isempty(cohortstmp)
            cohort = cohortstmp;
            selected_group = [];
            selected_subjects = [];
            selected = [];
            setup()
            update_filename('')
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
fig_subject = [];
fig_group = [];
fig_comparison = [];
f = GUI.init_figure(APPNAME, .8, .9, 'center');

    function init_disable()
        GUI.disable(ui_panel_grtab)
        set(ui_menu_groups, 'enable', 'off')
    end
    function init_enable()
        GUI.enable(ui_panel_grtab)
        set(ui_menu_groups, 'enable', 'on')
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
ATLAS_WIDTH = LEFTCOLUMN_WIDTH;
ATLAS_HEIGHT = HEADING_HEIGHT;
ATLAS_X0 = MARGIN_X;
ATLAS_Y0 = 1 - MARGIN_Y - ATLAS_HEIGHT;
ATLAS_POSITION = [ATLAS_X0 ATLAS_Y0 ATLAS_WIDTH ATLAS_HEIGHT];

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

%% Panel Group Table
GRTAB_SELECTED_COL = 1;
GRTAB_NAME_COL = 2;
GRTAB_SUBN_COL = 3;
GRTAB_LBL_COL = 4;
GRTAB_NOTES_COL = 5;

GRTAB_WIDTH = LEFTCOLUMN_WIDTH;
GRTAB_HEIGHT = MAINPANEL_HEIGHT;
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
ui_edit_grtab_cohortname = uicontrol(ui_panel_grtab, 'Style', 'edit');
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

        set(ui_edit_grtab_cohortname, 'Position', [.02 .95 .96 .04])
        set(ui_edit_grtab_cohortname, 'HorizontalAlignment', 'left')
        set(ui_edit_grtab_cohortname, 'FontWeight', 'bold')
        set(ui_edit_grtab_cohortname, 'Callback', {@cb_grtab_cohortname})

        set(ui_button_grtab_load_xls, 'Position',[.02 .90 .96 .035])
        set(ui_button_grtab_load_xls, 'String', GRTAB_LOAD_XLS_CMD)
        set(ui_button_grtab_load_xls, 'TooltipString', GRTAB_LOAD_XLS_TP)
        set(ui_button_grtab_load_xls, 'Callback', {@cb_grtab_load_xls})

        set(ui_button_grtab_load_txt, 'Position', [.02 .86 0.96 .035])
        set(ui_button_grtab_load_txt, 'String' ,GRTAB_LOAD_TXT_CMD)
        set(ui_button_grtab_load_txt, 'TooltipString', GRTAB_LOAD_TXT_TP)
        set(ui_button_grtab_load_txt, 'Callback', {@cb_grtab_load_txt})

        set(ui_button_grtab_load_json, 'Position', [.02 .82 .96 .035])
        set(ui_button_grtab_load_json, 'String', GRTAB_LOAD_JSON_CMD)
        set(ui_button_grtab_load_json, 'TooltipString', GRTAB_LOAD_JSON_TP)
        set(ui_button_grtab_load_json, 'Callback', {@cb_grtab_load_json})

        set(ui_table_grtab, 'Position', [.02 .21 .96 .59])
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
            set(f, 'Name', [GUI.MCE_NAME ' - ' BRAPH2.VERSION])
        else
            set(f, 'Name', [GUI.MCE_NAME ' - ' BRAPH2.VERSION ' - ' cohortname])
        end
        set(ui_edit_grtab_cohortname, 'String', cohortname)
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
    end
    function cb_grtab_cohortname(~, ~)  % (src,event)
        cohort.setID(get(ui_edit_grtab_cohortname, 'String'));
        update_grtab_cohortname()
    end
    function cb_grtab_load_xls(~, ~)  % (src,event)
        try
        sub_class = cohort.getSubjectClass();
        cohort = eval([sub_class '.load_from_xls(' cohort ')']);             
%         update
        update_grtab_table()         
        catch
            errordlg(['The file is not a valid ' sub_class ' Subjects file. Please load a valid XLS file']);
        end
    end
    function cb_grtab_load_txt(~, ~)  % (src,event)
        try
        sub_class = cohort.getSubjectClass();
        cohort = eval([sub_class '.load_from_txt(' cohort ')']);         
        update
        update_grtab_table()        
        catch
            errordlg(['The file is not a valid ' sub_class ' Subjects file. Please load a valid TXT file']);
        end
    end
    function cb_grtab_load_json(~, ~)  % (src,event)
        try
        sub_class = cohort.getSubjectClass();
        cohort = eval([sub_class '.load_from_json(' cohort ')']);
        update
        update_grtab_table()
        update_group_popups()

        catch
            errordlg(['The file is not a valid ' sub_class ' Subjects file. Please load a valid JSON file']);
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
                cohort.getGroups().getValue(g).setID(newdata)   
            case GRTAB_LBL_COL
                cohort.getGroups().getValue(g).setLabel(newdata)
            case GRTAB_NOTES_COL
                cohort.getGroups().getValue(g).setNotes(newdata)
        end
        update_grtab_table()        
    end
    function cb_grtab_add_gr(~, ~)  % (src,event)
        group = Group(cohort.getSubjectClass(), 'GroupID 1', 'Label 1', 'Notes 1', {});
        cohort.getGroups().add(group.getID(), group);
        update_grtab_table()
    end
    function cb_grtab_remove_gr(~, ~)  % (src,event)
        selected_group = cohort.getGroups().remove_all(selected_group);
        update_grtab_table()
    end
    function cb_grtab_moveup_gr(~, ~)  % (src,event)
        selected_group = cohort.getGroups().move_up(selected_group);
        update_grtab_table()
    end
    function cb_grtab_movedown_gr(~, ~)  % (src,event)
        selected_group = cohort.getGroups().move_down(selected_group);
        update_grtab_table()
    end
    function cb_grtab_complementary(~, ~)  % (src,event)
        g = get(ui_popup_grtab_invert, 'Value');
        group = cohort.getGroups().getValue(g);
        complementary = cohort.notGroup(group);
        cohort.getGroups().add(complementary.getID(), complementary);
        update_grtab_table()
    end
    function cb_grtab_merge(~, ~)  % (src,event)
        g1 = get(ui_popup_grtab_merge1,'Value');
        g2 = get(ui_popup_grtab_merge2,'Value');
        group1 = cohort.getGroups().getValue(g1);
        group2 = cohort.getGroups().getValue(g2);
        union = cohort.orGroup(group1,group2);
        cohort.getGroups().add(union.getID(), union);
        update_grtab_table()
    end
    function cb_grtab_intersect(~, ~)  % (src,event)
        g1 = get(ui_popup_grtab_intersect1, 'Value');
        g2 = get(ui_popup_grtab_intersect2, 'Value');
        group1 = cohort.getGroups().getValue(g1);
        group2 = cohort.getGroups().getValue(g2);
        and_group = cohort.andGroup(group1, group2);
        cohort.getGroups().add(and_group.getID(), and_group);
        update_grtab_table()        
    end

% Menus
MENU_FILE = GUI.MENU_FILE;
MENU_GROUPS = 'Groups';


ui_menu_file = uimenu(f,'Label',MENU_FILE);
ui_menu_file_open = uimenu(ui_menu_file);
ui_menu_file_save = uimenu(ui_menu_file);
ui_menu_file_saveas = uimenu(ui_menu_file);
ui_menu_file_import_xml = uimenu(ui_menu_file);
ui_menu_file_export_xml = uimenu(ui_menu_file);
ui_menu_file_close = uimenu(ui_menu_file);
ui_menu_groups = uimenu(f,'Label',MENU_GROUPS);
ui_menu_groups_load_xls = uimenu(ui_menu_groups);
ui_menu_groups_load_txt = uimenu(ui_menu_groups);
ui_menu_groups_load_xml = uimenu(ui_menu_groups);
ui_menu_groups_add = uimenu(ui_menu_groups);
ui_menu_groups_remove = uimenu(ui_menu_groups);
ui_menu_groups_moveup = uimenu(ui_menu_groups);
ui_menu_groups_movedown = uimenu(ui_menu_groups);

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

        set(ui_menu_file_import_xml, 'Separator', 'on')
        set(ui_menu_file_import_xml, 'Label',IMPORT_JSON_CMD)
        set(ui_menu_file_import_xml, 'Callback', {@cb_import_xml})

        set(ui_menu_file_export_xml, 'Label', EXPORT_JSON_CMD)
        set(ui_menu_file_export_xml, 'Callback', {@cb_export_xml})

        set(ui_menu_file_close, 'Separator', 'on')
        set(ui_menu_file_close, 'Label', CLOSE_CMD)
        set(ui_menu_file_close, 'Accelerator', CLOSE_SC);
        set(ui_menu_file_close, 'Callback', ['GUI.close(''' APPNAME ''', gcf)'])        

        set(ui_menu_groups_load_xls, 'Label', GRTAB_LOAD_XLS_CMD)
        set(ui_menu_groups_load_xls, 'Callback', {@cb_grtab_load_xls})

        set(ui_menu_groups_load_txt, 'Label', GRTAB_LOAD_TXT_CMD)
        set(ui_menu_groups_load_txt, 'Callback', {@cb_grtab_load_txt})

        set(ui_menu_groups_load_xml, 'Label', GRTAB_LOAD_JSON_CMD)
        set(ui_menu_groups_load_xml, 'Callback', {@cb_grtab_load_xml})
                
        set(ui_menu_groups_add, 'Separator', 'on')
        set(ui_menu_groups_add, 'Label', ADD_GR_CMD)
        set(ui_menu_groups_add, 'Callback', {@cb_grtab_add_gr})
        
        set(ui_menu_groups_remove, 'Label', REMOVE_GR_CMD)
        set(ui_menu_groups_remove, 'Callback', {@cb_grtab_remove_gr})
            
        set(ui_menu_groups_moveup, 'Label', MOVEUP_GR_CMD)
        set(ui_menu_groups_moveup, 'Callback', {@cb_grtab_moveup_gr})
            
        set(ui_menu_groups_movedown, 'Label', MOVEDOWN_GR_CMD)
        set(ui_menu_groups_movedown, 'Callback', {@cb_grtab_movedown_gr})

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
         
    end
end