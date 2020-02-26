classdef Subject < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        id  % subject id
        datadict  % dictionary with subject data
    end
    methods (Access=protected)
        function sub = Subject()
            
            sub.initialize_datadict();
        end
    end
    methods (Abstract, Access=protected)
        initialize_datadict(m)  % initialized the data_dict
    end
    methods (Static)
        function subject_list = getList()
            subject_list = subclasses( ...
                'Subject', ...
                [fileparts(which('Subject')) filesep 'subjects'] ...
                );
        end
        function subject_class = getClass(sub)
            % subject class (same as the subject object name)
            
            if isa(sub, 'Subject')
                subject_class = class(sub);
            else % g should be a string with the subject class
                subject_class = sub;
            end
        end
        function name = getName(sub)
            % subject name
            
            name = eval([Subject.getClass(sub) '.getName()']);
        end
        function description = getDescription(sub)
            % subject description
            
            description = eval([Subject.getClass(sub) '.getDescription()']);
        end
        function sub = getDataList(sub)
            % list of subject data keys
            
            name = eval([Subject.getClass(sub) '.getDataList()']);            
        end
        function sub = getSubject(subject_class, varargin)
            sub = eval([subject_class '(varargin{:})']);
        end
    end
    
end