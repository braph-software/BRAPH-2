classdef SubjectMRI < Subject
    methods
        function sub = SubjectMRI(atlas, varargin)

            if isa(atlas, 'BrainAtlas') 
                atlases = {atlas};
            else
                assert(iscell(atlas) && length(atlas)==1, ...
                    ['BRAIN:SubjectMRI:AtlasErr'], ...
                    ['The input must be a BrainAtlas or a cell with one BrainAtlas']) %#ok<NBRAK>
                atlases = atlas;
            end
            
            sub = sub@Subject(atlases, varargin{:});
        end
    end
    methods (Access=protected)
        function initialize_datadict(sub, varargin)
            
            atlases = sub.getBrainAtlases();
            atlas = atlases{1};
            
            sub.datadict = containers.Map;
            sub.datadict('age') = DataScalar(atlas);
            sub.datadict('MRI') = DataStructural(atlas);
        end
        function update_brainatlases(sub, atlases)

            sub.atlases = atlases;
            atlas = atlases{1};

            d1 = sub.datadict('age');
            d1.setBrainAtlas(atlas)
            
            d2 = sub.datadict('MRI');
            d2.setBrainAtlas(atlas);
        end
    end
    methods (Static)
        function subject_class = getClass()
                subject_class = 'SubjectMRI';
        end
        function name = getName()
            name = 'Subject Structural MRI';
        end
        function description = getDescription()
            description = [ ...
                'Subject with structural MRI data, ' ...
                'such as cortical thickness for each brain region' ...
                ];
        end
        function atlas_number = getBrainAtlasNumber()
            atlas_number = 1;
        end
        function datalist = getDataList()
            
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('age') = 'DataScalar';
            datalist('MRI') = 'DataStructural';            
        end
        function data_number = getDataNumber()
            data_number = Subject.getDataNumber('SubjectMRI');
        end
        function data_codes = getDataCodes()
            data_codes = Subject.getDataCodes('SubjectMRI');
        end
        function data_classes = getDataClasses()
            data_classes = Subject.getDataClasses('SubjectMRI');
        end
        function data_class = getDataClass(data_code)
            data_class = Subject.getDataNumber('SubjectMRI', data_code);
        end
    end
end