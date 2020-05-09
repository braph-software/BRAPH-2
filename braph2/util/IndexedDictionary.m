classdef IndexedDictionary < handle & matlab.mixin.Copyable
    % IndexedDictionary Indexed dictionary
    % IndexedDictionary provides the methods necessary to handle data 
    % in an indexed dictionary.
    % It is a subclass of handle and matlab.mixin.Copyable.
    %
    % IndexedDictionary contains and manages a ordered list of couples
    % {KEY, VALUE}, where KEY is a unique alphanumeric key (a string) and
    % VALUE is an object of a class defined in the constructor.
    %
    % IndexedDictionary methods:
    %   IndexedDictionary - constructor
    %   tostring          - returns a string representing the dictionary
    %   disp              - displays the dictionary
    %   getValueClass     - returns the value class
    %   length            - returns the length of the dictionary
    %   contains          - bool, checks if the dictionary contains the index, key or value
    %   containsIndex     - bool, checks if the dictionary contains the index
    %   containsKey       - bool, checks if the dictionary contains the key
    %   containsValue     - bool, checks if the dictionary contains the value
    %   getIndex          - returns the index of the key or value
    %   getIndexFromKey   - returns the index of the key
    %   getIndexFromValue - returns the index of the value
    %   getIndexFromValueAll - returns all the indexes of the same value
    %   getKeys           - returns all keys
    %   getKey            - returns the key of the index or value
    %   getKeyFromIndex   - returns the key of the index
    %   getKeyFromValue   - returns the key of the value
    %   getKeyFromValueAll   - returns all the keys of the same value.
    %   getValues         - returns all values
    %   getValue          - returns the value of the index or the key
    %   getValueFromIndex - returns the value of the index
    %   getValueFromKey   - returns the value of the key
    %   add               - adds a key and value to the dictionary
    %   remove            - removes the key and value from the dictionary
    %   replace           - replaces a key and value in the dictionary
    %   replaceKey        - replaces a key in the dictionary
    %   replaceValue      - replaces a value in the dictionary
    %   replaceValueAll   - replaces all values of same value in the dictionary
    %   invert            - inverts position of elements in the dictionary
    %   move_to           - move an element to a position in the ditionary
    %   remove_all        - removes all selected elements from the dictionary
    %   move_up           - moves an element up
    %   move_down         - moves an element down
    %   move_to_top       - moves an element to the top
    %   move_to_bottom    - moves an element to the bottom
    %
    % See also handle, matlab.mixin.Copyable.
    
    properties (GetAccess=protected, SetAccess=protected)
        value_class  % class of the value objects
        dict  % dict of (index, {key, value})
    end
    methods  % Basic functions
        function idict = IndexedDictionary(value_class, keys, values)
            % IndexedDictionary(VALUE_CLASS) creates an empty indexed
            % dictionary storing objects of class VALUE_CLASS. 
            %
            % IndexedDictionary(VALUE_CLASS, KEYS, VALUES) creates an
            % indexed dictionary storing objects of class VALUE_CLASS, and
            % inserts KEYS with corresponding values VALUES.
            % KEYS and VALUES must be same-length cell arrays of strings
            % and objects of class VALUE_CLASS, respectively.
            %
            % See also BrainAtlas, Cohort, GraphAnalysis.
            
            idict.value_class = value_class;
            
            idict.dict = containers.Map('KeyType', 'double', 'ValueType', 'any');
            
            if nargin > 2
                assert(length(keys) == length(values), ...
                    [BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_INPUT], ...
                    ['The size of keys and values must be the same,' ...
                    ' while length(keys)=%i and length(values)=%i.'], ...
                    length(keys), length(values))
                
                for i = 1:1:length(values)
                    
                    key = keys{i};
                    assert(ischar(key), ...
                        [BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_INPUT], ...
                        'Key must be a string.')
                    
                    value = values{i};
                    assert(isequal(class(value), value_class), ...
                        [BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_INPUT], ...
                        ['Value must be an object of class ' value_class ',' ...
                        ' while it is of class ' class(value) '.'])
                    
                    idict.add(key, value, i);
                end
            end
        end
        function str = tostring(idict)
            % TOSTRING string with information about the indexed dictionary
            %
            % STR = TOSTRING(IDICT) returns string with the value class and
            % length of the dictionary.
            %
            % See also disp().
            
            str = ['IndexDictionary of value class ' idict.getValueClass() ' with ' int2str(idict.length()) ' entries.'];
        end
        function disp(idict)
            % DISP displays information about the indexed dictionary
            %
            % DISP(IDICT) displays information about the indexed dictionary.
            % It provides information about the value class, size, keys and
            % values of the indexed dictionary.
            %
            % See also tostring().
            
            disp(['<a href="matlab:help ' class(idict) '">' class(idict) '</a>'])
            disp([' value class: ' idict.getValueClass()])
            disp([' size: ' int2str(idict.length())])
            disp([' With entries:' ]) %#ok<NBRAK>
            for i = 1:1:length(idict.dict)
                key_and_value = idict.dict(i);
                disp(['  key:' tostring(key_and_value{1}) ', value:' tostring(key_and_value{2})]);
            end
        end
        function value_class = getValueClass(idict)
            % GETVALUECLASS returns the value class of the indexed dictionary
            %
            % VALUE_CLASS = GEGETVALUECLASSTA(IDICT) returns the value
            % class of the indexed dictionary.
            
            value_class = idict.value_class;
        end
    end
    methods  % Inspection functions
        function n = length(idict)
            % LENGTH returns the number of elements in the indexed dictionary
            %
            % N = LENGTH(IDICT) returns the number of elements in the
            % indexed dictionary.
            
            n = length(idict.dict);
        end
        function bool = contains(idict, pointer)
            % CONTAINS checks if an element exists in an indexed dictionary
            %
            % BOOL = CONTAINS(IDICT, POINTER) returns true if POINTER (index, key
            % or value) exists in the indexed dictionary DICT.
            %
            % See also containsIndex(), containsKey(), containsValue().
            
            if isa(pointer, 'numeric')  % pointer is index
                bool = idict.containsIndex(pointer);
            elseif isa(pointer, 'char')  % pointer is key
                bool = idict.containsKey(pointer);
            elseif isa(pointer, idict.getValueClass())  % pointer is value - not necessarily unique
                bool = idict.containsValue(pointer);
            else
                bool = false;
            end
        end
        function bool = containsIndex(idict, index)
            % CONTAINSINDEX checks if an index exists in an indexed dictionary
            %
            % BOOL = CONTAINS(IDICT, INDEX) returns true if the INDEX exists
            % in the indexed dictionary IDICT.
            %
            % See also contains(), containsKey(), containsValue().
            
            if index > 0 && index <= idict.length() && index == round(index)
                bool = true;
            else
                bool = false;
            end
        end
        function bool = containsKey(idict, key)
            % CONTAINSKEY checks if a key exists in an indexed dictionary
            %
            % BOOL = CONTAINS(IDICT, KEY) returns true if the KEY exists
            % in the indexed dictionary DICT.
            %
            % See also contains(), containsIndex(), containsValue().
            
            bool = false;
            for i = 1:1:idict.length()
                if isequal(idict.getKey(i), key)
                    bool = true;
                    break;
                end
            end
        end
        function bool = containsValue(idict, value)
            % CONTAINSVALUE checks if a value exists in an indexed dictionary
            %
            % BOOL = CONTAINSVALUE(IDICT, VALUE) returns true if the VALUE exists
            % in the indexed dictionary DICT.
            %
            % See also contains(), containsValue(), containsKey().
            
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
            % a POINTER (a key or value).
            %
            % See also getIndexFromValue(), getIndexFromKey().
            
           if isa(pointer, 'char')  % pointer is key
                index = idict.getIndexFromKey(pointer);
            elseif isa(pointer, idict.getValueClass())  % pointer is value - not necessarily unique
                index = idict.getIndexFromValue(pointer);
            end
        end
        function index = getIndexFromKey(idict, key)
            % GETINDEXFROMKEY returns the index of a key
            %
            % INDEX = GETINDEXFROMKEY(IDICT, KEY) returns the index of KEY.
            %
            % See also getIndex(), getIndexFromValue().
            
            for i = 1:1:idict.length()
                if isequal(idict.getKey(i), key)
                    index = i;
                    break;
                end
            end
        end
        function index = getIndexFromValue(idict, value)
            % GETINDEXFROMVALUE returns the index of a value
            %
            % INDEX = GETINDEXFROMVALUE(IDICT, VALUE) returns the index of
            % the first occurrence of VALUE.
            %
            % See also getIndexFromValueAll(), getIndex(), getIndexFromKey().
            
            for i = 1:1:idict.length()                
                if isequal(idict.getValue(i), value)
                    index = i;  % return the first occurrence
                    break;
                end
            end
        end
        function indexes =  getIndexFromValueAll(idict, value)
            % GETINDEXFROMVALUEALL returns all the indexes with a value
            %
            % INDEXES = GETINDEXFROMVALUEALL(IDICT, VALUE) returns a cell
            % array with all the indexes of VALUE.
            %
            % See also getIndexFromValue().
            
            indexes = zeros(1, idict.length());  % create a matrix(1, idict.length)
            for i = 1:1:idict.length()
                if isequal(idict.getValue(i), value)
                    indexes(1, i) = i;  % get index of occurrence
                end
            end
            indexes = indexes(indexes~=0);  % remove non occurrence cases.
            indexes = num2cell(indexes);  % transform to cell array.
        end
        function keys = getKeys(idict)
            % GETKEYS returns all the keys in the indexed dictionary
            %
            % KEYS = GETKEYS(IDICT) returns all the keys in the indexed
            % dictionary.
            %
            % See also getValues().
            
            keys = cell(1, idict.length());
            for i = 1:1:idict.length()
                key_and_value = idict.dict(i);
                keys{1, i} = key_and_value{1};
            end
        end
        function key = getKey(idict, pointer)
            % GETKEY returns the key of an index or value.
            %
            % KEY = GETKEY(IDICT, POINTER) returns the key of POINTER (a
            % index or value). If the POINTER is a value, it returns the
            % first occurrence.
            %
            % See also getKeyFromIndex(), getKeyFromValue().
                        
            if isa(pointer, idict.getValueClass())  % pointer is value - not necessarily unique
                key = idict.getKeyFromValue(pointer);  % first occurrence
            else  % pointer is an index
                key_and_value = idict.dict(pointer);
                key = key_and_value{1};
            end
        end
        function key = getKeyFromIndex(idict, index)
            % GETKEYFROMINDEX returns the key of an index
            %
            % KEY = GETKEYFROMINDEX(IDICT, INDEX) returns the key of INDEX.
            %
            % See also getKey(), getKeyFromValue().
            
            key_and_value = idict.dict(index);
            key = key_and_value{1};
        end
        function key = getKeyFromValue(idict, value)
            % GETKEYFROMVALUE returns the key of a value
            %
            % KEY = GETKEYFROMVALUE(IDICT, VALUE) returns the key of the first 
            % occurrence of VALUE. 
            %
            % See also getKeyFromValueAll(), getKey(), getKeyFromIndex().
            
            index = idict.getIndexFromValue(value);
            key_and_value = idict.dict(index);
            key = key_and_value{1};
        end
        function keys = getKeyFromValueAll(idict, value)  
            % GETKEYFROMVALUEALL returns all the keys of a value
            %
            % KEYS = GETKEYFROMVALUEALL(IDICT, VALUE) returns a cell
            % array with all the keyes that have VALUE.
            % 
            % See also getIndexFromValue().
            
            indexes = idict.getIndexFromValueAll(value);

            keys = cell(1, length(indexes));
            for i = 1:1:length(indexes)
                keys{1, i} = idict.getKeyFromIndex(indexes{i});
            end
        end
        function values = getValues(idict)
            % GETVALUES returns all the values in the indexed dictionary
            %
            % VALUES = GETVALUES(IDICT) returns all the values in the
            % indexed dictionary.
            %
            % See also getKeys().
            
            values = cell(1, idict.length());
            for i = 1:1:idict.length()
                key_and_value = idict.dict(i);
                values{1, i} = key_and_value{2};
            end
        end
        function value = getValue(idict, pointer)
            % GETVALUE returns the value of an index or key
            %
            % VALUE = GETVALUE(IDICT, POINTER) returns the value a POINTER
            % (an index or key).
            %
            % See also getValueFromIndex(), getValueFromKey().
            
            if isa(pointer, 'char')  % pointer is a key
                value = idict.getValueFromKey(pointer);
            else  % pointer is an index
                value = idict.getValueFromIndex(pointer);
            end            
        end 
        function value = getValueFromIndex(idict, index)    
            % GETVALUEFROMINDEX returns the value of an index
            %
            % VALUE = GETVALUEFROMINDEX(IDICT, INDEX) returns the value of INDEX.
            %
            % See also getValue(), getValueFromKey().
            
            key_and_value = idict.dict(index);
            value = key_and_value{2};
        end
        function value = getValueFromKey(idict, key)
            % GETVALUEFROMKEY returns the value of a key
            %
            % VALUE = GETVALUEFROMKEY(IDICT, KEY) returns the value of KEY.
            %
            % See also getValue(), getValueFromIndex().
            
            index = idict.getIndexFromKey(key);
            value  = idict.getValueFromIndex(index);
        end
    end
    methods  % Editing functions
        function add(idict, key, value, index)
            % ADD adds a key and value to an indexed dictionary
            %
            % ADD(IDICT, KEY, VALUE, INDEX) adds a key and value to the
            % indexed dictionary in position INDEX. 
            % If INDEX is empty, it adds it to the end of IDICT.
            %
            % See also remove(), replace().
            
            if nargin < 4 || index < 0 || index > idict.length()
                index = idict.length() + 1;
            end
            
            assert(ischar(key), ...
                [BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_INPUT], ...
                'Key must be a string.')
            assert(~any(strcmp(key, idict.getKeys())), ...
                [BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_INPUT], ...
                ['Key ''' key ''' is already contained in the indexed dictionary.'])

            assert(isa(value, idict.getValueClass()), ...
                [BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_INPUT], ...
                ['Value must be an object of class ' idict.getValueClass() ',' ...
                ' while it is of class ' class(value) '.'])

            if index <= idict.length()  % create space for {key, value}
                for j = idict.length():-1:index
                    idict.dict(j+1) = idict.dict(j);
                end
            end
            idict.dict(index) = {key, value};  % {key, value} to indexed dictionary
        end
        function remove(idict, pointer)            
            % REMOVE removes a key and value from an indexed dictionary
            %
            % REMOVE(IDICT, POINTER) removes the key and value of POINTER
            % (an index, key or value) from the indexed dictionary IDICT.
            %
            % See also add(), replace().
            
            if isa(pointer, 'char')  % pointer is a key
                index = idict.getKeyIndex(pointer);
            elseif isa(pointer, 'numeric')  % pointer is an index
                index = pointer;
            elseif isa(pointer.getClass(), idict.getValueClass())  % pointer is a value
                index = idict.getValueIndex(pointer);
            end
            
            for j = index:1:idict.length()-1
                idict.dict(j) = idict.dict(j+1);
            end
            remove(idict.dict, idict.length());
        end
        function replace(idict, new_key, new_value, index)
            % REPLACE replaces a key and value in an indexed dictionary
            %
            % REPLACE(IDICT, NEW_KEY, NEW_VALUE, INDEX) replaces the key and 
            % value of INDEX in the indexed dictionary IDICT with NEW_KEY
            % and NEW_VALUE.
            %
            % See also add(), remove(), replaceKey(), replaceValue(), replaceValueAll().
            
            assert(isequal(idict.getValueClass(), class(new_value)), ...
                'BRAPH:IndexedDictionary:Bug', ...
                'value is not of the correct class.')
            
            if idict.contains(index)
                idict.remove(index)
                idict.add(new_key, new_value, index)
            end
        end
        function replaceKey(idict, old_key, new_key)
            % REPLACEKEY replaces key in indexed dictionary
            %
            % REPLACEKEY(IDICT, OLD_KEY, NEW_KEY) replaces OLD_KEY in the
            % indexed dictionary IDICT with NEW_KEY.
            %
            % See also replace(), replaceValue(), replaceValueAll()..
            
            index = idict.getIndexFromKey(old_key);
            value = idict.getValueFromIndex(index);
            idict.replace(new_key, value, index);
        end
        function replaceValue(idict, old_value, new_value)
            % REPLACEVALUE replaces value in indexed dictionary
            %
            % REPLACEVALUE(IDICT, OLD_VALUE, NEW_VALUE) replaces OLD_VALUE
            % with NEW_VALUE in the indexed dictionary IDICT. It replaces
            % only the first occurrence of OLD_VALUE.
            %
            % See also replace(), replaceKey(), replaceValueAll().
            
            index = idict.getIndexFromValue(old_value);
            key = idict.getKeyFromIndex(index);
            idict.replace(key, new_value, index);
        end
        function replaceValueAll(idict, old_value, new_value)
            % REPLACEVALUEALL replaces all occurrences of value in indexed dictionary
            % 
            % REPLACEVALUEALL(IDICT, OLD_VALUE, NEW_VALUE) replaces all
            % occurences of OLD_VALUE in the indexed dictionary IDICT with
            % NEW_VALUE.
            %
            % See also replace(), replaceKey(), replaceValue().
            
            indexes = idict.getIndexFromValueAll(old_value);
            for i = 1:1:length(indexes)
                key = idict.getKeyFromIndex(indexes{i});
                idict.replace(key, new_value, indexes{i});
            end            
        end
        function invert(idict, i, j)
            % INVERT inverts position of two elements in indexed dictionary
            %
            % INVERT(IDICT, INDEXI, INDEXJ) inverts the positions of a
            % elements at INDEX_I and INDEX_J in the indexed dictionary
            % IDICT.
            %
            % See also move_to().

            if i > j
                if i > 0 && i <= idict.length() && j > 0 && j <= idict.length() && i ~= j
                    pair_i = idict.dict(i);
                    pair_j = idict.dict(j);
                    
                    idict.remove(i)
                    idict.remove(j)
                    
                    idict.add(pair_i{1}, pair_i{2}, j);
                    idict.add(pair_j{1}, pair_j{2}, i);
                end
            else
                idict.invert(j, i);
            end
        end
        function move_to(idict, i, j)
            % MOVE_TO moves an element of an indexed dictionary to another position
            %
            % MOVE_TO(IDICT, OLD_INDEX, NEW_INDEX) moves an element from position 
            % OLD_INDEX to position NEW_INDEX in the indexed dictionary IDICT.
            %
            % See also invert().
            
            if i > 0 && i <= idict.length() && j > 0 && j <= idict.length() && i ~= j
                key_and_value = idict.dict(i);
                idict.remove(i)
                idict.add(key_and_value{1}, key_and_value{2}, j)
            end
        end
        function selected = remove_all(idict, selected)
            % REMOVEALL removes selected elements
            %
            % SELECTED = REMOVEALL(IDICT, SELECTED) removes all elements
            % whose positions in the indexed dictionary DICT are included
            % in the array SELECTED. It returns an empty array.
            %
            % See also move_up(), move_down(), move_to_top(), move_to_bottom().
            
            for i = length(selected):-1:1
                idict.remove(selected(i))
            end
            selected = [];
        end
        function selected =  move_up(idict, selected)
            % MOVEUP moves up selected elements
            %
            % SELECTED = MOVEUP(IDICT, SELECTED) moves up by one
            % position all elements whose positions in the indexed
            % dictionary DICT are included in the SELECTED array and
            % returns their final positions. 
            %
            % See also remove_all(), move_down(), move_to_top(), move_to_bottom().
            
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
            % MOVEDOWN moves down selected elements
            %
            % SELECTED = MOVEDOWN(IDICT, SELECTED) moves down by one
            % position all elements whose positions in the indexed
            % dictionary DICT are included in the SELECTED array and
            % returns their final positions.
            %
            % See also remove_all(), move_up(), move_to_top(), move_to_bottom().
            
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
            % SELECTED = MOVE2TOP(IDICT, SELECTED) moves to top all
            % elements whose positions in the indexed dictionary DICT are
            % included in the SELECTED array and returns their final
            % positions.
            %
            % See also remove_all(), move_up(), move_down(), move_to_bottom().
            
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
            % SELECTED = MOVE2BOTTOM(IDICT, SELECTED) moves to bottom all
            % elements whose positions in the indexed dictionary DICT
            % dictionary are included in the SELECTED array and returns
            % their final positions.
            %
            % See also remove_all(), move_up(), move_down(), move_to_top().
            
            if ~isempty(selected)
                for i = numel(selected):-1:1
                    idict.move_to(selected(i), idict.length() - (numel(selected)-i));
                end
                selected = reshape(idict.length() - numel(selected)+1:1:idict.length(), size(selected));
            end
        end
    end
    methods (Access=protected)  % Deep copy
        function idict_copy = copyElement(idict)
            % COPYELEMENT deep copy of indexed dictionary
            %
            % IDICT_COPY = COPYELEMENT(IDICT) makes a deep copy of the
            % indexed dictionary IDICT. If the values have a method copy(),
            % it calls it to make deep copies of the values. Otherwise, it
            % makes a copy of the value pointer (i.e., the value object is
            % not copied).
            
            % Make a shallow copy
            idict_copy = copyElement@matlab.mixin.Copyable(idict);
            
            % Make a deep copy of idict.dict
            idict_copy.dict = containers.Map('KeyType', 'double', 'ValueType', 'any');
            for i = 1:1:idict.length()
                key = idict.getKey(i);
                value = idict.getValue(i);
                if ismethod(value, 'copy')
                    idict_copy.add(key, value.copy)
                else
                    idict_copy.add(key, value)
                end
            end
        end
    end
end