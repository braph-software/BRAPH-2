classdef GUI
    properties (Access=protected)
        el % element to be visualized
    end
    methods % constructor
        function gui = GUI(el)
            gui.el = el;
        end
    end
end