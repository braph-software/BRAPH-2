classdef Analysis < handle & matlab.mixin.Copyable
    properties
        name  % brain atlas name
        cohort  % cohort
    end
    methods (Access=protected)
        function analysis = Analysis(cohort, varargin)
        end
    end
    methods
    end
    methods (Static)
    end    
end