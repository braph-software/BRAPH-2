classdef Format < handle
    %Format defines the format of a property.
    % Static class that defines the possible formats of the properties of
    % the elements. It is a subclass of handle.
    %
    % The possible formats are:
    %
    %  EMPTY        Empty has an empty value and is typically used as a
    %               result to execute some code. 
    %
    %  STRING       String is a char array.
    %
    %  LOGICAL      Logical is a boolean value.
    %
    %  OPTION       Option is a char array representing an option within a
    %               set defined in the element. 
    %               Sttings: cell array of chars representing the options,
    %               e.g., {'plus', 'minus', 'zero'}.
    %
    %  CLASS        Class is a char array corresponding to an element class.
    %               Settings: class name of a subclass of Element (or
    %               Element itself).
    %
    %  CLASSLIST    ClassList is a cell array with char arrays
    %               corresponding to element classes. 
    %               Settings: class name of a subclass of Element (or
    %               Element itself).
    %
    %  ITEM         Item is a pointer to an element of a class defined in
    %               the element. 
    %               Settings: class name of a subclass of Element (or
    %               Element itself).
    %
    %  ITEMLIST     ItemList is a cell array with pointers to elements of a
    %               class defined in the element. 
    %               Settings: class name of a subclass of Element (or
    %               Element itself).
    %
    %  IDICT        Idict is an indexed dictionary of elements of a class
    %               defined in the element. 
    %               Settings: class name of a subclass of Element (or
    %               Element itself).
    %
    %  SCALAR       Scalar is a scalar numerical value.
    %
    %  RVECTOR      Rvector is a numerical row vector.
    %
    %  CVECTOR      Cvector is a numerical column vector.
    %
    %  MATRIX       Matrix is a numerical matrix.
    %
    %  SMATRIX      Smatrix is a numerical square matrix.
    %
    %  CELL         Cell is a 2D cell array of numeric data, typically used
    %               for adjaciency matrices and measures.
    %
    % Format properties (Constant):
    %
    %  EMPTY = 'em'
    %  EMPTY_NAME = 'empty' 
    %  EMPTY_DESCRIPTION
    % 
    %  STRING = 'st'
    %  STRING_NAME = 'string' 
    %  STRING_DESCRIPTION
    % 
    %  LOGICAL = 'lo'
    %  LOGICAL_NAME = 'logical'
    %  LOGICAL_DESCRIPTION = 'Logical is a boolean value.'
    % 
    %  OPTION = 'op'
    %  OPTION_NAME = 'option' 
    %  OPTION_DESCRIPTION
    % 
    %  CLASS = 'ca'
    %  CLASS_NAME = 'class'
    %  CLASS_DESCRIPTION
    % 
    %  CLASSLIST = 'cl'
    %  CLASSLIST_NAME = 'classlist'
    %  CLASSLIST_DESCRIPTION
    % 
    %  ITEM = 'it'
    %  ITEM_NAME = 'item'
    %  ITEM_DESCRIPTION
    % 
    %  ITEMLIST = 'il'
    %  ITEMLIST_NAME = 'itemlist'
    %  ITEMLIST_DESCRIPTION
    % 
    %  IDICT = 'di'
    %  IDICT_NAME = 'idict' 
    %  IDICT_DESCRIPTION
    % 
    %  SCALAR = 'nn'
    %  SCALAR_NAME = 'scalar' 
    %  SCALAR_DESCRIPTION
    % 
    %  RVECTOR = 'nr'
    %  RVECTOR_NAME = 'rvector' 
    %  RVECTOR_DESCRIPTION
    % 
    %  CVECTOR = 'nc'
    %  CVECTOR_NAME = 'cvector' 
    %  CVECTOR_DESCRIPTION
    % 
    %  MATRIX = 'nm'
    %  MATRIX_NAME = 'matrix'
    %  MATRIX_DESCRIPTION
    % 
    %  SMATRIX = 'ns'
    %  SMATRIX_NAME = 'smatrix'
    %  SMATRIX_DESCRIPTION
    % 
    %  CELL = 'll'
    %  CELL_NAME = 'cell'
    %  CELL_DESCRIPTION
    %
    % Format methods (Static):
    %  getFormats - returns the list of formats
    %  getFormatNumber - returns the number of formats
    %  existsFormat - returns whether a format exists/error
    %  getFormatName - returns the name of a format
    %  getFormatDescription - returns the description of a format
    %  getFormatSettings - returns the settings for a format
    %  getFormatDefault - returns the default value for a format
    %  checkFormat - returns whether a value format is correct/error
    %
    % See also Element, Category.
    
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
        
        CELL = 'll'
        CELL_NAME = 'cell'
        CELL_DESCRIPTION = 'Cell is a 2D cell array of numeric data, typically used for adjaciency matrices and measures.'
    end
    methods (Static)
        function formats = getFormats()
            %GETFORMATS returns the list of formats.
            %
            % FORMATS = GETFORMATS() returns the list of formats.
            %
            % See also getFormatNumber, existsFormat.
            
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
                Format.CELL
                };
        end
        function format_number = getFormatNumber()
            %GETFORMATNUMBER returns the number of formats.
            %
            % N = GETFORMATNUMBER() returns the number of formats (15).
            %
            % See also getFormats, existsFormat.

            format_number = numel(Format.getFormats());
        end
        function check = existsFormat(format)
            %EXISTSFORMAT returns whether a format exists/error.
            %
            % CHECK = EXISTSFORMAT(FORMAT) returns whether format
            %  FORMAT exists.
            %
            % EXISTSFORMAT(FORMAT) throws an error if format FORMAT
            %  does not exist.
            %  Error id: [BRAPH2:Format:WrongInput].
            %
            % See also getFormats, getFormatNumber.

            if nargout == 1
                check = any(cellfun(@(x) isequal(format, x), Format.getFormats()));
            else
                assert( ...
                    Format.existsFormat(format), ...
                    [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT ' ' ...
                    'The value ' tostring(format) ' is not a valid format. ' ...
                    'Admissible values are ' char(join(cellfun(@(x) ['''' x ''''], Format.getFormats(), 'UniformOutput', false))) '.'] ...
                    )
            end
        end
        function format_name = getFormatName(format)
            %GETFORMATNAME returns the name of a format.
            %
            % NAME = GETFORMATNAME(FORMAT) returns the name of format
            %  FORMAT.
            %
            % A list of all format names can be obtained using
            %  <a href="matlab:cellfun(@(x) Format.getFormatName(x), Format.getFormats(), 'UniformOutput', false)">cellfun(@(x) Format.getFormatName(x), Format.getFormats(), 'UniformOutput', false)</a>
            %
            % See also getFormats, getFormatDescription, getFormatSettings, getFormatDefault, checkFormat.

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
                case Format.CELL
                    format_name = Format.CELL_NAME;
                otherwise
                    Format.existsFormat(format) % error because format does not exist
            end
        end
        function format_description = getFormatDescription(format, format_settings)
            %GETFORMATDESCRIPTION returns the description of a format.
            %
            % STR = GETFORMATDESCRIPTION(FORMAT) returns the description
            %  of format FORMAT with default settings.
            %
            % STR = GETFORMATDESCRIPTION(FORMAT, SETTINGS) returns the description
            %  adappted for settings SETTINGS.
            %
            % A list of all format descriptions with default settings can be obtained using
            %  <a href="matlab:cellfun(@(x) Format.getFormatDescription(x), Format.getFormats(), 'UniformOutput', false)">cellfun(@(x) Format.getFormatDescription(x), Format.getFormats(), 'UniformOutput', false)</a>
            %
            % See also getFormats, getFormatName, getFormatSettings, getFormatDefault, checkFormat.
            
            switch format
                case Format.EMPTY
                    format_description = Format.EMPTY_DESCRIPTION;
                case Format.STRING
                    format_description = Format.STRING_DESCRIPTION;
                case Format.LOGICAL
                    format_description = Format.LOGICAL_DESCRIPTION;
                case Format.OPTION
                    format_description = Format.OPTION_DESCRIPTION;
                    if nargin > 1 && ~isempty(format_settings)
                        format_description = [format_description ' ' ...
                            ['Admissible options are ' char(join(cellfun(@(x) ['''' x ''''], format_settings, 'UniformOutput', false))) '.'] ...
                            ];                        
                    end
                case Format.CLASS
                    format_description = Format.CLASS_DESCRIPTION;
                    if nargin > 1 && ~isempty(format_settings)
                        format_description = [format_description ' ' ...
                            'The element class must be ' format_settings ' or one of its subclasses.' ...
                            ];
                    end
                case Format.CLASSLIST
                    format_description = Format.CLASSLIST_DESCRIPTION;
                    if nargin > 1 && ~isempty(format_settings)
                        format_description = [format_description ' ' ...
                            'All element classes must be ' format_settings ' or one of its subclasses.' ...
                            ];
                    end
                case Format.ITEM
                    format_description = Format.ITEM_DESCRIPTION;
                    if nargin > 1 && ~isempty(format_settings)
                        format_description = [format_description ' ' ...
                            'The item must be of class ' format_settings ' or one of its subclasses.' ...
                            ];                        
                    end
                case Format.ITEMLIST
                    format_description = Format.ITEMLIST_DESCRIPTION;
                    if nargin > 1 && ~isempty(format_settings)
                        format_description = [format_description ' ' ...
                            'All items must be of class ' format_settings ' or one of its subclasses.' ...
                            ];                        
                    end
                case Format.IDICT
                    format_description = Format.IDICT_DESCRIPTION;
                    if nargin > 1 && ~isempty(format_settings)
                        format_description = [format_description ' ' ...
                            'The dictionary items must be of class ' format_settings ' or one of its subclasses.' ...
                            ];                        
                    end
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
                case Format.CELL
                    format_description = Format.CELL_DESCRIPTION;
                otherwise
                    Format.existsFormat(format) % error because format does not exist
            end
        end
        function format_settings = getFormatSettings(format, format_settings)
            %GETFORMATSETTINGS returns the settings of a format.
            %
            % SETTINGS = GETFORMATSETTINGS(FORMAT) returns the default
            %  settings of format FORMAT.
            %
            % SETTINGS = GETFORMATSETTINGS(FORMAT, SETTINGS) verifies and
            %  returns the default SETTINGS.
            %
            % A list of all format descriptions with default settings can be obtained using
            %  <a href="matlab:cellfun(@(x) Format.getFormatSettings(x), Format.getFormats(), 'UniformOutput', false)">cellfun(@(x) Format.getFormatSettings(x), Format.getFormats(), 'UniformOutput', false)</a>
            %
            % See also getFormats, getFormatName, getFormatDescription, getFormatDefault, checkFormat.
            
            switch format
                case Format.EMPTY
                    format_settings = '';
                case Format.STRING
                    format_settings = '';
                case Format.LOGICAL
                    format_settings = '';
                case Format.OPTION
                    % setting must be a cell array of options
                    if nargin < 2 || isempty(format_settings)
                        format_settings = {''};
                    end
                case Format.CLASS
                    % settings must be a class name of a subclass of Element (or Element itself)
                    if nargin < 2 || isempty(format_settings)
                        format_settings = 'Element';
                    end
                case Format.CLASSLIST
                    % settings must be a class name of a subclass of Element (or Element itself)
                    if nargin < 2 || isempty(format_settings)
                        format_settings = 'Element';
                    end
                case Format.ITEM
                    % settings must be a class name of a subclass of Element (or Element itself)
                    if nargin < 2 || isempty(format_settings)
                        format_settings = 'Element';
                    end
                case Format.ITEMLIST
                    % settings must be a class name of a subclass of Element (or Element itself)
                    if nargin < 2 || isempty(format_settings)
                        format_settings = 'Element';
                    end
                case Format.IDICT
                    % settings must be a class name of a subclass of Element (or Element itself)
                    if nargin < 2 || isempty(format_settings)
                        format_settings = 'Element';
                    end
                case Format.SCALAR
                    format_settings = '';
                case Format.RVECTOR
                    format_settings = '';
                case Format.CVECTOR
                    format_settings = '';
                case Format.MATRIX
                    format_settings = '';
                case Format.SMATRIX
                    format_settings = '';
                case Format.CELL
                    format_settings = '';
                otherwise
                    Format.existsFormat(format) % error because format does not exist
            end            
        end
        function format_default = getFormatDefault(format, format_settings)
            %GETFORMATDEFAULT returns the default value for a format.
            %
            % DEFAULT = GETFORMATDEFAULT(FORMAT) returns the default value
            %  for a format FORMAT.
            %
            % DEFAULT = GETFORMATDEFAULT(FORMAT, SETTINGS) returns the
            %  default value adappted for settings SETTINGS.
            % 
            % A list of all format defaults with default settings can be obtained using
            %  <a href="matlab:cellfun(@(x) Format.getFormatDefault(x), Format.getFormats(), 'UniformOutput', false)">cellfun(@(x) Format.getFormatDefault(x), Format.getFormats(), 'UniformOutput', false)</a>
            %
            % See also getFormats, getFormatName, getFormatDescription, getFormatSettings, checkFormat.
            
            switch format
                case Format.EMPTY
                    format_default = [];
                case Format.STRING
                    format_default = '';
                case Format.LOGICAL
                    format_default = false;
                case Format.OPTION
                    % setting must be a cell array of options
                    if nargin < 2 || isempty(format_settings)
                        format_default = '';
                    else
                        format_default = format_settings{1};
                    end
                case Format.CLASS
                    % settings must be a class name of a subclass of Element (or Element itself)
                    if nargin < 2 || isempty(format_settings)
                        format_default = 'Element';
                    else
                        format_default = format_settings;                        
                    end
                case Format.CLASSLIST
                    % settings must be a class name of a subclass of Element (or Element itself)
                    if nargin < 2 || isempty(format_settings)
                        format_default = {'Element'};
                    else
                        format_default = {format_settings{1}};
                    end
                case Format.ITEM
                    % settings must be a class name of a subclass of Element (or Element itself)
                    if nargin < 2 || isempty(format_settings)
                        format_default = NoValue.getNoValue();
                    else
                        format_default = eval([format_settings '()']);
                    end
                case Format.ITEMLIST
                    % settings must be a class name of a subclass of Element (or Element itself)
                    if nargin < 2 || isempty(format_settings)
                        format_default = {};
                    else
                        format_default = {};
                    end
                case Format.IDICT
                    % settings must be a class name of a subclass of Element (or Element itself)
                    if nargin < 2 || isempty(format_settings)
                        format_default = IndexedDictionary();
                    else
                        format_default = IndexedDictionary('IT_CLASS', format_settings);
                    end
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
                case Format.CELL
                    format_default = {};
                otherwise
                    Format.existsFormat(format) % error because format does not exist
            end
        end
        function format_check = checkFormat(format, value, format_settings)
            %CHECKFORMAT returns whether a value format is correct/error.
            %
            % CHECK = CHECKFORMAT(FORMAT, VAlUE) returns whether the value
            %  VALUE has the format FORMAT is correct.
            %
            % CHECK = CHECKFORMAT(FORMAT, VAlUE, SETTINGS) takes into
            %  account the format settings SETTINGS.
            %
            % CHECKFORMAT(FORMAT, VAlUE[, SETTINGS]) throws an error if the
            %  VALUE does not have format FORMAT.
            %  Error id: [BRAPH2:Format:WrongInput]
            %
            % See also getFormats, getFormatName, getFormatDescription, getFormatSettings, getFormatDefault.

            if nargin < 3 || isempty(format_settings)
                format_settings = '';
            end
            
            switch format
                case Format.EMPTY
                    check = isempty(value);
                case Format.STRING
                    check = ischar(value);
                case Format.LOGICAL
                    check = islogical(value) && numel(value) == 1;
                case Format.OPTION
                    % setting must be a cell array of options
                    options = Format.getFormatSettings(Format.OPTION, format_settings);
                    check = ischar(value) && any(strcmpi(value, options));
                case Format.CLASS
                    % settings must be a class name of a subclass of Element (or Element itself)
                    class = Format.getFormatSettings(Format.CLASS, format_settings);
                    check = ischar(value) && ...
                        any(strcmp(class, subclasses('Element', [], [], true))) && ...
                        any(strcmp(value, subclasses(class, [], [], true)));
                case Format.CLASSLIST
                    % settings must be a class name of a subclass of Element (or Element itself)
                    class = Format.getFormatSettings(Format.CLASSLIST, format_settings);
                    check = iscell(value) && ...
                        any(strcmp(class, subclasses('Element', [], [], true))) && ...
                        all(cellfun(@(x) any(strcmp(x, subclasses(class, [], [], true))), value));
                case Format.ITEM
                    % settings must be a class name of a subclass of Element (or Element itself)
                    class = Format.getFormatSettings(Format.ITEM, format_settings);
                    check = any(strcmp(class, subclasses('Element', [], [], true))) && ...
                        isa(value, class);
                case Format.ITEMLIST
                    % settings must be a class name of a subclass of Element (or Element itself)
                    class = Format.getFormatSettings(Format.ITEMLIST, format_settings);
                    check = iscell(value) && ...
                        any(strcmp(class, subclasses('Element', [], [], true))) && ...
                        all(cellfun(@(x) isa(x, class), value));
                case Format.IDICT
                    % settings must be a class name of a subclass of Element (or Element itself)
                    class = Format.getFormatSettings(Format.IDICT, format_settings);
                    check = isa(value, 'IndexedDictionary') && ...
                        any(strcmp(class, subclasses('Element', [], [], true))) && ...
                        any(strcmp(value.get('IT_CLASS'), subclasses(class, [], [], true)));
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
                case Format.CLASS
                    check = iscell(value) && all(cellfun(@(x) isnumeric(x), value(:)));
                otherwise
                    Format.existsFormat(format) % error because format does not exist
            end
            
            if nargout == 1
                format_check = check;
            else
                assert( ...
                    check, ...
                    [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT ' ' ...
                    'The value ' tostring(value) ' is not a valid Format.' upper(Format.getFormatName(format)) '. ' ...
                    Format.getFormatDescription(format)] ...
                    )
            end
        end
    end
end