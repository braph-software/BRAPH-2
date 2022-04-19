classdef BRAPH2
    %BRAPH2 constants.
    % BRAPH2 is a static class that contains the constants used by BRAPH2.
    %
    % Properties (Constant) - BRAPH2 ID Card:
    %  NAME             - BRAPH2 full name
    %  VERSION          - BRAPH2 version
    %  STR              - BRAPH2 short string
    %  BUILD            - BRAPH2 build number
    %  AUTHORS          - BRAPH2 authors
    %  COPYRIGHT        - BRAPH2 copyright
    %  WEB              - BRAPH2 website
    %  TWITTER          - BRAPH2 twitter handle
    %  MATLAB_RELEASE   - Minimal MatLab version (2020b)
    %
    % Properties (Constant) - BRAPH2 extensions
    %  EXT_ELEMENT      - BRAPH2 element extension (*.b2)
    %  EXT_PIPELINE     - BRAPH2 pipeline extension (*.braph2)
    %
    % Properties (Constant) - BRAPH2 check and testing
    %  CHECKED          - BRAPH2 check global switch
    %  TEST_PARALLEL    - BRAPH2 test using parallel computing
    %  TEST_RANDOM      - BRAPH2 random testing
    %
    % Properties (Constant) - BRAPH2 error codes:
    %  VER              - wrong MatLab or addon version
    %  ADDON            - addon not installed
    %  WRONG_INPUT      - wrong input value or format in a function
    %  WRONG_OUTPUT     - wrong output value or format in a function
    %  BUG_FUNC         - bug in a function (wrong behavior)
    %  BUG_COPY         - bug while deep-copying an object
    %  BUG_CLONE        - bug while cloning an object
    %  BUG_IO           - bug while loading/saving files
    %  BUG_JSON         - bug in JSON encoding/deconding
    %  BUG_ERR          - bug in the handling of errors
    %  BUG_LAYOUT       - bug in loading/saving layout
    %
    % Properties (Customizable) - BRAPH2 GUI constants:
    %  CUSTOMIZE        - returns/saves the customizable constants
    %  FONTUNITS        - sets the units of the font
    %  FONTSIZE         - sets the size of the font
    %  COL              - official BRAPH2 color
    %  COL_FIG          - standard figure background color
    %  COL_M            - standard metadata prop background color
    %  COL_P            - standard parameter prop background color
    %  COL_D            - standard data prop background color
    %  COL_R            - standard result prop background color
    %  COL_F            - standard figure prop background color
    %  COL_G            - standard gui prop background color
    %
    % Methods (Static) - BRAPH2 save/load elements
    %  save             - save BRAPH2 element as b2 file
    %  load             - load BRAPH2 element from b2 file
    %
    % Methods (Static) - BRAPH2 information:
    %  credits          - provides information about the authors of BRAPH2
    %  license          - provides information about the license of BRAPH2
    %  web              - opens the BRAPH2 website
    %  forum            - opens the BRAPH2 forum
    %  twitter          - opens the BRAPH2 Twitter
    %  add_menu_about   - adds the about menu to a figure
    %  add_tool_about   - adds the about tools to a toolbar
    %
    % Methods (Static) - BRAPH2 checks:
	%  checkMatLab      - checks whether the MatLab release is sufficiently new/error
    %  installed        - returns whether an addon is installed/error
    %
    % See also BRAPH2Constants.
    
    properties (Constant) % BRAPH2 ID Card
        NAME = 'Braph 2.0' % BRAPH2 full name
        VERSION = '2.0' % BRAPH2 version
        STR = 'BRAPH2' % BRAPH2 short string
        BUILD = 1 % BRAPH2 build number
        AUTHORS = 'Giovanni Volpe, Emiliano Gomez Ruiz, Anna Canal Garcia, Yu-Wei Chang, Mite Mijalkov, Joana Braga Pereira, Ehsan Kakaei, Eric Westman, et al.'
        COPYRIGHT = ['Copyright 2014-' datestr(now,'yyyy')]
        WEB = 'braph.org' % BRAPH2 website
        TWITTER = 'braph2software' % BRAPH2 twitter handle
        MATLAB_RELEASE = '9.9'; % Minimal MatLab release (2020b)
    end
    properties (Constant) % BRAPH2 extensions
        EXT_ELEMENT = {'*.b2'} % BRAPH2 element extension
        EXT_PIPELINE = {'*.braph2'} % BRAPH2 pipeline extension
    end
    properties (Constant) % BRAPH2 check and testing
        CHECKED = true % BRAPH2 check global switch
        TEST_PARALLEL = false % BRAPH2 test using parallel computing
        TEST_RANDOM = false % BRAPH2 random test
    end
    properties (Constant) % BRAPH2 error codes
        VER = 'Version' % wrong MatLab or addon version
        ADDON = 'AddOn' % addon not installed
        WRONG_INPUT = 'WrongInput' % wrong input value or format in a function
        WRONG_OUTPUT = 'WrongOutput' % wrong output value or format in a function
        BUG_FUNC = 'BugFunc' % bug in a function (wrong behavior)
        BUG_COPY = 'BugCopy' % bug while deep-copying an object
        BUG_CLONE = 'BugClone' % bug while cloning an object
        BUG_IO = 'BugIO' % bug while loading/saving files
        BUG_JSON = 'BugJSON' % bug in JSON encoding/deconding
        BUG_ERR = 'BugErr' % bug in the handling of errors
        BUG_LAYOUT = 'BugLayout' % bug in loading/saving layout
    end
    methods (Static) % BRAPH2 GUI constants
        function b2_out = customize(save)
            %CUSTOMIZE returns/saves the customizable constants.
            %
            % B2 = CUSTOMIZE() returns the element with the customizable constants.
            %
            % CUSTOMIZE(true) saves the element with the customizable constants.
            %
            % See also BRAPH2Constants.
            
            filename = [fileparts(which('braph2.m')) filesep() 'src' filesep() 'braph2.init.b2'];
            
            persistent b2
            if isempty(b2)
                if isfile(filename)
                    b2 = BRAPH2.load(filename);
                else
                    b2 = BRAPH2Constants();
                    %CET: initializes the values with their defaults
                    for prop = 1:1:BRAPH2Constants.getPropNumber()
                        b2.set(prop, BRAPH2Constants.getPropDefault(prop))
                    end
                end
            end
            
            if nargin && save
                BRAPH2.save(b2, filename);
            end
            
            if nargout > 0
                b2_out = b2;
            end
        end
        function fontunits = FONTUNITS()
            % FONTUNITS sets the units of the font.
            %
            % See also BRAPH2Constants.
            
            persistent b2
            if isempty(b2)
                b2 = BRAPH2.customize();
            end

            fontunits = b2.get('FONTUNITS');
        end
        function fontsize = FONTSIZE()
            % FONTSIZE sets the size of the font.
            %
            % See also BRAPH2Constants.
            
            persistent b2
            if isempty(b2)
                b2 = BRAPH2.customize();
            end

            fontsize = b2.get('FONTSIZE');
        end
        function col = COL()
            % COL is the official BRAPH2 color.
            %
            % See also BRAPH2Constants.
            
            persistent b2
            if isempty(b2)
                b2 = BRAPH2.customize();
            end

            col = b2.get('COL');
        end
        function col_fig = COL_FIG()
            % COL_FIG is the standard figure background color.
            %
            % See also BRAPH2Constants.
            
            persistent b2
            if isempty(b2)
                b2 = BRAPH2.customize();
            end

            col_fig = b2.get('COL_FIG');
        end
        function col_m = COL_M()
            % COL_M is the standard metadata prop background color.
            %
            % See also BRAPH2Constants.
            
            persistent b2
            if isempty(b2)
                b2 = BRAPH2.customize();
            end

            col_m = b2.get('COL_M');
        end
        function col_p = COL_P()
            % COL_P is the standard parameter prop background color.
            %
            % See also BRAPH2Constants.
            
            persistent b2
            if isempty(b2)
                b2 = BRAPH2.customize();
            end

            col_p = b2.get('COL_P');
        end
        function col_d = COL_D()
            % COL_D is the standard data prop background color.
            %
            % See also BRAPH2Constants.
            
            persistent b2
            if isempty(b2)
                b2 = BRAPH2.customize();
            end

            col_d = b2.get('COL_D');
        end
        function col_r = COL_R()
            % COL_R is the standard result prop background color.
            %
            % See also BRAPH2Constants.
            
            persistent b2
            if isempty(b2)
                b2 = BRAPH2.customize();
            end

            col_r = b2.get('COL_R');
        end
        function col_f = COL_F()
            % COL_F is the standard figure prop background color.
            %
            % See also BRAPH2Constants.
            
            persistent b2
            if isempty(b2)
                b2 = BRAPH2.customize();
            end

            col_f = b2.get('COL_F');
        end
        function col_g = COL_G()
            % COL_G is the standard gui prop background color.
            %
            % See also BRAPH2Constants.
            
            persistent b2
            if isempty(b2)
                b2 = BRAPH2.customize();
            end

            col_g = b2.get('COL_G');
        end
    end
    methods (Static) % BRAPH2 save/load elements
        function saved_out = save(el, filename)
            %SAVE saves BRAPH2 element as b2 file.
            %
            % SAVED = SAVE(EL, FILEMANE) saves the element EL in the file FILENAME.
            %
            % SAVED = SAVE(EL) opens a dialog box to select the file.
            %
            % See also load, uiputfile.
            
            if nargin < 2
                % select file
                [file, path, filterindex] = uiputfile(BRAPH2.EXT_ELEMENT, ['Select the ' el.getName() ' file.']);
                % save file
                if filterindex
                    filename = fullfile(path, file);
                else 
                    filename = '';
                end
            end
            
            if ~isempty(filename)
                build = BRAPH2.BUILD;
                matlab_release = ver('MATLAB').Version;
                matlab_release_details = ver();
                save(filename, 'el', 'build', 'matlab_release', 'matlab_release_details');
                
                saved = true;
            else
                saved = false;
            end
            
            if nargout
                saved_out = saved;
            end
        end
        function [el, build, matlab_release, matlab_release_details] = load(filename)
            %LOAD loads a BRAPH2 element from a b2 file.
            %
            % EL = LOAD(FILENAME) loads the element EL from the file b2 FILENAME. 
            %  If the element is not loaded, EL = false.
            %
            % EL = LOAD() opens a dialog box to select the file to be loaded. 
            %
            % [EL, BUILD, R, RD] = LOAD() returns also the BRAPH2 BUILD, the MatLab
            %  release number, and the details of the MatLab release RD.
            %
            % See also save, uigetfile.
            
            if nargin < 1
                % select file
                [file, path, filterindex] = uigetfile(BRAPH2.EXT_ELEMENT, 'Select the element file.');
                if filterindex
                    filename = fullfile(path, file);
                else 
                    filename = '';
                end
            end
            
            if isfile(filename)
                tmp = load(filename, '-mat', 'el', 'build', 'matlab_release', 'matlab_release_details');
                el = tmp.el;
                build  = tmp.build;
                matlab_release = tmp.matlab_release;
                matlab_release_details = tmp.matlab_release_details;
            else
                el = false;
                build  = [];
                matlab_release = [];
                matlab_release_details = [];
            end
        end
    end
    methods (Static) % BRAPH2 information
        function credits()
            %CREDITS provides information about the authors of BRAPH2.
            %
            % See also license, braph2msgbox.
            
            title = ['About ' BRAPH2.STR];
            
            message = {''
                ['{\bf\color{orange}' BRAPH2.STR '}']
                ['{\color{gray}version ' BRAPH2.VERSION '}']
                ['{\color{gray}build ' int2str(BRAPH2.BUILD) '}']
                ''
                BRAPH2.AUTHORS
                ''
                ['{\color{gray}' BRAPH2.WEB '}']
                ''
                ['{\color{gray}' BRAPH2.COPYRIGHT '}']
                ''
                ''};
            
            braph2msgbox(title, message)
        end
        function license()
            %LICENSE provides information about the license of BRAPH2.
            %
            % See also about, braph2msgbox.
            
            title = [BRAPH2.STR ' License'];
            
            message = {''
                ['{\bf\color{orange}' BRAPH2.STR '}']
                ['{\color{gray}version ' BRAPH2.VERSION '}']
                ['{\color{gray}build ' int2str(BRAPH2.BUILD) '}']
                ''
                'The license is available in the file {\bfbraph2license.rtf} on the main directory of BRAPH2.'
                'In brief, BRAPH2 is provided as is and is free to use for research.'
                ''
                ['{\color{gray}' BRAPH2.WEB '}']
                ''
                ['{\color{gray}' BRAPH2.COPYRIGHT '}']
                ''
                ''};
            
            braph2msgbox(title, message)
        end
        function web()
            %WEB opens the BRAPH2 website.
            %
            % See also forum, twitter.
            
            url = ['https://' BRAPH2.WEB];
            web(url);
        end
        function forum()
            %FORUM opens the BRAPH2 forums.
            %
            % See also web, twitter.
            
            url = ['https://' BRAPH2.WEB '/forums/'];
            web(url);
        end
        function twitter()
            %TWITTER opens the BRAPH2 Twitter.
            %
            % See also web, forum.
            
            url = ['https://twitter.com/' BRAPH2.TWITTER];
            web(url);
        end
        function menu_about = add_menu_about(f)
            %ADD_MENU_ABOUT adds the about menu to a figure.
            %
            % MENU_ABOUT = ADD_MENU_ABOUT(F) adds the menu about to the figure F
            %  and returns its handle MENU_ABOUT.
            
            menu_about = uimenu(f, 'Label', 'About');
            uimenu(menu_about, ...
                'Label', 'BRAPH.org ...', ...
                'Callback', 'BRAPH2.web()')
            uimenu(menu_about, ...
                'Label', 'Forums ...', ...
                'Callback', 'BRAPH2.forum()')
            uimenu(menu_about, ...
                'Label', 'Twitter ...', ...
                'Callback', 'BRAPH2.twitter()')
            uimenu(menu_about, ...
                'Label', 'License ...', ...
                'Callback', 'BRAPH2.license()')
            uimenu(menu_about, ...
                'Label', 'Credits ...', ...
                'Callback', 'BRAPH2.credits()')
        end
        function add_tool_about(toolbar)
            %ADD_TOOL_ABOUT adds the about tools to a toolbar.
            %
            % ADD_TOOL_ABOUT(TOOLBAR) adds the about tools to TOOLBAR.
            %
            % The tool buttons are findable and accessible through their tags:
            %  TOOL = findall(TOOLBAR, 'Tag', 'BRAPH2.Web');
            %  TOOL = findall(TOOLBAR, 'Tag', 'BRAPH2.Forum');
            %  TOOL = findall(TOOLBAR, 'Tag', 'BRAPH2.Twitter');
            %  TOOL = findall(TOOLBAR, 'Tag', 'BRAPH2.License');
            %  TOOL = findall(TOOLBAR, 'Tag', 'BRAPH2.Credits');
            
            uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off')
            
            % Website
            uipushtool(toolbar, ...
                'Tag', 'BRAPH2.Web', ...                
                'Separator', 'on', ...
                'TooltipString', 'Link to braph.org', ...
                'CData', imresize(imread('icon_web.png'), [24 24]), ...
                'ClickedCallback', 'BRAPH2.web()');
            
            % Forum
            uipushtool(toolbar, ...
                'Tag', 'BRAPH2.Forum', ...                
                'Separator', 'off', ...
                'TooltipString', 'Link to the BRAPH 2.0 forums', ...
                'CData', imresize(imread('icon_forum.png'), [24 24]), ...
                'ClickedCallback', 'BRAPH2.forum()');
            
            % Twitter
            uipushtool(toolbar, ...
                'Tag', 'BRAPH2.Twitter', ...                
                'Separator', 'off', ...
                'TooltipString', 'Link to the BRAPH 2.0 Twitter', ...
                'CData', imresize(imread('icon_twitter.png'), [24 24]), ...
                'ClickedCallback', 'BRAPH2.twitter()');
            
            uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off')
            
            % License
            uipushtool(toolbar, ...
                'Tag', 'BRAPH2.License', ...                
                'Separator', 'on', ...
                'TooltipString', 'BRAPH 2.0 License', ...
                'CData', imresize(imread('icon_license.png'), [24 24]), ...
                'ClickedCallback', 'BRAPH2.license()');
            
            % Credits
            uipushtool(toolbar, ...
                'Tag', 'BRAPH2.Credits', ...                
                'Separator', 'off', ...
                'TooltipString', 'Informtion about BRAPH 2.0 and credits', ...
                'CData', imresize(imread('icon_about.png'), [24 24]), ...
                'ClickedCallback', 'BRAPH2.credits()');
        end
    end
    methods (Static) % BRAPH2 checks
        function check_out = checkMatLab(ewm)
            %CHECKMATLAB checks whether the MatLab release is sufficiently new/error.
            %
            % CHECK = CHECKMATLAB checks whether the MatLab release is sufficiently new.
            %
            % CHECKMATLAB('error') throws an error if the MatLab release is sufficiently new.
            %  Error id: [BRAPH2:BRAPH2:Version].
            %
            % CHECKMATLAB('warning') throws a warning if the MatLab release is sufficiently new.
            %  Warning id: [BRAPH2:installed].
            %
            % CHECKMATLAB('msgbox') opens a message box if the MatLab release is sufficiently new.
            
            check = ~verLessThan('MatLab', BRAPH2.MATLAB_RELEASE);
            
            if nargin > 0 && strcmpi(ewm, 'error')
                assert( ...
                    check, ...
                    [BRAPH2.STR ':BRAPH2:' BRAPH2.VER], ...
                    [BRAPH2.STR ':BRAPH2:' BRAPH2.VER ' ' ...
                    'The minimal required MatLab release is ' BRAPH2.MATLAB_RELEASE ', ' ...
                    'while the installed one is ' ver('MATLAB').Version '.' ...
                    'Some BRAPH2 functionalities might not be available, or they might not function correctly.'] ...
                    )
            elseif nargin > 0 && strcmpi(ewm, 'warning') && ~check
                warning( ...
                    [BRAPH2.STR ':BRAPH2'], ...
                    [BRAPH2.STR ':BRAPH2 ' ...
                    'The minimal required MatLab release is ' BRAPH2.MATLAB_RELEASE ', ' ...
                    'while the installed one is ' ver('MATLAB').Version '. ' ...
                    'Some BRAPH2 functionalities might not be available, or they might not function correctly.'])
            elseif nargin > 0 && strcmpi(ewm, 'msgbox') && ~check
                title = [BRAPH2.STR ' MatLab version warning'];

                message = {''
                    ['{\bf\color{orange}' BRAPH2.STR '}']
                    ['{\color{gray}version ' BRAPH2.VERSION '}']
                    ['{\color{gray}build ' int2str(BRAPH2.BUILD) '}']
                    ''
                    '{\bf{WARNING} Wrong MatLab version}'
                    ''
                    ['MatLab ' BRAPH2.MATLAB_RELEASE ' is required, while MatLab ' ver('MATLAB').Version ' is installed.']
                    ''
                    'Some BRAPH2 functionalities might not be available, or they might not function correctly.'
                    ''
                    ''};

                braph2msgbox(title, message)
            end

            if nargout == 1
                check_out = check;
            end            
        end
        function check_out = installed(addon, ewm)
            %INSTALLED returns whether an addon is installed/error.
            %
            % CHECK = INSTALLED(ADDON) returns whether ADDON is installed.
            %  ADDON can be either the addon name or identifier.
            %
            % INSTALLED(ADDON, 'error') throws an error if ADDON is not installed.
            %  Error id: [BRAPH2:installed:AddOn].
            %
            % INSTALLED(ADDON, 'warning') throws a warning if ADDON is not installed.
            %  Warning id: [BRAPH2:installed].
            %
            % INSTALLED(ADDON, 'msgbox') opens a message box if ADDON is not installed.
            %
            % BRAPH2 uses the following addons:
            %  - DM: "Parallel Computing Toolbox"
            %  - NN: "Deep Learning Toolbox"
            %  - ONNXCONVERTER: "Deep Learning Toolbox Converter for ONNX Model Format"
            %  - ST: "Statistics and Machine Learning Toolbox"
            %
            % Some BRAPH2 functionalities might not be available if these addons are
            %  not installed.
            % 
            % A list of all installed addon can be obtained using
            %  <a href="matlab:matlab.addons.installedAddons">matlab.addons.installedAddons</a>

            addons = matlab.addons.installedAddons;
            check = ismember(addon, [addons.Name; addons.Identifier]);

            if nargin > 1 && strcmpi(ewm, 'error')
                assert( ...
                    check, ...
                    [BRAPH2.STR ':installed:' BRAPH2.ADDON], ...
                    [BRAPH2.STR ':installed:' BRAPH2.ADDON ' ' ...
                    'The addon ' addon ' is not installed. ' ...
                    'Some BRAPH2 functionalities might not be available, or they might not function correctly.'] ...
                    )
            elseif nargin > 1 && strcmpi(ewm, 'warning') && ~check
                warning( ...
                    [BRAPH2.STR ':installed'], ...
                    [BRAPH2.STR ':installed ' ...
                    'The addon ' addon ' is not installed. ' ...
                    'Some BRAPH2 functionalities might not be available, or they might not function correctly.'])    
            elseif nargin > 0 && strcmpi(ewm, 'msgbox') && ~check
                title = [BRAPH2.STR ' MatLab AddOn warning'];

                message = {''
                    ['{\bf\color{orange}' BRAPH2.STR '}']
                    ['{\color{gray}version ' BRAPH2.VERSION '}']
                    ['{\color{gray}build ' int2str(BRAPH2.BUILD) '}']
                    ''
                    '{\bf{WARNING} Missing MatLab AddOn}'
                    ''
                    ['MatLab ' BRAPH2.MATLAB_RELEASE ' is required, while MatLab ' ver('MATLAB').Version ' is installed.']
                    ''
                    ['The addon ' addon ' is not installed. ']
                    'Some BRAPH2 functionalities might not be available, or they might not function correctly.'
                    ''
                    ''};

                braph2msgbox(title, message)
            end

            if nargout == 1
                check_out = check;
            end
        end        
    end
end