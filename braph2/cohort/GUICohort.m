function GUICohort(tmp, restricted)
% GUICohort Cohort Editor
%
% GUICOHORT(SUBJECT_CLASS) opens an empty cohort with empty atlas for SUBJECT_CLASS type 
%
% GUICOHORT(COHORT) opens a cohort
%
% GUICOHORT(COHORT, TRUE) opens a cohort with only reading and basic writing

APPNAME  = GUI.BAE_NAME;  % application name
BUILD = BRAPH2.BUILD;

% Dimensions
MARGIN_X = .01;
MARGIN_Y = .01;
LEFTCOLUMN_WIDTH = .29;
FILENAME_HEIGHT = .02;

MAINPANEL_X0 = LEFTCOLUMN_WIDTH + 2 * MARGIN_X;
MAINPANEL_Y0 = FILENAME_HEIGHT + 2 * MARGIN_Y;
MAINPANEL_WIDTH = 1 - LEFTCOLUMN_WIDTH - 3 * MARGIN_X;
MAINPANEL_HEIGHT = 1 - FILENAME_HEIGHT - 3 * MARGIN_Y;
MAINPANEL_POSITION = [MAINPANEL_X0 MAINPANEL_Y0 MAINPANEL_WIDTH MAINPANEL_HEIGHT];

% Commands
OPEN_CMD = GUI.OPEN_CMD; 
OPEN_SC = GUI.OPEN_SC;
OPEN_TP = ['Open Cohort. Shortcut: ' GUI.ACCELERATOR '+' OPEN_SC];

SAVE_CMD = GUI.SAVE_CMD;
SAVE_SC = GUI.SAVE_SC;
SAVE_TP = ['Save current Cohort. Shortcut: ' GUI.ACCELERATOR '+' SAVE_SC];

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
ADD_GR_TP = ['Add group at the end of table'];

REMOVE_GR_CMD = GUI.REMOVE_CMD;
REMOVE_GR_TP = ['Remove selected group'];

MOVEUP_GR_CMD = GUI.MOVEUP_CMD;
MOVEUP_GR_TP = ['Move selected group up'];

MOVEDOWN_GR_CMD = GUI.MOVEDOWN_CMD;
MOVEDOWN_GR_TP = ['Move selected group down'];

SELECTALL_SUB_CMD = 'Select all';
SELECTALL_SUB_TP = 'Select all subjects';

CLEARSELECTION_SUB_CMD = 'Clear selection';
CLEARSELECTION_SUB_TP = 'Clear subject selection';

ADD_SUB_CMD = 'Add subject';
ADD_SUBJECTS_TP = 'Add subject at the end of table';

ADDABOVE_SUB_CMD = 'Add above';
ADDABOVE_SUB_TP = 'Add subjects above selected ones';

ADDBELOW_SUB_CMD = 'Add below';
ADDBELOW_SUB_TP = 'Add subjects below selected ones';

REMOVE_SUB_CMD = 'Remove';
REMOVE_SUB_TP = 'Remove selected subjects';

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
else
    assert(ismember(tmp, Subject.getList()));
    atlas = BrainAtlas('BA ID', 'Brain Atlas Label', 'Brain atlas notes.', 'BrainMesh_ICBM152.nv', {});
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


end