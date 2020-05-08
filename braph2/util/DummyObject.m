classdef DummyObject
    % DummyObject Dummy object.
    % Dummy objects used for unit testing and debugging.
    %
    % DummyObject properties:
    %   name
    %
    % DummyObject methods:
    %   DummyObject     - constructor
    
    properties
        name
    end
    methods 
        function obj = DummyObject(name)
            % DummyObject(NAME) creates a dummy object with the property NAME.

            obj.name = name;
        end
    end
end