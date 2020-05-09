classdef DummyCopiableObject < handle & matlab.mixin.Copyable
    % DummyCopiableObject Dummy copiable object.
    % Dummy objects used for unit testing and debugging.
    % It implements handle and matlab.mixin.Copyable.
    %
    % DummyCopiableObject properties:
    %   name
    %
    % DummyCopiableObject methods:
    %   DummyObject     - constructor
    %   tostring        - returns a string describing the object
    %
    % See also handle, matlab.mixin.Copyable, DummyObject.
    
    properties
        name
    end
    methods 
        function obj = DummyCopiableObject(name)
            % DummyObject(NAME) creates a dummy object with the property NAME.

            obj.name = name;
        end
        function str = tostring(obj)
            % TOSTRING string with information about the object
            %
            % STR = TOSTRING(IDICT) returns string with the object name.
            
            str = [class(obj) ' ' tostring(obj.name)];
        end
    end
end