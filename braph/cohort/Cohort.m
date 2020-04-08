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
            
            cohort.subject_dict = IndexedDictionary(subject_class);
            for i = 1:1:length(subjects)
                cohort.subject_dict.add(num2str(subjects{i}.getID()), subjects{i}, i);
            end
            
            cohort.group_dict = IndexedDictionary('Group');
        end
        function str = tostring(cohort)
            str = ['Cohort with ' int2str(cohort.getSubjects().length()) ' ' cohort.getSubjectClass() ' in ' int2str(cohort.getGroup().length()) ' group(s)'];
        end
        function disp(cohort)
            disp(['<a href="matlab:help ' class(cohort) '">' class(cohort) '</a>'])
            disp([' size: ' int2str(cohort.getSubjects().length()) ' <a href="matlab:help ' cohort.getSubjectClass() '">' cohort.getSubjectClass() '</a>'])
            disp([' group(s): ' int2str(cohort.getGroup().length())])
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
        function subject_idict = getSubjects(cohort)
            subject_idict = cohort.subject_dict;
        end
        function group_idict = getGroup(cohort)
            group_idict = cohort.group_dict;
        end
        function [subject_indices, subjects] = getGroupSubjects(cohort, i)
            
            subjects = cohort.getGroup().getValue(i).getSubjects();
            subject_indices = zeros(1, length(subjects));
            for j = 1:1:length(subjects)
                subject = subjects{j};
                subject_index = cohort.getSubjects().getIndexFromValue(subject); % returns first ocurrance
                subject_indices(j) = subject_index;
            end
            
        end
        function addSubjectToGroup(cohort, subject, group)
            if cohort.getSubjects().contains(subject) && cohort.getGroup().contains(group)
                if ~isa(subject, cohort.getSubjectClass())                   
                    subject = cohort.getSubjects().getValue(subject);
                end
                if ~isa(group, 'Group')                
                    group = cohort.getGroup().getValue(group);
                end
                
                cohort.getGroup().getValue(group).addSubject(subject);  % adding subject to the first ocurrance of type group
            end
        end
        function addSubjectsToGroup(cohort, subject_indices, group)            
            for i = 1:1:length(subject_indices)
                cohort.addSubjectToGroup(subject_indices(i), group);
            end
        end
        function removeSubjectFromGroup(cohort, subject, group)
            if cohort.getSubjects().contains(subject) && cohort.getGroup().contains(group)
                if ~isa(subject, cohort.getSubjectClass())
                    subject = cohort.getSubjects().getValue(subject);
                end
                if ~isa(group, 'Group')
                    group = cohort.getGroup().getValue(group);
                end
            end
            cohort.getGroup().getValue(group).removeSubject(subject);
        end
        function removeSubjectsFromGroup(cohort, subject_indices, group)            
            for i = 1:1:length(subject_indices)
                cohort.removeSubjectFromGroup(subject_indices(i), group);
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
            cohort_copy.subject_dict = IndexedDictionary(cohort_copy.subject_class);
            for i = 1:1:cohort.getSubjects().length()
                 cohort_copy.subject_dict.add(cohort.getSubjects().getKey(i), cohort.getSubjects().getValue(i).copy(), i);
            end
            
            % Make a deep copy of group_dict
            cohort_copy.group_dict = IndexedDictionary('Group'); 
            for j = 1:1:cohort.getGroup().length()
                cohort_copy.group_dict.add(cohort.getGroup().getKey(j), cohort.getGroup().getValue(j).copy(), j);
            end
        end
    end
end
