classdef Constant
    properties (Constant)
        % Braph
        BN_NAME = 'Braph'
        COLOR = [.9 .4 .1]
        FONT = 'Helvetica'

        % Variable type codes
        STRING = 1
        NUMERIC = 2
        LOGICAL = 3
        
        % file formats and dialogs
        MSG_GETDIR = 'Select directory'
        MSG_PUTDIR = 'Select directory'
        
        MAT_EXTENSION = '*.mat';
        MAT_MSG_GETFILE = 'Select MAT file';
        MAT_MSG_PUTFILE = 'Select MAT file';

        XML_EXTENSION = '*.xml'
        XML_MSG_GETFILE = 'Select XML file'
        XML_MSG_PUTFILE = 'Select XML file'
        
        TXT_EXTENSION = '*.txt'
        TXT_MSG_GETFILE = 'Select TXT file'
        TXT_MSG_PUTFILE = 'Select TXT file'
        
        XLS_EXTENSION = {'*.xlsx';'*.xls'}
        XLS_MSG_GETFILE = 'Select Excel file'
        XLS_MSG_PUTFILE = 'Select Excel file'        
    end
end