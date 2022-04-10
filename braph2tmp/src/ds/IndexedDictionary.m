classdef IndexedDictionary < Element
	% IndexedDictionary is an indexed dictionary.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% IndexedDictionary provides the methods necessary to handle data in an indexed dictionary. 
	% It contains and manages an ordered list of couples {KEY, ITEM}, 
	% where KEY is a unique alphanumeric key (a string) provided by a property of category PARAMETER or DATA and 
	% ITEM is an element of a class defined in the constructor using the property IT_CLASS.
	%
	% The list of IndexedDictionary properties is:
	%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code.
	%  <strong>2</strong> <strong>it_class</strong> 	IT_CLASS (parameter, class) is the class of the item elements.
	%  <strong>3</strong> <strong>it_key</strong> 	IT_KEY (parameter, scalar) is the property of the elements to be used as key (its category must be parameter or data, and its format must be string).
	%  <strong>4</strong> <strong>it_list</strong> 	IT_LIST (data, itemlist) is the list containing the items.
	%
	% IndexedDictionary methods (constructor):
	% IndexedDictionary - constructor
	%
	% IndexedDictionary methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in indexed dictionary/error.
	%  existsProp - checks whether property exists in indexed dictionary/error.
	%  getPropNumber - returns the property number of indexed dictionary.
	%  getProps - returns the property list of indexed dictionary.
	%  getDescription - returns the description of the indexed dictionary.
	%  getName - returns the name of the indexed dictionary.
	%  getClass - returns the class of the indexed dictionary.
	%
	% IndexedDictionary methods:
	%  move_to_bottom - moves selected items to bottom.
	%  move_to_top - moves selected items to top.
	%  move_down - moves down selected items.
	%  move_up - moves up selected items.
	%  remove_all - removes selected items.
	%  move_to - moves an item of an indexed dictionary to another position.
	%  invert - inverts position of two items in indexed dictionary.
	%  replaceItem - replaces item in indexed dictionary.
	%  replaceKey - replaces key in indexed dictionary.
	%  replace - replaces an item and key in an indexed dictionary.
	%  remove - removes a key and item from an indexed dictionary.
	%  add - adds an item and key to an indexed dictionary
	%  getItemFromKey - returns the item of a key.
	%  getItemFromIndex - returns the item of an index.
	%  getItem - returns the item of an index or key.
	%  getItems - returns all the items in the indexed dictionary
	%  getKeyFromItem - returns the key of a item.
	%  getKeyFromIndex - returns the key of an index
	%  getKey - returns the key of an index or item.
	%  getKeys - returns all the keys in the indexed dictionary.
	%  getIndexFromItem - returns the index of a item.
	%  getIndexFromKey - returns the index of a key.
	%  getIndex - returns the index of a key or item.
	%  containsItem - checks if an item exists in an indexed dictionary
	%  containsKey - checks if a key exists in an indexed dictionary.
	%  containsIndex - checks if an index exists in an indexed dictionary.
	%  contains - checks if an item exists in an indexed dictionary.
	%  length - returns the number of items in the indexed dictionary.
	%  getItemClass - returns the item class of the indexed dictionary.
	%  tostring - string with information about the indexed dictionary.
	%  set - sets the value of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns and memorizes the value of a property
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% IndexedDictionary methods (operators):
	%  isequal - determines whether two IndexedDictionary are equal (values, locked)
	%
	% IndexedDictionary methods (display):
	%  tostring - string with information about the IndexedDictionary
	%  disp - displays information about the IndexedDictionary
	%  tree - displays the element of IndexedDictionary
	%
	% IndexedDictionary method (element list):
	%  getElementList - returns a list with all subelements of IndexedDictionary
	%
	% IndexedDictionary method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the IndexedDictionary
	%
	% IndexedDictionary method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the IndexedDictionary
	%
	% IndexedDictionary methods (copy):
	%  copy - copies the IndexedDictionary
	%  deepclone - deep-clones the IndexedDictionary
	%  clone - clones the IndexedDictionary
	%
	% IndexedDictionary methods (inspection, Static):
	%  getClass - returns IndexedDictionary
	%  getName - returns the name of IndexedDictionary
	%  getDescription - returns the description of IndexedDictionary
	%  getProps - returns the property list of IndexedDictionary
	%  getPropNumber - returns the property number of IndexedDictionary
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditione default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% IndexedDictionary methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% IndexedDictionary methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% IndexedDictionary methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% IndexedDictionary methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% IndexedDictionary properties (Constant).
	%  ID - 1
	%  ID_TAG - 'id'
	%  ID_CATEGORY - 'd'
	%  ID_FORMAT - 'st'
	%  IT_CLASS - 2
	%  IT_CLASS_TAG - 'it_class'
	%  IT_CLASS_CATEGORY - 'p'
	%  IT_CLASS_FORMAT - 'ca'
	%  IT_KEY - 3
	%  IT_KEY_TAG - 'it_key'
	%  IT_KEY_CATEGORY - 'p'
	%  IT_KEY_FORMAT - 'nn'
	%  IT_LIST - 4
	%  IT_LIST_TAG - 'it_list'
	%  IT_LIST_CATEGORY - 'd'
	%  IT_LIST_FORMAT - 'il'
	%  METADATA - 'm'
	%  METADATA_NAME - 'metadata'
	%  METADATA_DESCRIPTION - 'Metadata NOT used in the calculation of the results (does not allow callbacks, not cloned).'
	%  PARAMETER - 'p'
	%  PARAMETER_NAME - 'parameter'
	%  PARAMETER_DESCRIPTION - 'Parameter used to calculate the results of the element (allows incoming and outgoing callbacks, cloned).'
	%  DATA - 'd'
	%  DATA_NAME - 'data'
	%  DATA_DESCRIPTION - 'Data used to calculate the results of the element (can be NoResult when not set, allows incoming and outgoing callbacks, not cloned).'
	%  RESULT - 'r'
	%  RESULT_NAME - 'result'
	%  RESULT_DESCRIPTION - 'Result calculated by the element using parameters and data (can be NoResult when not calculated, allows incoming callbacks).'
	%  FIGURE - 'f'
	%  FIGURE_NAME - 'figure'
	%  FIGURE_DESCRIPTION - 'Parameter used to plot the results in a figure (allows incoming and outgoing callbacks, not cloned).'
	%  GUI - 'g'
	%  GUI_NAME - 'gui'
	%  GUI_DESCRIPTION - 'Parameter used by the graphical user interface (allows incoming and outgoing callbacks, not cloned).'
	%  EMPTY - 'em'
	%  EMPTY_NAME - 'empty'
	%  EMPTY_DESCRIPTION - 'Empty has an empty value and is typically used as a result to execute some code.'
	%  STRING - 'st'
	%  STRING_NAME - 'string'
	%  STRING_DESCRIPTION - 'String is a char array.'
	%  LOGICAL - 'lo'
	%  LOGICAL_NAME - 'logical'
	%  LOGICAL_DESCRIPTION - 'Logical is a boolean value.'
	%  OPTION - 'op'
	%  OPTION_NAME - 'option'
	%  OPTION_DESCRIPTION - 'Option is a char array representing an option within a set defined in the element.'
	%  CLASS - 'ca'
	%  CLASS_NAME - 'class'
	%  CLASS_DESCRIPTION - 'Class is a char array corresponding to an element class.'
	%  CLASSLIST - 'cl'
	%  CLASSLIST_NAME - 'classlist'
	%  CLASSLIST_DESCRIPTION - 'ClassList is a cell array with char arrays corresponding to element classes.'
	%  ITEM - 'it'
	%  ITEM_NAME - 'item'
	%  ITEM_DESCRIPTION - 'Item is a pointer to an element of a class defined in the element.'
	%  ITEMLIST - 'il'
	%  ITEMLIST_NAME - 'itemlist'
	%  ITEMLIST_DESCRIPTION - 'ItemList is a cell array with pointers to elements of a class defined in the element.'
	%  IDICT - 'di'
	%  IDICT_NAME - 'idict'
	%  IDICT_DESCRIPTION - 'Idict is an indexed dictionary of elements of a class defined in the element.'
	%  SCALAR - 'nn'
	%  SCALAR_NAME - 'scalar'
	%  SCALAR_DESCRIPTION - 'Scalar is a scalar numerical value.'
	%  RVECTOR - 'nr'
	%  RVECTOR_NAME - 'rvector'
	%  RVECTOR_DESCRIPTION - 'Rvector is a numerical row vector.'
	%  CVECTOR - 'nc'
	%  CVECTOR_NAME - 'cvector'
	%  CVECTOR_DESCRIPTION - 'Cvector is a numerical column vector.'
	%  MATRIX - 'nm'
	%  MATRIX_NAME - 'matrix'
	%  MATRIX_DESCRIPTION - 'Matrix is a numerical matrix.'
	%  SMATRIX - 'ns'
	%  SMATRIX_NAME - 'smatrix'
	%  SMATRIX_DESCRIPTION - 'Smatrix is a numerical square matrix.'
	%  CELL - 'll'
	%  CELL_NAME - 'cell'
	%  CELL_DESCRIPTION - 'Cell is a 2D cell array of numeric data, typically used for adjaciency matrices and measures.'
	%  NET - 'ml'
	%  NET_NAME - 'net'
	%  NET_DESCRIPTION - 'Net is a MatLab neural network object.'
	%
	% See also Element.
	
	properties (Constant) % properties
		ID = 1;
		ID_TAG = 'id';
		ID_CATEGORY = Category.DATA;
		ID_FORMAT = Format.STRING;
		
		IT_CLASS = 2;
		IT_CLASS_TAG = 'it_class';
		IT_CLASS_CATEGORY = Category.PARAMETER;
		IT_CLASS_FORMAT = Format.CLASS;
		
		IT_KEY = 3;
		IT_KEY_TAG = 'it_key';
		IT_KEY_CATEGORY = Category.PARAMETER;
		IT_KEY_FORMAT = Format.SCALAR;
		
		IT_LIST = 4;
		IT_LIST_TAG = 'it_list';
		IT_LIST_CATEGORY = Category.DATA;
		IT_LIST_FORMAT = Format.ITEMLIST;
	end
	methods (Static) % inspection methods
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
			% See also getName, getDescription.
			
			idict_class = 'IndexedDictionary';
		end
		function idict_name = getName()
			%GETNAME returns the name of the indexed dictionary.
			%
			% NAME = IndexedDictionary.GETNAME() returns the name of the 'indexed dictionary'.
			%  Indexed Dictionary.
			%
			% Alternative forms to call this method are:
			%  NAME = IDICT.GETNAME() returns the name of the indexed dictionary IDICT.
			%  NAME = Element.GETNAME(IDICT) returns the name of 'IDICT'.
			%  NAME = Element.GETNAME('IndexedDictionary') returns the name of 'IndexedDictionary'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			idict_name = 'Indexed Dictionary';
		end
		function idict_description = getDescription()
			%GETDESCRIPTION returns the description of the indexed dictionary.
			%
			% STR = IndexedDictionary.GETDESCRIPTION() returns the description of the 'indexed dictionary'.
			%  which is:
			%
			%  IndexedDictionary provides the methods necessary to handle data in an indexed dictionary. 
			%  It contains and manages an ordered list of couples {KEY, ITEM}, 
			%  where KEY is a unique alphanumeric key (a string) provided by a property of category PARAMETER or DATA and 
			%  ITEM is an element of a class defined in the constructor using the property IT_CLASS.
			%
			% Alternative forms to call this method are:
			%  STR = IDICT.GETDESCRIPTION() returns the description of the indexed dictionary IDICT.
			%  STR = Element.GETDESCRIPTION(IDICT) returns the description of 'IDICT'.
			%  STR = Element.GETDESCRIPTION('IndexedDictionary') returns the description of 'IndexedDictionary'.
			%
			% See also getClass, getName.
			
			idict_description = [
				'IndexedDictionary provides the methods necessary to handle data in an indexed dictionary. ' ...
				'It contains and manages an ordered list of couples {KEY, ITEM}, ' ...
				'where KEY is a unique alphanumeric key (a string) provided by a property of category PARAMETER or DATA and ' ...
				'ITEM is an element of a class defined in the constructor using the property IT_CLASS.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of indexed dictionary.
			%
			% PROPS = IndexedDictionary.GETPROPS() returns the property list of indexed dictionary.
			%
			% PROPS = IndexedDictionary.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IDICT.GETPROPS([CATEGORY]) returns the property list of the indexed dictionary IDICT.
			%  PROPS = Element.GETPROPS(IDICT[, CATEGORY]) returns the property list of 'IDICT'.
			%  PROPS = Element.GETPROPS('IndexedDictionary'[, CATEGORY]) returns the property list of 'IndexedDictionary'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						];
				case Category.PARAMETER
					prop_list = [
						IndexedDictionary.IT_CLASS
						IndexedDictionary.IT_KEY
						];
				case Category.DATA
					prop_list = [
						IndexedDictionary.ID
						IndexedDictionary.IT_LIST
						];
				case Category.RESULT
					prop_list = [
						];
				case Category.FIGURE
					prop_list = [
						];
				case Category.GUI
					prop_list = [
						];
				otherwise
					prop_list = [
						IndexedDictionary.ID
						IndexedDictionary.IT_CLASS
						IndexedDictionary.IT_KEY
						IndexedDictionary.IT_LIST
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of indexed dictionary.
			%
			% N = IndexedDictionary.GETPROPNUMBER() returns the property number of indexed dictionary.
			%
			% Alternative forms to call this method are:
			%  N = IDICT.GETPROPNUMBER() returns the property number of the indexed dictionary IDICT.
			%  N = Element.GETPROPNUMBER(IDICT) returns the property number of 'IDICT'.
			%  N = Element.GETPROPNUMBER('IndexedDictionary') returns the property number of 'IndexedDictionary'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 4;
		end
		function check = existsProp(prop)
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
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4 ]);
			else
				assert( ...
					IndexedDictionary.existsProp(prop), ...
					[BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for IndexedDictionary.'] ...
					)
			end
		end
		function check = existsTag(tag)
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
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				indexeddictionary_tag_list = { 'id'  'it_class'  'it_key'  'it_list' };
				
				check = any(strcmpi(tag, indexeddictionary_tag_list));
			else
				assert( ...
					IndexedDictionary.existsTag(tag), ...
					[BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for IndexedDictionary'] ...
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
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				indexeddictionary_tag_list = { 'id'  'it_class'  'it_key'  'it_list' };
				
				tag = pointer;
				IndexedDictionary.existsTag(tag);
				
				prop = find(strcmpi(tag, indexeddictionary_tag_list));
			else % numeric
				prop = pointer;
				IndexedDictionary.existsProp(prop);
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
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				IndexedDictionary.existsTag(tag);
			else % numeric
				prop = pointer;
				IndexedDictionary.existsProp(prop);
				
				switch prop
					case IndexedDictionary.ID
						tag = IndexedDictionary.ID_TAG;
					case IndexedDictionary.IT_CLASS
						tag = IndexedDictionary.IT_CLASS_TAG;
					case IndexedDictionary.IT_KEY
						tag = IndexedDictionary.IT_KEY_TAG;
					case IndexedDictionary.IT_LIST
						tag = IndexedDictionary.IT_LIST_TAG;
				end
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the
			%  category of the property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the
			%  category of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = IDICT.GETPROPCATEGORY(POINTER) returns category of POINTER of IDICT.
			%  CATEGORY = Element.GETPROPCATEGORY(IndexedDictionary, POINTER) returns category of POINTER of IndexedDictionary.
			%  CATEGORY = IDICT.GETPROPCATEGORY(IndexedDictionary, POINTER) returns category of POINTER of IndexedDictionary.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			switch prop
				case IndexedDictionary.ID
					prop_category = IndexedDictionary.ID_CATEGORY;
				case IndexedDictionary.IT_CLASS
					prop_category = IndexedDictionary.IT_CLASS_CATEGORY;
				case IndexedDictionary.IT_KEY
					prop_category = IndexedDictionary.IT_KEY_CATEGORY;
				case IndexedDictionary.IT_LIST
					prop_category = IndexedDictionary.IT_LIST_CATEGORY;
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
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			switch prop
				case IndexedDictionary.ID
					prop_format = IndexedDictionary.ID_FORMAT;
				case IndexedDictionary.IT_CLASS
					prop_format = IndexedDictionary.IT_CLASS_FORMAT;
				case IndexedDictionary.IT_KEY
					prop_format = IndexedDictionary.IT_KEY_FORMAT;
				case IndexedDictionary.IT_LIST
					prop_format = IndexedDictionary.IT_LIST_FORMAT;
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
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			switch prop
				case IndexedDictionary.ID
					prop_description = 'ID (data, string) is a few-letter code.';
				case IndexedDictionary.IT_CLASS
					prop_description = 'IT_CLASS (parameter, class) is the class of the item elements.';
				case IndexedDictionary.IT_KEY
					prop_description = 'IT_KEY (parameter, scalar) is the property of the elements to be used as key (its category must be parameter or data, and its format must be string).';
				case IndexedDictionary.IT_LIST
					prop_description = 'IT_LIST (data, itemlist) is the list containing the items.';
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
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			switch prop
				case IndexedDictionary.ID
					prop_settings = Format.getFormatSettings(Format.STRING);
				case IndexedDictionary.IT_CLASS
					prop_settings = Format.getFormatSettings(Format.CLASS);
				case IndexedDictionary.IT_KEY
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case IndexedDictionary.IT_LIST
					prop_settings = Format.getFormatSettings(Format.ITEMLIST);
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
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			switch prop
				case IndexedDictionary.ID
					prop_default = Format.getFormatDefault(Format.STRING, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.IT_CLASS
					prop_default = 'IndexedDictionary';
				case IndexedDictionary.IT_KEY
					prop_default = 1;
				case IndexedDictionary.IT_LIST
					prop_default = Format.getFormatDefault(Format.ITEMLIST, IndexedDictionary.getPropSettings(prop));
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
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			prop_default = IndexedDictionary.conditioning(prop, IndexedDictionary.getPropDefault(prop));
		end
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
			%  Error id: [BRAPH2:IndexedDictionary:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IDICT.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IDICT.
			%   Error id: [BRAPH2:IndexedDictionary:WrongInput]
			%  Element.CHECKPROP(IndexedDictionary, PROP, VALUE) throws error if VALUE has not a valid format for PROP of IndexedDictionary.
			%   Error id: [BRAPH2:IndexedDictionary:WrongInput]
			%  IDICT.CHECKPROP(IndexedDictionary, PROP, VALUE) throws error if VALUE has not a valid format for PROP of IndexedDictionary.
			%   Error id: [BRAPH2:IndexedDictionary:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = IndexedDictionary.getPropProp(pointer);
			
			switch prop
				case IndexedDictionary.ID
					check = Format.checkFormat(Format.STRING, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.IT_CLASS
					check = Format.checkFormat(Format.CLASS, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.IT_KEY
					check = Format.checkFormat(Format.SCALAR, value, IndexedDictionary.getPropSettings(prop));
				case IndexedDictionary.IT_LIST
					check = Format.checkFormat(Format.ITEMLIST, value, IndexedDictionary.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' IndexedDictionary.getPropTag(prop) ' (' IndexedDictionary.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function idict = IndexedDictionary(varargin)
			% IndexedDictionary() creates a indexed dictionary.
			%
			% IndexedDictionary(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% IndexedDictionary(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of IndexedDictionary properties is:
			%  <strong>1</strong> <strong>id</strong> 	ID (data, string) is a few-letter code.
			%  <strong>2</strong> <strong>it_class</strong> 	IT_CLASS (parameter, class) is the class of the item elements.
			%  <strong>3</strong> <strong>it_key</strong> 	IT_KEY (parameter, scalar) is the property of the elements to be used as key (its category must be parameter or data, and its format must be string).
			%  <strong>4</strong> <strong>it_list</strong> 	IT_LIST (data, itemlist) is the list containing the items.
			%
			% See also Category, Format, set, check.
			
			idict = idict@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = IndexedDictionary.getPropProp(pointer);
			
			switch prop
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(idict, prop, value)
			check = true;
			msg = ['Error while checking' tostring(idict) ' ' idict.getPropTag(prop) '.'];
			
			switch prop
				case IndexedDictionary.IT_KEY
					it_class = idict.get('IT_CLASS');
					category = Element.getPropCategory(it_class, value);
					format = Element.getPropFormat(it_class, value);
					check = isequal(format, Format.STRING) && any(strcmp(category, {Category.PARAMETER, Category.DATA}));
					if check 
					    msg = 'All ok!';
					else
					    msg = [ ...
					        'The format of property ''IT_KEY'' must be ''' Format.STRING ''' (it is ''' format '''). ' ...
					        'Its category must be ''' Category.PARAMETER ''' or ''' Category.DATA ''' (it is ''' category ''').' ...
					        ];
					end
					
				case IndexedDictionary.IT_LIST
					check = all(cellfun(@(x) isa(x, idict.get('IT_CLASS')), idict.get('IT_LIST')));
					if check 
					    msg = 'All ok!';
					else
					    msg = ['All items of ''IT_LIST'' must be ' idict.get('IT_CLASS') '.'];
					end
					
				otherwise
					[check, msg] = checkValue@Element(idict, prop, value);
					
			end
		end
	end
	methods % methods
		function str = tostring(idict, varargin)
		    %TOSTRING string with information about the indexed dictionary.
		    %
		    % STR = TOSTRING(IDICT) returns a string with information about the
		    %  indexed dictionary. 
		    %
		    % STR = TOSTRING(IDICT, N) trims the string to the first N characters.
		    %
		    % STR = TOSTRING(IDICT, N, ENDING) ends the string with ENDING if it has
		    %  been trimmed.
		    %
		    % See also disp, tree.
		
			str = [class(idict) ' with ' int2str(idict.length()) ' ' idict.get('IT_CLASS') '.'];
		end
		% inspection
		function it_class = getItemClass(idict)
		    %GETITEMCLASS returns the item class of the indexed dictionary.
		    %
		    % ITEM_CLASS = GETITEMCLASS(IDICT) returns the item class of the indexed dictionary.
		
		    it_class = idict.get('IT_CLASS');
		end
		function n = length(idict)
		    %LENGTH returns the number of items in the indexed dictionary.
		    %
		    % N = LENGTH(IDICT) returns the number of items in the indexed dictionary.
		
		    n = length(idict.get('IT_LIST'));
		end
		function bool = contains(idict, pointer)
		    %CONTAINS checks if an item exists in an indexed dictionary.
		    %
		    % BOOL = CONTAINS(IDICT, POINTER) returns true if POINTER (index, key or
		    %  item) exists in the indexed dictionary DICT.
		    %
		    % See also containsIndex, containsKey, containsItem.
		
		    if isa(pointer, 'numeric')  % pointer is index
		        bool = idict.containsIndex(pointer);
		    elseif isa(pointer, 'char')  % pointer is key
		        bool = idict.containsKey(pointer);
		    elseif isa(pointer, idict.get('IT_CLASS'))  % pointer is item - not necessarily unique
		        bool = idict.containsItem(pointer);
		    else
		        bool = false;
		    end
		end
		function bool = containsIndex(idict, index)
		    %CONTAINSINDEX checks if an index exists in an indexed dictionary.
		    %
		    % BOOL = CONTAINS(IDICT, INDEX) returns true if the INDEX exists in the
		    %  indexed dictionary IDICT.
		    %
		    % See also contains, containsKey, containsItem.
		
		    if index > 0 && index <= idict.length() && index == round(index)
		        bool = true;
		    else
		        bool = false;
		    end
		end
		function bool = containsKey(idict, key)
		    %CONTAINSKEY checks if a key exists in an indexed dictionary.
		    %
		    % BOOL = CONTAINS(IDICT, KEY) returns true if the KEY exists in the indexed
		    %  dictionary DICT.
		    %
		    % See also contains, containsIndex, containsItem.
		
		    bool = false;
		    for i = 1:1:idict.length()
		        if isequal(idict.getKey(i), key)
		            bool = true;
		            break;
		        end
		    end
		end
		function bool = containsItem(idict, item)
		    %CONTAINSITEM checks if an item exists in an indexed dictionary
		    %
		    % BOOL = CONTAINSITEM(IDICT, ITEM) returns true if ITEM exists in the
		    %  indexed dictionary DICT.
		    %
		    % See also contains, containsIndex, containsKey.
		
		    bool = false;
		    for i = 1:1:idict.length()
		        if isequal(idict.getItem(i), item)
		            bool = true;
		            break;
		        end
		    end
		end
		function index = getIndex(idict, pointer) 
		    %GETINDEX returns the index of a key or item.
		    %
		    % INDEX = GETINDEX(IDICT, POINTER) returns the index of a POINTER (a key or
		    %  item).
		    %
		    % See also getIndexFromItem, getIndexFromKey.
		
		   if isa(pointer, 'char')  % pointer is key
		        index = idict.getIndexFromKey(pointer);
		    elseif isa(pointer, idict.get('IT_CLASS'))  % pointer is item - not necessarily unique
		        index = idict.getIndexFromItem(pointer);
		    end
		end
		function index = getIndexFromKey(idict, key)
		    %GETINDEXFROMKEY returns the index of a key.
		    %
		    % INDEX = GETINDEXFROMKEY(IDICT, KEY) returns the index of KEY.
		    %
		    % See also getIndex, getIndexFromItem.
		
		    for i = 1:1:idict.length()
		        if isequal(idict.getKey(i), key)
		            index = i;
		            break;
		        end
		    end
		end
		function index = getIndexFromItem(idict, item)
		    %GETINDEXFROMITEM returns the index of a item.
		    %
		    % INDEX = GETINDEXFROMITEM(IDICT, ITEM) returns the index of the first
		    %  occurrence of ITEM.
		    %
		    % See also getIndex, getIndexFromKey.
		
		    for i = 1:1:idict.length()
		        if isequal(idict.getItem(i), item)
		            index = i;  % return the first occurrence
		            break;
		        end
		    end
		end
		function keys = getKeys(idict)
		    %GETKEYS returns all the keys in the indexed dictionary.
		    %
		    % KEYS = GETKEYS(IDICT) returns all the keys in the indexed dictionary.
		    %
		    % See also getItems.
		
		    keys = cellfun(@(x) x.get(idict.get('IT_KEY')), idict.get('IT_LIST'), 'UniformOutput', false);
		end
		function key = getKey(idict, pointer)
		    %GETKEY returns the key of an index or item.
		    %
		    % KEY = GETKEY(IDICT, POINTER) returns the key of POINTER (a index or
		    %  item). If the POINTER is a item, it returns the first occurrence.
		    %
		    % See also getKeyFromIndex, getKeyFromItem.
		
		    if isa(pointer, idict.get('IT_CLASS'))  % pointer is item - not necessarily unique
		       key = idict.getKeyFromItem(pointer);  % first occurrence
		    else  % pointer is an index
		        it_list = idict.get('IT_LIST');
		        key = it_list{pointer}.get(idict.get('IT_KEY'));
		    end
		end
		function key = getKeyFromIndex(idict, index)
		    %GETKEYFROMINDEX returns the key of an index
		    %
		    % KEY = GETKEYFROMINDEX(IDICT, INDEX) returns the key of INDEX.
		    %
		    % See also getKey, getKeyFromItem.
		
		    it_list = idict.get('IT_LIST');
		    key = it_list{index}.get(idict.get('IT_KEY'));
		end
		function key = getKeyFromItem(idict, item)
		    %GETKEYFROMITEM returns the key of a item.
		    %
		    % KEY = GETKEYFROMITEM(IDICT, ITEM) returns the key of the first occurrence
		    %  of ITEM.
		    %
		    % See also getKey, getKeyFromIndex.
		
		    it_list = idict.get('IT_LIST');
		    index = idict.getIndexFromItem(item);
		    key = it_list{index}.get(idict.get('IT_KEY'));
		end
		function items = getItems(idict)
		    %GETITEMS returns all the items in the indexed dictionary
		    %
		    % ITEMS = GETITEMS(IDICT) returns all the items in the indexed dictionary.
		    %
		    % See also getKeys.
		
		    items = idict.get('IT_LIST');
		end
		function item = getItem(idict, pointer)
		    %GETITEM returns the item of an index or key.
		    %
		    % ITEM = GETITEM(IDICT, POINTER) returns the item of POINTER (an index or key).
		    %
		    % See also getItemFromIndex, getItemFromKey.
		
		    if isa(pointer, 'char')  % pointer is a key
		        item = idict.getItemFromKey(pointer);
		    else  % pointer is an index
		        item = idict.getItemFromIndex(pointer);
		    end            
		end 
		function item = getItemFromIndex(idict, index)    
		    %GETITEMFROMINDEX returns the item of an index.
		    %
		    % ITEM = GETITEMFROMINDEX(IDICT, INDEX) returns the item of INDEX.
		    %
		    % See also getItem, getItemFromKey.
		
		    it_list = idict.get('IT_LIST');
		    item = it_list{index};
		end
		function item = getItemFromKey(idict, key)
		    %GETITEMFROMKEY returns the item of a key.
		    %
		    % ITEM = GETITEMFROMKEY(IDICT, KEY) returns the item of KEY.
		    %
		    % See also getItem, getItemFromIndex.
		
		    index = idict.getIndexFromKey(key);
		    item  = idict.getItemFromIndex(index);
		end
		% editing
		function add(idict, item, index)
		    %ADD adds an item and key to an indexed dictionary
		    %
		    % ADD(IDICT, ITEM, INDEX) adds an item and key to the indexed dictionary in
		    %  position INDEX. If INDEX is empty, it adds it to the end of IDICT.
		    %
		    % See also remove, replace.
		
		    if nargin < 3 || index <= 0 || index > idict.length()
		        index = idict.length() + 1;
		    end
		    
		    assert(isa(item, idict.get('IT_CLASS')), ...
		        [BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_INPUT], ...
		        ['Item must be an object of class ' idict.get('IT_CLASS') ',' ...
		        ' while it is of class ' class(item) '.'])
		    
		    key = item.get(idict.get('IT_KEY'));
		    assert(~any(strcmp(key, idict.getKeys())), ...
		        [BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_INPUT], ...
		        ['Key ''' key ''' is already contained in the indexed dictionary.'])
		
		    it_list = idict.get('IT_LIST');
		    if index <= idict.length()  
		        % create space for {key, item}
		        it_list(index + 1:end + 1) = it_list(index:end);
		        it_list{index} = item;
		    else
		        it_list{end + 1} = item;
		    end
		    idict.set('IT_LIST', it_list)
		end
		function remove(idict, pointer)            
		    %REMOVE removes a key and item from an indexed dictionary.
		    %
		    % REMOVE(IDICT, POINTER) removes the key and item of POINTER (an index, key
		    %  or item) from the indexed dictionary IDICT.
		    %
		    % See also add, replace.
		
		    if isa(pointer, 'char')  % pointer is a key
		        index = idict.getKeyIndex(pointer);
		    elseif isa(pointer, 'numeric')  % pointer is an index
		        index = pointer;
		    elseif isa(pointer, idict.get('IT_CLASS'))  % pointer is a item
		        index = idict.getIndex(pointer);
		    end
		
		    if index > 0 && index <= idict.length() && index == round(index)
		        it_list = idict.get('IT_LIST');
		        it_list(index) = [];
		        idict.set('IT_LIST', it_list);
		    end
		end
		function replace(idict, new_item, index)
		    %REPLACE replaces an item and key in an indexed dictionary.
		    %
		    % REPLACE(IDICT, NEW_ITEM, INDEX) replaces the item and key of INDEX in the
		    %  indexed dictionary IDICT with NEW_ITEM.
		    %
		    % See also add, remove, replaceKey, replaceItem.
		
		    assert(isequal(idict.get('IT_CLASS'), class(new_item)), ...
		        [BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT], ...
		        'The item is not of the correct class.')
		
		    if idict.contains(index)
		        idict.remove(index)
		        idict.add(new_item, index)
		    end
		end
		function replaceKey(idict, old_key, new_key)
		    %REPLACEKEY replaces key in indexed dictionary.
		    %
		    % REPLACEKEY(IDICT, OLD_KEY, NEW_KEY) replaces OLD_KEY in the indexed
		    %  dictionary IDICT with NEW_KEY.
		    %
		    % See also replace, replaceItem.
		
		    item = idict.getItemFromKey(old_key);
		    item.set(idict.get('IT_KEY'), new_key)
		end
		function replaceItem(idict, old_item, new_item)
		    %REPLACEITEM replaces item in indexed dictionary.
		    %
		    % REPLACEITEM(IDICT, OLD_ITEM, NEW_ITEM) replaces OLD_ITEM with NEW_ITEM in
		    %  the indexed dictionary IDICT. It replaces only the first occurrence of
		    %  OLD_ITEM.
		    %
		    % See also replace, replaceKey.
		
		    index = idict.getIndexFromItem(old_item);
		    idict.replace(new_item, index);
		end
		function invert(idict, i, j)
		    %INVERT inverts position of two items in indexed dictionary.
		    %
		    % INVERT(IDICT, INDEXI, INDEXJ) inverts the positions of the items at
		    %  INDEX_I and INDEX_J in the indexed dictionary IDICT.
		    %
		    % See also move_to.
		
		    if i > j
		        if i > 0 && i <= idict.length() && j > 0 && j <= idict.length() && i ~= j
		            item_i = idict.getItem(i);
		            item_j = idict.getItem(j);
		
		            idict.remove(i)
		            idict.remove(j)
		
		            idict.add(item_i, j);
		            idict.add(item_j, i);
		        end
		    else
		        idict.invert(j, i);
		    end
		end
		function move_to(idict, i, j)
		    %MOVE_TO moves an item of an indexed dictionary to another position.
		    %
		    % MOVE_TO(IDICT, OLD_INDEX, NEW_INDEX) moves an item from position
		    %  OLD_INDEX to position NEW_INDEX in the indexed dictionary IDICT.
		    %
		    % See also invert.
		
		    if i > 0 && i <= idict.length() && j > 0 && j <= idict.length() && i ~= j
		        item = idict.getItem(i);
		        idict.remove(i)
		        idict.add(item, j)
		    end
		end
		function selected = remove_all(idict, selected)
		    %REMOVE_ALL removes selected items.
		    %
		    % SELECTED = REMOVE_ALL(IDICT, SELECTED) removes all items whose positions
		    %  in the indexed dictionary DICT are included in the array SELECTED. It
		    %  returns an empty array.
		    %
		    % See also move_up, move_down, move_to_top, move_to_bottom.
		
		    for i = length(selected):-1:1
		        idict.remove(selected(i))
		    end
		    selected = [];
		end
		function selected =  move_up(idict, selected)
		    %MOVE_UP moves up selected items.
		    %
		    % SELECTED = MOVE_UP(IDICT, SELECTED) moves up by one position all items
		    %  whose positions in the indexed dictionary DICT are included in the
		    %  SELECTED array and returns their final positions.
		    %
		    % See also remove_all, move_down, move_to_top, move_to_bottom.
		
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
		    %MOVE_DOWN moves down selected items.
		    %
		    % SELECTED = MOVE_DOWN(IDICT, SELECTED) moves down by one position all
		    %  items whose positions in the indexed dictionary DICT are included in the
		    %  SELECTED array and returns their final positions.  
		    %
		    % See also remove_all, move_up, move_to_top, move_to_bottom.
		
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
		    %MOVE_TO_TOP moves selected items to top.
		    %
		    % SELECTED = MOVE_TO_TOP(IDICT, SELECTED) moves to top all items whose
		    %  positions in the indexed dictionary DICT are included in the SELECTED
		    %  array and returns their final positions.
		    %
		    % See also remove_all, move_up, move_down, move_to_bottom.
		
		    if ~isempty(selected)
		        for i = 1:1:numel(selected)
		            idict.move_to(selected(i), i);
		        end
		        selected = reshape(1:1:numel(selected), size(selected));
		    end
		end
		function selected = move_to_bottom(idict, selected)
		    %MOVE_TO_BOTTOM moves selected items to bottom.
		    %
		    % SELECTED = MOVE_TO_BOTTOM(IDICT, SELECTED) moves to bottom all items
		    %  whose positions in the indexed dictionary DICT dictionary are included in
		    %  the SELECTED array and returns their final positions.
		    %
		    % See also remove_all, move_up, move_down, move_to_top.
		
		    if ~isempty(selected)
		        for i = numel(selected):-1:1
		            idict.move_to(selected(i), idict.length() - (numel(selected)-i));
		        end
		        selected = reshape(idict.length() - numel(selected)+1:1:idict.length(), size(selected));
		    end
		end
	end
end
