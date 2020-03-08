classdef Group < handle & matlab.mixin.Copyable
    properties % (GetAccess=protected, SetAccess=protected)
        name  % group name
        description  % group description
        subject_class  % class of the subjects
        subjects  % list of sugjects
    end
    methods
        function group = Group(subject_class, subjects, varargin)

            name = get_from_varargin('', 'GroupName', varargin{:});
            group.setName(name)

            description = get_from_varargin('', 'GroupDescription', varargin{:});
            group.setDescription(description)
            
            assert(any(strcmp(Subject.getList(), subject_class)), ...
                ['BRAPH:Group:SubjectClassErr'], ...
                [subject_class ' is not a valid Subject class']) %#ok<NBRAK>
            group.subject_class = subject_class;

            group.subjects = {};
            for i = 1:1:length(subjects)
                group.addSubject(subjects{i});
            end            
        end
        function str = tostring(group)
            str = ['Group ' group.getName() ' with ' int2str(group.subjectnumber()) ' ' group.getSubjectClass()];
        end
        function disp(group)
            disp(['<a href="matlab:help Group">Group</a> with ' int2str(group.subjectnumber()) ' ' group.getName() ' ' ...
                '<a href="matlab:help ' group.getSubjectClass() '">' group.getSubjectClass() '</a>'])
            disp(group.getDescription())
            subjects = group.getSubjects(); %#ok<PROP>
            str = 'Subject IDs: ';
            for i = 1:1:group.subjectnumber()
                subject = subjects{i}; %#ok<PROP>
                str = [str ' ' tostring(subject.getID())]; %#ok<AGROW>
            end
            disp(str)
        end
        function setName(group, name)
            group.name = tostring(name);
        end
        function name = getName(group)
            name = group.name;
        end
        function setDescription(group, description)
            group.description = tostring(description);
        end
        function description = getDescription(group)
            description = group.description;
        end
        function subject_class = getSubjectClass(group)
            subject_class = group.subject_class;
        end
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