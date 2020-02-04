classdef Graph < handle & matlab.mixin.Copyable
    properties (GetAccess=public, SetAccess=protected)
        A   % adjacency matrix
    end
    methods (Access=protected)
        function g = Graph(A, varargin)
            g.A = A;
        end
    end
    methods (Static, Abstract)
        is_weighted()  % whether is weighted graph
        is_binary()  % whether is binary graph
        is_directed()  % whether is directed graph
        is_undirected()  % whether is undirected graph
        is_selfconnected()  % whether is self-connected
        is_nonnegative()  % whether is non-negative graph
    end
end