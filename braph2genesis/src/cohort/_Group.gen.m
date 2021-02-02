%% ¡header!
Group < Element (gr, group of subjects) is a group of subjects.

%%% ¡description!
Group represents a group of subjects whose class is defined in the constructor.

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the group of subjects.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the group of subjects.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the group of subjects.

%%% ¡prop!
SUB_CLASS (parameter, class) is the class of the subjects of the group.
%%%% ¡settings!
'Subject'

%%% ¡prop!
SUB_DICT (data, idict) is an indexed dictionary containing the subjects  of the group.
%%%% ¡settings!
'Subject'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'Subject', 'IT_KEY', 1)

%% ¡methods!
function n = subjectnumber(gr)
    % SUBJECTNUMBER returns the number of subjects in the group
    %
    % N = SUBJECTNUMBER(GROUP) returns the number of subjects in
    % the group.
    %
    % See also getSubjects, contains_subject, addSubject, removeSubject.

    n = length(gr.get('SUB_DICT'));
end
function bool = contains_subject(gr, subject)
    % CONTAINS_SUBJECT checks if the subject is in the group
    %
    % BOOL = SUBJECTNUMBER(GR, SUBJECT) checks if the subject is in
    % the group.
    %
    % See also subjectnumber, addSubject, removeSubject.
    
    sub_dict = gr.get('SUB_DICT');
    bool = sub_dict.containsItem();
end
function addSubject(gr, subject)
    % ADDSUBJECT adds the subject to the group
    %
    % ADDSUBJECT(GR, SUBJECT) adds the subject to the group if
    % its not already a part of the group.
    %
    % See also subjectnumber, contains_subject, removeSubject.

    if ~gr.contains_subject(subject)
        sub_dict = gr.get('SUB_DICT');
        sub_dict.add(subject);  % adds subject to the end of sub_dict
    end
end
function addSubjects(gr, subjects)
    % ADDSUBJECTS adds the subjects to the group
    %
    % ADDSUBJECTS(GR, SUBJECTS) adds the subjects to the group.
    %
    % See also subjectnumber, contains_subject, addSubject, removeSubject.

    for i = 1:1:length(subjects)
        subject = subjects{i};
        gr.addSubject(subject)
    end
end
function removeSubject(group, subject)
    % REMOVESUBJECT removes the subject from the group
    %
    % REMOVESUBJECT(GR, SUBJECT) removes the subject from the group.
    %
    % See also subjectnumber, contains_subject, addSubject.
    
    sub_dict = gr.get('SUB_DICT');
    sub_dict.remove(subject);  % removes the subject from sub_dict
end
function removeSubjects(gr, subjects)
    % REMOVESUBJECTS removes the subjects from the group
    %
    % REMOVESUBJECTS(GR, SUBJECTS) removes the subjects from the group.
    %
    % See also subjectnumber, contains_subject, addSubject.
    
    for i = 1:1:length(subjects)
        subject = subjects{i};
        gr.removeSubject(subject)
    end
end
        