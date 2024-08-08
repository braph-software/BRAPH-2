classdef IndexedDictionary < ConcreteElement
	%IndexedDictionary is an indexed dictionary.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% An Indexed Dictionary (IndexedDictionary) provides the methods necessary 
	%  to handle data in an indexed dictionary. It contains and manages an 
	%  ordered list of couples {KEY, IT}, where KEY is a unique alphanumeric key 
	%  (a string) provided by a property of format STRING or CLASS and of 
	%  category PARAMETER or DATA, and IT is an element of a class defined in the 
	%  constructor using the property IT_CLASS.
	%
	% IndexedDictionary methods (constructor):
	%  IndexedDictionary - constructor
	%
	% IndexedDictionary methods:
	%  set - sets values of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns the value of a property and memorizes it
	%             (for RESULT, QUERY, and EVANESCENT properties)
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% IndexedDictionary methods (display):
	%  tostring - string with information about the indexed dictionary
	%  disp - displays information about the indexed dictionary
	%  tree - displays the tree of the indexed dictionary
	%
	% IndexedDictionary methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two indexed dictionary are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the indexed dictionary
	%
	% IndexedDictionary methods (save/load, Static):
	%  save - saves BRAPH2 indexed dictionary as b2 file
	%  load - loads a BRAPH2 indexed dictionary from a b2 file
	%
	% IndexedDictionary method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the indexed dictionary
	%
	% IndexedDictionary method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the indexed dictionary
	%
	% IndexedDictionary methods (inspection, Static):
	%  getClass - returns the class of the indexed dictionary
	%  getSubclasses - returns all subclasses of IndexedDictionary
	%  getProps - returns the property list of the indexed dictionary
	%  getPropNumber - returns the property number of the indexed dictionary
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditioned default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% IndexedDictionary methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% IndexedDictionary methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% IndexedDictionary methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% IndexedDictionary methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatTag - returns the tag of a format
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% To print full list of constants, click here <a href="matlab:metaclass = ?IndexedDictionary; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">IndexedDictionary constants</a>.
	%
	
	properties (Constant) % properties
		IT_CLASS = ConcreteElement.getPropNumber() + 1;
		IT_CLASS_TAG = 'IT_CLASS';
		IT_CLASS_CATEGORY = Category.PARAMETER;
		IT_CLASS_FORMAT = Format.CLASS;
		
		IT_KEY = ConcreteElement.getPropNumber() + 2;
		IT_KEY_TAG = 'IT_KEY';
		IT_KEY_CATEGORY = Category.PARAMETER;
		IT_KEY_FORMAT = Format.SCALAR;
		
		IT_LIST = ConcreteElement.getPropNumber() + 3;
		IT_LIST_TAG = 'IT_LIST';
		IT_LIST_CATEGORY = Category.DATA;
		IT_LIST_FORMAT = Format.ITEMLIST;
		
		LENGTH = ConcreteElement.getPropNumber() + 4;
		LENGTH_TAG = 'LENGTH';
		LENGTH_CATEGORY = Category.QUERY;
		LENGTH_FORMAT = Format.SCALAR;
		
		CONTAINS = ConcreteElement.getPropNumber() + 5;
		CONTAINS_TAG = 'CONTAINS';
		CONTAINS_CATEGORY = Category.QUERY;
		CONTAINS_FORMAT = Format.LOGICAL;
		
		CONTAINS_INDEX = ConcreteElement.getPropNumber() + 6;
		CONTAINS_INDEX_TAG = 'CONTAINS_INDEX';
		CONTAINS_INDEX_CATEGORY = Category.QUERY;
		CONTAINS_INDEX_FORMAT = Format.LOGICAL;
		
		CONTAINS_KEY = ConcreteElement.getPropNumber() + 7;
		CONTAINS_KEY_TAG = 'CONTAINS_KEY';
		CONTAINS_KEY_CATEGORY = Category.QUERY;
		CONTAINS_KEY_FORMAT = Format.LOGICAL;
		
		CONTAINS_IT = ConcreteElement.getPropNumber() + 8;
		CONTAINS_IT_TAG = 'CONTAINS_IT';
		CONTAINS_IT_CATEGORY = Category.QUERY;
		CONTAINS_IT_FORMAT = Format.LOGICAL;
		
		INDEX = ConcreteElement.getPropNumber() + 9;
		INDEX_TAG = 'INDEX';
		INDEX_CATEGORY = Category.QUERY;
		INDEX_FORMAT = Format.SCALAR;
		
		INDEX_FROM_KEY = ConcreteElement.getPropNumber() + 10;
		INDEX_FROM_KEY_TAG = 'INDEX_FROM_KEY';
		INDEX_FROM_KEY_CATEGORY = Category.QUERY;
		INDEX_FROM_KEY_FORMAT = Format.SCALAR;
		
		INDEX_FROM_IT = ConcreteElement.getPropNumber() + 11;
		INDEX_FROM_IT_TAG = 'INDEX_FROM_IT';
		INDEX_FROM_IT_CATEGORY = Category.QUERY;
		INDEX_FROM_IT_FORMAT = Format.SCALAR;
		
		KEYS = ConcreteElement.getPropNumber() + 12;
		KEYS_TAG = 'KEYS';
		KEYS_CATEGORY = Category.QUERY;
		KEYS_FORMAT = Format.STRINGLIST;
		
		KEY = ConcreteElement.getPropNumber() + 13;
		KEY_TAG = 'KEY';
		KEY_CATEGORY = Category.QUERY;
		KEY_FORMAT = Format.STRING;
		
		KEY_FROM_INDEX = ConcreteElement.getPropNumber() + 14;
		KEY_FROM_INDEX_TAG = 'KEY_FROM_INDEX';
		KEY_FROM_INDEX_CATEGORY = Category.QUERY;
		KEY_FROM_INDEX_FORMAT = Format.STRING;
		
		KEY_FROM_IT = ConcreteElement.getPropNumber() + 15;
		KEY_FROM_IT_TAG = 'KEY_FROM_IT';
		KEY_FROM_IT_CATEGORY = Category.QUERY;
		KEY_FROM_IT_FORMAT = Format.STRING;
		
		IT = ConcreteElement.getPropNumber() + 16;
		IT_TAG = 'IT';
		IT_CATEGORY = Category.QUERY;
		IT_FORMAT = Format.ITEM;
		
		IT_FROM_INDEX = ConcreteElement.getPropNumber() + 17;
		IT_FROM_INDEX_TAG = 'IT_FROM_INDEX';
		IT_FROM_INDEX_CATEGORY = Category.QUERY;
		IT_FROM_INDEX_FORMAT = Format.ITEM;
		
		IT_FROM_KEY = ConcreteElement.getPropNumber() + 18;
		IT_FROM_KEY_TAG = 'IT_FROM_KEY';
		IT_FROM_KEY_CATEGORY = Category.QUERY;
		IT_FROM_KEY_FORMAT = Format.ITEM;
		
		ADD = ConcreteElement.getPropNumber() + 19;
		ADD_TAG = 'ADD';
		ADD_CATEGORY = Category.QUERY;
		ADD_FORMAT = Format.EMPTY;
		
		REMOVE = ConcreteElement.getPropNumber() + 20;
		REMOVE_TAG = 'REMOVE';
		REMOVE_CATEGORY = Category.QUERY;
		REMOVE_FORMAT = Format.EMPTY;
		
		REPLACE = ConcreteElement.getPropNumber() + 21;
		REPLACE_TAG = 'REPLACE';
		REPLACE_CATEGORY = Category.QUERY;
		REPLACE_FORMAT = Format.EMPTY;
		
		REPLACE_KEY = ConcreteElement.getPropNumber() + 22;
		REPLACE_KEY_TAG = 'REPLACE_KEY';
		REPLACE_KEY_CATEGORY = Category.QUERY;
		REPLACE_KEY_FORMAT = Format.EMPTY;
		
		REPLACE_IT = ConcreteElement.getPropNumber() + 23;
		REPLACE_IT_TAG = 'REPLACE_IT';
		REPLACE_IT_CATEGORY = Category.QUERY;
		REPLACE_IT_FORMAT = Format.EMPTY;
		
		INVERT = ConcreteElement.getPropNumber() + 24;
		INVERT_TAG = 'INVERT';
		INVERT_CATEGORY = Category.QUERY;
		INVERT_FORMAT = Format.EMPTY;
		
		MOVE_TO = ConcreteElement.getPropNumber() + 25;
		MOVE_TO_TAG = 'MOVE_TO';
		MOVE_TO_CATEGORY = Category.QUERY;
		MOVE_TO_FORMAT = Format.EMPTY;
		
		REMOVE_ALL = ConcreteElement.getPropNumber() + 26;
		REMOVE_ALL_TAG = 'REMOVE_ALL';
		REMOVE_ALL_CATEGORY = Category.QUERY;
		REMOVE_ALL_FORMAT = Format.RVECTOR;
		
		MOVE_UP = ConcreteElement.getPropNumber() + 27;
		MOVE_UP_TAG = 'MOVE_UP';
		MOVE_UP_CATEGORY = Category.QUERY;
		MOVE_UP_FORMAT = Format.RVECTOR;
		
		MOVE_DOWN = ConcreteElement.getPropNumber() + 28;
		MOVE_DOWN_TAG = 'MOVE_DOWN';
		MOVE_DOWN_CATEGORY = Category.QUERY;
		MOVE_DOWN_FORMAT = Format.RVECTOR;
		
		MOVE_TO_TOP = ConcreteElement.getPropNumber() + 29;
		MOVE_TO_TOP_TAG = 'MOVE_TO_TOP';
		MOVE_TO_TOP_CATEGORY = Category.QUERY;
		MOVE_TO_TOP_FORMAT = Format.EMPTY;
		
		MOVE_TO_BOTTOM = ConcreteElement.getPropNumber() + 30;
		MOVE_TO_BOTTOM_TAG = 'MOVE_TO_BOTTOM';
		MOVE_TO_BOTTOM_CATEGORY = Category.QUERY;
		MOVE_TO_BOTTOM_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function idict = IndexedDictionary(varargin)
			%IndexedDictionary() creates a indexed dictionary.
			%
			% IndexedDictionary(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% IndexedDictionary(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			idict = idict@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function idict_class = getClass()
			%GETCLASS returns the class of the indexed dictionary.
			%
			% CLASS = IndexedDictionary.GETCLASS() returns the class 'IndexedDictionary'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IDICT.GETCLASS() returns the class of the indexed dictionary IDICT.
			%  CLASS = Element.GETCLASS(IDICT) returns the class of 'IDICT'.
			%  CLASS = Element.GETCLASS('IndexedDictionary') returns 'IndexedDictionary'.
			%
			% Note that the Element.GETCLASS(IDICT) and Element.GETCLASS('IndexedDictionary')
			%  are less computationally efficient.
			
			idict_class = 'IndexedDictionary';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the indexed dictionary.
			%
			% LIST = IndexedDictionary.GETSUBCLASSES() returns all subclasses of 'IndexedDictionary'.
			%
			% Alternative forms to call this method are:
			%  LIST = IDICT.GETSUBCLASSES() returns all subclasses of the indexed dictionary IDICT.
			%  LIST = Element.GETSUBCLASSES(IDICT) returns all subclasses of 'IDICT'.
			%  LIST = Element.GETSUBCLASSES('IndexedDictionary') returns all subclasses of 'IndexedDictionary'.
			%
			% Note that the Element.GETSUBCLASSES(IDICT) and Element.GETSUBCLASSES('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('IndexedDictionary', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of indexed dictionary.
			%
			% PROPS = IndexedDictionary.GETPROPS() returns the property list of indexed dictionary
			%  as a row vector.
			%
			% PROPS = IndexedDictionary.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IDICT.GETPROPS([CATEGORY]) returns the property list of the indexed dictionary IDICT.
			%  PROPS = Element.GETPROPS(IDICT[, CATEGORY]) returns the property list of 'IDICT'.
			%  PROPS = Element.GETPROPS('IndexedDictionary'[, CATEGORY]) returns the property list of 'IndexedDictionary'.
			%
			% Note that the Element.GETPROPS(IDICT) and Element.GETPROPS('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						IndexedDictionary.IT_CLASS ...
						IndexedDictionary.IT_KEY ...
						IndexedDictionary.IT_LIST ...
						IndexedDictionary.LENGTH ...
						IndexedDictionary.CONTAINS ...
						IndexedDictionary.CONTAINS_INDEX ...
						IndexedDictionary.CONTAINS_KEY ...
						IndexedDictionary.CONTAINS_IT ...
						IndexedDictionary.INDEX ...
						IndexedDictionary.INDEX_FROM_KEY ...
						IndexedDictionary.INDEX_FROM_IT ...
						IndexedDictionary.KEYS ...
						IndexedDictionary.KEY ...
						IndexedDictionary.KEY_FROM_INDEX ...
						IndexedDictionary.KEY_FROM_IT ...
						IndexedDictionary.IT ...
						IndexedDictionary.IT_FROM_INDEX ...
						IndexedDictionary.IT_FROM_KEY ...
						IndexedDictionary.ADD ...
						IndexedDictionary.REMOVE ...
						IndexedDictionary.REPLACE ...
						IndexedDictionary.REPLACE_KEY ...
						IndexedDictionary.REPLACE_IT ...
						IndexedDictionary.INVERT ...
						IndexedDictionary.MOVE_TO ...
						IndexedDictionary.REMOVE_ALL ...
						IndexedDictionary.MOVE_UP ...
						IndexedDictionary.MOVE_DOWN ...
						IndexedDictionary.MOVE_TO_TOP ...
						IndexedDictionary.MOVE_TO_BOTTOM ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						IndexedDictionary.IT_CLASS ...
						IndexedDictionary.IT_KEY ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						IndexedDictionary.IT_LIST ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						IndexedDictionary.LENGTH ...
						IndexedDictionary.CONTAINS ...
						IndexedDictionary.CONTAINS_INDEX ...
						IndexedDictionary.CONTAINS_KEY ...
						IndexedDictionary.CONTAINS_IT ...
						IndexedDictionary.INDEX ...
						IndexedDictionary.INDEX_FROM_KEY ...
						IndexedDictionary.INDEX_FROM_IT ...
						IndexedDictionary.KEYS ...
						IndexedDictionary.KEY ...
						IndexedDictionary.KEY_FROM_INDEX ...
						IndexedDictionary.KEY_FROM_IT ...
						IndexedDictionary.IT ...
						IndexedDictionary.IT_FROM_INDEX ...
						IndexedDictionary.IT_FROM_KEY ...
						IndexedDictionary.ADD ...
						IndexedDictionary.REMOVE ...
						IndexedDictionary.REPLACE ...
						IndexedDictionary.REPLACE_KEY ...
						IndexedDictionary.REPLACE_IT ...
						IndexedDictionary.INVERT ...
						IndexedDictionary.MOVE_TO ...
						IndexedDictionary.REMOVE_ALL ...
						IndexedDictionary.MOVE_UP ...
						IndexedDictionary.MOVE_DOWN ...
						IndexedDictionary.MOVE_TO_TOP ...
						IndexedDictionary.MOVE_TO_BOTTOM ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of indexed dictionary.
			%
			% N = IndexedDictionary.GETPROPNUMBER() returns the property number of indexed dictionary.
			%
			% N = IndexedDictionary.GETPROPNUMBER(CATEGORY) returns the property number of indexed dictionary
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IDICT.GETPROPNUMBER([CATEGORY]) returns the property number of the indexed dictionary IDICT.
			%  N = Element.GETPROPNUMBER(IDICT) returns the property number of 'IDICT'.
			%  N = Element.GETPROPNUMBER('IndexedDictionary') returns the property number of 'IndexedDictionary'.
			%
			% Note that the Element.GETPROPNUMBER(IDICT) and Element.GETPROPNUMBER('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(IndexedDictionary.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in indexed dictionary/error.
			%
			% CHECK = IndexedDictionary.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IDICT.EXISTSPROP(PROP) checks whether PROP exists for IDICT.
			%  CHECK = Element.EXISTSPROP(IDICT, PROP) checks whether PROP exists for IDICT.
			%  CHECK = Element.EXISTSPROP(IndexedDictionary, PROP) checks whether PROP exists for IndexedDictionary.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:IndexedDictionary:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IDICT.EXISTSPROP(PROP) throws error if PROP does NOT exist for IDICT.
			%   Error id: [BRAPH2:IndexedDictionary:WrongInput]
			%  Element.EXISTSPROP(IDICT, PROP) throws error if PROP does NOT exist for IDICT.
			%   Error id: [BRAPH2:IndexedDictionary:WrongInput]
			%  Element.EXISTSPROP(IndexedDictionary, PROP) throws error if PROP does NOT exist for IndexedDictionary.
			%   Error id: [BRAPH2:IndexedDictionary:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IDICT) and Element.EXISTSPROP('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == IndexedDictionary.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for IndexedDictionary.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in indexed dictionary/error.
			%
			% CHECK = IndexedDictionary.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IDICT.EXISTSTAG(TAG) checks whether TAG exists for IDICT.
			%  CHECK = Element.EXISTSTAG(IDICT, TAG) checks whether TAG exists for IDICT.
			%  CHECK = Element.EXISTSTAG(IndexedDictionary, TAG) checks whether TAG exists for IndexedDictionary.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:IndexedDictionary:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IDICT.EXISTSTAG(TAG) throws error if TAG does NOT exist for IDICT.
			%   Error id: [BRAPH2:IndexedDictionary:WrongInput]
			%  Element.EXISTSTAG(IDICT, TAG) throws error if TAG does NOT exist for IDICT.
			%   Error id: [BRAPH2:IndexedDictionary:WrongInput]
			%  Element.EXISTSTAG(IndexedDictionary, TAG) throws error if TAG does NOT exist for IndexedDictionary.
			%   Error id: [BRAPH2:IndexedDictionary:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IDICT) and Element.EXISTSTAG('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			indexeddictionary_tag_list = cellfun(@(x) IndexedDictionary.getPropTag(x), num2cell(IndexedDictionary.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, indexeddictionary_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for IndexedDictionary.'] ...
					)
			end
		end
		function prop = getPropProp(pointer)
			%GETPROPPROP returns the property number of a property.
			%
			% PROP = Element.GETPROPPROP(PROP) returns PROP, i.e., the 
			%  property number of the property PROP.
			%
			% PROP = Element.GETPROPPROP(TAG) returns the property number 
			%  of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PROPERTY = IDICT.GETPROPPROP(POINTER) returns property number of POINTER of IDICT.
			%  PROPERTY = Element.GETPROPPROP(IndexedDictionary, POINTER) returns property number of POINTER of IndexedDictionary.
			%  PROPERTY = IDICT.GETPROPPROP(IndexedDictionary, POINTER) returns property number of POINTER of IndexedDictionary.
			%
			% Note that the Element.GETPROPPROP(IDICT) and Element.GETPROPPROP('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				indexeddictionary_tag_list = cellfun(@(x) IndexedDictionary.getPropTag(x), num2cell(IndexedDictionary.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, indexeddictionary_tag_list)); % tag = pointer
			else % numeric
				prop = pointer;
			end
		end
		function tag = getPropTag(pointer)
			%GETPROPTAG returns the tag of a property.
			%
			% TAG = Element.GETPROPTAG(PROP) returns the tag TAG of the 
			%  property PROP.
			%
			% TAG = Element.GETPROPTAG(TAG) returns TAG, i.e. the tag of 
			%  the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  TAG = IDICT.GETPROPTAG(POINTER) returns tag of POINTER of IDICT.
			%  TAG = Element.GETPROPTAG(IndexedDictionary, POINTER) returns tag of POINTER of IndexedDictionary.
			%  TAG = IDICT.GETPROPTAG(IndexedDictionary, POINTER) returns tag of POINTER of IndexedDictionary.
			%
			% Note that the Element.GETPROPTAG(IDICT) and Element.GETPROPTAG('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case IndexedDictionary.IT_CLASS
						tag = IndexedDictionary.IT_CLASS_TAG;
					case IndexedDictionary.IT_KEY
						tag = IndexedDictionary.IT_KEY_TAG;
					case IndexedDictionary.IT_LIST
						tag = IndexedDictionary.IT_LIST_TAG;
					case IndexedDictionary.LENGTH
						tag = IndexedDictionary.LENGTH_TAG;
					case IndexedDictionary.CONTAINS
						tag = IndexedDictionary.CONTAINS_TAG;
					case IndexedDictionary.CONTAINS_INDEX
						tag = IndexedDictionary.CONTAINS_INDEX_TAG;
					case IndexedDictionary.CONTAINS_KEY
						tag = IndexedDictionary.CONTAINS_KEY_TAG;
					case IndexedDictionary.CONTAINS_IT
						tag = IndexedDictionary.CONTAINS_IT_TAG;
					case IndexedDictionary.INDEX
						tag = IndexedDictionary.INDEX_TAG;
					case IndexedDictionary.INDEX_FROM_KEY
						tag = IndexedDictionary.INDEX_FROM_KEY_TAG;
					case IndexedDictionary.INDEX_FROM_IT
						tag = IndexedDictionary.INDEX_FROM_IT_TAG;
					case IndexedDictionary.KEYS
						tag = IndexedDictionary.KEYS_TAG;
					case IndexedDictionary.KEY
						tag = IndexedDictionary.KEY_TAG;
					case IndexedDictionary.KEY_FROM_INDEX
						tag = IndexedDictionary.KEY_FROM_INDEX_TAG;
					case IndexedDictionary.KEY_FROM_IT
						tag = IndexedDictionary.KEY_FROM_IT_TAG;
					case IndexedDictionary.IT
						tag = IndexedDictionary.IT_TAG;
					case IndexedDictionary.IT_FROM_INDEX
						tag = IndexedDictionary.IT_FROM_INDEX_TAG;
					case IndexedDictionary.IT_FROM_KEY
						tag = IndexedDictionary.IT_FROM_KEY_TAG;
					case IndexedDictionary.ADD
						tag = IndexedDictionary.ADD_TAG;
					case IndexedDictionary.REMOVE
						tag = IndexedDictionary.REMOVE_TAG;
					case IndexedDictionary.REPLACE
						tag = IndexedDictionary.REPLACE_TAG;
					case IndexedDictionary.REPLACE_KEY
						tag = IndexedDictionary.REPLACE_KEY_TAG;
					case IndexedDictionary.REPLACE_IT
						tag = IndexedDictionary.REPLACE_IT_TAG;
					case IndexedDictionary.INVERT
						tag = IndexedDictionary.INVERT_TAG;
					case IndexedDictionary.MOVE_TO
						tag = IndexedDictionary.MOVE_TO_TAG;
					case IndexedDictionary.REMOVE_ALL
						tag = IndexedDictionary.REMOVE_ALL_TAG;
					case IndexedDictionary.MOVE_UP
						tag = IndexedDictionary.MOVE_UP_TAG;
					case IndexedDictionary.MOVE_DOWN
						tag = IndexedDictionary.MOVE_DOWN_TAG;
					case IndexedDictionary.MOVE_TO_TOP
						tag = IndexedDictionary.MOVE_TO_TOP_TAG;
					case IndexedDictionary.MOVE_TO_BOTTOM
						tag = IndexedDictionary.MOVE_TO_BOTTOM_TAG;
					otherwise
						tag = getPropTag@ConcreteElement(prop);
				end
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the category of the
			%  property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the category of the
			%  property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = IDICT.GETPROPCATEGORY(POINTER) returns category of POINTER of IDICT.
			%  CATEGORY = Element.GETPROPCATEGORY(IndexedDictionary, POINTER) returns category of POINTER of IndexedDictionary.
			%  CATEGORY = IDICT.GETPROPCATEGORY(IndexedDictionary, POINTER) returns category of POINTER of IndexedDictionary.
			%
			% Note that the Element.GETPROPCATEGORY(IDICT) and Element.GETPROPCATEGORY('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			switch prop
				case IndexedDictionary.IT_CLASS
					prop_category = IndexedDictionary.IT_CLASS_CATEGORY;
				case IndexedDictionary.IT_KEY
					prop_category = IndexedDictionary.IT_KEY_CATEGORY;
				case IndexedDictionary.IT_LIST
					prop_category = IndexedDictionary.IT_LIST_CATEGORY;
				case IndexedDictionary.LENGTH
					prop_category = IndexedDictionary.LENGTH_CATEGORY;
				case IndexedDictionary.CONTAINS
					prop_category = IndexedDictionary.CONTAINS_CATEGORY;
				case IndexedDictionary.CONTAINS_INDEX
					prop_category = IndexedDictionary.CONTAINS_INDEX_CATEGORY;
				case IndexedDictionary.CONTAINS_KEY
					prop_category = IndexedDictionary.CONTAINS_KEY_CATEGORY;
				case IndexedDictionary.CONTAINS_IT
					prop_category = IndexedDictionary.CONTAINS_IT_CATEGORY;
				case IndexedDictionary.INDEX
					prop_category = IndexedDictionary.INDEX_CATEGORY;
				case IndexedDictionary.INDEX_FROM_KEY
					prop_category = IndexedDictionary.INDEX_FROM_KEY_CATEGORY;
				case IndexedDictionary.INDEX_FROM_IT
					prop_category = IndexedDictionary.INDEX_FROM_IT_CATEGORY;
				case IndexedDictionary.KEYS
					prop_category = IndexedDictionary.KEYS_CATEGORY;
				case IndexedDictionary.KEY
					prop_category = IndexedDictionary.KEY_CATEGORY;
				case IndexedDictionary.KEY_FROM_INDEX
					prop_category = IndexedDictionary.KEY_FROM_INDEX_CATEGORY;
				case IndexedDictionary.KEY_FROM_IT
					prop_category = IndexedDictionary.KEY_FROM_IT_CATEGORY;
				case IndexedDictionary.IT
					prop_category = IndexedDictionary.IT_CATEGORY;
				case IndexedDictionary.IT_FROM_INDEX
					prop_category = IndexedDictionary.IT_FROM_INDEX_CATEGORY;
				case IndexedDictionary.IT_FROM_KEY
					prop_category = IndexedDictionary.IT_FROM_KEY_CATEGORY;
				case IndexedDictionary.ADD
					prop_category = IndexedDictionary.ADD_CATEGORY;
				case IndexedDictionary.REMOVE
					prop_category = IndexedDictionary.REMOVE_CATEGORY;
				case IndexedDictionary.REPLACE
					prop_category = IndexedDictionary.REPLACE_CATEGORY;
				case IndexedDictionary.REPLACE_KEY
					prop_category = IndexedDictionary.REPLACE_KEY_CATEGORY;
				case IndexedDictionary.REPLACE_IT
					prop_category = IndexedDictionary.REPLACE_IT_CATEGORY;
				case IndexedDictionary.INVERT
					prop_category = IndexedDictionary.INVERT_CATEGORY;
				case IndexedDictionary.MOVE_TO
					prop_category = IndexedDictionary.MOVE_TO_CATEGORY;
				case IndexedDictionary.REMOVE_ALL
					prop_category = IndexedDictionary.REMOVE_ALL_CATEGORY;
				case IndexedDictionary.MOVE_UP
					prop_category = IndexedDictionary.MOVE_UP_CATEGORY;
				case IndexedDictionary.MOVE_DOWN
					prop_category = IndexedDictionary.MOVE_DOWN_CATEGORY;
				case IndexedDictionary.MOVE_TO_TOP
					prop_category = IndexedDictionary.MOVE_TO_TOP_CATEGORY;
				case IndexedDictionary.MOVE_TO_BOTTOM
					prop_category = IndexedDictionary.MOVE_TO_BOTTOM_CATEGORY;
				otherwise
					prop_category = getPropCategory@ConcreteElement(prop);
			end
		end
		function prop_format = getPropFormat(pointer)
			%GETPROPFORMAT returns the format of a property.
			%
			% FORMAT = Element.GETPROPFORMAT(PROP) returns the
			%  format of the property PROP.
			%
			% FORMAT = Element.GETPROPFORMAT(TAG) returns the
			%  format of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  FORMAT = IDICT.GETPROPFORMAT(POINTER) returns format of POINTER of IDICT.
			%  FORMAT = Element.GETPROPFORMAT(IndexedDictionary, POINTER) returns format of POINTER of IndexedDictionary.
			%  FORMAT = IDICT.GETPROPFORMAT(IndexedDictionary, POINTER) returns format of POINTER of IndexedDictionary.
			%
			% Note that the Element.GETPROPFORMAT(IDICT) and Element.GETPROPFORMAT('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			switch prop
				case IndexedDictionary.IT_CLASS
					prop_format = IndexedDictionary.IT_CLASS_FORMAT;
				case IndexedDictionary.IT_KEY
					prop_format = IndexedDictionary.IT_KEY_FORMAT;
				case IndexedDictionary.IT_LIST
					prop_format = IndexedDictionary.IT_LIST_FORMAT;
				case IndexedDictionary.LENGTH
					prop_format = IndexedDictionary.LENGTH_FORMAT;
				case IndexedDictionary.CONTAINS
					prop_format = IndexedDictionary.CONTAINS_FORMAT;
				case IndexedDictionary.CONTAINS_INDEX
					prop_format = IndexedDictionary.CONTAINS_INDEX_FORMAT;
				case IndexedDictionary.CONTAINS_KEY
					prop_format = IndexedDictionary.CONTAINS_KEY_FORMAT;
				case IndexedDictionary.CONTAINS_IT
					prop_format = IndexedDictionary.CONTAINS_IT_FORMAT;
				case IndexedDictionary.INDEX
					prop_format = IndexedDictionary.INDEX_FORMAT;
				case IndexedDictionary.INDEX_FROM_KEY
					prop_format = IndexedDictionary.INDEX_FROM_KEY_FORMAT;
				case IndexedDictionary.INDEX_FROM_IT
					prop_format = IndexedDictionary.INDEX_FROM_IT_FORMAT;
				case IndexedDictionary.KEYS
					prop_format = IndexedDictionary.KEYS_FORMAT;
				case IndexedDictionary.KEY
					prop_format = IndexedDictionary.KEY_FORMAT;
				case IndexedDictionary.KEY_FROM_INDEX
					prop_format = IndexedDictionary.KEY_FROM_INDEX_FORMAT;
				case IndexedDictionary.KEY_FROM_IT
					prop_format = IndexedDictionary.KEY_FROM_IT_FORMAT;
				case IndexedDictionary.IT
					prop_format = IndexedDictionary.IT_FORMAT;
				case IndexedDictionary.IT_FROM_INDEX
					prop_format = IndexedDictionary.IT_FROM_INDEX_FORMAT;
				case IndexedDictionary.IT_FROM_KEY
					prop_format = IndexedDictionary.IT_FROM_KEY_FORMAT;
				case IndexedDictionary.ADD
					prop_format = IndexedDictionary.ADD_FORMAT;
				case IndexedDictionary.REMOVE
					prop_format = IndexedDictionary.REMOVE_FORMAT;
				case IndexedDictionary.REPLACE
					prop_format = IndexedDictionary.REPLACE_FORMAT;
				case IndexedDictionary.REPLACE_KEY
					prop_format = IndexedDictionary.REPLACE_KEY_FORMAT;
				case IndexedDictionary.REPLACE_IT
					prop_format = IndexedDictionary.REPLACE_IT_FORMAT;
				case IndexedDictionary.INVERT
					prop_format = IndexedDictionary.INVERT_FORMAT;
				case IndexedDictionary.MOVE_TO
					prop_format = IndexedDictionary.MOVE_TO_FORMAT;
				case IndexedDictionary.REMOVE_ALL
					prop_format = IndexedDictionary.REMOVE_ALL_FORMAT;
				case IndexedDictionary.MOVE_UP
					prop_format = IndexedDictionary.MOVE_UP_FORMAT;
				case IndexedDictionary.MOVE_DOWN
					prop_format = IndexedDictionary.MOVE_DOWN_FORMAT;
				case IndexedDictionary.MOVE_TO_TOP
					prop_format = IndexedDictionary.MOVE_TO_TOP_FORMAT;
				case IndexedDictionary.MOVE_TO_BOTTOM
					prop_format = IndexedDictionary.MOVE_TO_BOTTOM_FORMAT;
				otherwise
					prop_format = getPropFormat@ConcreteElement(prop);
			end
		end
		function prop_description = getPropDescription(pointer)
			%GETPROPDESCRIPTION returns the description of a property.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the
			%  description of the property PROP.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the
			%  description of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DESCRIPTION = IDICT.GETPROPDESCRIPTION(POINTER) returns description of POINTER of IDICT.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(IndexedDictionary, POINTER) returns description of POINTER of IndexedDictionary.
			%  DESCRIPTION = IDICT.GETPROPDESCRIPTION(IndexedDictionary, POINTER) returns description of POINTER of IndexedDictionary.
			%
			% Note that the Element.GETPROPDESCRIPTION(IDICT) and Element.GETPROPDESCRIPTION('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			switch prop
				case IndexedDictionary.IT_CLASS
					prop_description = 'IT_CLASS (parameter, class) is the class of the item elements.';
				case IndexedDictionary.IT_KEY
					prop_description = 'IT_KEY (parameter, scalar) is the property of the elements to be used as key (its category must be parameter or data, and its format must be string or class).';
				case IndexedDictionary.IT_LIST
					prop_description = 'IT_LIST (data, itemlist) is the list containing the items.';
				case IndexedDictionary.LENGTH
					prop_description = 'LENGTH (query, scalar) returns the number of items in the indexed dictionary.';
				case IndexedDictionary.CONTAINS
					prop_description = 'CONTAINS (query, logical) checks whether an item exists in an indexed dictionary.';
				case IndexedDictionary.CONTAINS_INDEX
					prop_description = 'CONTAINS_INDEX (query, logical) checks whether an index exists in an indexed dictionary.';
				case IndexedDictionary.CONTAINS_KEY
					prop_description = 'CONTAINS_KEY (query, logical) checks whether a key exists in an indexed dictionary.';
				case IndexedDictionary.CONTAINS_IT
					prop_description = 'CONTAINS_IT (query, logical) checks whether an item exists in an indexed dictionary';
				case IndexedDictionary.INDEX
					prop_description = 'INDEX (query, scalar) returns the index of a key or item.';
				case IndexedDictionary.INDEX_FROM_KEY
					prop_description = 'INDEX_FROM_KEY (query, scalar) returns the index of a key.';
				case IndexedDictionary.INDEX_FROM_IT
					prop_description = 'INDEX_FROM_IT (query, scalar) returns the index of a item.';
				case IndexedDictionary.KEYS
					prop_description = 'KEYS (query, stringlist) returns all the keys in the indexed dictionary.';
				case IndexedDictionary.KEY
					prop_description = 'KEY (query, string) returns the key of an index or item.';
				case IndexedDictionary.KEY_FROM_INDEX
					prop_description = 'KEY_FROM_INDEX (query, string) returns the key of an index';
				case IndexedDictionary.KEY_FROM_IT
					prop_description = 'KEY_FROM_IT (query, string) returns the key of a item.';
				case IndexedDictionary.IT
					prop_description = 'IT (query, item) returns the item of an index or key.';
				case IndexedDictionary.IT_FROM_INDEX
					prop_description = 'IT_FROM_INDEX (query, item) returns the item of an index.';
				case IndexedDictionary.IT_FROM_KEY
					prop_description = 'IT_FROM_KEY (query, item) returns the item of a key.';
				case IndexedDictionary.ADD
					prop_description = 'ADD (query, empty) adds an item and key to an indexed dictionary';
				case IndexedDictionary.REMOVE
					prop_description = 'REMOVE (query, empty) removes a key and item from an indexed dictionary.';
				case IndexedDictionary.REPLACE
					prop_description = 'REPLACE (query, empty) replaces an item and key in an indexed dictionary.';
				case IndexedDictionary.REPLACE_KEY
					prop_description = 'REPLACE_KEY (query, empty) replaces key in indexed dictionary.';
				case IndexedDictionary.REPLACE_IT
					prop_description = 'REPLACE_IT (query, empty) replaces item in indexed dictionary.';
				case IndexedDictionary.INVERT
					prop_description = 'INVERT (query, empty) inverts position of two items in indexed dictionary.';
				case IndexedDictionary.MOVE_TO
					prop_description = 'MOVE_TO (query, empty) moves an item of an indexed dictionary to another position.';
				case IndexedDictionary.REMOVE_ALL
					prop_description = 'REMOVE_ALL (query, rvector) removes selected items.';
				case IndexedDictionary.MOVE_UP
					prop_description = 'MOVE_UP (query, rvector) moves up selected items.';
				case IndexedDictionary.MOVE_DOWN
					prop_description = 'MOVE_DOWN (query, rvector) moves down selected items.';
				case IndexedDictionary.MOVE_TO_TOP
					prop_description = 'MOVE_TO_TOP (query, empty) moves selected items to top.';
				case IndexedDictionary.MOVE_TO_BOTTOM
					prop_description = 'MOVE_TO_BOTTOM (query, rvector) moves selected items to bottom.';
				case IndexedDictionary.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the indexed dictionary (IndexedDictionary).';
				case IndexedDictionary.NAME
					prop_description = 'NAME (constant, string) is the name of the indexed dictionary.';
				case IndexedDictionary.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the indexed dictionary.';
				case IndexedDictionary.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the indexed dictionary.';
				case IndexedDictionary.ID
					prop_description = 'ID (data, string) is a few-letter code for the indexed dictionary.';
				case IndexedDictionary.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the indexed dictionary.';
				case IndexedDictionary.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the indexed dictionary.';
				otherwise
					prop_description = getPropDescription@ConcreteElement(prop);
			end
		end
		function prop_settings = getPropSettings(pointer)
			%GETPROPSETTINGS returns the settings of a property.
			%
			% SETTINGS = Element.GETPROPSETTINGS(PROP) returns the
			%  settings of the property PROP.
			%
			% SETTINGS = Element.GETPROPSETTINGS(TAG) returns the
			%  settings of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SETTINGS = IDICT.GETPROPSETTINGS(POINTER) returns settings of POINTER of IDICT.
			%  SETTINGS = Element.GETPROPSETTINGS(IndexedDictionary, POINTER) returns settings of POINTER of IndexedDictionary.
			%  SETTINGS = IDICT.GETPROPSETTINGS(IndexedDictionary, POINTER) returns settings of POINTER of IndexedDictionary.
			%
			% Note that the Element.GETPROPSETTINGS(IDICT) and Element.GETPROPSETTINGS('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			switch prop
				case IndexedDictionary.IT_CLASS
					prop_settings = Format.getFormatSettings(Format.CLASS);
				case IndexedDictionary.IT_KEY
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case IndexedDictionary.IT_LIST
					prop_settings = Format.getFormatSettings(Format.ITEMLIST);
				case IndexedDictionary.LENGTH
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case IndexedDictionary.CONTAINS
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case IndexedDictionary.CONTAINS_INDEX
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case IndexedDictionary.CONTAINS_KEY
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case IndexedDictionary.CONTAINS_IT
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case IndexedDictionary.INDEX
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case IndexedDictionary.INDEX_FROM_KEY
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case IndexedDictionary.INDEX_FROM_IT
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case IndexedDictionary.KEYS
					prop_settings = Format.getFormatSettings(Format.STRINGLIST);
				case IndexedDictionary.KEY
					prop_settings = Format.getFormatSettings(Format.STRING);
				case IndexedDictionary.KEY_FROM_INDEX
					prop_settings = Format.getFormatSettings(Format.STRING);
				case IndexedDictionary.KEY_FROM_IT
					prop_settings = Format.getFormatSettings(Format.STRING);
				case IndexedDictionary.IT
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case IndexedDictionary.IT_FROM_INDEX
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case IndexedDictionary.IT_FROM_KEY
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case IndexedDictionary.ADD
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case IndexedDictionary.REMOVE
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case IndexedDictionary.REPLACE
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case IndexedDictionary.REPLACE_KEY
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case IndexedDictionary.REPLACE_IT
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case IndexedDictionary.INVERT
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case IndexedDictionary.MOVE_TO
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case IndexedDictionary.REMOVE_ALL
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case IndexedDictionary.MOVE_UP
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case IndexedDictionary.MOVE_DOWN
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case IndexedDictionary.MOVE_TO_TOP
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case IndexedDictionary.MOVE_TO_BOTTOM
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case IndexedDictionary.TEMPLATE
					prop_settings = 'IndexedDictionary';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = IndexedDictionary.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = IndexedDictionary.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IDICT.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IDICT.
			%  DEFAULT = Element.GETPROPDEFAULT(IndexedDictionary, POINTER) returns the default value of POINTER of IndexedDictionary.
			%  DEFAULT = IDICT.GETPROPDEFAULT(IndexedDictionary, POINTER) returns the default value of POINTER of IndexedDictionary.
			%
			% Note that the Element.GETPROPDEFAULT(IDICT) and Element.GETPROPDEFAULT('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			switch prop
				case IndexedDictionary.IT_CLASS
					prop_default = Format.getFormatDefault(Format.CLASS, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.IT_KEY
					prop_default = ConcreteElement.ID;
				case IndexedDictionary.IT_LIST
					prop_default = Format.getFormatDefault(Format.ITEMLIST, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.LENGTH
					prop_default = Format.getFormatDefault(Format.SCALAR, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.CONTAINS
					prop_default = Format.getFormatDefault(Format.LOGICAL, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.CONTAINS_INDEX
					prop_default = Format.getFormatDefault(Format.LOGICAL, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.CONTAINS_KEY
					prop_default = Format.getFormatDefault(Format.LOGICAL, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.CONTAINS_IT
					prop_default = Format.getFormatDefault(Format.LOGICAL, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.INDEX
					prop_default = Format.getFormatDefault(Format.SCALAR, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.INDEX_FROM_KEY
					prop_default = Format.getFormatDefault(Format.SCALAR, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.INDEX_FROM_IT
					prop_default = Format.getFormatDefault(Format.SCALAR, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.KEYS
					prop_default = Format.getFormatDefault(Format.STRINGLIST, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.KEY
					prop_default = Format.getFormatDefault(Format.STRING, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.KEY_FROM_INDEX
					prop_default = Format.getFormatDefault(Format.STRING, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.KEY_FROM_IT
					prop_default = Format.getFormatDefault(Format.STRING, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.IT
					prop_default = Format.getFormatDefault(Format.ITEM, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.IT_FROM_INDEX
					prop_default = Format.getFormatDefault(Format.ITEM, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.IT_FROM_KEY
					prop_default = Format.getFormatDefault(Format.ITEM, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.ADD
					prop_default = Format.getFormatDefault(Format.EMPTY, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.REMOVE
					prop_default = Format.getFormatDefault(Format.EMPTY, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.REPLACE
					prop_default = Format.getFormatDefault(Format.EMPTY, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.REPLACE_KEY
					prop_default = Format.getFormatDefault(Format.EMPTY, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.REPLACE_IT
					prop_default = Format.getFormatDefault(Format.EMPTY, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.INVERT
					prop_default = Format.getFormatDefault(Format.EMPTY, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.MOVE_TO
					prop_default = Format.getFormatDefault(Format.EMPTY, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.REMOVE_ALL
					prop_default = Format.getFormatDefault(Format.RVECTOR, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.MOVE_UP
					prop_default = Format.getFormatDefault(Format.RVECTOR, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.MOVE_DOWN
					prop_default = Format.getFormatDefault(Format.RVECTOR, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.MOVE_TO_TOP
					prop_default = Format.getFormatDefault(Format.EMPTY, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.MOVE_TO_BOTTOM
					prop_default = Format.getFormatDefault(Format.RVECTOR, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.ELCLASS
					prop_default = 'IndexedDictionary';
				case IndexedDictionary.NAME
					prop_default = 'Indexed Dictionary';
				case IndexedDictionary.DESCRIPTION
					prop_default = 'An Indexed Dictionary (IndexedDictionary) provides the methods necessary to handle data in an indexed dictionary. It contains and manages an ordered list of couples {KEY, IT}, where KEY is a unique alphanumeric key (a string) provided by a property of format STRING or CLASS and of category PARAMETER or DATA, and IT is an element of a class defined in the constructor using the property IT_CLASS.';
				case IndexedDictionary.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.ID
					prop_default = 'IndexedDictionary ID';
				case IndexedDictionary.LABEL
					prop_default = 'IndexedDictionary label';
				case IndexedDictionary.NOTES
					prop_default = 'IndexedDictionary notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = IndexedDictionary.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = IndexedDictionary.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IDICT.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IDICT.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(IndexedDictionary, POINTER) returns the conditioned default value of POINTER of IndexedDictionary.
			%  DEFAULT = IDICT.GETPROPDEFAULTCONDITIONED(IndexedDictionary, POINTER) returns the conditioned default value of POINTER of IndexedDictionary.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IDICT) and Element.GETPROPDEFAULTCONDITIONED('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			prop_default = IndexedDictionary.conditioning(prop, IndexedDictionary.getPropDefault(prop));
		end
	end
	methods (Access=protected) % preset
		function value = preset(idict, prop, value)
			%PRESET preprocesses the value of a property before setting it.
			%
			% VALUE = PRESET(EL, PROP, VALUE) prepropcesses the VALUE of the property
			%  PROP. It works only with properties with Category.METADATA,
			%  Category.PARAMETER, Category.DATA, Category.FIGURE and Category.GUI. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% See also conditioning, checkProp, postset, postprocessing,
			%  calculateValue, checkValue.
			
			switch prop
				case IndexedDictionary.IT_KEY % __IndexedDictionary.IT_KEY__
					it_class = idict.get('IT_CLASS');
					category = Element.getPropCategory(it_class, value);
					format = Element.getPropFormat(it_class, value);
					if ~(any(format == [Format.STRING Format.CLASS]) && any(category == [Category.CONSTANT Category.PARAMETER Category.DATA]))
					    error( ...
					        [BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT], ...
					        [BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT '\n' ...
					        'The format of property ''IT_KEY'' must be ''' int2str(Format.STRING) ''' or ''' int2str(Format.CLASS) ''' (it is ''' int2str(format) ''').\n' ...
					        'Its category must be ''' int2str(Category.CONSTANT) ''', ''' int2str(Category.PARAMETER) ''' or ''' int2str(Category.DATA) ''' (it is ''' int2str(category) ''').'] ...
					        )
					end
					
				case IndexedDictionary.IT_LIST % __IndexedDictionary.IT_LIST__
					if ~all(cellfun(@(x) isa(x, idict.get('IT_CLASS')), idict.get('IT_LIST')))
					    error( ...
					        [BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT], ...
					        [BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT '\n' ...
					        'All items of ''IT_LIST'' must be ' idict.get('IT_CLASS') '.'] ...
					        )
					end
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = preset@ConcreteElement(idict, prop, value);
					end
			end
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = IDICT.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = IDICT.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of IDICT.
			%  CHECK = Element.CHECKPROP(IndexedDictionary, PROP, VALUE) checks VALUE format for PROP of IndexedDictionary.
			%  CHECK = IDICT.CHECKPROP(IndexedDictionary, PROP, VALUE) checks VALUE format for PROP of IndexedDictionary.
			% 
			% IDICT.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:IndexedDictionary:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IDICT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IDICT.
			%   Error id: €BRAPH2.STR€:IndexedDictionary:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(IndexedDictionary, PROP, VALUE) throws error if VALUE has not a valid format for PROP of IndexedDictionary.
			%   Error id: €BRAPH2.STR€:IndexedDictionary:€BRAPH2.WRONG_INPUT€
			%  IDICT.CHECKPROP(IndexedDictionary, PROP, VALUE) throws error if VALUE has not a valid format for PROP of IndexedDictionary.
			%   Error id: €BRAPH2.STR€:IndexedDictionary:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(IDICT) and Element.CHECKPROP('IndexedDictionary')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			switch prop
				case IndexedDictionary.IT_CLASS % __IndexedDictionary.IT_CLASS__
					check = Format.checkFormat(Format.CLASS, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.IT_KEY % __IndexedDictionary.IT_KEY__
					check = Format.checkFormat(Format.SCALAR, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.IT_LIST % __IndexedDictionary.IT_LIST__
					check = Format.checkFormat(Format.ITEMLIST, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.LENGTH % __IndexedDictionary.LENGTH__
					check = Format.checkFormat(Format.SCALAR, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.CONTAINS % __IndexedDictionary.CONTAINS__
					check = Format.checkFormat(Format.LOGICAL, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.CONTAINS_INDEX % __IndexedDictionary.CONTAINS_INDEX__
					check = Format.checkFormat(Format.LOGICAL, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.CONTAINS_KEY % __IndexedDictionary.CONTAINS_KEY__
					check = Format.checkFormat(Format.LOGICAL, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.CONTAINS_IT % __IndexedDictionary.CONTAINS_IT__
					check = Format.checkFormat(Format.LOGICAL, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.INDEX % __IndexedDictionary.INDEX__
					check = Format.checkFormat(Format.SCALAR, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.INDEX_FROM_KEY % __IndexedDictionary.INDEX_FROM_KEY__
					check = Format.checkFormat(Format.SCALAR, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.INDEX_FROM_IT % __IndexedDictionary.INDEX_FROM_IT__
					check = Format.checkFormat(Format.SCALAR, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.KEYS % __IndexedDictionary.KEYS__
					check = Format.checkFormat(Format.STRINGLIST, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.KEY % __IndexedDictionary.KEY__
					check = Format.checkFormat(Format.STRING, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.KEY_FROM_INDEX % __IndexedDictionary.KEY_FROM_INDEX__
					check = Format.checkFormat(Format.STRING, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.KEY_FROM_IT % __IndexedDictionary.KEY_FROM_IT__
					check = Format.checkFormat(Format.STRING, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.IT % __IndexedDictionary.IT__
					check = Format.checkFormat(Format.ITEM, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.IT_FROM_INDEX % __IndexedDictionary.IT_FROM_INDEX__
					check = Format.checkFormat(Format.ITEM, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.IT_FROM_KEY % __IndexedDictionary.IT_FROM_KEY__
					check = Format.checkFormat(Format.ITEM, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.ADD % __IndexedDictionary.ADD__
					check = Format.checkFormat(Format.EMPTY, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.REMOVE % __IndexedDictionary.REMOVE__
					check = Format.checkFormat(Format.EMPTY, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.REPLACE % __IndexedDictionary.REPLACE__
					check = Format.checkFormat(Format.EMPTY, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.REPLACE_KEY % __IndexedDictionary.REPLACE_KEY__
					check = Format.checkFormat(Format.EMPTY, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.REPLACE_IT % __IndexedDictionary.REPLACE_IT__
					check = Format.checkFormat(Format.EMPTY, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.INVERT % __IndexedDictionary.INVERT__
					check = Format.checkFormat(Format.EMPTY, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.MOVE_TO % __IndexedDictionary.MOVE_TO__
					check = Format.checkFormat(Format.EMPTY, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.REMOVE_ALL % __IndexedDictionary.REMOVE_ALL__
					check = Format.checkFormat(Format.RVECTOR, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.MOVE_UP % __IndexedDictionary.MOVE_UP__
					check = Format.checkFormat(Format.RVECTOR, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.MOVE_DOWN % __IndexedDictionary.MOVE_DOWN__
					check = Format.checkFormat(Format.RVECTOR, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.MOVE_TO_TOP % __IndexedDictionary.MOVE_TO_TOP__
					check = Format.checkFormat(Format.EMPTY, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.MOVE_TO_BOTTOM % __IndexedDictionary.MOVE_TO_BOTTOM__
					check = Format.checkFormat(Format.RVECTOR, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.TEMPLATE % __IndexedDictionary.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, IndexedDictionary.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' IndexedDictionary.getPropTag(prop) ' (' IndexedDictionary.getFormatTag(IndexedDictionary.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(idict, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with Category.RESULT,
			%  Category.QUERY, and Category.EVANESCENT. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  Category.QUERY.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case IndexedDictionary.LENGTH % __IndexedDictionary.LENGTH__
					value = length(idict.get('IT_LIST')); 
					% length = value
					
				case IndexedDictionary.CONTAINS % __IndexedDictionary.CONTAINS__
					% BOOL = idict.get('CONTAINS', POINTER) returns true if POINTER (index, key
					%  or item) exists in the indexed dictionary.
					if isempty(varargin)
					    value = false;
					    return
					end    
					pointer = varargin{1};
					
					if isa(pointer, 'numeric')  % pointer is index
					    value = idict.get('CONTAINS_INDEX', pointer);
					elseif isa(pointer, 'char')  % pointer is key
					    value = idict.get('CONTAINS_KEY', pointer);
					elseif isa(pointer, idict.get('IT_CLASS'))  % pointer is item - not necessarily unique
					    value = idict.get('CONTAINS_IT', pointer);
					else
					    value = false;
					end
					% bool = value
					
				case IndexedDictionary.CONTAINS_INDEX % __IndexedDictionary.CONTAINS_INDEX__
					% BOOL = idict.get('CONTAINS_INDEX', INDEX) returns true if the INDEX exists in
					%  the indexed dictionary.
					if isempty(varargin)
					    value = false;
					    return
					end
					index = varargin{1};
					
					value = index >= 1 && index <= idict.get('LENGTH') && round(index) == index;
					% bool = value
					
				case IndexedDictionary.CONTAINS_KEY % __IndexedDictionary.CONTAINS_KEY__
					% BOOL = idict.get('CONTAINS_KEY', KEY) returns true if the KEY exists in
					%  the indexed dictionary.
					if isempty(varargin)
					    value = false;
					    return
					end
					key = varargin{1};
					
					it_key = idict.get('IT_KEY');
					value = any(cellfun(@(it) strcmp(it.get(it_key), key), idict.get('IT_LIST')));
					% bool = value
					
				case IndexedDictionary.CONTAINS_IT % __IndexedDictionary.CONTAINS_IT__
					% BOOL = idict.get('CONTAINS_IT', IT) returns true if IT exists in
					%  the indexed dictionary.
					if isempty(varargin)
					    value = false;
					    return
					end
					item = varargin{1};
					
					value = any(cellfun(@(it) it == item, idict.get('IT_LIST')));
					% bool = value
					
				case IndexedDictionary.INDEX % __IndexedDictionary.INDEX__
					% INDEX = idict.get('INDEX', POINTER) returns the index of a POINTER (a key
					%  or item).
					if isempty(varargin)
					    value = -1;
					    return
					end
					pointer = varargin{1};
					
					if isa(pointer, 'numeric')  % pointer is index
					    value = pointer;
					elseif isa(pointer, 'char')  % pointer is key
					    value = idict.get('INDEX_FROM_KEY', pointer);
					elseif isa(pointer, idict.get('IT_CLASS'))  % pointer is item - not necessarily unique
					    value = idict.get('INDEX_FROM_IT', pointer);
					end
					% index = value
					
				case IndexedDictionary.INDEX_FROM_KEY % __IndexedDictionary.INDEX_FROM_KEY__
					% INDEX = idict.get('INDEX_FROM_KEY', KEY) returns the index of KEY.
					if isempty(varargin)
					    value = -1;
					    return
					end
					key = varargin{1};
					
					value = find(strcmp(key, idict.get('KEYS')));
					% index = value 
					% error if idict does not contain the key
					
				case IndexedDictionary.INDEX_FROM_IT % __IndexedDictionary.INDEX_FROM_IT__
					% INDEX = idict.get('INDEX_FROM_IT', IT) returns the index of the first
					% occurrence of item IT.
					if isempty(varargin)
					    value = -1;
					    return
					end
					item = varargin{1};
					
					value = find(cellfun(@(it) it == item, idict.get('IT_LIST'))); % return the first occurrence
					% index = value 
					% error if idict does not contain the item
					
				case IndexedDictionary.KEYS % __IndexedDictionary.KEYS__
					it_key = idict.get('IT_KEY');
					value = cellfun(@(it) it.get(it_key), idict.get('IT_LIST'), 'UniformOutput', false);
					% keys = value
					
				case IndexedDictionary.KEY % __IndexedDictionary.KEY__
					% KEY = idict.get('KEY', POINTER) returns the key of POINTER (a index or
					%  item). If the POINTER is a item, it returns the first occurrence.
					if isempty(varargin)
					    value = '';
					    return
					end
					pointer = varargin{1};
					
					if isa(pointer, idict.get('IT_CLASS'))  % pointer is item - not necessarily unique
					   value = idict.get('KEY_FROM_IT', pointer);  % first occurrence
					else  % pointer is an index
					    it_list = idict.get('IT_LIST');
					    value = it_list{pointer}.get(idict.get('IT_KEY'));
					end
					% key = value
					
				case IndexedDictionary.KEY_FROM_INDEX % __IndexedDictionary.KEY_FROM_INDEX__
					% KEY = idict.get('KEY_FROM_INDEX', INDEX) returns the key of INDEX.
					if isempty(varargin)
					    value = '';
					    return
					end
					index = varargin{1};
					
					it_list = idict.get('IT_LIST');
					value = it_list{index}.get(idict.get('IT_KEY'));
					% key = value % error if index does not exist
					
				case IndexedDictionary.KEY_FROM_IT % __IndexedDictionary.KEY_FROM_IT__
					% KEY = get('KEY_FROM_IT', IT) returns the key of the first occurrence
					%  of item IT.
					if isempty(varargin)
					    value = '';
					    return
					end
					item = varargin{1};
					
					it_list = idict.get('IT_LIST');
					value = it_list{idict.get('INDEX_FROM_IT', item)}.get(idict.get('IT_KEY'));
					% key = value % error if idict does not contain the item
					
				case IndexedDictionary.IT % __IndexedDictionary.IT__
					% IT = idict.get('IT', POINTER) returns the item of POINTER (an index or key).
					if isempty(varargin)
					    value = ConcreteElement();
					    return
					end
					pointer = varargin{1};
					
					if isa(pointer, 'char')  % pointer is a key
					    value = idict.get('IT_FROM_KEY', pointer);
					else  % pointer is an index
					    value = idict.get('IT_FROM_INDEX', pointer);
					end
					% item = value
					
				case IndexedDictionary.IT_FROM_INDEX % __IndexedDictionary.IT_FROM_INDEX__
					% IT = idict.get('IT_FROM_INDEX', INDEX) returns the item of INDEX.
					if isempty(varargin)
					    value = ConcreteElement();
					    return
					end
					index = varargin{1};
					
					it_list = idict.get('IT_LIST');
					value = it_list{index};
					% item = value % error if the index does not exist
					
				case IndexedDictionary.IT_FROM_KEY % __IndexedDictionary.IT_FROM_KEY__
					% IT = idict.get('IT_FROM_KEY', KEY) returns the item of KEY.
					if isempty(varargin)
					    value = ConcreteElement();
					    return
					end
					key = varargin{1};
					
					it_list = idict.get('IT_LIST');
					value = it_list{idict.get('INDEX_FROM_KEY', key)};
					% item = value % error if idict does not containt the key
					
				case IndexedDictionary.ADD % __IndexedDictionary.ADD__
					% idict.get('ADD', IT, INDEX) adds an item and key to the indexed
					%  dictionary in position INDEX. If INDEX is empty, it adds it to the end
					%  of IDICT.
					if isempty(varargin)
					    value = [];
					    return
					end
					item = varargin{1};
					if length(varargin) == 2
					    index = varargin{2};
					else
					    index = idict.get('LENGTH') + 1;
					end
					
					if index <= 0 || index > idict.get('LENGTH')
					    index = idict.get('LENGTH') + 1;
					end
					
					if ~isa(item, idict.get('IT_CLASS'))
					    error(...
					        [BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_INPUT], ...
					        [BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_INPUT '\n' ...
					        'Item must be an object of class ' idict.get('IT_CLASS') ',' ...
					        ' while it is of class ' class(item) '.'] ...
					        )
					end
					if idict.get('CONTAINS_KEY', item.get(idict.get('IT_KEY'))) % key = item.get(idict.get('IT_KEY'))
					    error( ...
					        [BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_INPUT], ...
					        [BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_INPUT '\n' ...
					        'Key ''' item.get(idict.get('IT_KEY')) ''' is already contained in the indexed dictionary.'] ... % key = item.get(idict.get('IT_KEY'))
					        )
					end
					
					it_list = idict.get('IT_LIST');
					if index <= idict.get('LENGTH')  
					    % create space for {key, item}
					    it_list(index + 1:end + 1) = it_list(index:end);
					    it_list{index} = item;
					else
					    it_list{end + 1} = item;
					end
					idict.set('IT_LIST', it_list)
					
					value = [];
					
				case IndexedDictionary.REMOVE % __IndexedDictionary.REMOVE__
					% idict.get('REMOVE', POINTER) removes the key and item of POINTER (an
					%  index, key or item) from the indexed dictionary IDICT.
					if isempty(varargin)
					    value = [];
					    return
					end
					pointer = varargin{1};
					
					index = idict.get('INDEX', pointer);
					
					it_list = idict.get('IT_LIST');
					it_list(index) = [];
					idict.set('IT_LIST', it_list);
					
					value = [];
					
				case IndexedDictionary.REPLACE % __IndexedDictionary.REPLACE__
					% idict.get('REPLACE', NEW_IT, INDEX) replaces the item and key of INDEX
					%  in the indexed dictionary IDICT with item NEW_IT.
					if isempty(varargin)
					    value = [];
					    return
					end
					new_item = varargin{1};
					index = varargin{2};
					
					if ~isa(new_item, idict.get('IT_CLASS'))
					    error( ...
					        [BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT], ...
					        ['The item class must be ' idict.get('IT_CLASS') '.'] ...
					        )
					end
					
					if idict.get('CONTAINS', index)
					    idict.get('REMOVE', index)
					    idict.get('ADD', new_item, index)
					end
					
					value = [];
					
				case IndexedDictionary.REPLACE_KEY % __IndexedDictionary.REPLACE_KEY__
					% idict.get('REPLACE_KEY', OLD_KEY, NEW_KEY) replaces OLD_KEY in the
					%  indexed dictionary IDICT with NEW_KEY.
					if isempty(varargin)
					    value = [];
					    return
					end
					old_key = varargin{1};
					new_key = varargin{2};
					
					if ~idict.get('CONTAINS', new_key)
					    item = idict.get('IT_FROM_KEY', old_key);
					    item.set(idict.get('IT_KEY'), new_key)
					end
					
					value = [];
					
				case IndexedDictionary.REPLACE_IT % __IndexedDictionary.REPLACE_IT__
					% idict.get('REPLACE_IT', OLD_IT, NEW_IT) replaces OLD_IT with
					%  NEW_IT in the indexed dictionary IDICT. It replaces only the first
					%  occurrence of OLD_IT.
					if isempty(varargin)
					    value = [];
					    return
					end
					old_it = varargin{1};
					new_it = varargin{2};
					
					index = idict.get('INDEX_FROM_IT', old_it);
					idict.get('REPLACE', new_it, index);
					
					value = [];
					
				case IndexedDictionary.INVERT % __IndexedDictionary.INVERT__
					% idict.get('INVERT', INDEXI, INDEXJ) inverts the positions of the items at
					%  INDEX_I and INDEX_J in the indexed dictionary IDICT.
					if isempty(varargin)
					    value = [];
					    return
					end
					i = varargin{1};
					j = varargin{2};
					
					if i > j
					    if i > 0 && i <= idict.get('LENGTH') && j > 0 && j <= idict.get('LENGTH') && i ~= j
					        item_i = idict.get('IT', i);
					        item_j = idict.get('IT', j);
					
					        idict.get('REMOVE', i)
					        idict.get('REMOVE', j)
					
					        idict.get('ADD', item_i, j);
					        idict.get('ADD', item_j, i);
					    end
					elseif i ~= j
					    idict.get('INVERT', j, i);
					end
					
					value = [];
					
				case IndexedDictionary.MOVE_TO % __IndexedDictionary.MOVE_TO__
					% idict.get('MOVE_TO', OLD_INDEX, NEW_INDEX) moves an item from position
					%  OLD_INDEX to position NEW_INDEX in the indexed dictionary IDICT.
					if isempty(varargin)
					    value = [];
					    return
					end
					i = varargin{1};
					j = varargin{2};
					
					if i > 0 && i <= idict.get('LENGTH') && j > 0 && j <= idict.get('LENGTH') && i ~= j
					    item = idict.get('IT', i);
					    idict.get('REMOVE', i)
					    idict.get('ADD', item, j)
					end
					
					value = [];
					
				case IndexedDictionary.REMOVE_ALL % __IndexedDictionary.REMOVE_ALL__
					% SELECTED = idict.get('REMOVE_ALL', SELECTED) removes all items whose
					%  positions in the indexed dictionary DICT are included in the array
					%  SELECTED. It returns an empty array.
					if isempty(varargin)
					    value = [];
					    return
					end
					selected = varargin{1};
					
					for i = length(selected):-1:1
					    idict.get('REMOVE', selected(i))
					end
					value = []; % selected = value;
					
				case IndexedDictionary.MOVE_UP % __IndexedDictionary.MOVE_UP__
					% SELECTED = idict.get('MOVE_UP', SELECTED) moves up by one position all
					%  items whose positions in the indexed dictionary DICT are included in the
					%  SELECTED array and returns their final positions.
					if isempty(varargin)
					    value = [];
					    return
					end
					selected = varargin{1};
					
					if ~isempty(selected)
					    first_index_to_process = 1;
					    unprocessable_length = 1;
					    while first_index_to_process <= idict.get('LENGTH') ...
					            && first_index_to_process <= numel(selected) ...
					            && selected(first_index_to_process) == unprocessable_length
					        first_index_to_process = first_index_to_process + 1;
					        unprocessable_length = unprocessable_length + 1;
					    end
					
					    for i = first_index_to_process:1:numel(selected)
					        idict.get('INVERT', selected(i), selected(i)-1);
					        selected(i) = selected(i) - 1;
					    end
					end
					
					value = selected;
					
				case IndexedDictionary.MOVE_DOWN % __IndexedDictionary.MOVE_DOWN__
					% SELECTED = idict.get('MOVE_DOWN', SELECTED) moves down by one position
					%  all items whose positions in the indexed dictionary DICT are included in
					%  the SELECTED array and returns their final positions.  
					if isempty(varargin)
					    value = [];
					    return
					end
					selected = varargin{1};
					
					if ~isempty(selected)
					    last_index_to_process = numel(selected);
					    unprocessable_length = idict.get('LENGTH');
					    while last_index_to_process > 0 ...
					            && selected(last_index_to_process) == unprocessable_length
					        last_index_to_process = last_index_to_process - 1;
					        unprocessable_length = unprocessable_length - 1;
					    end
					
					    for i = last_index_to_process:-1:1
					        idict.get('INVERT', selected(i), selected(i) + 1);
					        selected(i) = selected(i) + 1;
					    end
					end
					
					value = selected;
					
				case IndexedDictionary.MOVE_TO_TOP % __IndexedDictionary.MOVE_TO_TOP__
					% SELECTED = idict.get('MOVE_TO_TOP', SELECTED) moves to top all items
					%  whose positions in the indexed dictionary DICT are included in the
					%  SELECTED array and returns their final positions.
					if isempty(varargin)
					    value = [];
					    return
					end
					selected = varargin{1};
					
					if ~isempty(selected)
					    for i = 1:1:numel(selected)
					        idict.get('MOVE_TO', selected(i), i);
					    end
					    selected = reshape(1:1:numel(selected), size(selected));
					end
					
					value = selected;
					
				case IndexedDictionary.MOVE_TO_BOTTOM % __IndexedDictionary.MOVE_TO_BOTTOM__
					% SELECTED = idict.get('MOVE_TO_BOTTOM', SELECTED) moves to bottom all
					%  items whose positions in the indexed dictionary DICT dictionary are
					%  included in the SELECTED array and returns their final positions.
					if isempty(varargin)
					    value = [];
					    return
					end
					selected = varargin{1};
					
					idict_length = idict.get('LENGTH');
					if ~isempty(selected)
					    for i = numel(selected):-1:1
					        idict.get('MOVE_TO', selected(i), idict_length - (numel(selected)-i));
					    end
					    selected = reshape(idict_length - numel(selected)+1:1:idict_length, size(selected));
					end
					
					value = selected;
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(idict, prop, varargin{:});
					else
						value = calculateValue@Element(idict, prop, varargin{:});
					end
			end
			
		end
	end
end
