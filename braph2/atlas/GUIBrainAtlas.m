function GUIBrainAtlas(atlas, restricted)
% GUIBRAINATLAS  Brain Atlas Editor
%
% GUIBRAINATLAS() opens empty atlas.
%
% GUIBRAINATLAS(atlas) opens atlas.
%
% GUIBRAINATLAS(atlas, true) opens atlas with only reading and basic writing permissions.
%
% See also BrainAtlas, GUI.

%% General Constants
APPNAME = GUI.BAE_NAME;  % application name
BUILD = BRAPH2.BUILD;

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

TABLE_WIDTH = LEFTCOLUMN_WIDTH;
TABLE_HEIGHT = MAINPANEL_HEIGHT;
TABLE_X0 = MARGIN_X;
TABLE_Y0 = FILENAME_HEIGHT + 2 * MARGIN_Y;
TABLE_POSITION = [TABLE_X0 TABLE_Y0 TABLE_WIDTH TABLE_HEIGHT];

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

ID_TP = 'Brain atlas id';
LABEL_TP = 'Brain atlas label';
NOTES_TP = 'Brain atlas notes';

SELECTALL_CMD = GUI.SELECTALL_CMD;
SELECTALL_TP = 'Select all brain regions';

CLEARSELECTION_CMD = GUI.CLEARSELECTION_CMD;
CLEARSELECTION_TP = 'Clear selection';

ADD_CMD = GUI.ADD_CMD;
ADD_SC = GUI.ADD_SC;
ADD_TP = ['Add brain region at the end of table. Shortcut: ' GUI.ACCELERATOR '+' ADD_SC];

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

%% GUI inizialization
f = GUI.init_figure(APPNAME, .8, .8, 'northwest');

%% Application data
if ~exist('atlas', 'var')
    atlas = BrainAtlas('BA ID', 'Brain Atlas Label', 'Brain atlas notes.', 'BrainMesh_ICBM152.nv', {});
end
selected = [];

%% Panel Table
TAB_BR_SELECTED_COL = 1;
TAB_BR_ID_COL = 2;
TAB_BR_LABEL_COL = 3;
TAB_BR_X_COL = 4;
TAB_BR_Y_COL = 5;
TAB_BR_Z_COL = 6;
TAB_BR_NOTES_COL = 7;

ui_panel_table = uipanel();
ui_edit_table_id = uicontrol(ui_panel_table, 'Style', 'edit');
ui_edit_table_label = uicontrol(ui_panel_table, 'Style', 'edit');
ui_edit_table_notes = uicontrol(ui_panel_table, 'Style', 'edit');
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
        
        set(ui_edit_table_id, 'Position', [.02 .95 .36 .04])
        set(ui_edit_table_id, 'HorizontalAlignment', 'left')
        set(ui_edit_table_id, 'FontWeight', 'bold')
        set(ui_edit_table_id, 'TooltipString', ID_TP)
        set(ui_edit_table_id, 'Callback', {@cb_table_id})

        set(ui_edit_table_label, 'Position', [.42 .95 .56 .04])
        set(ui_edit_table_label, 'HorizontalAlignment', 'left')
        set(ui_edit_table_label, 'FontWeight', 'bold')
        set(ui_edit_table_label, 'TooltipString', LABEL_TP)
        set(ui_edit_table_label, 'Callback', {@cb_table_label})

        set(ui_edit_table_notes, 'Position', [.02 .90 .96 .04])
        set(ui_edit_table_notes, 'HorizontalAlignment', 'left')
        set(ui_edit_table_notes, 'FontWeight', 'bold')
        set(ui_edit_table_notes, 'TooltipString', NOTES_TP)
        set(ui_edit_table_notes, 'Callback', {@cb_table_notes})
        
        set(ui_table_table, 'Position', [.02 .16 .96 .72])
        set(ui_table_table, 'ColumnName', {'', 'ID', 'Label', 'x', 'y', 'z', 'Notes'})
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
        
        set(ui_button_table_add, 'Position', [.27 .11 .21 .03])
        set(ui_button_table_add, 'String', ADD_CMD)
        set(ui_button_table_add, 'TooltipString', ADD_TP);
        set(ui_button_table_add, 'Callback', {@cb_table_add})
        
        set(ui_button_table_remove, 'Position', [.52 .11 .21 .03])
        set(ui_button_table_remove, 'String', REMOVE_CMD)
        set(ui_button_table_remove, 'TooltipString', REMOVE_TP);
        set(ui_button_table_remove, 'Callback', {@cb_table_remove})
        
        set(ui_button_table_moveup, 'Position', [.77 .11 .21 .03])
        set(ui_button_table_moveup, 'String', MOVEUP_CMD)
        set(ui_button_table_moveup, 'TooltipString', MOVEUP_TP);
        set(ui_button_table_moveup, 'Callback', {@cb_table_moveup})
        
        set(ui_button_table_movedown, 'Position', [.77 .08 .21 .03])
        set(ui_button_table_movedown, 'String', MOVEDOWN_CMD)
        set(ui_button_table_movedown, 'TooltipString', MOVEDOWN_TP);
        set(ui_button_table_movedown, 'Callback', {@cb_table_movedown})
        
        set(ui_button_table_move2top, 'Position', [.77 .05 .21 .03])
        set(ui_button_table_move2top, 'String', MOVE2TOP_CMD)
        set(ui_button_table_move2top, 'TooltipString', MOVE2TOP_TP);
        set(ui_button_table_move2top, 'Callback', {@cb_table_move2top})
        
        set(ui_button_table_move2bottom, 'Position', [.77 .02 .21 .03])
        set(ui_button_table_move2bottom, 'String', MOVE2BOTTOM_CMD)
        set(ui_button_table_move2bottom, 'TooltipString', MOVE2BOTTOM_TP);
        set(ui_button_table_move2bottom, 'Callback', {@cb_table_move2bottom})
    end
    function update_table_id()
        atlas_id = atlas.getID();
        if isempty(atlas_id)
            set(f, 'Name', [APPNAME ' ' BRAPH2.VERSION])
        else
            set(f, 'Name', [APPNAME ' ' BRAPH2.VERSION ' - ' atlas_id])
        end
        set(ui_edit_table_id, 'String', atlas_id)
    end
%     function update_table_table()
%         data = cell(atlas.getBrainRegions().length(), 8);
%         for i = 1:1:atlas.getBrainRegions().length()
%             if any(selected == i)
%                 data{i, TAB_BR_SELECTED_COL} = true;
%             else
%                 data{i, TAB_BR_SELECTED_COL} = false;
%             end
%             data{i, TAB_BR_ID_COL} = atlas.getBrainRegions().getValue(i).getID();
%             data{i, TAB_BR_LABEL_COL} = atlas.getBrainRegions().getValue(i).getLabel();
%             data{i, TAB_BR_X_COL} = atlas.getBrainRegions().getValue(i).getX();
%             data{i, TAB_BR_Y_COL} = atlas.getBrainRegions().getValue(i).getY();
%             data{i, TAB_BR_Z_COL} = atlas.getBrainRegions().getValue(i).getZ();
%             data{i, TAB_BR_NOTES_COL} = atlas.getBrainRegions().getValue(i).getNotes();
%         end
%         h_br = data;
%         set(ui_table_table, 'Data', data)
%     end
    function cb_table_id(~, ~)  % (src, event)
        atlas.setID(get(ui_edit_table_id,  'String'));
        update_table_id()
    end
%     function cb_table_edit(~, event)  % (src, event)
%         i = event.Indices(1);
%         col = event.Indices(2);
%         newdata = event.NewData;
%         switch col
%             case TAB_BR_SELECTED_COL
%                 if newdata == 1
%                     selected = sort(unique([selected(:); i]));
%                     h_br(i, 1) = {newdata};
%                     figure_brain_region_proximity(1)
%                 else
%                     selected = selected(selected~=i);
%                     h_br(i, 1) = {newdata};
%                     figure_brain_region_proximity(1)
%                 end
%             case TAB_BR_ID_COL
%                 atlas.getBrainRegions().getValue(i).setID(newdata)
%                 oldkey = atlas.getBrainRegions().getKey(i);
%                 atlas.getBrainRegions().replaceKey(oldkey, newdata);
%             case TAB_BR_LABEL_COL
%                 atlas.getBrainRegions().getValue(i).setLabel(newdata)
%             case TAB_BR_X_COL
%                 atlas.getBrainRegions().getValue(i).setX(newdata)
%             case TAB_BR_Y_COL
%                 atlas.getBrainRegions().getValue(i).setY(newdata)
%             case TAB_BR_Z_COL
%                 atlas.getBrainRegions().getValue(i).setZ(newdata)
%             case TAB_BR_NOTES_COL
%                 atlas.getBrainRegions().getValue(i).setNotes(newdata)
%         end
%         update_figure_brainview()
%     end
%     function cb_table_selectall(~, ~)  % (src, event)
%         selected = (1:1:atlas.getBrainRegions().length())';
%         update_table_table()
%         update_figure_brainview()
%     end
%     function cb_table_clearselection(~, ~)  % (src, event)
%         selected = [];
%         update_table_table()
%         update_figure_brainview()
%     end
% % TODO - MANAGE COUNTER SO THAT IT DOESN'T CREATE POTENTIAL ERRORS
%     counter_add = 0;
%     function cb_table_add(~, ~)  % (src, event)
%         counter_add = counter_add + 1;
%         dummyBrainRegion = BrainRegion(['ID' num2str(counter_add)], 'Label', 'Notes', 0, 0, 0);
%         atlas.getBrainRegions().add(dummyBrainRegion.getID(), dummyBrainRegion);
%         update_table_table()
%         update_figure_brainview()
%     end
%     function cb_table_remove(~, ~)  % (src, event)
%         selected = atlas.getBrainRegions().remove_all(selected);
%         update_table_table()
%         update_figure_brainview()
%     end
%     function cb_table_moveup(~, ~)  % (src, event)
%         selected = atlas.getBrainRegions().move_up(selected);
%         update_table_table()
%         update_figure_brainview()
%     end
%     function cb_table_movedown(~, ~)  % (src, event)
%         selected = atlas.getBrainRegions().move_down(selected);
%         update_table_table()
%         update_figure_brainview()
%     end
%     function cb_table_move2top(~, ~)  % (src, event)
%         selected = atlas.getBrainRegions().move_to_top(selected);
%         update_table_table()
%         update_figure_brainview()
%     end
%     function cb_table_move2bottom(~, ~)  % (src, event)
%         selected = atlas.getBrainRegions().move_to_bottom(selected);
%         update_table_table()
%         update_figure_brainview()
%     end

%% Make the GUI visible.
setup()
set(f, 'Visible', 'on');

%% Auxiliary functions
    function setup()
        % setup table
        update_table_id()
    end

end