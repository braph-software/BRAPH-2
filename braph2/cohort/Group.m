classdef Group < handle & matlab.mixin.Copyable
    properties % (GetAccess=protected, SetAccess=protected)
        id  % group id
        label  % group label
        notes  % group notes
        subject_class  % class of the subjects
        subjects  % list of subjects
    end
    methods  % Basic functions
        function group = Group(subject_class, id, label, notes, subjects, varargin)

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
            str = ['Group ' group.getID() ' with ' int2str(group.subjectnumber()) ' ' group.getSubjectClass()];
        end
        function disp(group)
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
            group.id = tostring(id);
        end
        function setLabel(group, label)
            group.label = tostring(label);
        end
        function setNotes(group, notes)
            group.notes = tostring(notes);
        end
    end
    methods  % Get functions
        function id = getID(group)
            id = group.id;
        end
        function label = getLabel(group)
            label = group.label;
        end
        function notes = getNotes(group)
            notes = group.notes;
        end
        function subject_class = getSubjectClass(group)
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