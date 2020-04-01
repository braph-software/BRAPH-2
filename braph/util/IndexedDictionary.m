classdef IndexedDictionary < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        value_class  % class of the value objects
        dict  % dict of (index, {key, value})
    end
    methods
        function idict = IndexedDictionary(value_class, keys, values)
            idict.value_class = value_class;
            idict.dict = containers.Map('KeyType', 'double', 'ValueType', 'any');            
         
            assert(isequal(length(values), length(keys)), ...
                ['BRAPH:IndexDictionary:Constructor'], ...
                ['Size of arguments is not the same.']) %#ok<NBRAK>
            
            for i = 1:1:length(values)
                assert(ischar(keys{i}), ...
                ['BRAPH:IndexDictionary:Constructor'], ...
                ['Size of arguments is not the same.']) %#ok<NBRAK>
            % values
                pairementKeyValue = {keys{i}, values{i}};
                idict.add(pairementKeyValue, i);
            end
        end
        function str = tostring(idict)
            str = ['IndexDictionary of class ' idict.getValueClass() ' with ' int2str(idict.dictnumber()) ' entries.'];
        end
        function disp(idict)
            disp(['<a href="matlab:help ' class(idict) '">' class(idict) '</a>'])
            disp([' class: ' idict.getValueClass()])
            disp([' size: ' int2str(idict.dictnumber())])
        end
        function n = length(idict)
            n = length(idict.dict);
        end
        function value_class = getValueClass(idict)
            value_class = idict.value_class;
        end
        %contains val, numer or key;
        % contains index
        function bool = constainsValue(idict, value)
            bool = false;            
            for i = 1:1:idict.dictnumber()
                pair = idict.getPairment(i);
                if isequal( pair{2}, value)  % compares exact object
                    bool = true;
                    break;
                end
            end
        end
        function bool = containsKey(idict, key)
            bool = false;
            for i = 1:1:idict.dictnumber()
                pair = idict.getPairment(i);
                if isequal( pair{1}, key)  % compares exact object
                    bool = true;
                    break;
                end
            end
        end
        
%         function pairment = getPairment(idict, index)
%             pairment = idict.dict(index);
%         end
%         function pairments = getPairments(idict)
%             pairments = values(idict.dict);
%         end
        function index = getValueIndex(idict, value)
            for i = 1:1:idict.dictnumber()
                pair = idict.getPairment(i);
                if isequal(pair{2}, value) 
                    index = i;
                    break;
                end
            end
        end
        function index = getKeyIndex(idict, key)
            for i = 1:1:idict.dictnumber()
                pair = idict.getPairment(i);
                if isequal(pair{1}, key)
                    index = i;
                    break;
                end
            end
        end
        function indexes = getAllKeysIndexes(idict, keys)
            indexes = zeros(1, idict.dictnumber());
            for i = 1:1:idict.dictnumber()
                pair = idict.getPairment(i);
                 if isequal(pair{1}, keys)
                    indexes(1, i) = i;                
                end
            end
            indexes = indexes(indexes~=0);            
        end
%         function index = getPairmentIndex(idict, pair)
%             for i = 1:1:idict.dictnumber()
%                 if isequal(idict.getPairment(i), pair)
%                     index = i;
%                     break;
%                 end
%             end
%         end
        % get index  // key from value or value from key
        function value = getValue(idict, index)
            pair = idict.getPairment(index);
            value = pair{2};            
        end
        function key = getKey(idict, index)
            pair = idict.getPairment(index);
            key = pair{1}; 
        end
        function add(idict, pairment, index)
            if nargin < 3 || index < 0 || index > idict.dictnumber()
                index = idict.dictnumber() + 1;
            end
            
            dict(index) = {key, {}};
            
            if index <= idict.dictnumber()
                for j = idict.dictnumber():-1:index
                    idict.dict(j+1) = idict.dict(j);
                end
            end
            idict.dict(index) = pairment;  % adds at the end
        end
        % rem
        function remove(idict, index)
            if (isa(index, 'object')
                
            for j = index:1:idict.dictnumber()-1
                idict.dict(j) = idict.dict(j+1);
            end
            remove(idict.dict, idict.dictnumber());
        end
%         function removePairment(idict, pair)
%             index = idict.getPairmentIndex(pair);
%             idict.remove(index);
%         end
%         function removeAllPairWithKey(idict, key)
%             
%         end
%         function replace(idict, index, varargin)
% %             
% %              assert(lenth(varargin)==2, ...
% %                 ['BRAPH:IndexDictionary:Replace'], ...
% %                 ['Missing parameters to Replace.']) %#ok<NBRAK>
% %             
% %             if nargin < 4 || index < 0 || index > idict.dictnumber()
% %                 index = idict.dictnumber() + 1;
% %             end
% %             
%         end
        % management functions
    end
    % Indexed dictionary with index (positive integer, sequesntial, 1, 2,
    % 3, 4, ...), key (string) and value (object of the class value_class)
end