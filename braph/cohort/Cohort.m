classdef Cohort < handle & matlab.mixin.Copyable
	properties (GetAccess=protected, SetAccess=protected) 
        name  % brain atlas name
        subject_class  % class of the subjects
        atlases  % cell array with brain atlases
        subdict  % dictionary with subjects
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

            cohort.subdict = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            for i = 1:1:length(subjects)
                cohort.addSubject(subjects{i}, i);
            end
        end
        function str = tostring(cohort)
            str = ['Cohort with ' int2str(cohort.subjectnumber()) ' ' cohort.getSubjectClass()];
        end
        function disp(cohort)
            disp(['<a href="matlab:help ' class(cohort) '">' class(cohort) '</a>'])
            disp([' size: ' int2str(cohort.subjectnumber()) ' <a href="matlab:help ' cohort.getSubjectClass() '">' cohort.getSubjectClass() '</a>'])
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
            n = length(cohort.subdict);
        end
        function bool = contains_subject(cohort, subject_index)
            bool = isKey(cohort.subdict, subject_index);
        end
        function subject = getSubject(cohort, subject_index)
            subject = cohort.subdict(subject_index);
        end
        function subjects = getSubjects(cohort)
            subjects = values(cohort.subdict);
        end
        function subject_ids = getSubjectIDs(cohort)
            subject_ids = cell(1, cohort.subjectnumber());
            for i = 1:1:cohort.subjectnumber()
                subject = cohort.getSubject(i);
                subject_ids{i} = subject.getID();
            end
        end
        function subject_groups = getSubjectGroups(cohort)
            subject_groups = cell(1, cohort.subjectnumber());
            for i = 1:1:cohort.subjectnumber()
                sub = cohort.getSubject(i);
                subject_groups{i} = sub.getGroups();
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
                    cohort.subdict(j+1) = cohort.subdict(j);
                end
            end
	    cohort.subdict(i) = subject;
        end
        function removeSubject(cohort, i)
            
            for j = i:1:cohort.subjectnumber()-1
                cohort.subdict(j) = cohort.subdict(j+1);
            end
            remove(cohort.subdict, cohort.subjectnumber());
        end
        function replaceSubject(cohort, i, subject)

            assert(isa(subject, cohort.getSubjectClass()), ...
                ['BRAPH:Cohort:SubjectClassErr'], ...
                ['All Subject classes should be ' cohort.getSubjectClass() ', but one is ' subject.getClass()]) %#ok<NBRAK>

            if i > 0 || i <= cohort.subjectnumber()
                cohort.subdict(i) = subject;
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
    end
    methods (Access=protected)
        function cohort_copy = copyElement(cohort)
            
            % Make a shallow copy
            cohort_copy = copyElement@matlab.mixin.Copyable(cohort);

            % Make a deep copy of atlases
            cohort_copy.atlases = cellfun(@(atlas) {atlas.copy()}, cohort.atlases);
            
            % Make a deep copy of subdict
            cohort_copy.subdict = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            subjects = values(cohort.subdict);
            for i = 1:1:length(subjects)
                subject = subjects{i};
                subject_copy = subject.copy();
                subject_copy.setBrainAtlases(cohort_copy.getBrainAtlases());
                cohort_copy.subdict(i) = subject_copy;
            end
        end
    end
end
