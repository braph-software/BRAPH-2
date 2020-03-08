classdef Cohort < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        name  % brain atlas name
        subject_class  % class of the subjects
        atlases  % cell array with brain atlases
        subject_dict  % indexed dictionary with subjects
        group_dict  % indexed dictionary with groups
    end
    methods
        function cohort = Cohort(name, subject_class, atlases, subjects)
            % subjects must be a cell array of Subjects of class
            
            cohort.name = name;
            
            assert(any(strcmp(Subject.getList(), subject_class)), ...
                ['BRAPH:Cohort:SubjectClassErr'], ...
                [subject_class ' is not a valid Subject class']) %#ok<NBRAK>
            cohort.subject_class = subject_class;
            
            if ~iscell(atlases)
                atlases = {atlases};
            end
            assert(all(cellfun(@(atlas) isa(atlas, 'BrainAtlas'), atlases)) ...
                && length(atlases) == Subject.getBrainAtlasNumber(subject_class), ...
                ['BRAPH:Cohort:AtlasErr'], ...
                ['The input atlases should be a cell array with ' int2str(Subject.getBrainAtlasNumber(subject_class)) ' BrainAtlas']) %#ok<NBRAK>
            cohort.atlases = atlases;
            
            cohort.subject_dict = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            for i = 1:1:length(subjects)
                cohort.addSubject(subjects{i}, i);
            end
            
            cohort.group_dict = containers.Map('KeyType', 'int32', 'ValueType', 'any');
        end
        function str = tostring(cohort)
            str = ['Cohort with ' int2str(cohort.subjectnumber()) ' ' cohort.getSubjectClass() ' in ' int2str(cohort.groupnumber()) ' group(s)'];
        end
        function disp(cohort)
            disp(['<a href="matlab:help ' class(cohort) '">' class(cohort) '</a>'])
            disp([' size: ' int2str(cohort.subjectnumber()) ' <a href="matlab:help ' cohort.getSubjectClass() '">' cohort.getSubjectClass() '</a>'])
            disp([' group(s): ' int2str(cohort.groupnumber())])
        end
        function name = getName(cohort)
            name = cohort.name;
        end
        function subject_class = getSubjectClass(cohort)
            subject_class = cohort.subject_class;
        end
        function atlases = getBrainAtlases(cohort)
            atlases = cohort.atlases;
        end
        function n = subjectnumber(cohort)
            n = length(cohort.subject_dict);
        end
        function bool = contains_subject(cohort, subject)
            
            if isa(subject, cohort.getSubjectClass())
                bool = false;
                for i = 1:1:cohort.subjectnumber()
                    if cohort.getSubject(i) == subject
                        bool = true;
                        break
                    end
                end
            else  % the subject is the subject_index
                subject_index = subject;
                bool = isKey(cohort.subject_dict, subject_index);
            end
        end
        function subject_index = getSubjectIndex(cohort, subject)
            
            for i = 1:1:cohort.subjectnumber()
                if cohort.getSubject(i) == subject
                    subject_index = i;
                    break
                end
            end
        end
        function subject = getSubject(cohort, subject_index)
            subject = cohort.subject_dict(subject_index);
        end
        function subjects = getSubjects(cohort)
            subjects = values(cohort.subject_dict);
        end
        function subject_ids = getSubjectIDs(cohort)
            subject_ids = cell(1, cohort.subjectnumber());
            for i = 1:1:cohort.subjectnumber()
                subject = cohort.getSubject(i);
                subject_ids{i} = subject.getID();
            end
        end
        function addSubject(cohort, subject, i)
            
            if nargin < 3 || i < 0 || i > cohort.subjectnumber()
                i = cohort.subjectnumber() + 1;
            end
            
            assert(isa(subject, cohort.getSubjectClass()), ...
                ['BRAPH:Cohort:SubjectClassErr'], ...
                ['All Subject classes should be ' cohort.getSubjectClass() ', but one is ' subject.getClass()]) %#ok<NBRAK>
            
            if i <= cohort.subjectnumber()
                for j = cohort.subjectnumber():-1:i
                    cohort.subject_dict(j+1) = cohort.subject_dict(j);
                end
            end
            cohort.subject_dict(i) = subject;
        end
        function removeSubject(cohort, i)
            
            for j = i:1:cohort.subjectnumber()-1
                cohort.subject_dict(j) = cohort.subject_dict(j+1);
            end
            remove(cohort.subject_dict, cohort.subjectnumber());
        end
        function replaceSubject(cohort, i, subject)
            
            assert(isa(subject, cohort.getSubjectClass()), ...
                ['BRAPH:Cohort:SubjectClassErr'], ...
                ['All Subject classes should be ' cohort.getSubjectClass() ', but one is ' subject.getClass()]) %#ok<NBRAK>
            
            if i > 0 || i <= cohort.subjectnumber()
                cohort.subject_dict(i) = subject;
            end
            
        end
        function invertSubjects(cohort, i, j)
            
            if i > 0 && i <= cohort.subjectnumber() && j > 0 && j <= cohort.subjectnumber() && i ~= j
                subject_i = cohort.getSubject(i);
                subject_j = cohort.getSubject(j);
                cohort.replaceSubject(i, subject_j)
                cohort.replaceSubject(j, subject_i)
            end
        end
        function movetoSubject(cohort, i, j)
            
            if i > 0 && i <= cohort.subjectnumber() && j > 0 && j <= cohort.subjectnumber() && i ~= j
                subject = cohort.getSubject(i);
                if i > j
                    cohort.removeSubject(i)
                    cohort.addSubject(subject, j)
                else  % j < i
                    cohort.addSubject(subject, j+1)
                    cohort.removeSubject(i)
                end
            end
        end
        function selected = removeSubjects(cohort, selected)
            
            for i = length(selected):-1:1
                cohort.removeSubject(selected(i))
            end
            selected = [];
        end
        function [selected, added] = addaboveSubjects(cohort, selected)
            
            for i = length(selected):-1:1
                subject = Subject.getSubject(cohort.getSubjectClass(), cohort.atlases{:});
                cohort.addSubject(subject, selected(i))
            end
            selected = selected + reshape(1:1:numel(selected), size(selected));
            added = selected - 1;
        end
        function [selected, added] = addbelowSubjects(cohort, selected)
            
            for i = length(selected):-1:1
                subject = Subject.getSubject(cohort.getSubjectClass(), cohort.atlases{:});
                cohort.addSubject(subject, selected(i) + 1)
            end
            selected = selected + reshape(0:1:numel(selected)-1, size(selected));
            added = selected + 1;
        end
        function selected = moveupSubjects(cohort, selected)
            
            if ~isempty(selected)
                
                first_index_to_process = 1;
                unprocessable_length = 1;
                while first_index_to_process <= cohort.subjectnumber() ...
                        && first_index_to_process <= numel(selected) ...
                        && selected(first_index_to_process) == unprocessable_length
                    first_index_to_process = first_index_to_process + 1;
                    unprocessable_length = unprocessable_length + 1;
                end
                
                for i = first_index_to_process:1:numel(selected)
                    cohort.invertSubjects(selected(i), selected(i)-1);
                    selected(i) = selected(i) - 1;
                end
            end
        end
        function selected = movedownSubjects(cohort, selected)
            
            if ~isempty(selected)
                
                last_index_to_process = numel(selected);
                unprocessable_length = cohort.subjectnumber();
                while last_index_to_process > 0 ...
                        && selected(last_index_to_process) == unprocessable_length
                    last_index_to_process = last_index_to_process - 1;
                    unprocessable_length = unprocessable_length - 1;
                end
                
                for i = last_index_to_process:-1:1
                    cohort.invertSubjects(selected(i), selected(i) + 1);
                    selected(i) = selected(i) + 1;
                end
            end
        end
        function selected = move2topSubjects(cohort, selected)
            
            if ~isempty(selected)
                for i = 1:1:numel(selected)
                    cohort.movetoSubject(selected(i), i);
                end
                selected = reshape(1:1:numel(selected), size(selected));
            end
        end
        function selected = move2bottomSubjects(cohort, selected)
            
            if ~isempty(selected)
                for i = numel(selected):-1:1
                    cohort.movetoSubject(selected(i), cohort.subjectnumber() - (numel(selected)-i));
                end
                selected = reshape(cohort.subjectnumber() - numel(selected)+1:1:cohort.subjectnumber(), size(selected));
            end
        end
        function n = groupnumber(cohort)
            n = length(cohort.group_dict);
        end
        function bool = contains_group(cohort, group)
            
            if isa(group, 'Group')
                bool = false;
                for i = 1:1:cohort.groupnumber()
                    if cohort.getGroup(i) == group
                        bool = true;
                        break
                    end
                end
            else  % the group is the group_index
                group_index = group;
                bool = isKey(cohort.group_dict, group_index);
            end
        end
        function group = getGroup(cohort, group_index)
            group = cohort.group_dict(group_index);
        end
        function groups = getGroups(cohort)
            groups = values(cohort.group_dict);
        end
        function group_names = getGroupNames(cohort)
            
            group_names = cell(1, cohort.groupnumber());
            for i = 1:1:cohort.groupnumber()
                group = cohort.getGroup(i);
                group_names{i} = group.getName();
            end
        end
        function group_descriptions = getGroupDescriptions(cohort)
            
            group_descriptions = cell(1, cohort.groupnumber());
            for i = 1:1:cohort.groupnumber()
                group = cohort.getGroup(i);
                group_descriptions{i} = group.getDescription();
            end
        end
        function addGroup(cohort, group, i)
            
            if nargin < 3 || i < 0 || i > cohort.groupnumber()
                i = cohort.groupnumber() + 1;
            end
            
            if nargin < 2
                group = Group(cohort.getSubjectClass(), []);
            end
            
            assert(isa(group, 'Group') && isequal(group.getSubjectClass, cohort.getSubjectClass()), ...
                ['BRAPH:Cohort:GroupClassErr'], ...
                ['All groups must be objects of the class Group with Subject class ' cohort.getSubjectClass() ', but this is ' class(group)]) %#ok<NBRAK>
            
            if i <= cohort.groupnumber()
                for j = cohort.groupnumber():-1:i
                    cohort.group_dict(j+1) = cohort.group_dict(j);
                end
            end
            cohort.group_dict(i) = group;
        end
        function removeGroup(cohort, i)

            for j = i:1:cohort.groupnumber()-1
                cohort.group_dict(j) = cohort.group_dict(j+1);
            end
            remove(cohort.group_dict, cohort.groupnumber());
        end
        function replaceGroup(cohort, i, group)

            assert(isa(group, 'Group') && isequal(group.getSubjectClass, cohort.getSubjectClass()), ...
                ['BRAPH:Cohort:GroupClassErr'], ...
                ['All groups must be objects of the class Group with Subject class ' cohort.getSubjectClass() ', but this is ' class(group)]) %#ok<NBRAK>

            if i > 0 || i <= cohort.groupnumber()
                cohort.group_dict(i) = group;
            end

        end
        function invertGroups(cohort, i, j)

            if i > 0 && i <= cohort.groupnumber() && j > 0 && j <= cohort.groupnumber() && i ~= j
                group_i = cohort.getGroup(i);
                group_j = cohort.getGroup(j);
                cohort.replaceGroup(i, group_j)
                cohort.replaceGroup(j, group_i)
            end
        end
        function movetoGroup(cohort, i, j)

            if i > 0 && i <= cohort.groupnumber() && j > 0 && j <= cohort.groupnumber() && i ~= j
                group = cohort.getGroup(i);
                if i > j
                    cohort.removeGroup(i)
                    cohort.addGroup(group, j)
                else  % j < i
                    cohort.addGroup(group, j+1)
                    cohort.removeGroup(i)
                end
            end
        end
        function selected = removeGroups(cohort, selected)

            for i = length(selected):-1:1
                cohort.removeGroup(selected(i))
            end
            selected = [];
        end
        function selected = moveupGroups(cohort, selected)

            if ~isempty(selected)

                first_index_to_process = 1;
                unprocessable_length = 1;
                while first_index_to_process <= cohort.groupnumber() ...
                        && first_index_to_process <= numel(selected) ...
                        && selected(first_index_to_process) == unprocessable_length
                    first_index_to_process = first_index_to_process + 1;
                    unprocessable_length = unprocessable_length + 1;
                end

                for i = first_index_to_process:1:numel(selected)
                    cohort.invertGroups(selected(i), selected(i)-1);
                    selected(i) = selected(i) - 1;
                end
            end
        end
        function selected = movedownGroups(cohort, selected)

            if ~isempty(selected)

                last_index_to_process = numel(selected);
                unprocessable_length = cohort.groupnumber();
                while last_index_to_process > 0 ...
                        && selected(last_index_to_process) == unprocessable_length
                    last_index_to_process = last_index_to_process - 1;
                    unprocessable_length = unprocessable_length - 1;
                end

                for i = last_index_to_process:-1:1
                    cohort.invertGroups(selected(i), selected(i) + 1);
                    selected(i) = selected(i) + 1;
                end
            end
        end
        function selected = move2topGroups(cohort, selected)

            if ~isempty(selected)
                for i = 1:1:numel(selected)
                    cohort.movetoGroup(selected(i), i);
                end
                selected = reshape(1:1:numel(selected), size(selected));
            end
        end
        function selected = move2bottomGroups(cohort, selected)

            if ~isempty(selected)
                for i = numel(selected):-1:1
                    cohort.movetoGroup(selected(i), cohort.groupnumber() - (numel(selected)-i));
                end
                selected = reshape(cohort.groupnumber() - numel(selected)+1:1:cohort.groupnumber(), size(selected));
            end
        end
        function [subject_indices, subjects] = getGroupSubjects(cohort, i)
            
            subjects = cohort.getGroup(i).getSubjects();
            
            subject_indices = zeros(1, length(subjects));
            for j = 1:1:length(subjects)
                subject = subjects{j};
                subject_index = cohort.getSubjectIndex(subject);
                subject_indices(j) = subject_index;
            end
        end
        function addSubjectToGroup(cohort, subject, group)

            if cohort.contains_subject(subject) && cohort.contains_group(group)
                
                if ~isa(subject, cohort.getSubjectClass())
                    subject_index = subject;
                    subject = cohort.getSubject(subject_index);
                end
                
                if ~isa(group, 'Group')
                    group_index = group;
                    group = cohort.getGroup(group_index);
                end
                
                group.addSubject(subject);
            end
        end
        function removeSubjectFromGroup(cohort, subject, group)
            if cohort.contains_subject(subject) && cohort.contains_group(group)
                
                if ~isa(subject, cohort.getSubjectClass())
                    subject_index = subject;
                    subject = cohort.getSubject(subject_index);
                end
                
                if ~isa(group, 'Group')
                    group_index = group;
                    group = cohort.getGroup(group_index);
                end
                
                group.removeSubject(subject);
            end
        end
    end
    methods (Access=protected)
        function cohort_copy = copyElement(cohort)
            
            % Make a shallow copy
            cohort_copy = copyElement@matlab.mixin.Copyable(cohort);
            
            % Make a deep copy of atlases
            cohort_copy.atlases = cellfun(@(atlas) {atlas.copy()}, cohort.atlases);
            
            % Make a deep copy of subject_dict
            cohort_copy.subject_dict = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            subjects = values(cohort.subject_dict);
            for i = 1:1:length(subjects)
                subject = subjects{i};
                subject_copy = subject.copy();
                subject_copy.setBrainAtlases(cohort_copy.getBrainAtlases());
                cohort_copy.subject_dict(i) = subject_copy;
            end
        end
    end
end
