%% ¡header!
Group < Element (gr, group of subjects) is a group of subjects.

%%% ¡description!
Group represents a group of subjects whose class is defined in the constructor.
Group provides the methods necessary to handle groups of subjects. 
It manages the subjects as a dictionary of subjects. Group can inspect
inside the dictionary to search for specific subjects. Group can add or 
remove subjects from the dictionary.

%%% ¡seealso!
Element, Subject

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
SUB_DICT (data, idict) is an indexed dictionary containing the subjects of the group.
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

% TO ADAPT FROM PREVIOUS VERSION
% for i = 1:1:length(subject_class_list)
%     subject_class = subject_class_list{i};
% 
%     sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)));
%     sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)));
%     sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)));
%     sub4 = Subject.getSubject(subject_class, 'id4', 'label 4', 'notes 4', repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)));
%     sub5 = Subject.getSubject(subject_class, 'id5', 'label 5', 'notes 5', repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)));
%     
%     group = Group(subject_class, 'id', 'label', 'notes', {sub1, sub2, sub3 sub4, sub5});
% end