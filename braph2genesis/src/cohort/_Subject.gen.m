%% ¡header!
Subject < Element (sub, subject) is a subject.

%%% ¡description!
Subject provides the methods necessary for all subjects. 
Instances of this class should not be created. 
Use one of its subclasses instead.

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the subject.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject.

%%% ¡prop!
ATLASES (data, cell) is a cell array with brain atlases.

%%% ¡prop!
DATA_DICT (data, idict) is a dictionary with subject data.

%%% ¡prop!
h_panel

%% ¡methods!
function subject_list = getList()
    % GETLIST returns the list of available subjects
    %
    % SUBJECT_LIST = GETLIST() returns the list of subjects
    % (cell array) that are subclasses of Subject.
    %
    % See also getClass, getName, getDescription.

    subject_list = subclasses('Subject');
end
function atlas_number = getBrainAtlasNumber(sub)
    % GETBRAINATLASNUMBER returns the number of brain atlases
    %
    % N = GETBRAINATLASNUMBER(SUB) returns the number of
    % brain atlases to the concrete subject SUB.
    %
    % N = GETBRAINATLASNUMBER(SUBJECT_CLASS) returns the number
    % of brain atlases to the subject whose class is SUBJECT_CLASS.
    %
    % See also getList, getDescription, getName, getClass.

    % number of differetn brain atlases

    atlas_number = length(sub.get('ATLASES'));
end
function data_number = getDataNumber(sub)
    % GETDATANUMBER returns the number of data
    %
    % N = GETDATANUMBER(SUB) returns the number of data of the
    % subclass SUB
    %
    % N = GETDATANUMBER(SUBJECT_CLASS) returns the number
    % of data to the subject whose class is SUBJECT_CLASS.
    %
    % See also getDataList, getBrainAtlasNumber, getDataCodes

    data_number = length(gr.get('DATA_DICT'));
end