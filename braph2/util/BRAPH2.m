classdef BRAPH2
    % BRAPH2 Constants
    % BRAPH2 is a static class that contains the constants used by BRAPH2.
    %
    % Properties(Constant) - BRAPH2 ID Card:
    %   NAME    - BRAPH2 full name
    %   STR     - BRAPH2 sort string
    %
    % Properties(Constant) - BRAPH2 error codes:
    %   WRONG_INPUT     - wrong input value or format in a function
    %   WRONG_OUTPUT    - wrong output value or format in a function
    %   BUG_FUNC        - bug in a function (wrong behavior)
    %   BUG_COPY        - bug while deep-copying an object
    
    properties (Constant)  % BRAPH2 ID Card
        NAME = 'Braph 2.0'  % BRAPH2 full name
        STR = 'BRAPH2'  % BRAPH2 sort string
    end
    properties (Constant)  % BRAPH2 error codes
        WRONG_INPUT = 'WrongInput'  % wrong input value or format in a function
        WRONG_OUTPUT = 'WrongOutput'  % wrong output value or format in a function
        BUG_FUNC = 'BugFunc'  % bug in a function (wrong behavior)
        BUG_COPY = 'BugCopy'  % bug while deep-copying an object
    end
    properties (Constant)  % BRAPH2 file extensions
        % Brain Surface
        BRAINSURFACE_EXTENSION = '*.nv';
        BRAINSURFACE_MSG = 'Select NV file';
    end
    %         BUILD = 2020
    %         VERSION = '2.0.0'
    %         DATE = ''
    %         AUTHORS = ''
    %         COPYRIGHT = ['Copyright 2014-' datestr(now,'yyyy')]
    %
    %         % Braph
    %         COLOR = [.9 .4 .1]
    %         FONT = 'Helvetica'
    
    properties (Constant) % Variable type codes
        STRING = 1
        NUMERIC = 2
        LOGICAL = 3
    end
    
    
    
    %         % file formats and dialogs
    %         MSG_GETDIR = 'Select directory'
    %         MSG_PUTDIR = 'Select directory'
    %
    %         MAT_EXTENSION = '*.mat';
    %         MAT_MSG_GETFILE = 'Select MAT file';
    %         MAT_MSG_PUTFILE = 'Select MAT file';
    %
    %         XLS_EXTENSION = {'*.xlsx';'*.xls'};
    %         XLS_MSG_GETFILE = 'Select Excel file';
    %         XLS_MSG_PUTFILE = 'Select Excel file';
    %
    %         TXT_EXTENSION = '*.txt';
    %         TXT_MSG_GETFILE = 'Select TXT file';
    %         TXT_MSG_PUTFILE = 'Select TXT file';
    %
    %         JSON_EXTENSION = '*.json'
    %         JSON_MSG_GETFILE = 'Select JSON file'
    %         JSON_MSG_PUTFILE = 'Select JSON file'
end