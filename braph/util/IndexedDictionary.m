classdef IndexedDictionary < handle & matlab.mixin.Copyable
    % IndexedDictionary < handle & matlab.mixin.Copyable A indexed dictionary
    % IndexedDictionary provides the methods necessary to handle data 
    % in a indexed dictionary.
    %
    % IndexedDictionary properties (GetAccess=protected, SetAccess=protected):
    %   value_class  - class of the elements of the dictionary.
    %   dict         - dictionary of elements of class value_class.
    %
    % IndexedDictionary methods 
    %   IndexedDictionary - constructor.
    %   tostring          - returns a string representing the index dictionary.
    %   disp              - displays the index dictionary.
    %   length            - returns the length of the dictionary.
    %   getValueClass     - returns the value_class.
    %   contains          - bool, checks if the dictionary contains the index, key or object
    %   containsIndex     - bool, checks if the dictionary contains the index.
    %   containsKey       - bool, checks if the dictionary contains the key.
    %   containsValue     - bool, checks if the dictionary contains the value.
    %   getIndex          - returns the index of the key or value.
    %   getIndexFromValue - returns the index of the value.
    %   getIndexFromKey   - returns the index of the key.
    %   getValue          - returns the value of the index or the key.
    %   getValueFromIndex - returns the value of the index.
    %   getValueFromKey   - returns the value of the key.
    %   getKey            - returns the key of the index or value.
    %   getKeyFromIndex   - returns the key of the index.
    %   getKeyFromValue   - returns the key of the value.
    %   add               - adds a key and value to the dictionary.
    %   remove            - removes the key and value from the dictionary.
    %   replace           - replaces a key and value in the dictionary.
    %   replaceKey        - replaces a key in the dictionary.
    %   replaceValue      - replaces a value in the dictionary.
    %   invert            - inverts position of elements in the dictionary.
    %   move_to           - move an element to a position in the ditionary.
    %   remove_all        - removes all selected elements from the dictionary.
    %   move_up           - moves an element up. 
    %   move_down         - moves an element down.
    %   move_to_top       - moves an element to the top.
    %   move_to_bottom    - moves an element to the bottom.
    %
    % See also subclasses, constants.
    
    properties (GetAccess=protected, SetAccess=protected)
        value_class  % class of the value objects
        dict  % dict of (index, {key, value})
    end
    methods
        function idict = IndexedDictionary(value_class, keys, values)
            % IndexedDictionary(VALUE_CLASS) creates an empty indexdictionary
            % storign objects of class VALUE_CLASS. 
            %
            % IndexedDictionary(VALUE_CLASS, KEYS, VALUES)  creates a
            % dictionary and inserts KEYS with corresponding valeus VALUES. 
            % KEYS and VALUES must be cell arrays of strings and objects of
            % class VALUE_CLASS, respectively.
            %
            % See also BrainAtlas, Cohort, GraphAnalysis.
            
            idict.value_class = value_class;
            
            idict.dict = containers.Map('KeyType', 'double', 'ValueType', 'any');
            
            if nargin > 2
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
        end
        function str = tostring(idict)
            % TOSTRING string with information about the index dictionary
            %
            % STR = TOSTRING(IDICT) returns string with the value_class and
            % length of the dictionary.
            %
            % See also disp().
            
            str = ['IndexDictionary of class ' idict.getValueClass() ' with ' int2str(idict.length()) ' entries.'];
        end
        function disp(idict)
            % DISP displays information about the index dictionary
            %
            % DISP(IDICT) displays information about the index dictionary.
            % It provides information about value class, size,
            % value, entries of the dictionary.
            %
            % See also tostring().
            
            disp(['<a href="matlab:help ' class(idict) '">' class(idict) '</a>'])
            disp([' class: ' idict.getValueClass()])
            disp([' size: ' int2str(idict.length())])
            disp([' With entries:' ]) %#ok<NBRAK>
            for i = 1:2:length(idict.dict)
                key_and_value = idict.dict(i);
                disp(['  key:' key_and_value{1} ' ,value:' key_and_value{2}]);
            end
        end
        function n = length(idict)
            % LENGTH returns the number of elements in the index dictionary.
            %
            % N = LENGTH(IDICT) returns the number of elements in the index
            % dictionary.
            %
            % See also getValueClass(), tostring(), disp().
            
            n = length(idict.dict);
        end
        function value_class = getValueClass(idict)
            % GETVALUECLASS returns the value_class.
            %
            % A = GEGETVALUECLASSTA(IDICT) returns the value_class.
            %
            % See also length(), getValue().
            
            value_class = idict.value_class;
        end
        function bool = contains(idict, pointer)
            % CONTAINS checks if an element exists in the dictionary.
            %
            % BOOL = CONTAINS(IDICT, POINTER) returns true if a index, key
            % or object exists in the dictionary DICT.
            %
            % See also containsIndex(), containsKey()
            
            if isa(pointer, 'double')  % pointer is index
                bool = idict.containsIndex(pointer);
            elseif isa(pointer, 'char')  % pointer is key
                bool = idict.containsKey(pointer);
            elseif isa(pointer, idict.getValueClass()) % pointer is value - not necessarily unique
                bool = idict.containsValue(pointer);
            else
                bool = false;
            end
        end
        function bool = containsIndex(idict, index)
            % CONTAINSINDEX checks if an index exists in the dictionary.
            %
            % BOOL = CONTAINS(IDICT, INDEX) returns true if a index exists
            % in the dictionary DICT.
            %
            % See also containsKey(), contains()
            
            if index > 0 && index <= idict.length()
                bool = true;
            else
                bool = false;
            end
        end
        function bool = containsKey(idict, key)
            % CONTAINSKEY checks if a key exists in the dictionary.
            %
            % BOOL = CONTAINS(IDICT, KEY) returns true if a key exists
            % in the dictionary DICT.
            %
            % See also containsIndex(), contains()
            
            bool = false;
            for i = 1:1:idict.length()
                if isequal(idict.getKey(i), key)
                    bool = true;
                    break;
                end
            end
        end
        function bool = containsValue(idict, value)
            % CONTAINSVALUE checks if a value exists in the dictionary.
            %
            % BOOL = CONTAINSVALUE(IDICT, VALUE) returns true if a value exists
            % in the dictionary DICT.
            %
            % See also containsIndex(), contains()
            
            bool = false;
            for i = 1:1:idict.length()
                if isequal(idict.getValue(i), value)
                    bool = true;
                    break;
                end
            end
        end
        function index = getIndex(idict, pointer) 
            % GETINDEX returns the index of a key or value
            %
            % INDEX = GETINDEX(IDICT, POINTER) returns the index of
            % a element that has a key or value.
            %
            % See also getIndexFromValue(), getIndexFromKey().
            
           if isa(pointer, 'char')  % pointer is key
                index = idict.getIndexFromKey(pointer);
            elseif isa(pointer, idict.getValueClass())
                index = idict.getIndexFromValue(pointer);
            end
        end
        function index = getIndexFromValue(idict, value)
            % GETINDEXFROMVALUE returns the index of a value
            %
            % INDEX = GETINDEXFROMVALUE(IDICT, VALUE) returns the index of
            % a element that has a VALUE. Returns the first ocurrance.
            %
            % See also getIndex(), getIndexFromKey().
            
            for i = 1:1:idict.length()                
                if isequal(idict.getValue(i), value)
                    index = i;  % return the first ocurrance
                    break;
                end
            end
        end
        function index = getIndexFromKey(idict, key)
            % GETINDEXFROMKEY returns the index of a key
            %
            % INDEX = GETINDEXFROMKEY(IDICT, KEY) returns the index of
            % a element that has a KEY.
            %
            % See also getIndex(), getIndexFromValue().
            
            for i = 1:1:idict.length()
                if isequal(idict.getKey(i), key)
                    index = i;
                    break;
                end
            end
        end
        function indexes =  getIndexFromValueAll(idict, value)
            % GETINDEXFROMVALUEALL returns all the indexes with the same value
            %
            % INDEXES = GETINDEXFROMVALUEALL(IDICT, VALUE) returns a cell
            % array with the indexes with value VALUE.
            %
            % See also getIndexFromValue(), getIndexFromKey().
            
            indexes = zeros(1, idict.length());  % create a matrix(1, idict.length)
            for i = 1:1:idict.length()
                if isequal(idict.getValue(i), value)
                    indexes(1, i) = i;  % get index of occurrance
                end
            end
            indexes = indexes(indexes~=0);  % remove non ocurrance cases.
            indexes = num2cell(indexes);  % transform to cell array.
        end
        function value = getValue(idict, pointer)
            % GETVALUE returns the value of a index or key.
            %
            % VALUE = GETVALUE(IDICT, POINTER) returns the value a index or key.
            %
            % See also getValueFromIndex(), getValueFromKey().
            
            if isa(pointer, 'char')  % key
                value = idict.getValueFromKey(pointer);
            else
                value = idict.getValueFromIndex(pointer);
            end            
        end 
        function value = getValueFromIndex(idict, index)    
            % GETVALUEFROMINDEX returns the value of a index.
            %
            % VALUE = GETVALUEFROMINDEX(IDICT, INDEX) returns a value of a index.
            %
            % See also getValue(), getValueFromKey().
            
            key_and_value = idict.dict(index);
            value = key_and_value{2};
        end
        function value = getValueFromKey(idict, key)
            % GETVALUEFROMKEY returns the value of a key.
            %
            % VALUE = GETVALUEFROMKEY(IDICT, KEY) returns a value of a index.
            %
            % See also getValue(), getValueFromIndex().
            
            index = idict.getIndexFromKey(key);
            value  = idict.getValueFromIndex(index);
        end
        function values = getValueAll(idict)
            % GETVALUEALL returns all the values in the dictionary
            %
            % VALUES = GETVALUEALL(IDICT) returns all the values in the
            % indexed dictionary.
            %
            % See also getValue(), getIndexFromValueAll()
            
            values = cell(1, idict.length());
            for i = 1:1:idict.length()
                key_and_value = idict.dict(i);
                values{1, i} = key_and_value{2};
            end
        end
        function key = getKey(idict, pointer)
            % GETKEY returns the key of a index or value.
            %
            % KEY = GETKEY(IDICT, POINTER) returns a key of a index or
            % value. If the POINTER is a value, it returns the first
            % ocurrance.
            %
            % See also getValue(), getValueFromIndex().
            
            if isa(class(pointer), idict.getValueClass())
                key = getKeyFromValue(pointer);  % first ocurrance
            else  % is index
                key_and_value = idict.dict(pointer);
                key = key_and_value{1};  % unique key
            end
        end
        function key = getKeyFromIndex(idict, index)
            % GETKEYFROMINDEX returns the key of a index.
            %
            % KEY = GETKEYFROMINDEX(IDICT, INDEX) returns a key of a index.
            %
            % See also getValue(), getKey().
            
            key_and_value = idict.dict(index);
            key = key_and_value{1};
        end
        function key = getKeyFromValue(idict, value)
            % GETKEYFROMVALUE returns the key of a value.
            %
            % KEY = GETKEYFROMVALUE(IDICT, VALUE) returnsa key of the first 
            % ocurrance a value. 
            %
            % See also getValue(), getKey().
            
            index = idict.getIndexFromValue(value);
            key_and_value = idict.dict(index);
            key = key_and_value{1};
        end
        function keys = getKeyFromValueAll(idict, value)  
            % GETKEYFROMVALUEALL returns the keys of the value
            %
            % KEYS = GETKEYFROMVALUEALL(IDICT, VALUE) returns the keys the
            % share the value VALUE. 
            % 
            % See also getIndexFromValueAll(), getKeyFromIndex().
            
            indexes = idict.getIndexFromValueAll(value);
            keys = cell(1, length(indexes));
            
            for i = 1:1:length(indexes)
                keys{1, i} = idict.getKeyFromIndex(indexes{i});
            end
        end
        function add(idict, key, value, index)
            % ADD adds a key and value to DICT in position index.
            %
            % ADD(IDICT, KEY, VALUE, INDEX) adds a key and value to the
            % IDICT dictionary in position INDEX. If INDEX 
            % is empty it adds it to the end of DICT by default.
            %
            % See also remove(), replace().
            
            if nargin < 4 || index < 0 || index > idict.length()
                index = idict.length() + 1;
            end
            
            assert(ischar(key), ...
                ['BRAPH:IndexDictionary:Add'], ...
                ['Key is not a string.']) %#ok<NBRAK>
            assert(isequal(class(value), idict.getValueClass()), ...
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
            % REMOVE removes a key and value from DICT that has index, key
            % or value of pointer.
            %
            % REMOVE(IDICT, POINTER) removes a key and value from DICT that
            % has index, key or value of POINTER.
            %
            % See also add(), replace().
            
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
            % REPLACE replaces a key and value from DICT.
            %
            % REPLACE(IDICT, KEYNEW, VALUENEW, INDEX) replaces a key and 
            % value from DICT that has index with key_new and value_new.
            %
            % See also add(), remove().
            
            if idict.contains(index)
                idict.dict(index) = {key_new, value_new};
            end
        end
        function replaceKey(idict, key_old, key_new)
            % REPLACEKEY replaces a key from DICT.
            %
            % REPLACEKEY(IDICT, KEYOLD, KEYNEW) replaces a key from DICT 
            % with key_new.
            %
            % See also add(), replace(), replaceValue().
            
            index = idict.getIndexFromKey(key_old);
            value = idict.getValueFromIndex(index);
            idict.replace(key_new, value, index);
        end
        function replaceValue(idict, value_old, value_new)
            % REPLACEVALUE replaces a value from DICT.
            %
            % REPLACEVALUE(IDICT, VALUEOLD, VALUENEW) replaces a value from
            % DICT with value_new.
            %
            % See also add(), replace(), replaceKey().
            
            index = idict.getIndexFromValue(value_old);
            key = idict.getKeyFromIndex(index);
            idict.replace(key, value_new, index);
        end
        function replaceValueAll(idict, value_old, value_new)
            % REPLACEVALUEALL replaces all equal values from DICT
            % 
            % REPLACEVALUEALL(IDICT, VALUE_OLD, VALUE_NEW) replaces all
            % values VALUE_OLD, with a new value VALUE_NEW.
            %
            % See also replaceValue(), getIndexFromValueAll()
            
            indexes = idict.getIndexFromValueAll(value_old);
            for i = 1:1:length(indexes)
                key = idict.getKeyFromIndex(indexes{i});
                idict.replace(key, value_new, indexes{i});
            end            
        end
        function invert(idict, i, j)
            % INVERT inverts position of two elements.
            %
            % INVERT(IDICT, INDEXI, INDEXJ) inverts the
            % position of a element at INDEXI with the position of a
            % element at INDEXJ.  
            %
            % See also add(), replace(), remove().
            
            if i > 0 && i <= idict.length() && j > 0 && j <= idict.length() && i ~= j
                pair_i = idict.dict(i);
                pair_j = idict.dict(j);
                idict.replace(pair_j{1}, pair_j{2}, i);
                idict.replace(pair_i{1}, pair_i{2}, j);
            end
        end
        function move_to(idict, i, j)
            % MOVETO moves a element of the dictionary to another position.
            %
            % MOVETO(IDICT, INDEXI, INDEXJ) moves a element from position 
            % INDEXI to position INDEXJ.
            %
            % See also add(), replace(), remove(), invert().
            
            if i > 0 && i <= idict.length() && j > 0 && j <= idict.length() && i ~= j
                key_and_value = idict.dict(i);
                if i > j
                    idict.remove(i)
                    idict.add(key_and_value{1}, key_and_value{2}, j)
                else  % j < i
                    idict.add(key_and_value{1}, key_and_value{2}, j+1)
                    idict.remove(i)
                end
            end
        end
        function selected = remove_all(idict, selected)
            % REMOVEALL removes selected elements.
            %
            % SELECTED = REMOVEALL(IDICT, SELECTED) removes all
            % elements whose positions in DICT are included in the
            % array SELECTED. It returns an empty array.
            %
            % See also add(), remove().
            
            for i = length(selected):-1:1
                idict.remove(selected(i))
            end
            selected = [];
        end
        function selected =  move_up(idict, selected)
            % MOVEUP moves up selected elements.
            %
            % SELECTED = MOVEUP(IDICT, SELECTED) moves up by one
            % position all elements whose positions in DICT are included
            % in the SELECTED array and returns their final positions.
            %
            % See also move_down().
            
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
            % MOVEDOWN moves down selected elements.
            %
            % SELECTED = MOVEDOWN(IDICT, SELECTED) moves down by one
            % position all elements whose positions in DICT are included
            % in the SELECTED array and returns their final positions.
            %
            % See also move_up().
            
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
            % MOVE2TOP moves selected elements to top
            %
            % SELECTED = MOVE2TOP(IDICT, SELECTED) moves to top
            % all elements whose positions in the DICT dictionary are 
            % included in the SELECTED array and returns their final positions.
            %
            % See also move_to_bottom().
            
            if ~isempty(selected)
                for i = 1:1:numel(selected)
                    idict.move_to(selected(i), i);
                end
                selected = reshape(1:1:numel(selected), size(selected));
            end
        end
        function selected = move_to_bottom(idict, selected)
            % MOVE2BOTTOM moves selected elements to bottom
            %
            % SELECTED = MOVE2BOTTOM(IDICT, SELECTED) moves to bottom
            % all elements whose positions in the DICT dictionary are 
            % included in the SELECTED array and returns their final positions.
            %
            % See also move_to_top().
            
            if ~isempty(selected)
                for i = numel(selected):-1:1
                    idict.move_to(selected(i), idict.length() - (numel(selected)-i));
                end
                selected = reshape(idict.length() - numel(selected)+1:1:idict.length(), size(selected));
            end
        end
    end
end