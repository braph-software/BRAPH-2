classdef Group < handle & matlab.mixin.Copyable
    % Group A group of subjects
    % Group provides the methods necessary to handle groups of subjects
    % It is a subclass of handle & matlab.mixin.Copyable
    %
    % Group provides the methods necessary to handle groups of subjects. 
    % It manages the subjects as a list of subjects. Group can inspect
    % inside the list to search for specific subjects. Group can add or 
    % remove subjects from the list. 
    %
    % Group basic methods:
    %   Group                   - constructor
    %   tostring                - returns a string representing the group
    %   disp                    - displays the group
    % 
    % Group set methods:
    %   setID                   - sets the ID
    %   setLabel                - sets the label
    %   setNotes                - sets the notes
    %
    % Group get methods:
    %   getID                   - gets the ID
    %   getLabel                - gets the label
    %   getNotes                - gets the notes
    %   getSubjectClass         - gets the class of the subject
    %
    % Group inspection methods (Static):
    %   subjectnumber           - returns the number of subjects in the group
    %   getSubjects             - returns the subjects
    %   contains_subject        - checks if the group contains the subject
    %   addSubject              - adds the subject to the group
    %   addSubjects             - adds the subjects to the group
    %   removeSubject           - removes the subject from the group
    %   removeSubjects          - removes the subjects from the group
    %
    % See also Data, Subject, Group.

    properties % (GetAccess=protected, SetAccess=protected)
        id  % group id
        label  % group label
        notes  % group notes
        subject_class  % class of the subjects
        subjects  % list of subjects
    end
    methods  % Basic functions
        function group = Group(subject_class, id, label, notes, subjects, varargin)
            % GROUP creates a group
            %
            % GROUP(SUBJECT_CLASS, ID, LABEL, NOTES, SUBJECTS) creates a
            % group with ID, LABEL and notes. Adds the SUBJECTS of class
            % SUBJECT_CLASS to the group.
            %
            % See also Data, Subject, Cohort.

            group.setID(id)
            group.setLabel(label)
            group.setNotes(notes)
            
            assert(any(strcmp(Subject.getList(), subject_class)), ...
                [BRAPH2.STR ':Group:' BRAPH2.WRONG_INPUT], ...
                [subject_class ' is not a valid Subject class'])
            group.subject_class = subject_class;

            group.subjects = {};
            for i = 1:1:length(subjects)
                group.addSubject(subjects{i});
            end            
        end
        function str = tostring(group)
            % TOSTRING string with information about the group
            %
            % STR = TOSTRING(SUBJECT) returns a string with the group ID,
            % number of subjects and class of the subjects.
            %
            % See also disp.
            
            str = ['Group ' group.getID() ' with ' int2str(group.subjectnumber()) ' ' group.getSubjectClass()];
        end
        function disp(group)
            % DISP displays information about the group
            %
            % DISP(SUBJECT) displays information about the group.
            % It provides information about group ID, subjectnumber, label,
            % notes, class and subjects.
            %
            % See also tostring.
            
            disp(['<a href="matlab:help Group">Group</a> with ' int2str(group.subjectnumber()) ' ' group.getID() ' ' group.getLabel() ' ' ...
                '<a href="matlab:help ' group.getSubjectClass() '">' group.getSubjectClass() '</a>'])
            disp(group.getNotes())
            subjects = group.getSubjects(); %#ok<PROP>
            str = 'Subject IDs: ';
            for i = 1:1:group.subjectnumber()
                subject = subjects{i}; %#ok<PROP>
                str = [str ' ' tostring(subject.getID())]; %#ok<AGROW>
            end
            disp(str)
        end
    end
    methods  % Set functions
        function setID(group, id)
            % SETID sets the id of the group
            %
            % SETID(GROUP, ID) sets the ID of the group.
            %
            % See also getID, setLabel, setNotes.
            
            group.id = tostring(id);
        end
        function setLabel(group, label)
            % SETLABEL sets the label of the group
            %
            % SETLABEL(GROUP, LABEL) sets the label of the group.
            %
            % See also setID, setNotes, getLabel.
            
            group.label = tostring(label);
        end
        function setNotes(group, notes)
            % SETNOTES sets the notes of the group
            %
            % SETNOTES(GROUP, NOTES) sets the notes of the group.
            %
            % See also setID, setLabel, getNotes.
            
            group.notes = tostring(notes);
        end
    end
    methods  % Get functions
        function id = getID(group)
            % GETID returns the id of the group
            %
            % ID = GETID(GROUP) returns the id of the group.
            %
            % See also setID, getLabel, getNotes, getSubjectClass.
            
            id = group.id;
        end
        function label = getLabel(group)
            % GETLABEL returns the label of the group
            %
            % LABEL = GETLABEL(GROUP) returns the label of the group.
            %
            % See also getID, getNotes, getBrainAtlases, getData, setLabel.
            
            label = group.label;
        end
        function notes = getNotes(group)
            % GETNOTES returns the notes of the group
            %
            % NOTES = GETNOTES(GROUP) returns the notes of the group.
            %
            % See also getID, getLabel, getSubjectClass, setNotes.

            notes = group.notes;
        end
        function subject_class = getSubjectClass(group)
            % GETSUBJECTCLASS returns the class of the subjects 
            %
            % SUBJECT_CLASS = GETSUBJECTCLASS(GROUP) returns the class of 
            % the subjects in the group.
            %
            % See also getID, getLabel, getNotes.
            
            subject_class = group.subject_class;
        end
    end
    methods  % Inspection functions
        function n = subjectnumber(group)
            n = length(group.subjects);
        end
        function subjects = getSubjects(group)
            subjects = group.subjects;
        end
        function bool = contains_subject(group, subject)
            bool = false;
            for i = 1:1:group.subjectnumber()
                if group.subjects{i} == subject
                    bool = true;
                    break
                end
            end
        end
        function addSubject(group, subject)
            if ~group.contains_subject(subject)
                group.subjects{end+1} = subject;
            end
        end
        function addSubjects(group, subjects)
            for i = 1:1:length(subjects)
                subject = subjects{i};
                group.addSubject(subject)
            end
        end
        function removeSubject(group, subject)
            for i = 1:1:group.subjectnumber()
                if group.subjects{i} == subject
                    group.subjects(i) = [];
                    break
                end
            end
        end
        function removeSubjects(group, subjects)
            for i = 1:1:length(subjects)
                subject = subjects{i};
                group.removeSubject(subject)
            end
        end
    end    
end