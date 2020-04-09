classdef Cohort < handle & matlab.mixin.Copyable
    % Cohort < handle & matlab.mixin.Copyable: A cohort
    % Cohort represents a collection of subjects and groups. 
    %
    % Cohort properties (GetAccess=protected, SetAccess=protected):
    %   name                    - name of the brain atlas.
    %   subject_class           - general class of subjects.
    %   atlases                 - cell array with brain atlases
    %   subject_idict           - indexed dictionary with subjects
    %   group_idict             - indexed dictionary with groups.
    %
    % Cohort methods (Access=protected)
    %   copyElement             - deep copy cohort  communite structure.
    %
    % Cohort methods:
    %   Cohort                  - Constructor.
    %   tostring                - returns a string representing the Cohort.
    %   disp                    - displays the Cohort.
    %   getName                 - returns the name of the Cohort.
    %   getSubjectClass         - returns the general class of subjects.
    %   getBrainAtlases         - returns an array with brain atlases.
    %   getSubjects             - returns the idexed dictionary with Subjects.
    %   getGroups               - returns the indexed dictionary with Groups.
    %   getNewSubject           - returns a new Subject.
    %   getGroupSubjects        - returns the Subjects of specified group.
    %   addSubjectToGroup       - adds a subject to a specified group.
    %   addSubjectsToGroup      - adds subjects to a specified group.
    %   removeSubjectFromGroup  - removes a subject from a specified group.
    %   removeSubjectsFromGroup - removes subjects from a specified group.
    %
    % Additionally, it is possible to use the following IndexDictionary
    % methods through getSubjects():
    %   getSubjects()                   - returns the indexed dictionary br_idict with BrainRegions.
    %   getSubjects().tostring          - returns a string representing the indexed dictionary br_idict.
    %   getSubjects().disp              - displays the indexed dictionary br_idict.
    %   getSubjects().length            - returns the length of the indexed dictionary br_idict.
    %   getSubjects().getValueClass     - returns the value_class of the indexed dictionary br_idict.
    %   getSubjects().contains          - bool, checks if the indexed dictionary br_idict contains the index, key or object
    %   getSubjects().containsIndex     - bool, checks if the indexed dictionary br_idict contains the index.
    %   getSubjects().containsKey       - bool, checks if the indexed dictionary br_idict contains the key.
    %   getSubjects().containsValue     - bool, checks if the indexed dictionary br_idict contains the value.
    %   getSubjects().getIndex          - returns the index of the key or value.
    %   getSubjects().getIndexFromValue - returns the index of the value.
    %   getSubjects().getIndexFromKey   - returns the index of the key.
    %   getSubjects().getIndexFromValueAll - returns all the indexes of the same value.
    %   getSubjects().getValue          - returns the value of the index or the key.
    %   getSubjects().getValueFromIndex - returns the value of the index.
    %   getSubjects().getValueFromKey   - returns the value of the key.
    %   getSubjects().getValues         - returns all the values.
    %   getSubjects().getKey            - returns the key of the index or value.
    %   getSubjects().getKeyFromIndex   - returns the key of the index.
    %   getSubjects().getKeyFromValue   - returns the key of the value.
    %   getSubjects().getKeyFromValueAll - returns all the keys of the same value.
    %   getSubjects().getKeys           - returns all the keys.
    %   getSubjects().add               - adds a key and value to the indexed dictionary br_idict.
    %   getSubjects().remove            - removes the key and value from the indexed dictionary br_idict.
    %   getSubjects().replace           - replaces a key and value in the indexed dictionary br_idict.
    %   getSubjects().replaceKey        - replaces a key in the indexed dictionary br_idict.
    %   getSubjects().replaceValue      - replaces a value in the indexed dictionary br_idict.
    %   getSubjects().replaceValueAll   - replaces all values of same value in the indexed dictionary br_idict.
    %   getSubjects().invert            - inverts position of elements in the indexed dictionary br_idict.
    %   getSubjects().move_to           - move an element to a position in the indexed dictionary br_idict.
    %   getSubjects().remove_all        - removes all selected elements from the indexed dictionary br_idict.
    %   getSubjects().move_up           - moves an element up in the indexed dictionary br_idict
    %   getSubjects().move_down         - moves an element down in the indexed dictionary br_idict
    %   getSubjects().move_to_top       - moves an element to the top in the indexed dictionary br_idict
    %   getSubjects().move_to_bottom    - moves an element to the bottom in the indexed dictionary br_idict
    %
    % Additionally, it is possible to use the following IndexDictionary
    % methods through getGroups():
    %   getGroups()                   - returns the indexed dictionary br_idict with BrainRegions.
    %   getGroups().tostring          - returns a string representing the indexed dictionary br_idict.
    %   getGroups().disp              - displays the indexed dictionary br_idict.
    %   getGroups().length            - returns the length of the indexed dictionary br_idict.
    %   getGroups().getValueClass     - returns the value_class of the indexed dictionary br_idict.
    %   getGroups().contains          - bool, checks if the indexed dictionary br_idict contains the index, key or object
    %   getGroups().containsIndex     - bool, checks if the indexed dictionary br_idict contains the index.
    %   getGroups().containsKey       - bool, checks if the indexed dictionary br_idict contains the key.
    %   getGroups().containsValue     - bool, checks if the indexed dictionary br_idict contains the value.
    %   getGroups().getIndex          - returns the index of the key or value.
    %   getGroups().getIndexFromValue - returns the index of the value.
    %   getGroups().getIndexFromKey   - returns the index of the key.
    %   getGroups().getIndexFromValueAll - returns all the indexes of the same value.
    %   getGroups().getValue          - returns the value of the index or the key.
    %   getGroups().getValueFromIndex - returns the value of the index.
    %   getGroups().getValueFromKey   - returns the value of the key.
    %   getGroups().getValues         - returns all the values.
    %   getGroups().getKey            - returns the key of the index or value.
    %   getGroups().getKeyFromIndex   - returns the key of the index.
    %   getGroups().getKeyFromValue   - returns the key of the value.
    %   getGroups().getKeyFromValueAll - returns all the keys of the same value.
    %   getGroups().getKeys           - returns all the keys.
    %   getGroups().add               - adds a key and value to the indexed dictionary br_idict.
    %   getGroups().remove            - removes the key and value from the indexed dictionary br_idict.
    %   getGroups().replace           - replaces a key and value in the indexed dictionary br_idict.
    %   getGroups().replaceKey        - replaces a key in the indexed dictionary br_idict.
    %   getGroups().replaceValue      - replaces a value in the indexed dictionary br_idict.
    %   getGroups().replaceValueAll   - replaces all values of same value in the indexed dictionary br_idict.
    %   getGroups().invert            - inverts position of elements in the indexed dictionary br_idict.
    %   getGroups().move_to           - move an element to a position in the indexed dictionary br_idict.
    %   getGroups().remove_all        - removes all selected elements from the indexed dictionary br_idict.
    %   getGroups().move_up           - moves an element up in the indexed dictionary br_idict
    %   getGroups().move_down         - moves an element down in the indexed dictionary br_idict
    %   getGroups().move_to_top       - moves an element to the top in the indexed dictionary br_idict
    %   getGroups().move_to_bottom    - moves an element to the bottom in the indexed dictionary br_idict
    %   
    % See also Group, Subjects, IndexedDictioanry.
    properties (GetAccess=protected, SetAccess=protected)
        name  % brain atlas name
        subject_class  % class of the subjects
        atlases  % cell array with brain atlases
        subject_idict  % indexed dictionary with subjects
        group_idict  % indexed dictionary with groups
    end
    methods
        function cohort = Cohort(name, subject_class, atlases, subjects)
            % COHORT(NAME, SUBJECT_CLASS, ATLASES, SUBJECTS) creates a cohort. 
            % The constructor will initialize the properties with the
            % corresponding arguments, with exception of group dictionary. 
            % 
            % See also Group, Subject, BrainAtlases, IndexedDictionary.
            
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
            
            cohort.subject_idict = IndexedDictionary(subject_class);
            for i = 1:1:length(subjects)
                cohort.subject_idict.add(tostring(subjects{i}.getID()), subjects{i}, i);
            end
            
            cohort.group_idict = IndexedDictionary('Group');
        end
        function str = tostring(cohort)
            % TOSTRING string with information about the cohort
            %
            % STR = TOSTRING(COHORT) returns string with the cohort subject
            % class, subjects indexed dictionary length and groups indexed
            % dictionary length
            %
            % See also disp().
            
            str = ['Cohort with ' int2str(cohort.getSubjects().length()) ' ' cohort.getSubjectClass() ' in ' int2str(cohort.getGroups().length()) ' group(s)'];
        end
        function disp(cohort)
            % DISP displays information about the cohort
            %
            % DISP(COHORT) displays information about the cohort.
            % It provides information about cohort class, indexed
            % dictionaries length and subject class.
            % codes.
            %
            % See also tostring().
            
            disp(['<a href="matlab:help ' class(cohort) '">' class(cohort) '</a>'])
            disp([' size: ' int2str(cohort.getSubjects().length()) ' <a href="matlab:help ' cohort.getSubjectClass() '">' cohort.getSubjectClass() '</a>'])
            disp([' group(s): ' int2str(cohort.getGroups().length())])
        end
        function name = getName(cohort)
            % GETNAME returns the name of the cohort.
            %
            % NAME = GETNAME(COHORT) returns the name of the cohort.
            %
            % See also brainregionnumber().
            
            name = cohort.name;
        end
        function subject_class = getSubjectClass(cohort)
            % GETSUBJECTCLASS returns the class of subjects in the cohort.
            %
            % NAME = GETSUBJECTCLASS(COHORT) returns the class of subjects
            % in the cohort.
            %
            % See also getName(), getBrainAtlases().
            
            subject_class = cohort.subject_class;
        end
        function atlases = getBrainAtlases(cohort)
            % GETBRAINATLASES returns the brain atlases.
            %
            % ATLASES = GETBRAINATLASES(COHORT) returns the brain atlases
            % from the cohort.
            %
            % See also getName(), getSubjectClass().
            
            atlases = cohort.atlases;
        end
        function subject_idict = getSubjects(cohort)
            % GETSUBJECTS returns the indexed dictionary with subjects
            % 
            % SUBJECT_IDICT = GETSUBJECTS(COHORT) returns the indexed
            % dictionary SUBJECT_IDICT. This function exposes to the user 
            % the methods and functions of the INDEXEDDICTIONARY class.
            %
            % See also IndexedDictionary, getName(), getGroups().
            
            subject_idict = cohort.subject_idict;
        end
        function group_idict = getGroups(cohort)
            % GETGROUPS returns the indexed dictionary with groups
            % 
            % GROUP_IDICT = GETGROUPS(COHORT) returns the indexed
            % dictionary GROUP_IDICT. This function exposes to the user 
            % the methods and functions of the INDEXEDDICTIONARY class.
            %
            % See also IndexedDictionary, getName(), getSubjects().
            
            group_idict = cohort.group_idict;
        end
        function subject = getNewSubject(cohort, varargin)
            % GETSUBJECT returns a subject 
            %
            % SUBJECT = GETNEWSUBJECT(COHORT, VARARGIN) returns an instance
            % of the class of the subject SUBJECT_CLASS with arguments
            % ATLASES, VARARGIN. It initializes the new instance of the
            % subject class.
            %
            % See also getSubjects(), Subject.
            
            subject = Subject.getSubject(cohort.getSubjectClass(), cohort.getBrainAtlases(), varargin{:});
        end
        function [subject_indexes, subjects] = getGroupSubjects(cohort, i)
            % GETGROUPSUBJECTS returns subjects from a specified group
            %
            % [SUBJECT_INDEXES, SUBJECTS] = GETGROUPSUBJECTS(COHORT, INDEX) 
            % returns subjects from a specificed group INDEX.
            %
            % See also addSubjectToGroup(), removeSubjectFromGroup()
            
            subjects = cohort.getGroups().getValue(i).getSubjects();
            subject_indexes = zeros(1, length(subjects));
            for j = 1:1:length(subjects)
                subject = subjects{j};
                subject_index = cohort.getSubjects().getIndexFromValue(subject); % returns first ocurrance
                subject_indexes(j) = subject_index;
            end
            
        end
        function addSubjectToGroup(cohort, subject, group)
            % ADDSUBJECTTOGROUP inserts a subject to a specified group.
            %
            % ADDSUBJECTTOGROUP(COHORT, SUBJECT, GROUP) inserts a SUBJECT
            % to a specified GROUP.
            %
            % See also getGroupSubjects(), removeSubjectFromGroup()
            
            if cohort.getSubjects().contains(subject) && cohort.getGroups().contains(group)
                if ~isa(subject, cohort.getSubjectClass())
                    subject = cohort.getSubjects().getValue(subject);
                end
                if ~isa(group, 'Group')
                    cohort.getGroups().getValue(group).addSubject(subject);  % adding subject to the first ocurrance of type group
                else
                    index = cohort.getGroups().getIndex(group);
                    cohort.getGroups().getValue(index).addSubject(subject);
                end
            end
        end
        function addSubjectsToGroup(cohort, subject_indexes, group)
            % ADDSUBJECTSTOGROUP inserts subjects to a specified group.
            %
            % ADDSUBJECTSTOGROUP(COHORT, SUBJECT_INDEXES, GROUP) inserts 
            % subjects with SUBJECT_INDEX to a specified GROUP.
            %
            % See also getGroupSubjects(), addSubjectToGroup()
            
            for i = 1:1:length(subject_indexes)
                cohort.addSubjectToGroup(subject_indexes(i), group);
            end
        end
        function removeSubjectFromGroup(cohort, subject, group)
            % REMOVESUBJECTFROMGROUP remvoes a subject from a specified group.
            %
            % REMOVESUBJECTFROMGROUP(COHORT, SUBJECT, GROUP) removes a 
            % SUBJECT to a specified GROUP.
            %
            % See also getGroupSubjects(), addSubjectToGroup()
            
            if cohort.getSubjects().contains(subject) && cohort.getGroups().contains(group)
                if ~isa(subject, cohort.getSubjectClass())
                    subject = cohort.getSubjects().getValue(subject);
                end
                if ~isa(group, 'Group')
                    cohort.getGroups().getValue(group).removeSubject(subject);
                else
                    index = cohort.getGroups().getIndex(group);
                    cohort.getGroups().getValue(index).removeSubject(subject);
                end
            end
            
        end
        function removeSubjectsFromGroup(cohort, subject_indexes, group)
            % REMOVESUBJECTSFROMGROUP remvoes subjects from a specified group.
            %
            % REMOVESUBJECTSFROMGROUP(COHORT, SUBJECT_INDEXES, GROUP) 
            % removes subejcts with SUBJECT_INDEXES from a specified GROUP.
            %
            % See also getGroupSubjects(), addSubjectsToGroup()
            
            for i = 1:1:length(subject_indexes)
                cohort.removeSubjectFromGroup(subject_indexes(i), group);
            end
        end
    end
    methods (Access=protected)
        function cohort_copy = copyElement(cohort)
            % COPYELEMENT(COHORT) copies elements of cohort.
            %
            % COHORT_COPY = COPYELEMENT(COHORT) copies elements of the
            % cohort COHORT. Makes a deep copy of the structure
            % subject_idict and group_idict. Makes a shallow copy of
            % atlases.
            %
            % See also Group, Graph, Subject, IndexedDictionary.
            
            % Make a shallow copy
            cohort_copy = copyElement@matlab.mixin.Copyable(cohort);
            
            % Make a deep copy of atlases
            cohort_copy.atlases = cellfun(@(atlas) {atlas.copy()}, cohort.atlases);
            
            % Make a deep copy of subject_idict
            cohort_copy.subject_idict = IndexedDictionary(cohort_copy.subject_class);
            for i = 1:1:cohort.getSubjects().length()
                sub = cohort.getSubjects().getValue(i);
                sub_copy = sub.copy();
                sub_copy.setBrainAtlases(cohort_copy.getBrainAtlases());
                cohort_copy.subject_idict.add(tostring(sub_copy.getID()), sub_copy, i);                
            end
            
            % Make a deep copy of group_idict
            cohort_copy.group_idict = IndexedDictionary('Group');
            for j = 1:1:cohort.getGroups().length()  
                group_copy = Group(cohort.getSubjectClass(), []);
                cohort_copy.group_idict.add(group_copy.getName(), group_copy, j);
                cohort_copy.addSubjectsToGroup(cohort.getGroupSubjects(j), j);
            end           
        end
    end
end
