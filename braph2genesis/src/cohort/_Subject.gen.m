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
ATLASES () is a cell array with brain atlases.

%%% ¡prop!
DATADICT () is a dictionary with subject data.

%%% ¡prop!
h_panel

%% ¡methods!
function sub = Subject(id, label, notes, atlases, varargin)
    % SUBJECT creates a subject
%
% SUBJECT(ID, LABEL, NOTES, ATLASES) creates a subject with ID,
% LABEL, NOTES and ATLASES which are the brain atlases that subject will use.
% This method is only accessible by the subclasses of Subject.
%
% SUBJECT(ID, LABEL, NOTES, ATLASES, 'PROPERTYRULE1, 'VALUE1, ...)
% creates a subject with subject ID, LABEL NOTES and ATLASES.
% Subject will be initialized with the settings passed in the
% VARARGIN.
%
% See also Group, Cohort, SubjectMRI, SubjectfMRI, SubjectDTI.

    assert(iscell(atlases) && all(cellfun(@(atlas) isa(atlas, 'BrainAtlas'), atlases)), ...
        [BRAPH2.STR ':' class(sub) ':' BRAPH2.WRONG_INPUT], ...
        'The input atlases must be a cell array of BrainAtlas.')
    sub.atlases = atlases;

    sub.set('ID', id)
    sub.set('LABEL', label)
    sub.set('NOTES', notes)

    sub.initialize_datadict(atlases, varargin{:})

    data_codes = sub.getDataCodes();
    for i = 1:1:numel(data_codes)
        data_code = data_codes{i};
        value = get_from_varargin(sub.getData(data_code).getValue(), data_code, varargin{:});
        sub.getData(data_code).setValue(value);
    end
end
function str = tostring(subject)
    % TOSTRING string with information about the subject
    %
    % STR = TOSTRING(SUBJECT) returns string with the subject class and id.
    %
    % See also disp.

    str = [Subject.getClass(subject) ' ' tostring(subject.get('ID'))];
end
function disp(subject)
    % DISP displays information about the subject
    %
    % DISP(SUBJECT) displays information about the subject.
    % It provides information about subject class, id and data
    % codes.
    %
    % See also tostring.

    disp(['<a href="matlab:help ' Subject.getClass(subject) '">' Subject.getClass(subject) '</a>' ...
        ' ID:' tostring(subject.getID())])
    data_codes = subject.getDataCodes();
    for i = 1:1:subject.getDataNumber()
        data_code = data_codes{i};
        d = subject.getData(data_code);
        disp([data_code ' = ' d.tostring()])
    end
end
