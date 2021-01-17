classdef Format < handle

    properties (Constant)
        EMPTY = 'em'
        EMPTY_NAME = 'empty' 
        EMPTY_DESCRIPTION = 'Empty has an empty value and is typically used as a result to execute some code.'

        STRING = 'st'
        STRING_NAME = 'string' 
        STRING_DESCRIPTION = 'String is a char array.'
        
        LOGICAL = 'lo'
        LOGICAL_NAME = 'logical'
        LOGICAL_DESCRIPTION = 'Logical is a boolean value.'

        OPTION = 'op'
        OPTION_NAME = 'option' 
        OPTION_DESCRIPTION = 'Option is a char array representing an option within a set defined in the element.'
        
        CLASS = 'ca'
        CLASS_NAME = 'class'
        CLASS_DESCRIPTION = 'Class is a char array corresponding to an element class.'

        CLASSLIST = 'cl'
        CLASSLIST_NAME = 'classlist'
        CLASSLIST_DESCRIPTION = 'ClassList is a cell array with char arrays corresponding to element classes.'
        
        ITEM = 'it'
        ITEM_NAME = 'item'
        ITEM_DESCRIPTION = 'Item is a pointer to an element of a class defined in the element.'

        ITEMLIST = 'il'
        ITEMLIST_NAME = 'itemlist'
        ITEMLIST_DESCRIPTION = 'ItemList is a cell array with pointers to elements of a class defined in the element.'
        
        IDICT = 'di'
        IDICT_NAME = 'idict' 
        IDICT_DESCRIPTION = 'Idict is an indexed dictionary of elements of a class defined in the element.'
        
        SCALAR = 'nn'
        SCALAR_NAME = 'scalar' 
        SCALAR_DESCRIPTION = 'Scalar is a scalar numerical value.'
        
        RVECTOR = 'nr'
        RVECTOR_NAME = 'rvector' 
        RVECTOR_DESCRIPTION = 'Rvector is a numerical row vector.'
        
        CVECTOR = 'nc'
        CVECTOR_NAME = 'cvector' 
        CVECTOR_DESCRIPTION = 'Cvector is a numerical column vector.'
        
        MATRIX = 'nm'
        MATRIX_NAME = 'matrix'
        MATRIX_DESCRIPTION = 'Matrix is a numerical matrix.'

        SMATRIX = 'ns'
        SMATRIX_NAME = 'smatrix'
        SMATRIX_DESCRIPTION = 'Smatrix is a numerical square matrix.'
        
        ADJACENCY = 'ad'
        ADJACENCY_NAME = 'adjacency'
        ADJACENCY_DESCRIPTION = 'Adjaciency is an adjaciency matrix or a 2D-cell array of adjacency matrices.'

        MEASURE = 'ms'
        MEASURE_NAME = 'measure'
        MEASURE_DESCRIPTION = 'Measure is the result of graph measure calculation.'
    end
    methods (Static)
        function formats = getFormats()
            formats = {
                Format.EMPTY
                Format.STRING
                Format.LOGICAL
                Format.OPTION
                Format.CLASS
                Format.CLASSLIST
                Format.ITEM
                Format.ITEMLIST
                Format.IDICT
                Format.SCALAR
                Format.RVECTOR
                Format.CVECTOR
                Format.MATRIX
                Format.SMATRIX
                Format.ADJACENCY
                Format.MEASURE
                };
        end
        function format_number = getFormatNumber()
            format_number = numel(Format.getFormats());
        end
        function check = existsFormat(format)
            if nargout == 1
                check = any(cellfun(@(x) isequal(format, x), Format.getFormats()));
            else
                assert( ...
                    Format.existsFormat(format), ...
                    [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], ...
                    ['The value ' tostring(format) ' is not a valid format. ' ...
                    'Admissible values are ' char(join(cellfun(@(x) ['''' x ''''], Format.getFormats(), 'UniformOutput', false))) '.'] ...
                    )
            end
        end
        function format_name = getFormatName(format)

            Format.existsFormat(format)

            switch format
                case Format.EMPTY
                    format_name = Format.EMPTY_NAME;
                case Format.STRING
                    format_name = Format.STRING_NAME;
                case Format.LOGICAL
                    format_name = Format.LOGICAL_NAME;
                case Format.OPTION
                    format_name = Format.OPTION_NAME;
                case Format.CLASS
                    format_name = Format.CLASS_NAME;
                case Format.CLASSLIST
                    format_name = Format.CLASSLIST_NAME;
                case Format.ITEM
                    format_name = Format.ITEM_NAME;
                case Format.ITEMLIST
                    format_name = Format.ITEMLIST_NAME;
                case Format.IDICT
                    format_name = Format.IDICT_NAME;
                case Format.SCALAR
                    format_name = Format.SCALAR_NAME;
                case Format.RVECTOR
                    format_name = Format.RVECTOR_NAME;
                case Format.CVECTOR
                    format_name = Format.CVECTOR_NAME;
                case Format.MATRIX
                    format_name = Format.MATRIX_NAME;
                case Format.SMATRIX
                    format_name = Format.SMATRIX_NAME;
                case Format.ADJACENCY
                    format_name = Format.ADJACENCY_NAME;
                case Format.MEASURE
                    format_name = Format.MEASURE_NAME;
            end
        end
        function format_description = getFormatDescription(format)
            
            Format.existsFormat(format);
            
            switch format
                case Format.EMPTY
                    format_description = Format.EMPTY_DESCRIPTION;
                case Format.STRING
                    format_description = Format.STRING_DESCRIPTION;
                case Format.LOGICAL
                    format_description = Format.LOGICAL_DESCRIPTION;
                case Format.OPTION
                    format_description = Format.OPTION_DESCRIPTION;                    
                case Format.CLASS
                    format_description = Format.CLASS_DESCRIPTION;                    
                case Format.CLASSLIST
                    format_description = Format.CLASSLIST_DESCRIPTION;                    
                case Format.ITEM
                    format_description = Format.ITEM_DESCRIPTION;
                case Format.ITEMLIST
                    format_description = Format.ITEMLIST_DESCRIPTION;
                case Format.IDICT
                    format_description = Format.IDICT_DESCRIPTION;
                case Format.SCALAR
                    format_description = Format.SCALAR_DESCRIPTION;
                case Format.RVECTOR
                    format_description = Format.RVECTOR_DESCRIPTION;
                case Format.CVECTOR
                    format_description = Format.CVECTOR_DESCRIPTION;
                case Format.MATRIX
                    format_description = Format.MATRIX_DESCRIPTION;
                case Format.SMATRIX
                    format_description = Format.SMATRIX_DESCRIPTION;
                case Format.ADJACENCY
                    format_description = Format.ADJACENCY_DESCRIPTION;
                case Format.MEASURE
                    format_description = Format.MEASURE_DESCRIPTION;
            end
        end
        function format_default = getFormatDefault(format)
            
            Format.existsFormat(format);
            
            switch format
                case Format.EMPTY
                    format_default = [];
                case Format.STRING
                    format_default = '';
                case Format.LOGICAL
                    format_default = false;
                case Format.OPTION
                    format_default = '';
                case Format.CLASS
                    format_default = 'Element';
                case Format.CLASSLIST
                    format_default = {};
                case Format.ITEM
                    format_default = NoValue();
                case Format.ITEMLIST
                    format_default = {};
                case Format.IDICT
                    format_default = IndexedDictionary();
                case Format.SCALAR
                    format_default = 0;
                case Format.RVECTOR
                    format_default = [];
                case Format.CVECTOR
                    format_default = [];
                case Format.MATRIX
                    format_default = [];
                case Format.SMATRIX
                    format_default = [];
                case Format.ADJACENCY
                    format_default = [];
                case Format.MEASURE
                    format_default = [];
            end
        end
        function format_check = checkFormat(format, value, settings)

            Format.existsFormat(format)
            
            switch format
                case Format.EMPTY
                    check = isempty(value);
                case Format.STRING
                    check = ischar(value);
                case Format.LOGICAL
                    check = islogical(value) && numel(value) == 1;
                case Format.OPTION
                    % setting must be a cell array of options
                    if nargin < 3 || isempty(settings)
                        options = {''};
                    else
                        options = settings;
                    end
                    check = ischar(value) && any(strcmpi(value, options));
                case Format.CLASS
                    % settings must be a class name of a subclass of Element (or Element itself)
                    if nargin < 3 || isempty(settings)
                        class = 'Element';
                    else
                        class = settings;
                    end
                    check = ischar(value) && ...
                        any(strcmp(class, subclasses('Element', [], [], true))) && ...
                        any(strcmp(value, subclasses(class, [], [], true)));
                case Format.CLASSLIST
                    % settings must be a class name of a subclass of Element (or Element itself)
                    if nargin < 3 || isempty(settings)
                        class = 'Element';
                    else
                        class = settings;
                    end
                    check = iscell(value) && ...
                        any(strcmp(class, subclasses('Element', [], [], true))) && ...
                        all(cellfun(@(x) any(strcmp(x, subclasses(class, [], [], true))), value));
                case Format.ITEM
                    % settings must be a class name of a subclass of Element (or Element itself)
                    if nargin < 3 || isempty(settings)
                        class = 'Element';
                    else
                        class = settings;
                    end
                    check = any(strcmp(class, subclasses('Element', [], [], true))) && ...
                        isa(value, class);
                case Format.ITEMLIST
                    % settings must be a class name of a subclass of Element (or Element itself)
                    if nargin < 3 || isempty(settings)
                        class = 'Element';
                    else
                        class = settings;
                    end
                    check = iscell(value) && ...
                        any(strcmp(class, subclasses('Element', [], [], true))) && ...
                        all(cellfun(@(x) isa(x, class), value));
                case Format.IDICT
                    % settings must be a class name of a subclass of Element (or Element itself)
                    if nargin < 3 || isempty(settings)
                        class = 'Element';
                    else
                        class = settings;
                    end
                    check = isa(value, 'IndexedDictionary') && ...
                        any(strcmp(class, subclasses('Element', [], [], true))) && ...
                        any(strcmp(value.getItemClass(), subclasses(class, [], [], true)));
                case Format.SCALAR
                    check = isnumeric(value) && isscalar(value);
                case Format.RVECTOR
                    check = isnumeric(value) && (isrow(value) || isempty(value));
                case Format.CVECTOR
                    check = isnumeric(value) && (iscolumn(value) || isempty(value));
                case Format.MATRIX
                    check = isnumeric(value) && ismatrix(value);
                case Format.SMATRIX
                    check = isnumeric(value) && ismatrix(value) && size(value, 1) == size(value, 2);
                case Format.ADJACENCY
                    % TODO implement settings ADJACENCY
                    check = ...
                        (isnumeric(value) && ismatrix(value) && size(value, 1) == size(value, 2)) ...  % if graph, adjacency matrix
                        || ...
                        (iscell(value) && ismatrix(value) && size(value, 1) == size(value, 2) && ... % all other graph types, square cell array of matrices
                        all(cellfun(@(a) size(a, 1) == size(a, 2), value(1:length(value)+1:end))));  % all submatrices in the diagonal are square
                case Format.MEASURE
                    % TODO implement settings MEASURE
                    check = true; % TODO implement check MEASURE
            end
            
            if nargout == 1
                format_check = check;
            else
                assert( ...
                    check, ...
                    [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], ...
                    ['The value ' tostring(value) ' is not a valid Format.' upper(Format.getFormatName(format)) '. ' ...
                    Format.getFormatDescription(format)] ...
                    )
            end
        end
    end
end