classdef RandomComparison 
    properties (GetAccess = protected, SetAccess = protected)
    end
    methods (Access = protected)
        function m =  RandomComparison(atlas, group, varargin)
            % Should be an abstract class implemented by RandomComparison
            % subclasses
        end
    end 
end