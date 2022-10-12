classdef (ConstructOnLoad) EventResultMemorized < event.EventData
    %EventResultMemorized is the data container for the ResultMemorized event.
    %
    % EventResultMemorized properties:
    %  el       - element
    %  prop     - property whose result has been memorized
    %
    % EventResultMemorized constructor:
    %  EventResultMemorized - constructor
    %
    % See also Element, event, listener.
    
    properties
        el % element
        prop % property whose result has been memorized
    end
    methods
        function event = EventResultMemorized(el, pointer)
            %EVENTRESULTMEMORIZED() creates a data container for the ResultMemorized event.
            %
            % EVENTRESULTMEMORIZED(EL, POINTER) with element EL and the POINTER to the
            %  result property that has been memorized. 
            %  POINTER can be either a TAG or a PROP.
            %
            % See also Element, event.

            event.el = el;
            event.prop = el.getPropProp(pointer);
        end
    end
end