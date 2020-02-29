classdef Subject < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        id  % subject id
        groups  % cell array with the groups of the subjects
        datadict  % dictionary with subject data
    end
    methods (Access=protected)
        function sub = Subject(varargin)
            
            id = get_from_varargin(now(), 'SubjectID', varargin{:});
            sub.setID(id)
            
            groups = get_from_varargin({}, 'SubjectGroups', varargin{:});
            sub.setGroups(groups)
            
            sub.datadict = sub.initialize_datadict(varargin{:});
        end
    end
    methods
        function str = tostring(sub)
            str = [Subject.getClass(sub) ' ' int2str(size(sub.getA(), 1)) ' rows x ' int2str(size(sub.getA(), 2)) ' columns'];
        end
        function disp(sub)
            disp(['<a href="matlab:help ' Subject.getClass(sub) '">' Subject.getClass(sub) '</a>' ...
                ' ID:' tostring(sub.getID()) ...
                ' Groups: ' tostring(cellfun(@(group) group, sub.getGroups()))])
            data_codes = sub.getDataCodes();
            for i = 1:1:sub.getDataNumber()
                data_code = data_codes{i};
                d = sub.getData(data_code);
                disp([data_code ' = ' d.tostring()])
            end
        end
        function setID(sub, id)
            sub.id = id;
        end
        function id = getID(sub)
            id = sub.id;
        end
        function setGroups(sub, groups)
            
            assert(all(cellfun(@isnumeric, groups)), ...
                ['BRAPH:Subject:Groups'], ...
                ['Groups must be a numeric cell array']) %#ok<*NBRAK>
            sub.groups = groups;
        end
        function groups = getGroups(sub)
            groups = sub.groups;
        end
        function d = getData(sub, data_code)
            d = sub.datadict(data_code);            
        end
    end
    methods (Abstract, Access=protected)
        initialize_datadict(sub)  % initialized the data_dict
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