classdef GUI
    % GUI manages GUI's constants and functionalities
    % GUI is a static class that contains constant properties and static
    % functions used by all BRAPH2 graphical user interfaces.
    %
    % GUI is a static class that contains static properties and static
    % methods that all graphical interfaces in BRAPH2 utilize. The static
    % properties include the background color, font, menu items name and
    % shortcut characters, and all type of files extension command
    % messages. GUI static methods control the height, width, close
    % message, and about menus.
    %
    % Properties (Constant)
    % COLOR             - GUI font color
    % FONT              - GUI font style
    % BAE_NAME          - Brain Atlas editor window title
    % BAE_EXTENSION     - Brain Atlas editor file extension
    % BAE_MSG_PUTFILE   - Brain Atlas editor put file message
    % BAE_MSG_GETFILE   - Brain Atlas editor get file message
    % MSG_YES           - affirmtive message
    % MSG_NO            - negation message
    % BRA_UNITS         - left square bracket character
    % KET_UNITS         - right square bracket character
    % BKGCOLOR          - background color
    % TABBKGCOLOR       - tab background color
    % PLOT_SYMBOL_TAG   - plot symbols tag
    % PLOT_SYMBOL_NAME  - plot symbols name
    % PLOT_LINESTYLE_TAG - plot line style tage
    % PLOT_LINESTYLE_NAME - plot linestyle name
    % FONT_INTERPRETER_TAG - font interpreter tag
    % FONT_INTERPRETER_NAME - font interpreter name
    % FONT_TYPE_TAG     - font type tag
    % FONT_TYPE_NAME    - font type name
    % FONT_WEIGHT_TAG   - font weight tag
    % FONT_WEIGHT_NAME  - font weight name
    % MENU_FILE         - menu file string
    % MENU_EDIT         - menu edit string
    % MENU_VIEW         - menu view string
    % OPEN_CMD          - open command string
    % OPEN_SC           - open command char
    % SAVE_CMD          - save command string
    % SAVE_SC           - save command char
    % SAVEAS_CMD        - save as command string
    % IMPORT_TXT_CMD    - import '.txt' file command string
    % IMPORT_XLS_CMD    - imort '.xls' file command string
    % IMPORT_JSON_CMD   - improt '.json' file command string
    % EXPORT_TXT_CMD    - export to '.txt' file command string
    % EXPORT_XLS_CMD    - export to '.xls' file command string
    % EXPORT_JSON_CMD   - export to '.json' file command string
    % CLOSE_CMD         - close command string
    % CLOSE_SC          - close command char
    % SELECTALL_CMD     - sellect all command string
    % CLEARSELECTION_CMD - clear selection command string
    % ADD_CMD           - add command string
    % ADD_SC            - add command char
    % REMOVE_CMD        - remove command string
    % REMOVE_SC         - remove command char
    % MOVEUP_CMD        - move up command string
    % MOVEUP_SC         - move up command char
    % MOVEDOWN_CMD      - move down command string
    % MOVEDOWN_SC       - move down command char
    % MOVE2TOP_CMD      - move to top command string
    % MOVE2TOP_SC       - move to top command char
    % MOVE2BOTTOM_CMD   - move to bottom command string
    % MOVE2BOTTOM_SC    - move to bottom command char
    % FIGURE_CMD        - generate figure command string 
    % FIGURE_SC         - generate figure command char
    %
    % GUI methods (static, constants)
    % ACCELERATOR       - returns the corresponding OS accelerator
    % SCREEN_WIDTH      - returns the screen size width
    % SCREEN_HEIGHT     - returns the screen size height
    %
    % GUI methods (static)
    % INIT_FIGURE       - creates and initializes the GUI figure
    % CLOSE             - closes GUI figure
    % SETMENUABOUT      - initializes about menu
    % ABOUT             - message in about menu
    % SETUNITS          - sets GUI figure units
    % SETBACKGROUNDCOLOR - sets GUI figure background color
    % DISABLE           - disable all children of a specified object
    % ENABLE            - enable all children of a specified object
    % X                 - returns the x initial position of a figure
    % Y                 - returns the y initial position of a figure
    % WIDTH             - returns the width of a figure 
    % HEIGHT            - returns the height of a figure
    %
    % See also BRAPH2, GUIBrainAtlas
    
    properties (Constant)        
        % Braph
        COLOR = [.9 .4 .1]
        FONT = 'Helvetica'
        
        % GUI windows
        BAE_NAME = 'Brain Atlas Editor'
        BAE_EXTENSION = '*.atlas'
        BAE_MSG_PUTFILE = 'Save brain atlas'
        BAE_MSG_GETFILE = ['Select brain atlas file (' GUI.BAE_EXTENSION ')']
        
%         MCE_NAME = 'MRI Cohort Editor'
%         MCE_EXTENSION = '*.mc'
%         MCE_MSG_PUTFILE = 'Save MRI cohort'
%         MCE_MSG_GETFILE = ['Select MRI cohort file (' GUI.MCE_EXTENSION ')']
%         
%         MGA_NAME = 'MRI Graph Analysis'
%         MGA_EXTENSION = '*.mga'
%         MGA_MSG_PUTFILE = 'Save MRI graph analysis'
%         MGA_MSG_GETFILE = ['Select MRI graph analysis file (' GUI.MGA_EXTENSION ')']
%         
%         fMCE_NAME = 'fMRI Cohort Editor'
%         fMCE_EXTENSION = '*.fc'
%         fMCE_MSG_PUTFILE = 'Save fMRI cohort'
%         fMCE_MSG_GETFILE = ['Select fMRI cohort file (' GUI.fMCE_EXTENSION ')']
%         
%         fMGA_NAME = 'fMRI Graph Analysis'
%         fMGA_EXTENSION = '*.fga'
%         fMGA_MSG_PUTFILE = 'Save fMRI graph analysis'
%         fMGA_MSG_GETFILE = ['Select fMRI graph analysis file (' GUI.fMGA_EXTENSION ')']
%         
%         ECE_NAME = 'EEG Cohort Editor'
%         ECE_EXTENSION = '*.ec'
%         ECE_MSG_PUTFILE = 'Save EEg cohort'
%         ECE_MSG_GETFILE = ['Select EEG cohort file (' GUI.ECE_EXTENSION ')']
%         
%         EGA_NAME = 'EEG Graph Analysis'
%         EGA_EXTENSION = '*.ega'
%         EGA_MSG_PUTFILE = 'Save EEG graph analysis'
%         EGA_MSG_GETFILE = ['Select EEG graph analysis file (' GUI.EGA_EXTENSION ')']
%         
%         PCE_NAME = 'PET Cohort Editor'
%         PCE_EXTENSION = '*.pc'
%         PCE_MSG_PUTFILE = 'Save PET cohort'
%         PCE_MSG_GETFILE = ['Select PET cohort file (' GUI.PCE_EXTENSION ')']
%         
%         PGA_NAME = 'PET Graph Analysis'
%         PGA_EXTENSION = '*.pga'
%         PGA_MSG_PUTFILE = 'Save PET graph analysis'
%         PGA_MSG_GETFILE = ['Select PET graph analysis file (' GUI.PGA_EXTENSION ')']
        
        % GUI general
        MSG_YES = 'Yes'
        MSG_NO = 'No'
        BRA_UNITS = '['
        KET_UNITS = ']'
        BKGCOLOR = [.95 .95 .95]
        TABBKGCOLOR = [.95 .98 1.00; 1.00 .98 .95]
        
        PLOT_SYMBOL_TAG = { ...
            '.' ...
            'o' ...
            'x' ...
            '+' ...
            '*' ...
            's' ...
            'd' ...
            'v' ...
            '^' ...
            '>' ...
            '<' ...
            'p' ...
            'h' ...
            'none' ...
            }
        
        PLOT_SYMBOL_NAME = { ...
            'point' ...
            'circle' ...
            'x-mark' ...
            'plus' ...
            'star' ...
            'square' ...
            'diamond' ...
            'triangle (down)' ...
            'triangle (up)' ...
            'triangle (left)' ...
            'triangle (right)' ...
            'pentagram' ...
            'hexagram' ...
            'none' ...
            }
        
        PLOT_LINESTYLE_TAG = { ...
            '-' ...
            ':' ...
            '-.' ...
            '--' ...
            'none' ...
            }
        
        PLOT_LINESTYLE_NAME = { ...
            'solid' ...
            'dotted' ...
            'dashdot' ...
            'dashed' ...
            'none' ...
            }
        
        FONT_INTERPRETER_TAG = { ...
            'tex' ...
            'latex' ...
            'none' ...
            }
        
        FONT_INTERPRETER_NAME = { ...
            'tex' ...
            'latex' ...
            'none' ...
            }
        
        FONT_TYPE_TAG = { ...
            'Helvetica' ...
            'Calibri' ...
            'Arial' ...
            'Times New Roman' ...
            'Arial Unicode' ...
            'FixedWidth' ...
            }
        
        FONT_TYPE_NAME = { ...
            'Helvetica' ...
            'Calibri' ...
            'Arial' ...
            'Times New Roman' ...
            'Arial Unicode' ...
            'FixedWidth' ...
            }
        
        FONT_WEIGHT_TAG = { ...
            'normal' ...
            'bold' ...
            }
        
        FONT_WEIGHT_NAME = { ...
            'normal' ...
            'bold' ...
            }
        
        % Menus
        MENU_FILE = 'File'
        MENU_EDIT = 'Edit'
        MENU_VIEW = 'View'
        
        % Commands
        OPEN_CMD = 'Open ...';
        OPEN_SC = 'O';
        
        SAVE_CMD = 'Save';
        SAVE_SC = 'S';
        
        SAVEAS_CMD = 'Save as ...';
        
     
        IMPORT_TXT_CMD = 'Import (txt) ...';
        IMPORT_XLS_CMD = 'Import (xls) ...';
        IMPORT_JSON_CMD =  'Import (json) ...';        
        
        EXPORT_TXT_CMD = 'Export (txt) ...';
        EXPORT_XLS_CMD = 'Export (xls)  ...';
        EXPORT_JSON_CMD = 'Export (json) ...';
        
        CLOSE_CMD = 'Close';
        CLOSE_SC = 'C';
        
        SELECTALL_CMD = 'Select all';
        
        CLEARSELECTION_CMD = 'Clear selection';
        
        ADD_CMD = 'Add';
        ADD_SC = 'A';
        
        ADDABOVE_CMD = 'Add above';
        
        ADDBELOW_CMD = 'Add below';
        
        REMOVE_CMD = 'Remove';
        REMOVE_SC = 'R';
        
        MOVEUP_CMD = 'Move up';
        MOVEUP_SC = 'U';
        
        MOVEDOWN_CMD = 'Move down';
        MOVEDOWN_SC = 'D';
        
        MOVE2TOP_CMD = 'Move to top';
        MOVE2TOP_SC = 'T';
        
        MOVE2BOTTOM_CMD = 'Move to bottom';
        MOVE2BOTTOM_SC = 'B';
        
        FIGURE_CMD = 'Generate figure';
        FIGURE_SC = 'F';
    end
    methods (Static)  % constants
        function c = ACCELERATOR()
            % ACCELERATOR defines accelerator
            %
            % C = ACCELERATOR() returns the corresponding accelerator depending
            % on whether the version is for Apple Mac OS X or form Win/Unix.
            %
            % See also GUI, ismac.
            
            if ismac  % Mac
                c = 'Cmd';
            else  % Win/Unix
                c = 'Crtl';
            end
        end
        function w = SCREEN_WIDTH()
            % SCREEN_WIDTH defines screen width
            %
            % W = SCREEN_WIDTH() returns the width of the screen.
            %
            % See also GUI.
            
            screensize = get(0, 'screensize');
            w = screensize(3);
        end
        function h = SCREEN_HEIGHT()
            % SCREEN_HEIGHT defines screen height
            %
            % W = SCREEN_HEIGHT() returns the height of the screen.
            %
            % See also GUI.
            
            screensize = get(0, 'screensize');
            h = screensize(4);
        end
    end
    methods (Static)  % functions
        function f = init_figure(AppName, width, height, position)
            % INIT_FIGURE creates and intializes GUI figure
            %
            % F = INIT_FIGURE(APPNAME,WIDTH,HEIGHT,POSITION) creates a GUI figure
            % F with name APPNAME and initializes the following properties:
            %   WIDTH     -  width of the figure as percentage of the screen width
            %   HEIGHT    -  height of the figure as percentage of the screen height
            %   POSITION  -  position of the figure on the screen
            %
            % Admissible POSITION initializations are:
            %   north     | south     | east      | west
            %   northeast | northwest | southeast | southwest
            %   center    | onscreen  | [h, v]
            %
            % The figure is initially hidden.
            %
            % See also GUI, movegui.
            
            f = figure();
            set(f, 'Visible', 'off')
            set(f, 'Position', [1 1 GUI.SCREEN_WIDTH * width GUI.SCREEN_HEIGHT * height])
            movegui(f, position)
            set(f, 'Color', GUI.BKGCOLOR)
            set(f, 'Name', [AppName ' - ' BRAPH2.BUILD])
            set(f, 'MenuBar', 'none')
            set(f, 'NumberTitle', 'off')
            set(f, 'DockControls', 'off')
            set(f, 'CloseRequestFcn', ['GUI.close(''' AppName ''', gcf)'])
        end
        function close(AppName, f)
            % CLOSE closes GUI figure
            %
            % CLOSE(APPNAME,F) promts the user to choose whether to close the
            % GUI figure F with name APPNAME. If the user answers positively, 
            % the GUI figure closes. F can also be a vector of figures.
            %
            % See also GUI.
            
            selection = questdlg(['Do you want to close ' AppName '?'], ...
                ['Close ' AppName], ...
                GUI.MSG_YES, GUI.MSG_NO, GUI.MSG_YES);
            switch selection
                case GUI.MSG_YES
                    delete(f)
                case GUI.MSG_NO
                    return
            end
        end
        function [ui_menu_about, ui_menu_about_about] = setMenuAbout(f, AppName)
            % SETMENUABOUT initializes about menu
            %
            % [UI_MENU_ABOUT, UI_MENU_ABOUT_ABOUT] = SETMENUABOUT(APPNAME, F)
            % adds the menu item UI_MENU_ABOUT and its submenu item
            % UI_MENU_ABOUT_ABOUT to the figure F.
            %
            % UI_MENU_ABOUT_ABOUT gives general information about the
            % brain network toolbox.
            %
            % See also GUI.
            
            ui_menu_about = uimenu(f, 'Label', 'About');
            
            ui_menu_about_about = uimenu(ui_menu_about);
            set(ui_menu_about_about, 'Label', 'About ...')
            set(ui_menu_about_about, 'Callback', ['GUI.about(''' AppName ''')'])
        end
        function about(AppName)
            % ABOUT message in about menu
            %
            % ABOUT(APPNAME) specifies the message displayed in the about
            % menu in the figure with name APPNAME.
            %
            % See also GUI.
            
            msgbox({'' [AppName ' ' BNC.VERSION] '' BNC.AUTHORS '' BNC.COPYRIGHT ''}, ...
                ['About ' AppName])
        end
        function setUnits(h, alsochildren)
            % SETUNITS sets GUI figure units
            %
            % SETUNITS(H,ALSOCHILDREN) sets the units of the object with
            % handle H and all its children to normalized if ALSOCHILDREN
            % is true. If ALSOCHILDREN is false, only the units of the
            % object with handle H are set to normalized.
            %
            % See also GUI.
            
            if nargin<2
                alsochildren = true;
            end
            
            set(h, 'Units', 'normalized')
            if alsochildren
                set(allchild(h), 'Units', 'normalized')
            end
        end
        function setBackgroundColor(h, alsochildren)
            % SETBACKGROUNDCOLOR sets GUI figure background color
            %
            % SETBACKGROUNDCOLOR(H,ALSOCHILDREN) sets the background color
            % of the object with handle H and all its children to the
            % brain network color if ALSOCHILDREN is true.
            %
            % If ALSOCHILDREN is false, only the background color of the
            % object with handle H are set to normalized.
            %
            % If the child of the object H is a table, the color is
            % initialized to the background table tab color.
            %
            % If the child of the object H is a push button, the color of
            % the child remains unaffected.
            %
            % See also GUI.
            
            if nargin<2
                alsochildren = true;
            end
            
            if isa(h, 'matlab.ui.control.Table')
                set(h, 'BackgroundColor', GUI.TABBKGCOLOR)
            elseif isa(h, 'matlab.ui.control.UIControl') && strcmpi(get(h, 'Style'), 'pushbutton')
                % no action
            else
                set(h, 'BackgroundColor', GUI.BKGCOLOR)
            end
            
            if alsochildren
                h_vec = allchild(h);
                for i = 1:1:length(h_vec)
                    GUI.setBackgroundColor(h_vec(i), false);
                end
            end
        end
        function disable(h)
            % DISABLE disables all children of a specified object
            %
            % DISABLE(H) disables all children of the object specified by
            % the handle H. The object H must be of the type "uipanel".
            %
            % See also GUI.
            
            all = allchild(h);
            for i = 1:1:length(all)
                ht = all(i);
                if isa(ht, 'matlab.ui.control.UIControl')
                    set(ht, 'enable', 'off')
                end
            end
        end
        function enable(h)
            % ENABLE enables all children of a specified object
            %
            % ENABLE(H) enables all children of the object specified by
            % the handle H. The object H must be of the type "uipanel".
            %
            % See also GUI.
            
            all = allchild(h);
            for i = 1:1:length(all)
                ht = all(i);
                if isa(ht, 'matlab.ui.control.UIControl')
                    set(ht, 'enable', 'on')
                end
            end
        end
        function x0 = x(f,r)
            % X initial position
            %
            % X0 = X(F,R) returns the initial position corresponding to
            % figure F and ratio R.
            %
            % See also GUI.
            
            if nargin < 2
                r = 1;
            end
            
            pos = get(f, 'Position');
            x0 = r * pos(1);
        end
        function y0 = y(f,r)
            % Y initial position
            %
            % Y0 = Y(F,R) returns the initial position corresponding to
            % figure F and ratio R.
            %
            % See also GUI.
            
            if nargin < 2
                r = 1;
            end
            
            pos = get(f, 'Position');
            y0 = r * pos(2);
        end
        function w = width(f,r)
            % WIDTH width
            %
            % W = WIDTH(F,R) returns the width corresponding to figure F and ratio R.
            %
            % See also GUI.
            
            if nargin < 2
                r = 1;
            end
            
            pos = get(f, 'Position');
            w = r * pos(3);
        end
        function h = height(f,r)
            % HEIGHT height
            %
            % H = HEIGHT(F,R) returns the height corresponding to figure F and ratio R.
            %
            % See also GUI.
            
            if nargin < 2
                r = 1;
            end
            
            pos = get(f, 'Position');
            h = r * pos(4);
        end
    end
end