%% ¡header!
Subject < Element (sub, subject) is a subject.

%%% ¡description!
Subject provides the methods necessary for all subjects. 
Instances of this class should not be created. 
Use one of its subclasses instead.

%%% ¡seealso!
Element, BrainAtlas, Group

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the subject.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject.

%%% ¡prop!
ATLAS_DICT (data, idict) is a dictionary with brain atlases.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
DATA_DICT (data, idict) is a dictionary with subject data.

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

    atlas_number = length(sub.get('ATLAS_DICT'));
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

    data_number = length(sub.get('DATA_DICT'));
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Instantiation
%%%% ¡code!
br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);

items = {br1, br2, br3, br4, br5};

idict_1 = IndexedDictionary( ...
    'id', 'idict', ...
    'it_class', 'BrainRegion', ...
    'it_key', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'it_list', items ...
    );
atlas = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'Notes', 'Notes on brain atlas.', 'br_dict', idict_1);

atlas_dict = IndexedDictionary( ...
    'id', 'atlas_idict', ...
    'it_class', 'BrainAtlas', ...
    'it_key', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'it_list', {atlas} ...
    );

subject = Subject('ID','id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'ATLAS_DICT', atlas_dict)
