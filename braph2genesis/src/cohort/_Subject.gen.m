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