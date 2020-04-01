classdef IndexedDictionary < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        value_class  % class of the value objects
        dict  % dict of (index, {key, value})
    end
    methods
        function idict = IndexedDictionary(value_class, keys, values)
            %
        end
        % management functions
    end
    % Indexed dictionary with index (positive integer, sequesntial, 1, 2,
    % 3, 4, ...), key (string) and value (object of the class value_class)
end