classdef MeasurementMRI < Measurement
    % single group of mri subjects
    methods
        function m =  MeasurementMRI(atlas, group, varargin)
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
    
end