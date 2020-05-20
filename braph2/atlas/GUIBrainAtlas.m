function GUIBrainAtlas(atlas,restricted)
% GUIBRAINATLAS  Brain Atlas Editor
%
% GUIBRAINATLAS() opens empty atlas.
%
% GUIBRAINATLAS(atlas) opens atlas.
%
% GUIBRAINATLAS(atlas,true) opens atlas with only reading and basic writing permissions.
%
% See also BrainAtlas, BNC, GUI.


%% General Constants
APPNAME = BRAPH2.NAME; % GUI.BAE_NAME;  % application name
BUILT = BRAPH2.BUILD;

% Dimensions
MARGIN_X = .01;
MARGIN_Y = .01;
LEFTCOLUMN_WIDTH = .39;
FILENAME_HEIGHT = .02;

MAINPANEL_X0 = LEFTCOLUMN_WIDTH + 2 * MARGIN_X;
MAINPANEL_Y0 = FILENAME_HEIGHT + 2 * MARGIN_Y;
MAINPANEL_WIDTH = 1 - LEFTCOLUMN_WIDTH - 3 * MARGIN_X;
MAINPANEL_HEIGHT = 1 - FILENAME_HEIGHT - 3 * MARGIN_Y;
MAINPANEL_POSITION = [MAINPANEL_X0 MAINPANEL_Y0 MAINPANEL_WIDTH MAINPANEL_HEIGHT];

% Commands
OPEN_CMD = GUI.OPEN_CMD;
OPEN_SC = GUI.OPEN_SC;
OPEN_TP = ['Open brain atlas. Shortcut: ' GUI.ACCELERATOR '+' OPEN_SC];

SAVE_CMD = GUI.SAVE_CMD;
SAVE_SC = GUI.SAVE_SC;
SAVE_TP = ['Save current brain atlas. Shortcut: ' GUI.ACCELERATOR '+' SAVE_SC];

SAVEAS_CMD = GUI.SAVEAS_CMD;
SAVEAS_TP = 'Open dialog box to save current brain atlas';

IMPORT_TXT_CMD = GUI.IMPORT_TXT_CMD;
IMPORT_TXT_TP = 'Import brain atlas from a txt file (tab-delimited text file)';

IMPORT_XLS_CMD = GUI.IMPORT_XLS_CMD;
IMPORT_XLS_TP = 'Import brain atlas from an Excel file';

IMPORT_JSON_CMD = GUI.IMPORT_JSON_CMD;
IMPORT_JSON_TP = 'Import brain atlas from a json file.';

EXPORT_TXT_CMD = GUI.EXPORT_TXT_CMD;
EXPORT_TXT_TP = 'Export brain atlas as a txt file (tab-delimited text file)';

EXPORT_XLS_CMD = GUI.EXPORT_XLS_CMD;
EXPORT_XLS_TP = 'Export brain atlas as a xls file.';

EXPORT_JSON_CMD = GUI.EXPORT_JSON_CMD;
EXPRT_JSON_TP = 'Export brain atlas as a json file.';

CLOSE_CMD = GUI.CLOSE_CMD;
CLOSE_SC = GUI.CLOSE_SC;
CLOSE_TP = ['Close ' APPNAME '. Shortcut: ' GUI.ACCELERATOR '+' CLOSE_SC];

SELECTALL_CMD = GUI.SELECTALL_CMD;
SELECTALL_TP = 'Select all brain regions';

CLEARSELECTION_CMD = GUI.CLEARSELECTION_CMD;
CLEARSELECTION_TP = 'Clear selection';

ADD_CMD = GUI.ADD_CMD;
ADD_SC = GUI.ADD_SC;
ADD_TP = ['Add brain region at the end of table. Shortcut: ' GUI.ACCELERATOR '+' ADD_SC];

ADDABOVE_CMD = GUI.ADDABOVE_CMD;
ADDABOVE_TP = 'Add brain regions above selected ones';

ADDBELOW_CMD = GUI.ADDBELOW_CMD;
ADDBELOW_TP = 'Add brain regions below selected ones';

REMOVE_CMD = GUI.REMOVE_CMD;
REMOVE_SC = GUI.REMOVE_SC;
REMOVE_TP = ['Remove selected brain regions. Shortcut: ' GUI.ACCELERATOR '+' REMOVE_SC];

MOVEUP_CMD = GUI.MOVEUP_CMD;
MOVEUP_SC = GUI.MOVEUP_SC;
MOVEUP_TP = ['Move selected brain regions up. Shortcut: ' GUI.ACCELERATOR '+' MOVEUP_SC];

MOVEDOWN_CMD = GUI.MOVEDOWN_CMD;
MOVEDOWN_SC = GUI.MOVEDOWN_SC;
MOVEDOWN_TP = ['Move selected brain regions down. Shortcut: ' GUI.ACCELERATOR '+' MOVEDOWN_SC];

MOVE2TOP_CMD = GUI.MOVE2TOP_CMD;
MOVE2TOP_SC = GUI.MOVE2TOP_SC;
MOVE2TOP_TP = ['Move selected brain regions to top of table. Shortcut: ' GUI.ACCELERATOR '+' MOVE2TOP_SC];

MOVE2BOTTOM_CMD = GUI.MOVE2BOTTOM_CMD;
MOVE2BOTTOM_SC = GUI.MOVE2BOTTOM_SC;
MOVE2BOTTOM_TP = ['Move selected brain regions to bottom of table. Shortcut: ' GUI.ACCELERATOR '+' MOVE2BOTTOM_SC];

FIGURE_CMD = GUI.FIGURE_CMD;
FIGURE_SC = GUI.FIGURE_SC;
FIGURE_TP = ['Generate brain figure. Shortcut: ' GUI.ACCELERATOR '+' FIGURE_SC];

MRICOHORT_CMD = 'New MRI Cohort ...';
MRICOHORT_TP = ['Generate new MRI cohort and opens it with ' GUI.MCE_NAME];

fMRICOHORT_CMD = 'New fMRI Cohort ...';
fMRICOHORT_TP = ['Generate new fMRI cohort and opens it with ' GUI.fMCE_NAME];

EEGCOHORT_CMD = 'New EEG Cohort ...';
EEGCOHORT_TP = ['Generate new EEG cohort and opens it with ' GUI.ECE_NAME];

PETCOHORT_CMD = 'New PET Cohort ...';
PETCOHORT_TP = ['Generate new PET cohort and opens it with ' GUI.PCE_NAME];

%% Application data
if ~exist('atlas','var')
    atlas = BrainAtlas('', '', '', {});
end
selected = [];

% Callbacks to manage application data
    function cb_open(~,~)  % (src,event)
        % select file
        [file,path,filterindex] = uigetfile(GUI.BAE_EXTENSION, GUI.BAE_MSG_GETFILE);
        % load file
        if filterindex
            filename = fullfile(path,file);
            tmp = load(filename, '-mat', 'atlas', 'selected', 'BUILT');
            if isa(tmp.atlas, 'BrainAtlas')
                atlas = tmp.atlas;
                selected = tmp.selected;
                setup()
                update_filename(filename)
            end
        end
    end
    function cb_save(~,~)
        filename = get(ui_text_filename,'String');
        if isempty(filename)  % (src,event)
            cb_saveas();
        else
            save(filename,'atlas','selected','BUILT');
        end
    end
    function cb_saveas(~,~)  % (src,event)
        % select file
        [file,path,filterindex] = uiputfile(GUI.BAE_EXTENSION,GUI.BAE_MSG_PUTFILE);
        % save file
        if filterindex
            filename = fullfile(path,file);
            save(filename,'atlas','selected','BUILT');
            update_filename(filename)
        end
    end
    function cb_import_txt(~,~)  % (scr,event)
       %  = ('', '', '', {});
        atlastmp = BrainAtlas.load_from_txt();
        if ~isempty(atlastmp)
            atlas = atlastmp;
            selected = [];
            setup()
            update_filename('')
        end
    end
    function cb_import_xls(~,~)  % (scr,event)
        atlastmp = BrainAtlas.load_from_xls();
        if  ~isempty(atlastmp)
            atlas = atlastmp;
            selected = [];
            setup()
            update_filename('')
        end
    end
    function cb_import_json(~,~)  % (src, event)
        atlastmp = BrainAtlas.load_from_json();
        if ~isempty(atlastmp)
            atlas = atlastmp;
            selected = [];
            setup()
            update_filename('')
        end
    end
    function cb_export_txt(~,~)  % (scr,event)
        BrainAtlas.save_to_txt(atlas);
    end
    function cb_export_xls(~,~)  % (src,event)
        BrainAtlas.save_to_xls(atlas);
    end
    function cb_export_json(~,~)
        BrainAtlas.save_to_json(atlas);
    end

% GUI application data
h_axis = [];
h_grid = [];

h_brain = [];
h_brain_visible = [];
h_brainalpha = [];

h_br = [];
h_br_visible = [];

h_labels = [];
h_labels_visible = [];

%% GUI inizialization
f = GUI.init_figure(APPNAME, .8, .8, 'northwest');
dcm = datacursormode(f);
init_datacursormode()
    function init_datacursormode()
        set(dcm,'UpdateFcn',{@cb_datacursor})
        set(dcm,'Enable','off')
    end
    function txt = cb_datacursor(~,~)  % (src,event)
        userdata = get(gco,'UserData');
        if isempty(userdata)
            txt = 'brain surface';
        else
            i = userdata{2};
            txt = {[atlas.getBrainRegions().getValue(i).getLabel() ' #' int2str(i)], ...
                atlas.get(i).getProp(BrainRegion.NAME), ...
                [FIG_XLABEL ' = ' num2str(atlas.getBrainRegions().getValue(i).getX()) ' ' FIG_UNITS], ...
                [FIG_YLABEL ' = ' num2str(atlas.getBrainRegions().getValue(i).getY()) ' ' FIG_UNITS], ...
                [FIG_ZLABEL ' = ' num2str(atlas.getBrainRegions().getValue(i).getZ()) ' ' FIG_UNITS], ...
                [lower(atlas.get(i).getProp(BrainRegion.HS)) ' hemisphere']};
        end
    end

%% Text File Name
FILENAME_WIDTH = 1-2*MARGIN_X;
FILENAME_POSITION = [MARGIN_X MARGIN_Y FILENAME_WIDTH FILENAME_HEIGHT];

ui_text_filename = uicontrol('Style','text');
init_filename()
    function init_filename()
        GUI.setUnits(ui_text_filename)
        GUI.setBackgroundColor(ui_text_filename)
        
        set(ui_text_filename,'Position',FILENAME_POSITION)
        set(ui_text_filename,'HorizontalAlignment','left')
    end
    function update_filename(filename)
        set(ui_text_filename,'String',filename)
    end

%% Panel Table
TAB_BR_SELECTED_COL = 1;
TAB_BR_LABEL_COL = 2;
TAB_BR_ID_COL = 3;
TAB_BR_X_COL = 4;
TAB_BR_Y_COL = 5;
TAB_BR_Z_COL = 6;
TAB_BR_NOTES_COL = 7;

TABLE_WIDTH = LEFTCOLUMN_WIDTH;
TABLE_HEIGHT = MAINPANEL_HEIGHT;
TABLE_X0 = MARGIN_X;
TABLE_Y0 = FILENAME_HEIGHT+2*MARGIN_Y;
TABLE_POSITION = [TABLE_X0 TABLE_Y0 TABLE_WIDTH TABLE_HEIGHT];

counter_add = 0;

ui_panel_table = uipanel();
ui_edit_table_atlasname = uicontrol(ui_panel_table,'Style','edit');
ui_table_table = uitable(ui_panel_table);
ui_button_table_selectall = uicontrol(ui_panel_table,'Style', 'pushbutton');
ui_button_table_clearselection = uicontrol(ui_panel_table,'Style', 'pushbutton');
ui_button_table_add = uicontrol(ui_panel_table,'Style', 'pushbutton');
ui_button_table_remove = uicontrol(ui_panel_table,'Style', 'pushbutton');
ui_button_table_moveup = uicontrol(ui_panel_table,'Style', 'pushbutton');
ui_button_table_movedown = uicontrol(ui_panel_table,'Style', 'pushbutton');
ui_button_table_move2top = uicontrol(ui_panel_table,'Style', 'pushbutton');
ui_button_table_move2bottom = uicontrol(ui_panel_table,'Style', 'pushbutton');
init_table()
    function init_table()
        GUI.setUnits(ui_panel_table)
        GUI.setBackgroundColor(ui_panel_table)
        
        set(ui_panel_table, 'Position', TABLE_POSITION)
        set(ui_panel_table, 'BorderType', 'none')
        
        set(ui_edit_table_atlasname, 'Position',[.02 .95 .96 .04])
        set(ui_edit_table_atlasname, 'HorizontalAlignment','left')
        set(ui_edit_table_atlasname, 'FontWeight','bold')
        set(ui_edit_table_atlasname, 'Callback',{@cb_table_atlasname})
        
        set(ui_table_table, 'Position', [.02 .16 .96 .77])
        set(ui_table_table, 'ColumnName', {'', 'Label', 'ID', 'x', 'y', 'z', 'Notes'})
        set(ui_table_table, 'ColumnFormat', {'logical', 'char', 'char', 'numeric', 'numeric', 'numeric', 'char'})
        set(ui_table_table, 'ColumnEditable', true)
        set(ui_table_table, 'CellEditCallback', {@cb_table_edit});
        
        set(ui_button_table_selectall, 'Position', [.02 .11 .21 .03])
        set(ui_button_table_selectall, 'String', SELECTALL_CMD)
        set(ui_button_table_selectall, 'TooltipString', SELECTALL_TP)
        set(ui_button_table_selectall, 'Callback', {@cb_table_selectall})
        
        set(ui_button_table_clearselection, 'Position', [.02 .08 .21 .03])
        set(ui_button_table_clearselection, 'String', CLEARSELECTION_CMD)
        set(ui_button_table_clearselection, 'TooltipString', CLEARSELECTION_TP)
        set(ui_button_table_clearselection, 'Callback', {@cb_table_clearselection})
        
        set(ui_button_table_add,'Position',[.27 .11 .21 .03])
        set(ui_button_table_add,'String',ADD_CMD)
        set(ui_button_table_add,'TooltipString',ADD_TP);
        set(ui_button_table_add,'Callback',{@cb_table_add})   
        
        set(ui_button_table_remove,'Position',[.52 .11 .21 .03])
        set(ui_button_table_remove,'String',REMOVE_CMD)
        set(ui_button_table_remove,'TooltipString',REMOVE_TP);
        set(ui_button_table_remove,'Callback',{@cb_table_remove})
        
        set(ui_button_table_moveup,'Position',[.77 .11 .21 .03])
        set(ui_button_table_moveup,'String',MOVEUP_CMD)
        set(ui_button_table_moveup,'TooltipString',MOVEUP_TP);
        set(ui_button_table_moveup,'Callback',{@cb_table_moveup})
        
        set(ui_button_table_movedown,'Position',[.77 .08 .21 .03])
        set(ui_button_table_movedown,'String',MOVEDOWN_CMD)
        set(ui_button_table_movedown,'TooltipString',MOVEDOWN_TP);
        set(ui_button_table_movedown,'Callback',{@cb_table_movedown})
        
        set(ui_button_table_move2top,'Position',[.77 .05 .21 .03])
        set(ui_button_table_move2top,'String',MOVE2TOP_CMD)
        set(ui_button_table_move2top,'TooltipString',MOVE2TOP_TP);
        set(ui_button_table_move2top,'Callback',{@cb_table_move2top})
        
        set(ui_button_table_move2bottom,'Position',[.77 .02 .21 .03])
        set(ui_button_table_move2bottom,'String',MOVE2BOTTOM_CMD)
        set(ui_button_table_move2bottom,'TooltipString',MOVE2BOTTOM_TP);
        set(ui_button_table_move2bottom,'Callback',{@cb_table_move2bottom})
    end
    function update_table_atlasname()
        atlasname = atlas.getID();
        if isempty(atlasname)
            set(f, 'Name', [APPNAME ' - ' BRAPH2.BUILD])
        else
            set(f, 'Name', [APPNAME ' - ' BRAPH2.BUILD ' - ' atlasname])
        end
        set(ui_edit_table_atlasname, 'String', atlasname)
    end
    function update_table_table()
        data = cell(atlas.getBrainRegions().length(), 8);
        for i = 1:1:atlas.getBrainRegions().length()
            if any(selected == i)
                data{i, TAB_BR_SELECTED_COL} = true;
            else
                data{i, TAB_BR_SELECTED_COL} = false;
            end
            data{i, TAB_BR_LABEL_COL} = atlas.getBrainRegions().getValue(i).getLabel();
            data{i, TAB_BR_ID_COL} = atlas.getBrainRegions().getValue(i).getID();
            data{i, TAB_BR_X_COL} = atlas.getBrainRegions().getValue(i).getX();
            data{i, TAB_BR_Y_COL} = atlas.getBrainRegions().getValue(i).getY();
            data{i, TAB_BR_Z_COL} = atlas.getBrainRegions().getValue(i).getZ();
            data{i, TAB_BR_NOTES_COL} = atlas.getBrainRegions().getValue(i).getNotes();
        end
        set(ui_table_table, 'Data', data)
    end
    function cb_table_atlasname(~,~)  % (src,event)
        atlas.setID(get(ui_edit_table_atlasname, 'String')); 
        update_table_atlasname()
    end
    function cb_table_edit(~,event)  % (src,event)
        i = event.Indices(1);
        col = event.Indices(2);
        newdata = event.NewData;
        switch col
            case TAB_BR_SELECTED_COL
                if newdata==1
                    selected = sort(unique([selected(:); i]));
                else
                    selected = selected(selected~=i);
                end
            case TAB_BR_LABEL_COL
                atlas.getBrainRegions().getValue(i).setLabel(newdata)
            case TAB_BR_ID_COL
                atlas.getBrainRegions().getValue(i).setID(newdata)
                oldkey = atlas.getBrainRegions().getKey(i);
                atlas.getBrainRegions().replaceKey(oldkey, newdata);
            case TAB_BR_X_COL
                atlas.getBrainRegions().getValue(i).setX(newdata)
            case TAB_BR_Y_COL
                atlas.getBrainRegions().getValue(i).setY(newdata)
            case TAB_BR_Z_COL
                atlas.getBrainRegions().getValue(i).setZ(newdata)
            case TAB_BR_NOTES_COL
                atlas.getBrainRegions().getValue(i).setNotes(newdata)
        end
        update_figure_brainview()
    end
    function cb_table_selectall(~,~)  % (src,event)
        selected = (1:1:atlas.getBrainRegions().length())';
        update_table_table()
        update_figure_brainview()
    end
    function cb_table_clearselection(~,~)  % (src,event)
        selected = [];
        update_table_table()
        update_figure_brainview()
    end
    function cb_table_add(~,~)  % (src,event)
        counter_add = counter_add + 1;
        dummyBrainRegion = BrainRegion(['ID' num2str(counter_add)],'Label','Notes',0,0,0);  % maybe have a counter to change ID
        atlas.getBrainRegions().add(dummyBrainRegion.getID(), dummyBrainRegion);
        update_table_table()
        update_figure_brainview()
    end
    function cb_table_remove(~,~)  % (src,event)
        selected = atlas.getBrainRegions().remove_all(selected);
        update_table_table()
        update_figure_brainview()
    end
    function cb_table_moveup(~,~)  % (src,event)
        selected = atlas.getBrainRegions().move_up(selected);
        update_table_table()
        update_figure_brainview()
    end
    function cb_table_movedown(~,~)  % (src,event)
        selected = atlas.getBrainRegions().move_down(selected);
        update_table_table()
        update_figure_brainview()
    end
    function cb_table_move2top(~,~)  % (src,event)
        selected = atlas.getBrainRegions().move_to_top(selected);
        update_table_table()
        update_figure_brainview()
    end
    function cb_table_move2bottom(~,~)  % (src,event)
        selected = atlas.getBrainRegions().move_to_bottom(selected);
        update_table_table()
        update_figure_brainview()
    end

%% Panel Figure
FIG_BRAIN_CMD = 'Show brain';
FIG_BRAIN_TP = 'Brain surface on/off';

FIG_BRAINALPHA_CMD = 'Brain transparency';
FIG_BRAINALPHA_TP = 'Adjust the transparency of the brain surface';

FIG_AXIS_CMD = 'Show axis';
FIG_AXIS_TP = 'Toggle axis on/off';

FIG_GRID_CMD = 'Show grid';
FIG_GRID_TP = 'Toggle grid on/off';

FIG_LABELS_CMD = 'Show labels';
FIG_LABELS_TP = 'Toggle labels on/off';

FIG_BR_CMD = 'Show brain regions';
FIG_BR_TP = 'Toggle brain regions'' markers on/off';

FIG_VIEW_3D_CMD = PlotBrainAtlas.VIEW_3D_CMD;
FIG_VIEW_SR_CMD = PlotBrainAtlas.VIEW_SR_CMD;
FIG_VIEW_SL_CMD = PlotBrainAtlas.VIEW_SL_CMD;
FIG_VIEW_AD_CMD = PlotBrainAtlas.VIEW_AD_CMD;
FIG_VIEW_AV_CMD = PlotBrainAtlas.VIEW_AV_CMD;
FIG_VIEW_CA_CMD = PlotBrainAtlas.VIEW_CA_CMD;
FIG_VIEW_CP_CMD = PlotBrainAtlas.VIEW_CP_CMD;

FIG_ZOOMIN_CMD = 'Zoom in';
FIG_ZOOMIN_TP = 'Zoom in';

FIG_ZOOMOUT_CMD = 'Zoom out';
FIG_ZOOMOUT_TP = 'Zoom out';

FIG_PAN_CMD = 'Pan';
FIG_PAN_TP = 'Pan';

FIG_ROTATE3D_CMD = '3D rotation';
FIG_ROTATE3D_TP = '3D rotation';

FIG_DATACURSOR_CMD = 'Data cursor';
FIG_DATACURSOR_TP = 'Data cursor';

FIG_SELECTBR_CMD = 'Select';
FIG_DESELECTBR_CMD = 'Deselect';
FIG_INFOBR_CMD = 'Info';

FIG_INIT_AXISON = 1;
FIG_INIT_GRIDON = 1;
FIG_INIT_LABELSON = 1;
FIG_INIT_BRAIN_VISIBLE = 1;
FIG_INIT_BRAIN_ALPHA = .5;

FIG_XLABEL = 'x';
FIG_YLABEL = 'y';
FIG_ZLABEL = 'z';
FIG_UNITS = 'mm';
FIG_EDGECOLOR = 'none';
FIG_FACECOLOR = [.5 .5 .5];

FIG_INIT_BR_VISIBLE = 1;
FIG_BR_MARKER = 'o';
FIG_BR_COLOR = 'b';
FIG_BR_SIZE = 10;
FIG_BRSELECTED_MARKER = FIG_BR_MARKER;
FIG_BRSELECTED_COLOR = 'r';
FIG_BRSELECTED_SIZE = FIG_BR_SIZE;

FIGURE_POSITION = MAINPANEL_POSITION;

ui_panel_figure = uipanel();
ui_axes_figure = axes();
ui_checkbox_figure_brain = uicontrol(ui_panel_figure,'Style','checkbox');
ui_slider_figure_brainalpha = uicontrol(ui_panel_figure,'Style','slider');
ui_checkbox_figure_axis = uicontrol(ui_panel_figure,'Style','checkbox');
ui_checkbox_figure_grid = uicontrol(ui_panel_figure,'Style','checkbox');
ui_checkbox_figure_br = uicontrol(ui_panel_figure,'Style','checkbox');
ui_checkbox_figure_labels = uicontrol(ui_panel_figure,'Style','checkbox');
ui_button_figure_3d = uicontrol(ui_panel_figure,'Style','pushbutton');
ui_button_figure_sagittalright = uicontrol(ui_panel_figure,'Style','pushbutton');
ui_button_figure_sagittalleft = uicontrol(ui_panel_figure,'Style','pushbutton');
ui_button_figure_axialdorsal = uicontrol(ui_panel_figure,'Style','pushbutton');
ui_button_figure_axialventral = uicontrol(ui_panel_figure,'Style','pushbutton');
ui_button_figure_coronalanterior = uicontrol(ui_panel_figure,'Style','pushbutton');
ui_button_figure_coronalposterior = uicontrol(ui_panel_figure,'Style','pushbutton');
init_figure()
    function init_figure()
        GUI.setUnits(ui_panel_figure)
         GUI.setBackgroundColor(ui_panel_figure)
        
        set(ui_panel_figure,'Position',FIGURE_POSITION)
        
        set(ui_axes_figure,'Parent',ui_panel_figure)
        set(ui_axes_figure,'Position',[.02 .20 .96 .78])
        
        set(ui_checkbox_figure_brain,'Position',[.10 .11 .10 .03])
        set(ui_checkbox_figure_brain,'String',FIG_BRAIN_CMD)
        set(ui_checkbox_figure_brain,'Value',true)
        set(ui_checkbox_figure_brain,'TooltipString',FIG_BRAIN_TP)
        set(ui_checkbox_figure_brain,'Callback',{@cb_figure_plotsettings})
        
        set(ui_slider_figure_brainalpha,'Position',[.30 .105 .40 .03])
        set(ui_slider_figure_brainalpha,'String',FIG_BRAINALPHA_CMD)
        set(ui_slider_figure_brainalpha,'Min',0,'Max',1,'Value',FIG_INIT_BRAIN_ALPHA)
        set(ui_slider_figure_brainalpha,'TooltipString',FIG_BRAINALPHA_TP)
        set(ui_slider_figure_brainalpha,'Callback',{@cb_figure_plotsettings})
        
        set(ui_checkbox_figure_axis,'Position',[.80 .11 .18 .03])
        set(ui_checkbox_figure_axis,'String',FIG_AXIS_CMD)
        set(ui_checkbox_figure_axis,'Value',true)
        set(ui_checkbox_figure_axis,'TooltipString',FIG_AXIS_TP)
        set(ui_checkbox_figure_axis,'Callback',{@cb_figure_plotsettings})
        
        set(ui_checkbox_figure_grid,'Position',[.80 .08 .18 .03])
        set(ui_checkbox_figure_grid,'String',FIG_GRID_CMD)
        set(ui_checkbox_figure_grid,'Value',true)
        set(ui_checkbox_figure_grid,'TooltipString',FIG_GRID_TP);
        set(ui_checkbox_figure_grid,'Callback',{@cb_figure_plotsettings})
        
        set(ui_checkbox_figure_br,'Position',[.80 .05 .18 .03])
        set(ui_checkbox_figure_br,'String',FIG_BR_CMD)
        set(ui_checkbox_figure_br,'Value',true)
        set(ui_checkbox_figure_br,'TooltipString',FIG_BR_TP);
        set(ui_checkbox_figure_br,'Callback',{@cb_figure_plotsettings})
        
        set(ui_checkbox_figure_labels,'Position',[.80 .02 .18 .03])
        set(ui_checkbox_figure_labels,'String',FIG_LABELS_CMD)
        set(ui_checkbox_figure_labels,'Value',true)
        set(ui_checkbox_figure_labels,'TooltipString',FIG_LABELS_TP);
        set(ui_checkbox_figure_labels,'Callback',{@cb_figure_plotsettings})
        
        set(ui_button_figure_3d,'Position',[.10 .05 .14 .03])
        set(ui_button_figure_3d,'String',FIG_VIEW_3D_CMD)
        set(ui_button_figure_3d,'Callback',{@cb_figure_plotsettings})
        
        set(ui_button_figure_sagittalleft,'Position',[.25 .05 .14 .03])
        set(ui_button_figure_sagittalleft,'String',FIG_VIEW_SL_CMD)
        set(ui_button_figure_sagittalleft,'Callback',{@cb_figure_plotsettings})
        
        set(ui_button_figure_sagittalright,'Position',[.25 .02 .14 .03])
        set(ui_button_figure_sagittalright,'String',FIG_VIEW_SR_CMD)
        set(ui_button_figure_sagittalright,'Callback',{@cb_figure_plotsettings})
        
        set(ui_button_figure_axialdorsal,'Position',[.40 .05 .14 .03])
        set(ui_button_figure_axialdorsal,'String',FIG_VIEW_AD_CMD)
        set(ui_button_figure_axialdorsal,'Callback',{@cb_figure_plotsettings})
        
        set(ui_button_figure_axialventral,'Position',[.40 .02 .14 .03])
        set(ui_button_figure_axialventral,'String',FIG_VIEW_AV_CMD)
        set(ui_button_figure_axialventral,'Callback',{@cb_figure_plotsettings})
        
        set(ui_button_figure_coronalanterior,'Position',[.55 .05 .14 .03])
        set(ui_button_figure_coronalanterior,'String',FIG_VIEW_CA_CMD)
        set(ui_button_figure_coronalanterior,'Callback',{@cb_figure_plotsettings})
        
        set(ui_button_figure_coronalposterior,'Position',[.55 .02 .14 .03])
        set(ui_button_figure_coronalposterior,'String',FIG_VIEW_CP_CMD)
        set(ui_button_figure_coronalposterior,'Callback',{@cb_figure_plotsettings})
    end
ui_contextmenu_figure_select = uicontextmenu();
ui_contextmenu_figure_select_select = uimenu(ui_contextmenu_figure_select);
ui_contextmenu_figure_select_info = uimenu(ui_contextmenu_figure_select);
ui_contextmenu_figure_deselect = uicontextmenu();
ui_contextmenu_figure_deselect_deselect = uimenu(ui_contextmenu_figure_deselect);
ui_contextmenu_figure_deselect_info = uimenu(ui_contextmenu_figure_deselect);

% new uicontextmenu
ui_contextmenu_brain = uicontextmenu();
ui_contextmenu_brain_settings = uimenu(ui_contextmenu_brain);

init_contextmenu()
    function init_contextmenu()
        set(ui_contextmenu_figure_select_select,'Label',FIG_SELECTBR_CMD)
        set(ui_contextmenu_figure_select_select,'Callback',{@cb_figure_selectbr})
        
        set(ui_contextmenu_figure_select_info,'Label',FIG_INFOBR_CMD)
        set(ui_contextmenu_figure_select_info,'Callback',{@cb_figure_infobr})
        
        set(ui_contextmenu_figure_deselect_deselect,'Label',FIG_DESELECTBR_CMD)
        set(ui_contextmenu_figure_deselect_deselect,'Callback',{@cb_figure_deselectbr})
        
        set(ui_contextmenu_figure_deselect_info,'Label',FIG_INFOBR_CMD)
        set(ui_contextmenu_figure_deselect_info,'Callback',{@cb_figure_infobr})
        
        set(ui_contextmenu_brain_settings, 'Label', 'Brain Settings')
        set(ui_contextmenu_brain_settings, 'Callback', {@cb_brain_settings})
    end
    function create_figure()
        h_axis = FIG_INIT_AXISON;
        axis on
        
        h_grid = FIG_INIT_GRIDON;
        grid on
        
        delete(h_brain)
        h_brain = [];
        h_brain_visible = FIG_INIT_BRAIN_VISIBLE;
        h_brainalpha = FIG_INIT_BRAIN_ALPHA;
        
        delete(h_br)
        h_br = [];
        h_br_visible = FIG_INIT_BR_VISIBLE;
        
        delete(h_labels)
        h_labels = [];
        h_labels_visible = FIG_INIT_LABELSON;
        
        axes(ui_axes_figure)
        hold on
        daspect([1 1 1]);
        
        xlabel([FIG_XLABEL ' ' GUI.BRA_UNITS FIG_UNITS GUI.KET_UNITS])
        ylabel([FIG_YLABEL ' ' GUI.BRA_UNITS FIG_UNITS GUI.KET_UNITS])
        zlabel([FIG_ZLABEL ' ' GUI.BRA_UNITS FIG_UNITS GUI.KET_UNITS])
        
        ui_contextmenu_brain = uicontextmenu();
        ui_contextmenu_brain_settings = uimenu(ui_contextmenu_brain);
        set(ui_contextmenu_brain_settings,'Label','Brain Settings')
        set(ui_contextmenu_brain_settings,'Callback',{@cb_brainview_brain_settings})
        
        ui_contextmenu_brain_light = uimenu(ui_contextmenu_brain);
        set(ui_contextmenu_brain_light,'Label','Brain Light')
        set(ui_contextmenu_brain_light,'Callback',{@cb_brainview_brain_light})
        
        h_brain_obj = atlas.getPlotBrainSurf();
        h_brain = h_brain_obj.brain();
        set(h_brain,'EdgeColor',FIG_EDGECOLOR);
        set(h_brain,'FaceColor',FIG_FACECOLOR);
        set(h_brain,'FaceAlpha',h_brainalpha, 'UiContextMenu', ui_contextmenu_brain);
      
        
        function cb_brainview_brain_settings(~, ~)
            h_brain_obj.brain_settings();
        end      
        function cb_brainview_brain_light(~, ~)
            h_brain_obj.brain_lighting();
        end      
        
        update_figure_light()
        
        update_figure_brainview()
    end
    function update_figure_brainview()
        
        ui_contextmenu_brain = uicontextmenu();
        ui_contextmenu_brain_settings = uimenu(ui_contextmenu_brain);
        set(ui_contextmenu_brain_settings,'Label','Settings')
        set(ui_contextmenu_brain_settings,'Callback',{@cb_brainview_brain_settings})
        
        if get(ui_checkbox_figure_axis,'Value')~=h_axis
            h_axis = get(ui_checkbox_figure_axis,'Value');
            if h_axis
                axis on
                set(ui_toolbar_axis,'State','on')
            else
                axis off
                set(ui_toolbar_axis,'State','off')
            end
        end
        
        if get(ui_checkbox_figure_grid,'Value')~=h_grid
            h_grid = get(ui_checkbox_figure_grid,'Value');
            if h_grid
                grid on
                set(ui_toolbar_grid,'State','on');
            else
                grid off
                set(ui_toolbar_grid,'State','off');
            end
        end
        
        if get(ui_button_figure_3d,'Value')
            view(3)
            update_figure_light()
            set(ui_button_figure_3d,'Value',0);
        elseif get(ui_button_figure_sagittalleft,'Value')
            view(-90,0)
            update_figure_light()
            set(ui_button_figure_sagittalleft,'Value',0);
        elseif get(ui_button_figure_sagittalright,'Value')
            view(+90,0)
            update_figure_light()
            set(ui_button_figure_sagittalright,'Value',0);
        elseif get(ui_button_figure_axialdorsal,'Value')
            view(0,+90)
            update_figure_light()
            set(ui_button_figure_axialdorsal,'Value',0);
        elseif get(ui_button_figure_axialventral,'Value')
            view(0,-90)
            update_figure_light()
            set(ui_button_figure_axialventral,'Value',0);
        elseif get(ui_button_figure_coronalanterior,'Value')
            view(180,0)
            update_figure_light()
            set(ui_button_figure_coronalanterior,'Value',0);
        elseif get(ui_button_figure_coronalposterior,'Value')
            view(0,0)
            update_figure_light()
            set(ui_button_figure_coronalposterior,'Value',0);
        end
        
        % brain
        if get(ui_checkbox_figure_brain,'Value')~=h_brain_visible
            h_brain_visible = get(ui_checkbox_figure_brain,'Value');
            if h_brain_visible  % brain surface on
                set(h_brain,'Visible','on')
                set(ui_toolbar_brain,'State','on');
            else
                set(h_brain,'Visible','off')
                set(ui_toolbar_brain,'State','off');
            end
        end
        
        if h_brain_visible
            if get(ui_slider_figure_brainalpha,'Value')~=h_brainalpha
                h_brainalpha = get(ui_slider_figure_brainalpha,'Value');
                set(h_brain,'FaceAlpha',h_brainalpha);
            end
        end
        
        % brain regions
        if get(ui_checkbox_figure_br,'Value')~=h_br_visible
            h_br_visible = get(ui_checkbox_figure_br,'Value');
            if h_br_visible  % brain regions on
                set(h_br,'Visible','on')
                set(ui_toolbar_br,'State','on');
            else
                set(h_br,'Visible','off')
                set(ui_toolbar_br,'State','off');
            end
        end
        
        % labels
        if get(ui_checkbox_figure_labels,'Value')~=h_labels_visible
            h_labels_visible = get(ui_checkbox_figure_labels,'Value');
            if h_labels_visible  % labels on
                set(h_labels,'Visible','on')
                set(ui_toolbar_label,'State','on')
            else
                set(h_labels,'Visible','off')
                set(ui_toolbar_label,'State','off')
            end
        end
        
        % brain regions and labels
        if h_br_visible || h_labels_visible
            
            if length(h_br)<atlas.getBrainRegions().length()  % create new markers as needed
                for i = length(h_br)+1:1:atlas.getBrainRegions().length()
                    create_figure_brainregionplot(i);
                end
            else % eliminate unnecessary markers as needed
                delete(h_br(atlas.getBrainRegions().length()+1:1:end))
                h_br = h_br(1:1:atlas.getBrainRegions().length());
                
                delete(h_labels(atlas.getBrainRegions().length()+1:1:end))
                h_labels = h_labels(1:1:atlas.getBrainRegions().length());
            end
            
            for i = 1:1:atlas.getBrainRegions().length()
                userdata = get(h_br(i),'UserData');
                if xor(userdata{1},any(selected==i)) || ...
                        userdata{3}~=atlas.getBrainRegions().getValue(i).getX() || ...
                        userdata{4}~=atlas.getBrainRegions().getValue(i).getY() || ...
                        userdata{5}~=atlas.getBrainRegions().getValue(i).getZ() || ...
                        ~strcmp(userdata{6},atlas.getBrainRegions().getValue(i).getLabel())
                    update_figure_brainregionplot(i);
                end
            end
        end
    end
    function update_figure_light()
        delete(findall(f,'Type','light'));
        material dull
        lighting gouraud
        camlight('Headlight')
    end
    function create_figure_brainregionplot(i)
        X = atlas.getBrainRegions().getValue(i).getX();
        Y = atlas.getBrainRegions().getValue(i).getY();
        Z = atlas.getBrainRegions().getValue(i).getZ();
        label = atlas.getBrainRegions().getValue(i).getLabel();
        if any(selected==i)
            h_br(i) = plot3(X,Y,Z, ...
                'Marker',FIG_BRSELECTED_MARKER, ...
                'MarkerFaceColor',FIG_BRSELECTED_COLOR, ...
                'MarkerEdgeColor',FIG_BRSELECTED_COLOR, ...
                'MarkerSize',FIG_BRSELECTED_SIZE, ...
                'UIContextMenu',ui_contextmenu_figure_deselect, ...
                'UserData',{1 i X Y Z label});
            h_labels(i) = text(X,Y,Z,label);
        else
            h_br(i) = plot3(X,Y,Z, ...
                'Marker',FIG_BR_MARKER, ...
                'MarkerFaceColor',FIG_BR_COLOR, ...
                'MarkerEdgeColor',FIG_BR_COLOR, ...
                'MarkerSize',FIG_BR_SIZE, ...
                'UIContextMenu',ui_contextmenu_figure_select, ...
                'UserData',{0 i X Y Z label});
            h_labels(i) = text(X,Y,Z,label);
        end
    end
    function update_figure_brainregionplot(i)
        X = atlas.getBrainRegions().getValue(i).getX();
        Y = atlas.getBrainRegions().getValue(i).getY();
        Z = atlas.getBrainRegions().getValue(i).getZ();
        label = atlas.getBrainRegions().getValue(i).getLabel();
        if any(selected==i)
            set(h_br(i), ...
                'XData',X, ...
                'YData',Y, ...
                'ZData',Z, ...
                'MarkerFaceColor',FIG_BRSELECTED_COLOR, ...
                'MarkerEdgeColor',FIG_BRSELECTED_COLOR, ...
                'UIContextMenu',ui_contextmenu_figure_deselect, ...
                'UserData',{1 i X Y Z label});
            set(h_labels(i), ...
                'Position',[X Y Z], ...
                'String',label);
        else
            set(h_br(i), ...
                'XData',X, ...
                'YData',Y, ...
                'ZData',Z, ...
                'MarkerFaceColor',FIG_BR_COLOR, ...
                'MarkerEdgeColor',FIG_BR_COLOR, ...
                'UIContextMenu',ui_contextmenu_figure_select, ...
                'UserData',{0 i X Y Z label});
            set(h_labels(i), ...
                'Position',[X Y Z], ...
                'String',label);
        end
    end
    function cb_figure_plotsettings(~,~)  % (src,event)
        update_figure_brainview()
    end
    function cb_figure_selectbr(~,~)  % (src,event)
        userdata = get(gco,'UserData');
        i = userdata{2};
        selected = sort([selected; i]);
        update_table_table()
        update_figure_brainview()
    end
    function cb_figure_deselectbr(~,~)  % (src,event)
        userdata = get(gco,'UserData');
        i = userdata{2};
        selected = selected(selected~=i);
        update_table_table()
        update_figure_brainview()
    end
    function cb_figure_infobr(~,~)  % (src,event)
        set(dcm,'enable','on')
    end

%% Menus
MENU_FILE = GUI.MENU_FILE;
MENU_EDIT = GUI.MENU_EDIT;
MENU_BRAINVIEW = 'Brain View';
MENU_COHORTS = 'Subject Cohorts';

ui_menu_file = uimenu(f,'Label',MENU_FILE);
ui_menu_file_open = uimenu(ui_menu_file);
ui_menu_file_save = uimenu(ui_menu_file);
ui_menu_file_saveas = uimenu(ui_menu_file);
ui_menu_file_import_txt = uimenu(ui_menu_file);
ui_menu_file_import_xls = uimenu(ui_menu_file);
ui_menu_file_import_json = uimenu(ui_menu_file);
ui_menu_file_export_txt = uimenu(ui_menu_file);
ui_menu_file_export_xls = uimenu(ui_menu_file);
ui_menu_file_export_json = uimenu(ui_menu_file);
ui_menu_file_close = uimenu(ui_menu_file);
ui_menu_edit = uimenu(f,'Label',MENU_EDIT);
ui_menu_edit_selectall = uimenu(ui_menu_edit);
ui_menu_edit_clearselection = uimenu(ui_menu_edit);
ui_menu_edit_add = uimenu(ui_menu_edit);
ui_menu_edit_remove = uimenu(ui_menu_edit);
ui_menu_edit_moveup = uimenu(ui_menu_edit);
ui_menu_edit_movedown = uimenu(ui_menu_edit);
ui_menu_edit_move2top = uimenu(ui_menu_edit);
ui_menu_edit_move2bottom = uimenu(ui_menu_edit);
ui_menu_brainview = uimenu(f,'Label',MENU_BRAINVIEW);
ui_menu_brainview_figure = uimenu(ui_menu_brainview);
ui_menu_cohorts = uimenu(f,'Label',MENU_COHORTS);
ui_menu_cohorts_mricohort = uimenu(ui_menu_cohorts);
ui_menu_cohorts_fmricohort = uimenu(ui_menu_cohorts);
ui_menu_cohorts_eegcohort = uimenu(ui_menu_cohorts);
ui_menu_cohorts_petcohort = uimenu(ui_menu_cohorts);
init_menu()
    function init_menu()
        set(ui_menu_file_open,'Label',OPEN_CMD)
        set(ui_menu_file_open,'Accelerator',OPEN_SC)
        set(ui_menu_file_open,'Callback',{@cb_open})
        
        set(ui_menu_file_save,'Separator','on')
        set(ui_menu_file_save,'Label',SAVE_CMD)
        set(ui_menu_file_save,'Accelerator',SAVE_SC)
        set(ui_menu_file_save,'Callback',{@cb_save})
        
        set(ui_menu_file_saveas,'Label',SAVEAS_CMD)
        set(ui_menu_file_saveas,'Callback',{@cb_saveas});
        
        % menu import
        set(ui_menu_file_import_txt,'Separator','on')
        set(ui_menu_file_import_txt,'Label', IMPORT_TXT_CMD)
        set(ui_menu_file_import_txt,'Callback',{@cb_import_txt})
        
        set(ui_menu_file_import_xls,'Label', IMPORT_XLS_CMD)
        set(ui_menu_file_import_xls,'Callback',{@cb_import_xls})
        
        set(ui_menu_file_import_json,'Label', IMPORT_JSON_CMD)
        set(ui_menu_file_import_json,'Callback',{@cb_import_json})
        
        % menu export
        set(ui_menu_file_export_txt,'Label',EXPORT_TXT_CMD)
        set(ui_menu_file_export_txt,'Callback',{@cb_export_txt})
        
        set(ui_menu_file_export_xls,'Label',EXPORT_XLS_CMD)
        set(ui_menu_file_export_xls,'Callback',{@cb_export_xls})
        
        set(ui_menu_file_export_json,'Label',EXPORT_JSON_CMD)
        set(ui_menu_file_export_json,'Callback',{@cb_export_json})
        
        set(ui_menu_file_close,'Separator','on')
        set(ui_menu_file_close,'Label',CLOSE_CMD)
        set(ui_menu_file_close,'Accelerator',CLOSE_SC);
        set(ui_menu_file_close,'Callback',['GUI.close(''' APPNAME ''',gcf)'])
        
        set(ui_menu_edit_selectall,'Label',SELECTALL_CMD)
        set(ui_menu_edit_selectall,'Callback',{@cb_table_selectall})
        
        set(ui_menu_edit_clearselection,'Label',CLEARSELECTION_CMD)
        set(ui_menu_edit_clearselection,'Callback',{@cg_table_clearselection})
        
        set(ui_menu_edit_add,'Separator','on')
        set(ui_menu_edit_add,'Label',ADD_CMD)
        set(ui_menu_edit_add,'Accelerator',ADD_SC)
        set(ui_menu_edit_add,'Callback',{@cb_table_add})
        
        set(ui_menu_edit_remove,'Label',REMOVE_CMD)
        set(ui_menu_edit_remove,'Accelerator',REMOVE_SC)
        set(ui_menu_edit_remove,'Callback',{@cb_table_remove})
        
        set(ui_menu_edit_moveup,'Separator','on')
        set(ui_menu_edit_moveup,'Label',MOVEUP_CMD)
        set(ui_menu_edit_moveup,'Accelerator',MOVEUP_SC)
        set(ui_menu_edit_moveup,'Callback',{@cb_table_moveup})
        
        set(ui_menu_edit_movedown,'Label',MOVEDOWN_CMD)
        set(ui_menu_edit_movedown,'Accelerator',MOVEDOWN_SC)
        set(ui_menu_edit_movedown,'Callback',{@cb_table_movedown})
        
        set(ui_menu_edit_move2top,'Label',MOVE2TOP_CMD)
        set(ui_menu_edit_move2top,'Accelerator',MOVE2TOP_SC)
        set(ui_menu_edit_move2top,'Callback',{@cb_vmove2top})
        
        set(ui_menu_edit_move2bottom,'Label',MOVE2BOTTOM_CMD)
        set(ui_menu_edit_move2bottom,'Accelerator',MOVE2BOTTOM_SC)
        set(ui_menu_edit_move2bottom,'Callback',{@cb_table_move2bottom})
        
        set(ui_menu_brainview_figure,'Label',FIGURE_CMD)
        set(ui_menu_brainview_figure,'Accelerator',FIGURE_SC)
        set(ui_menu_brainview_figure,'Callback',{@cb_menu_figure})
        
        set(ui_menu_cohorts_mricohort,'Label',MRICOHORT_CMD)
        set(ui_menu_cohorts_mricohort,'Callback',{@cb_menu_mricohort})
        
        set(ui_menu_cohorts_fmricohort,'Label',fMRICOHORT_CMD)
        set(ui_menu_cohorts_fmricohort,'Callback',{@cb_menu_fmricohort})
        
        set(ui_menu_cohorts_eegcohort,'Label',EEGCOHORT_CMD)
        set(ui_menu_cohorts_eegcohort,'Callback',{@cb_menu_eegcohort})
        
        set(ui_menu_cohorts_petcohort,'Label',PETCOHORT_CMD)
        set(ui_menu_cohorts_petcohort,'Callback',{@cb_menu_petcohort})
    end
[ui_menu_about,ui_menu_about_about] = GUI.setMenuAbout(f,APPNAME);

%% Toolbar
set(f,'Toolbar','figure')
ui_toolbar = findall(f,'Tag','FigureToolBar');
ui_toolbar_open = findall(ui_toolbar,'Tag','Standard.FileOpen');
ui_toolbar_save = findall(ui_toolbar,'Tag','Standard.SaveFigure');
ui_toolbar_zoomin = findall(ui_toolbar,'Tag','Exploration.ZoomIn');
ui_toolbar_zoomout = findall(ui_toolbar,'Tag','Exploration.ZoomOut');
ui_toolbar_pan = findall(ui_toolbar,'Tag','Exploration.Pan');
ui_toolbar_rotate = findall(ui_toolbar,'Tag','Exploration.Rotate');
ui_toolbar_datacursor = findall(ui_toolbar,'Tag','Exploration.DataCursor');
ui_toolbar_3D = uipushtool(ui_toolbar);
ui_toolbar_SL = uipushtool(ui_toolbar);
ui_toolbar_SR = uipushtool(ui_toolbar);
ui_toolbar_AD = uipushtool(ui_toolbar);
ui_toolbar_AV = uipushtool(ui_toolbar);
ui_toolbar_CA = uipushtool(ui_toolbar);
ui_toolbar_CP = uipushtool(ui_toolbar);
ui_toolbar_brain = uitoggletool(ui_toolbar);
ui_toolbar_axis = uitoggletool(ui_toolbar);
ui_toolbar_grid = uitoggletool(ui_toolbar);
ui_toolbar_br = uitoggletool(ui_toolbar);
ui_toolbar_label = uitoggletool(ui_toolbar);
init_toolbar()
    function init_toolbar()
        % get(findall(ui_toolbar),'Tag')
        delete(findall(ui_toolbar,'Tag','Standard.NewFigure'))
        % delete(findall(ui_toolbar,'Tag','Standard.FileOpen'))
        % delete(findall(ui_toolbar,'Tag','Standard.SaveFigure'))
        delete(findall(ui_toolbar,'Tag','Standard.PrintFigure'))
        delete(findall(ui_toolbar,'Tag','Standard.EditPlot'))
        % delete(findall(ui_toolbar,'Tag','Exploration.ZoomIn'))
        % delete(findall(ui_toolbar,'Tag','Exploration.ZoomOut'))
        % delete(findall(ui_toolbar,'Tag','Exploration.Pan'))
        % delete(findall(ui_toolbar,'Tag','Exploration.Rotate'))
        % delete(findall(ui_toolbar,'Tag','Exploration.DataCursor'))
        delete(findall(ui_toolbar,'Tag','Exploration.Brushing'))
        delete(findall(ui_toolbar,'Tag','DataManager.Linking'))
        delete(findall(ui_toolbar,'Tag','Annotation.InsertColorbar'))
        delete(findall(ui_toolbar,'Tag','Annotation.InsertLegend'))
        delete(findall(ui_toolbar,'Tag','Plottools.PlottoolsOff'))
        delete(findall(ui_toolbar,'Tag','Plottools.PlottoolsOn'))
        
        set(ui_toolbar_open,'TooltipString',OPEN_TP);
        set(ui_toolbar_open,'ClickedCallback',{@cb_open})
        
        set(ui_toolbar_save,'TooltipString',SAVE_TP);
        set(ui_toolbar_save,'ClickedCallback',{@cb_save})
        
        set(ui_toolbar_zoomin,'TooltipString',FIG_ZOOMIN_TP);
        
        set(ui_toolbar_zoomout,'TooltipString',FIG_ZOOMOUT_TP);
        
        set(ui_toolbar_pan,'TooltipString',FIG_PAN_TP);
        
        set(ui_toolbar_rotate,'TooltipString',FIG_ROTATE3D_TP);
        
        set(ui_toolbar_datacursor,'TooltipString',FIG_DATACURSOR_TP);
        
        set(ui_toolbar_3D,'TooltipString',FIG_VIEW_3D_CMD);
        set(ui_toolbar_3D,'CData',imread('icon_view_3d.png'));
        set(ui_toolbar_3D,'Separator','on');
        set(ui_toolbar_3D,'ClickedCallback',{@cb_toolbar_3D})
        function cb_toolbar_3D(~,~)  % (src,event)
            set(ui_button_figure_3d,'Value',1);
            update_figure_brainview()
        end
        
        set(ui_toolbar_SL,'TooltipString',FIG_VIEW_SL_CMD);
        set(ui_toolbar_SL,'CData',imread('icon_view_sl.png'));
        set(ui_toolbar_SL,'ClickedCallback',{@cb_toolbar_SL})
        function cb_toolbar_SL(~,~)  % (src,event)
            set(ui_button_figure_sagittalleft,'Value',1);
            update_figure_brainview()
        end
        
        set(ui_toolbar_SR,'TooltipString',FIG_VIEW_SR_CMD);
        set(ui_toolbar_SR,'CData',imread('icon_view_sr.png'));
        set(ui_toolbar_SR,'ClickedCallback',{@cb_toolbar_SR})
        function cb_toolbar_SR(~,~)  % (src,event)
            set(ui_button_figure_sagittalright,'Value',1);
            update_figure_brainview()
        end
        
        set(ui_toolbar_AD,'TooltipString',FIG_VIEW_AD_CMD);
        set(ui_toolbar_AD,'CData',imread('icon_view_ad.png'));
        set(ui_toolbar_AD,'ClickedCallback',{@cb_toolbar_AD})
        function cb_toolbar_AD(~,~)  % (src,event)
            set(ui_button_figure_axialdorsal,'Value',1);
            update_figure_brainview()
        end
        
        set(ui_toolbar_AV,'TooltipString',FIG_VIEW_AV_CMD);
        set(ui_toolbar_AV,'CData',imread('icon_view_av.png'));
        set(ui_toolbar_AV,'ClickedCallback',{@cb_toolbar_AV})
        function cb_toolbar_AV(~,~)  % (src,event)
            set(ui_button_figure_axialventral,'Value',1);
            update_figure_brainview()
        end
        
        set(ui_toolbar_CA,'TooltipString',FIG_VIEW_CA_CMD);
        set(ui_toolbar_CA,'CData',imread('icon_view_ca.png'));
        set(ui_toolbar_CA,'ClickedCallback',{@cb_toolbar_CA})
        function cb_toolbar_CA(~,~)  % (src,event)
            set(ui_button_figure_coronalanterior,'Value',1);
            update_figure_brainview()
        end
        
        set(ui_toolbar_CP,'TooltipString',FIG_VIEW_CP_CMD);
        set(ui_toolbar_CP,'CData',imread('icon_view_cp.png'));
        set(ui_toolbar_CP,'ClickedCallback',{@cb_toolbar_CP})
        function cb_toolbar_CP(~,~)  % (src,event)
            set(ui_button_figure_coronalposterior,'Value',1);
            update_figure_brainview()
        end
        
        set(ui_toolbar_brain,'TooltipString',FIG_BRAIN_CMD);
        set(ui_toolbar_brain,'State','on');
        set(ui_toolbar_brain,'CData',imread('icon_brain.png'));
        set(ui_toolbar_brain,'Separator','on');
        set(ui_toolbar_brain,'OnCallback',{@cb_toolbar_brain_on})
        set(ui_toolbar_brain,'OffCallback',{@cb_toolbar_brain_off})
        function cb_toolbar_brain_on(~,~)  % (src,event)
            set(ui_checkbox_figure_brain,'Value',1)
            update_figure_brainview()
        end
        function cb_toolbar_brain_off(~,~)  % (src,event)
            set(ui_checkbox_figure_brain,'Value',0)
            update_figure_brainview()
        end
        
        set(ui_toolbar_axis,'TooltipString',FIG_AXIS_CMD);
        set(ui_toolbar_axis,'State','on');
        set(ui_toolbar_axis,'CData',imread('icon_axis.png'));
        set(ui_toolbar_axis,'OnCallback',{@cb_toolbar_axis_on})
        set(ui_toolbar_axis,'OffCallback',{@cb_toolbar_axis_off})
        function cb_toolbar_axis_on(~,~)  % (src,event)
            set(ui_checkbox_figure_axis,'Value',true)
            update_figure_brainview()
        end
        function cb_toolbar_axis_off(~,~)  % (src,event)
            set(ui_checkbox_figure_axis,'Value',false)
            update_figure_brainview()
        end
        
        set(ui_toolbar_grid,'TooltipString',FIG_GRID_CMD);
        set(ui_toolbar_grid,'State','on');
        set(ui_toolbar_grid,'CData',imread('icon_grid.png'));
        set(ui_toolbar_grid,'OnCallback',{@cb_toolbar_grid_on})
        set(ui_toolbar_grid,'OffCallback',{@cb_toolbar_grid_off})
        function cb_toolbar_grid_on(~,~)  % (src,event)
            set(ui_checkbox_figure_grid,'Value',true)
            update_figure_brainview()
        end
        function cb_toolbar_grid_off(~,~)  % (src,event)
            set(ui_checkbox_figure_grid,'Value',false)
            update_figure_brainview()
        end
        
        set(ui_toolbar_br,'TooltipString',FIG_BR_CMD);
        set(ui_toolbar_br,'State','on');
        set(ui_toolbar_br,'CData',imread('icon_br.png'));
        set(ui_toolbar_br,'OnCallback',{@cb_toolbar_br_on})
        set(ui_toolbar_br,'OffCallback',{@cb_toolbar_br_off})
        function cb_toolbar_br_on(~,~)  % (src,event)
            set(ui_checkbox_figure_br,'Value',true)
            update_figure_brainview()
        end
        function cb_toolbar_br_off(~,~)  % (src,event)
            set(ui_checkbox_figure_br,'Value',false)
            update_figure_brainview()
        end
        
        set(ui_toolbar_label,'TooltipString',FIG_LABELS_CMD);
        set(ui_toolbar_label,'State','on');
        set(ui_toolbar_label,'CData',imread('icon_label.png'));
        set(ui_toolbar_label,'OnCallback',{@cb_toolbar_label_on})
        set(ui_toolbar_label,'OffCallback',{@cb_toolbar_label_off})
        function cb_toolbar_label_on(~,~)  % (src,event)
            set(ui_checkbox_figure_labels,'Value',true)
            update_figure_brainview()
        end
        function cb_toolbar_label_off(~,~)  % (src,event)
            set(ui_checkbox_figure_labels,'Value',false)
            update_figure_brainview()
        end
    end
    function cb_menu_figure(~,~)  % (src,event)
        h = figure('ID', ['Brain Atlas - ' atlas.getID()]);
        set(gcf,'color','w')
        copyobj(ui_axes_figure,h)
        set(gca,'Units','normalized')
        set(gca,'OuterPosition',[0 0 1 1])
    end
    function cb_menu_mricohort(~,~)  % (src,event)
        if atlas.getBrainRegions().length()>0
            GUIMRICohort(atlas.copy())
        else
            msgbox('In order to create an MRI cohort the brain atlas must have at least one brain region.', ...
                'Warning: Empty brain atlas', ...
                'warn')
        end
    end
    function cb_menu_fmricohort(~,~) % (src,event)
        if atlas.getBrainRegions().length()>0
            GUIfMRICohort(atlas.copy())
        else
            msgbox('In order to create an fMRI cohort the brain atlas must have at least one brain region.', ...
                'Warning: Empty brain atlas', ...
                'warn')
        end
    end
    function cb_menu_eegcohort(~,~) % (src,event)
        if atlas.getBrainRegions().length()>0
            GUIEEGCohort(atlas.copy())
        else
            msgbox('In order to create an EEG cohort the brain atlas must have at least one brain region.', ...
                'Warning: Empty brain atlas', ...
                'warn')
        end
    end
    function cb_menu_petcohort(~,~) % (src,event)
        if atlas.getBrainRegions().length()>0
            GUIPETCohort(atlas.copy())
        else
            msgbox('In order to create an PET cohort the brain atlas must have at least one brain region.', ...
                'Warning: Empty brain atlas', ...
                'warn')
        end
    end

%% Make the GUI visible.
setup()
set(f,'Visible','on');

setup_restrictions()
    function setup_restrictions()
        if exist('restricted','var') && restricted
            set(ui_button_table_add,'enable','off')
            set(ui_button_table_remove,'enable','off')
            set(ui_button_table_moveup,'enable','off')
            set(ui_button_table_movedown,'enable','off')
            set(ui_button_table_move2top,'enable','off')
            set(ui_button_table_move2bottom,'enable','off')
            
            set(ui_menu_file_open,'enable','off')

            set(ui_menu_file_import_txt,'enable','off')
            set(ui_menu_file_import_xls,'enable','off')
            set(ui_menu_edit_add,'enable','off')
            set(ui_menu_edit_remove,'enable','off')
            set(ui_menu_edit_moveup,'enable','off')
            set(ui_menu_edit_movedown,'enable','off')
            set(ui_menu_edit_move2top,'enable','off')
            set(ui_menu_edit_move2bottom,'enable','off')
            
            set(ui_toolbar_open,'enable','off')
        end
    end

%% Auxiliary functions

    function setup()
        
        % setup table
        update_table_atlasname()
        update_table_table()
        
        % setup figure
        create_figure()
        
    end

end