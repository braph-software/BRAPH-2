classdef BRAPH2
    %BRAPH2 constants.
    % BRAPH2 is a static class that contains the constants used by BRAPH2.
    %
    % Properties (Constant) - BRAPH2 ID Card:
    %  NAME         - BRAPH2 full name
    %  VERSION      - BRAPH2 version
    %  WEB          - BRAPH2 website
    %  STR          - BRAPH2 sort string
    %  BUILD        - BRAPH2 build number
    %  AUTHORS      - BRAPH2 authors
    %  COPYRIGHT    - BRAPH2 copyright
    %
    % Properties (Constant) - BRAPH2 extensions
    %  EXT_ELEMENT  - BRAPH2 element extension (*.b2)
    %  EXT_PIPELINE - BRAPH2 pipeline extension (*.braph2)
    %  EXT_WORKSPACE - BRAPH2 workspace extension (*.mat)
    %
    % Properties (Constant) - BRAPH2 error codes:
    %  WRONG_INPUT  - wrong input value or format in a function
    %  WRONG_OUTPUT - wrong output value or format in a function
    %  BUG_FUNC     - bug in a function (wrong behavior)
    %  BUG_COPY     - bug while deep-copying an object
    %  BUG_CLONE    - bug while cloning an object
    %  BUG_IO       - bug while loading/saving
    %  BUG_JSON     - bug in JSON encoding/deconding
    %  BUG_ERR      - bug in the handling of errors
    %  IM_ERR       - error while importing a file
    %  EX_ERR       - error while exporting a file
    %
    % Properties (Constant) - BRAPH2 GUI constants:
    %  FONTUNITS    - sets the units of the font
    %  FONTSIZE     - sets the size of the font
    %  COL_FIG      - figure background color
    %
    % Methods (Static) - BRAPH2 info panels:
    %  about        - provides information about BRAPH2
    %  license      - provides information about the license of BRAPH2
    
    properties (Constant) % BRAPH2 ID Card
        NAME = 'Braph 2.0' % BRAPH2 full name
        VERSION = '2.0' % BRAPH2 version
        WEB = 'braph.org' % BRAPH2 website
        STR = 'BRAPH2' % BRAPH2 sort string
        BUILD = 1 % BRAPH2 build number
        AUTHORS = 'Giovanni Volpe, Emiliano Gomez Ruiz, Anna Canal Garcia, Yu-Wei Chang, Mite Mijalkov, Joana Braga Pereira, Ehsan Kakaei, Eric Westman, et al.'
        COPYRIGHT = ['Copyright 2014-' datestr(now,'yyyy')]        
    end
    properties (Constant) % BRAPH2 extensions
        EXT_ELEMENT = {'*.b2'} % BRAPH2 element extension
        EXT_PIPELINE = {'*.braph2'} % BRAPH2 pipeline extension
        EXT_WORKSPACE = {'*.b2ws'} % BRAPH2 workspace extension % FIXME: keep? eliminate? change to .mat?
    end
    properties (Constant) % BRAPH2 error codes
        WRONG_INPUT = 'WrongInput' % wrong input value or format in a function
        WRONG_OUTPUT = 'WrongOutput' % wrong output value or format in a function
        BUG_FUNC = 'BugFunc' % bug in a function (wrong behavior)
        BUG_COPY = 'BugCopy' % bug while deep-copying an object
        BUG_CLONE = 'BugClone' % bug while cloning an object
        BUG_IO = 'BugIO' % bug while loading/saving files
        BUG_JSON = 'BugJSON' % bug in JSON encoding/deconding
        BUG_ERR = 'BugErr' % bug in the handling of errors
        IM_ERR = 'ImporterError. Most likely wrong file format.' % error while importing a file
        EX_ERR = 'ExporterError.' % error while exporting a file
    end
    properties (Constant) % BRAPH2 GUI constants
        FONTUNITS = 'points'
        FONTSIZE = 12
        COL_FIG = [1 .9725 .929] % figure background color
        COL_M = [.20 .50 .80] % standard metadata background color % [.745 .839 .902]
        COL_P = [.40 .50 .60] % standard parameter background color % [.38 .514 .6]
        COL_D = [.60 .50 .40] % standard data background color % [.902 .835 .745]
        COL_R = [.80 .50 .20] % standard result background color % [.62 .545 .439]
    end
    methods (Static)
        function about()
            %ABOUT provides information about BRAPH2.
            %
            % See also license.
            
            CreateStruct.WindowStyle = 'modal';
            CreateStruct.Interpreter = 'tex';
            h = msgbox({'' ...
                ['{\bf\color{orange}' BRAPH2.STR '}'] ...
                ['{\color{gray}version ' BRAPH2.VERSION '}'] ...
                ['{\color{gray}' BRAPH2.WEB '}'] ...
                '' ...
                BRAPH2.AUTHORS ...
                '' ...
                ['{\color{gray}' BRAPH2.COPYRIGHT '}'] ...
                '' ...
                ''}, ...
                ['About ' BRAPH2.STR], ...
                CreateStruct);
            set_braph2_icon(h)
        end        
        function license()
            %LICENSE provides information about the license of BRAPH2.
            %
            % See also about.
            
            CreateStruct.WindowStyle = 'modal';
            CreateStruct.Interpreter = 'tex';
            h = msgbox({'' ...
                ['{\bf\color{orange}' BRAPH2.STR '}'] ...
                ['{\color{gray}version ' BRAPH2.VERSION '}'] ...
                ['{\color{gray}' BRAPH2.WEB '}'] ...
                '' ...
                'The license is available in the file {\bfbraph2license.rtf} on the main directory of BRAPH2.' ...
                'In brief, BRAPH2 is provided as is and is free to use for research.' ...
                '' ...
                ['{\color{gray}' BRAPH2.COPYRIGHT '}'] ...
                '' ...
                ''}, ...
                [BRAPH2.STR ' License'], ...
                CreateStruct);
            set_braph2_icon(h)
        end        
    end
end