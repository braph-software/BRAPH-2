classdef IndexedDictionary < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        value_class  % class of the value objects
        dict  % dict of (index, {key, value})
    end
    methods (Access=private)
        % TODO: don't use these private functions
        function pairment = getPairment(idict, index)
            pairment = idict.dict(index);
        end
        function pairments = getPairments(idict)
            pairments = values(idict.dict);
        end
    end
    methods
        function idict = IndexedDictionary(value_class, keys, values)
            
            idict.value_class = value_class;
            
            idict.dict = containers.Map('KeyType', 'double', 'ValueType', 'any');
            
            assert(isequal(length(values), length(keys)), ...
                ['BRAPH:IndexDictionary:Constructor'], ...
                ['Size of arguments is not the same.']) %#ok<NBRAK>
            
            for i = 1:1:length(values)
                
                key = keys{i};
                assert(ischar(key), ...
                    ['BRAPH:IndexDictionary:Constructor'], ...
                    ['Key is not a string.']) %#ok<NBRAK>
                
                value = values{i};
                assert(isequal(class(value), value_class), ...
                    ['BRAPH:IndexDictionary:Constructor'], ...
                    ['Values is not an object of class ' value_class]) %#ok<NBRAK>
                
                idict.add(key, value, i);
            end
        end
        function str = tostring(idict)
            str = ['IndexDictionary of class ' idict.getValueClass() ' with ' int2str(idict.length()) ' entries.'];
        end
        function disp(idict)
            disp(['<a href="matlab:help ' class(idict) '">' class(idict) '</a>'])
            disp([' class: ' idict.getValueClass()])
            disp([' size: ' int2str(idict.length())])
% TODO: add a list of all elements - for cycle
        end
        function n = length(idict)
            n = length(idict.dict);
        end
        function value_class = getValueClass(idict)
            value_class = idict.value_class;
        end
        function bool = contains(idict, pointer)
            
            if isa(pointer, 'double')  % pointer is index
                bool = idict.containsIndex(pointer);
            elseif isa(pointer, 'char')  % pointer is key
                bool = idict.containsKey(pointer);
            elseif isa(pointer, idict.getValueClass()) % pointer is value - not necessarily unique
                bool = idict.containsValue(pointer);
            else
                bool = false
            end
        end
        function bool = containsIndex(idict, index)
            
            bool = false;
            if index > 0 && index <= idict.length()
                bool = true;
            end
        end
        function bool = containsValue(idict, value)
            bool = false;
            for i = 1:1:idict.length()
% if isequal(idict.getValue(i), value)
pair = idict.getPairment(i);
if isequal(pair{2}, value)  % compares exact object
                    bool = true;
                    break;
                end
            end
        end
        function bool = containsKey(idict, key)
            bool = false;
            for i = 1:1:idict.length()
% if isequal(idict.getKey(i), key)
pair = idict.getPairment(i);
if isequal( pair{1}, key)  % compares exact object
                    bool = true;
                    break;
                end
            end
        end
% function index = getIndex(idict, pointer)  % pointer = key, value
    function index = getIndexFromValue(idict, value)
        for i = 1:1:idict.length()
            pair = idict.getPairment(i);
            if isequal(pair{2}, value)
                index = i;
                break;
            end
        end
    end
    function index = getIndexFromKey(idict, key)
        for i = 1:1:idict.length()
            pair = idict.getPairment(i);
            if isequal(pair{1}, key)
                index = i;
                break;
            end
        end
    end
% function value = getValue(idict, pointer)  % pointer = key, index
function value = getValue(idict, index)
        pair = idict.getPairment(index);
        value = pair{2};
end
% getValueFromIndex        
        function value = getValueFromKey(idict, key)
            index = idict.getKeyIndex(key);
            value  = idict.getValue(index);
        end
% function key = getKey(idict, pointer)  % pointer = index, value
function key = getKey(idict, index)
    pair = idict.getPairment(index);
    key = pair{1};
end
% getKeyFromIndex
        function key = getKeyFromValue(idict, value)
            index = idict.getValueIndex(value);
            key = idict.getKey(index);
        end
        function add(idict, key, value, index)
            if nargin < 4 || index < 0 || index > idict.length()
                index = idict.length() + 1;
            end
            
            assert(ischar(key), ...
                ['BRAPH:IndexDictionary:Add'], ...
                ['Key is not a string.']) %#ok<NBRAK>
            assert(isequal(value.getClass(), idict.getValueClass()), ...
                ['BRAPH:IndexDictionary:Add'], ...
                ['Values is not an object of class ' idict.getValueClass() ]) %#ok<NBRAK>
            
            if index <= idict.length()
                for j = idict.length():-1:index
                    idict.dict(j+1) = idict.dict(j);
                end
            end
            idict.dict(index) = {key, value};  % adds at the end
        end
        function remove(idict, pointer)
            
% reorder index, key, value
            if isa(pointer, 'char')  % pointer is key
                index = idict.getKeyIndex(pointer);
            elseif  isa(pointer, 'double')  % pointer is index
                index = pointer;
            elseif isa(pointer.getClass(), idict.getValueClass())  % pointer is value
                index = idict.getValueIndex(pointer);
            end
            
            for j = index:1:idict.length()-1
                idict.dict(j) = idict.dict(j+1);
            end
            remove(idict.dict, idict.length());
        end
        function replace(idict, key_new, value_new, index)
            if idict.contains(index)
                idict.dict(index) = {key_new, value_new};
            end
        end
        function replaceKey(idict, key_old, key_new)
            index = idict.getKeyIndex(key_old);
            value = idict.getValue(index);
            idict.replace(key_new, value, index);
        end
        function replaceValue(idict, value_old, value_new)
            index = idict.getValueIndex(value_old);
            key = idict.getKey(index);
            idict.replace(key, value_new, index);
        end
        function invert(idict, i, j)
            if i > 0 && i <= idict.length() && j > 0 && j <= idict.length() && i ~= j
                pair_i = idict.getPairment(i);
                pair_j = idict.getPairment(j);
                idict.replace(pair_j{1}, pair_j{2}, i);
                idict.replace(pair_i{1}, pair_i{2}, j);
            end
        end
        function move_to(idict, i, j)
            if i > 0 && i <= idict.length() && j > 0 && j <= idict.length() && i ~= j
                pair = idict.getPairment(i);
                if i > j
                    idict.remove(i)
                    idict.add(pair{1}, pair{2}, j)
                else  % j < i
                    idict.add(pair{1}, pair{2}, j+1)
                    idict.remove(i)
                end
            end
        end
        function selected = remove_all(idict, selected)
            for i = length(selected):-1:1
                idict.remove(selected(i))
            end
            selected = [];
        end
        function selected =  move_up(idict, selected)
            if ~isempty(selected)
                first_index_to_process = 1;
                unprocessable_length = 1;
                while first_index_to_process <= idict.length() ...
                        && first_index_to_process <= numel(selected) ...
                        && selected(first_index_to_process) == unprocessable_length
                    first_index_to_process = first_index_to_process + 1;
                    unprocessable_length = unprocessable_length + 1;
                end
                
                for i = first_index_to_process:1:numel(selected)
                    idict.invert(selected(i), selected(i)-1);
                    selected(i) = selected(i) - 1;
                end
            end
        end
        function selected = move_down(idict, selected)
            if ~isempty(selected)
                last_index_to_process = numel(selected);
                unprocessable_length = idict.length();
                while last_index_to_process > 0 ...
                        && selected(last_index_to_process) == unprocessable_length
                    last_index_to_process = last_index_to_process - 1;
                    unprocessable_length = unprocessable_length - 1;
                end
                
                for i = last_index_to_process:-1:1
                    idict.invert(selected(i), selected(i) + 1);
                    selected(i) = selected(i) + 1;
                end
            end
        end
        function selected = move_to_top(idict, selected)
            if ~isempty(selected)
                for i = 1:1:numel(selected)
                    idict.moveTo(selected(i), i);
                end
                selected = reshape(1:1:numel(selected), size(selected));
            end
        end
        function selected = move_to_bottom(idict, selected)
            if ~isempty(selected)
                for i = numel(selected):-1:1
                    idict.moveTo(selected(i), idict.length() - (numel(selected)-i));
                end
                selected = reshape(idict.length() - numel(selected)+1:1:idict.length(), size(selected));
            end
        end
    end
    % Indexed dictionary with index (positive integer, sequesntial, 1, 2,
    % 3, 4, ...), key (string) and value (object of the class value_class)
end