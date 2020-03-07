classdef Subject < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        id  % subject id
        atlases % cell array with brain atlases
        datadict  % dictionary with subject data
    end
    methods (Access=protected)
        function sub = Subject(atlases, varargin)
            
            assert(iscell(atlases), ...
                ['BRAIN:Subject:AtlasErr'], ...
                ['The input must be a cell containing BrainAtlas objects'])
            sub.atlases = atlases;

            id = get_from_varargin(now(), 'SubjectID', varargin{:});
            sub.setID(id)
            
            sub.initialize_datadict(atlases, varargin{:})
        end
        function sub_copy = copyElement(sub)
            % IMPORTANT! It does NOT make a deep copy of the BrainAtlas
            % atlas in the data objects
            
            % Make a shallow copy
            sub_copy = copyElement@matlab.mixin.Copyable(sub);
            
            % Make a deep copy of datadict
            sub_copy.datadict = containers.Map;
            data_codes = keys(sub.datadict);
            for i = 1:1:length(data_codes)
                code = data_codes{i};
                d = sub.getData(code);
                sub_copy.datadict(code) = d.copy();
            end
        end        
    end
    methods
        function str = tostring(subject)
            str = [Subject.getClass(subject) ' ' tostring(subject.getID())];
        end
        function disp(subject)
            disp(['<a href="matlab:help ' Subject.getClass(subject) '">' Subject.getClass(subject) '</a>' ...
                ' ID:' tostring(subject.getID())])
            data_codes = subject.getDataCodes();
            for i = 1:1:subject.getDataNumber()
                data_code = data_codes{i};
                d = subject.getData(data_code);
                disp([data_code ' = ' d.tostring()])
            end
        end
        function setID(sub, id)
            sub.id = id;
        end
        function id = getID(sub)
            id = sub.id;
        end
        function d = getData(sub, data_code)
            d = sub.datadict(data_code);            
        end
        function setBrainAtlases(sub, atlases)
            sub.update_brainatlases(atlases);
        end
        function atlases = getBrainAtlases(sub)
            atlases = sub.atlases;
        end
    end
    methods (Abstract, Access=protected)
        initialize_datadict(sub, varargin)  % initialized the data_dict
        update_brainatlases(sub, atlases)  % updates brainatlases also in datadict
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
        function atlas_number = getBrainAtlasNumber(sub)
            % number of differetn brain atlases

            atlas_number = eval([Subject.getClass(sub) '.getBrainAtlasNumber()']);
        end
        function datalist = getDataList(sub)
            % list of subject data keys
            
            datalist = eval([Subject.getClass(sub) '.getDataList()']);
        end
        function data_number = getDataNumber(sub)
            datalist = Subject.getDataList(sub);
            data_number = length(datalist);
        end
        function data_codes = getDataCodes(sub)
            datalist = Subject.getDataList(sub);
            data_codes = keys(datalist);
        end
        function data_classes = getDataClasses(sub)
            datalist = Subject.getDataList(sub);
            data_classes = values(datalist);
        end
        function data_class = getDataClass(sub, data_code)
            datalist = Subject.getDataList(sub);
            data_class = datalist(data_code);
        end
        function sub = getSubject(subject_class, varargin)
            sub = eval([subject_class '(varargin{:})']);
        end
    end   
end