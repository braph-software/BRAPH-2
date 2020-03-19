%comparasionMRI
classdef ComparisionMRI < Measurement
    methods
        function m =  ComparisionMRI(atlas, group, varargin)
            if isa(atlas, 'BrainAtlas')
                atlases = {atlas};
            else
                assert(iscell(atlas) && length(atlas)==1, ...
                    ['BRAIN:MeasurmentMRI:AtlasErr'], ...
                    ['The input must be a BrainAtlas or a cell with one BrainAtlas']) %#ok<NBRAK>
                atlases = atlas;
            end
            %         % grousps
            if isa(atlas, 'Group')
                groups = {group};
            else
                assert(iscell(group) && length(group)==1, ...
                    ['BRAIN:MeasurmentMRI:GroupErr'], ...
                    ['The input must be a Group or a cell with one Group']) %#ok<NBRAK>
                groups = group;
            end
            m = m@Measurement(atlases, groups, varargin{:});
        end
    end
    % data : single datascalar & datastructer use only depending on the
    % measure.
    methods (Access = protected)
        function initialize_datadict(m, varargin)
            
            atlases = m.getBrainAtlases();
            atlas = atlases{1};
            
            m.datadict = containers.Map;
            %             m.datadict('age') = DataScalar(atlas);
            %             m.datadict('DTI') = DataConnectivity(atlas);
        end
        function update_brainatlases(m, atlases)
            
            m.atlases = atlases;
            % this has to be inside a for?
            %for i = 1:1:numel(atlases)
            atlas = atlases{1}; %atlas = atlases{i};
            
%             d1 = m.datadict('age');  % d1 = m.datadict(key);
%             d1.setBrainAtlas(atlas)  % d1.setBrainAtlas(atlas);
%             
%             d2 = m.datadict('DTI');
%             d2.setBrainAtlas(atlas);
            %end
        end
        function update_groups(m, groups)
            m.groups = groups;
            group = groups{1};
        end
    end
    
end