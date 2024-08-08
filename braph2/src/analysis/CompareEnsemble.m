classdef CompareEnsemble < ConcreteElement
	%CompareEnsemble is a comparison between two ensemble-based analyses.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% CompareEnsemble compares two ensemble-based analyses, 
	% which need to be of the same class.
	%
	% CompareEnsemble methods (constructor):
	%  CompareEnsemble - constructor
	%
	% CompareEnsemble methods:
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
	% CompareEnsemble methods (display):
	%  tostring - string with information about the ensemble-based comparison
	%  disp - displays information about the ensemble-based comparison
	%  tree - displays the tree of the ensemble-based comparison
	%
	% CompareEnsemble methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two ensemble-based comparison are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the ensemble-based comparison
	%
	% CompareEnsemble methods (save/load, Static):
	%  save - saves BRAPH2 ensemble-based comparison as b2 file
	%  load - loads a BRAPH2 ensemble-based comparison from a b2 file
	%
	% CompareEnsemble method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ensemble-based comparison
	%
	% CompareEnsemble method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the ensemble-based comparison
	%
	% CompareEnsemble methods (inspection, Static):
	%  getClass - returns the class of the ensemble-based comparison
	%  getSubclasses - returns all subclasses of CompareEnsemble
	%  getProps - returns the property list of the ensemble-based comparison
	%  getPropNumber - returns the property number of the ensemble-based comparison
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
	% CompareEnsemble methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% CompareEnsemble methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% CompareEnsemble methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% CompareEnsemble methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?CompareEnsemble; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">CompareEnsemble constants</a>.
	%
	%
	% See also AnalyzeEnsemble, ComparisonEnsemble.
	
	properties (Constant) % properties
		WAITBAR = ConcreteElement.getPropNumber() + 1;
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = Category.GUI;
		WAITBAR_FORMAT = Format.LOGICAL;
		
		VERBOSE = ConcreteElement.getPropNumber() + 2;
		VERBOSE_TAG = 'VERBOSE';
		VERBOSE_CATEGORY = Category.GUI;
		VERBOSE_FORMAT = Format.LOGICAL;
		
		INTERRUPTIBLE = ConcreteElement.getPropNumber() + 3;
		INTERRUPTIBLE_TAG = 'INTERRUPTIBLE';
		INTERRUPTIBLE_CATEGORY = Category.GUI;
		INTERRUPTIBLE_FORMAT = Format.SCALAR;
		
		MEMORIZE = ConcreteElement.getPropNumber() + 4;
		MEMORIZE_TAG = 'MEMORIZE';
		MEMORIZE_CATEGORY = Category.METADATA;
		MEMORIZE_FORMAT = Format.LOGICAL;
		
		P = ConcreteElement.getPropNumber() + 5;
		P_TAG = 'P';
		P_CATEGORY = Category.PARAMETER;
		P_FORMAT = Format.SCALAR;
		
		LONGITUDINAL = ConcreteElement.getPropNumber() + 6;
		LONGITUDINAL_TAG = 'LONGITUDINAL';
		LONGITUDINAL_CATEGORY = Category.PARAMETER;
		LONGITUDINAL_FORMAT = Format.LOGICAL;
		
		A1 = ConcreteElement.getPropNumber() + 7;
		A1_TAG = 'A1';
		A1_CATEGORY = Category.DATA;
		A1_FORMAT = Format.ITEM;
		
		A2 = ConcreteElement.getPropNumber() + 8;
		A2_TAG = 'A2';
		A2_CATEGORY = Category.DATA;
		A2_FORMAT = Format.ITEM;
		
		PERM_SEEDS = ConcreteElement.getPropNumber() + 9;
		PERM_SEEDS_TAG = 'PERM_SEEDS';
		PERM_SEEDS_CATEGORY = Category.RESULT;
		PERM_SEEDS_FORMAT = Format.RVECTOR;
		
		A1_PERM_DICT = ConcreteElement.getPropNumber() + 10;
		A1_PERM_DICT_TAG = 'A1_PERM_DICT';
		A1_PERM_DICT_CATEGORY = Category.RESULT;
		A1_PERM_DICT_FORMAT = Format.IDICT;
		
		A2_PERM_DICT = ConcreteElement.getPropNumber() + 11;
		A2_PERM_DICT_TAG = 'A2_PERM_DICT';
		A2_PERM_DICT_CATEGORY = Category.RESULT;
		A2_PERM_DICT_FORMAT = Format.IDICT;
		
		CP_DICT = ConcreteElement.getPropNumber() + 12;
		CP_DICT_TAG = 'CP_DICT';
		CP_DICT_CATEGORY = Category.RESULT;
		CP_DICT_FORMAT = Format.IDICT;
		
		COMPARISON = ConcreteElement.getPropNumber() + 13;
		COMPARISON_TAG = 'COMPARISON';
		COMPARISON_CATEGORY = Category.QUERY;
		COMPARISON_FORMAT = Format.ITEM;
		
		PERM = ConcreteElement.getPropNumber() + 14;
		PERM_TAG = 'PERM';
		PERM_CATEGORY = Category.QUERY;
		PERM_FORMAT = Format.ITEMLIST;
	end
	methods % constructor
		function c = CompareEnsemble(varargin)
			%CompareEnsemble() creates a ensemble-based comparison.
			%
			% CompareEnsemble(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% CompareEnsemble(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			c = c@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function c_class = getClass()
			%GETCLASS returns the class of the ensemble-based comparison.
			%
			% CLASS = CompareEnsemble.GETCLASS() returns the class 'CompareEnsemble'.
			%
			% Alternative forms to call this method are:
			%  CLASS = C.GETCLASS() returns the class of the ensemble-based comparison C.
			%  CLASS = Element.GETCLASS(C) returns the class of 'C'.
			%  CLASS = Element.GETCLASS('CompareEnsemble') returns 'CompareEnsemble'.
			%
			% Note that the Element.GETCLASS(C) and Element.GETCLASS('CompareEnsemble')
			%  are less computationally efficient.
			
			c_class = 'CompareEnsemble';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the ensemble-based comparison.
			%
			% LIST = CompareEnsemble.GETSUBCLASSES() returns all subclasses of 'CompareEnsemble'.
			%
			% Alternative forms to call this method are:
			%  LIST = C.GETSUBCLASSES() returns all subclasses of the ensemble-based comparison C.
			%  LIST = Element.GETSUBCLASSES(C) returns all subclasses of 'C'.
			%  LIST = Element.GETSUBCLASSES('CompareEnsemble') returns all subclasses of 'CompareEnsemble'.
			%
			% Note that the Element.GETSUBCLASSES(C) and Element.GETSUBCLASSES('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('CompareEnsemble', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of ensemble-based comparison.
			%
			% PROPS = CompareEnsemble.GETPROPS() returns the property list of ensemble-based comparison
			%  as a row vector.
			%
			% PROPS = CompareEnsemble.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = C.GETPROPS([CATEGORY]) returns the property list of the ensemble-based comparison C.
			%  PROPS = Element.GETPROPS(C[, CATEGORY]) returns the property list of 'C'.
			%  PROPS = Element.GETPROPS('CompareEnsemble'[, CATEGORY]) returns the property list of 'CompareEnsemble'.
			%
			% Note that the Element.GETPROPS(C) and Element.GETPROPS('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						CompareEnsemble.WAITBAR ...
						CompareEnsemble.VERBOSE ...
						CompareEnsemble.INTERRUPTIBLE ...
						CompareEnsemble.MEMORIZE ...
						CompareEnsemble.P ...
						CompareEnsemble.LONGITUDINAL ...
						CompareEnsemble.A1 ...
						CompareEnsemble.A2 ...
						CompareEnsemble.PERM_SEEDS ...
						CompareEnsemble.A1_PERM_DICT ...
						CompareEnsemble.A2_PERM_DICT ...
						CompareEnsemble.CP_DICT ...
						CompareEnsemble.COMPARISON ...
						CompareEnsemble.PERM ...
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
						CompareEnsemble.MEMORIZE ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						CompareEnsemble.P ...
						CompareEnsemble.LONGITUDINAL ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						CompareEnsemble.A1 ...
						CompareEnsemble.A2 ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						CompareEnsemble.PERM_SEEDS ...
						CompareEnsemble.A1_PERM_DICT ...
						CompareEnsemble.A2_PERM_DICT ...
						CompareEnsemble.CP_DICT ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						CompareEnsemble.COMPARISON ...
						CompareEnsemble.PERM ...
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
						CompareEnsemble.WAITBAR ...
						CompareEnsemble.VERBOSE ...
						CompareEnsemble.INTERRUPTIBLE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of ensemble-based comparison.
			%
			% N = CompareEnsemble.GETPROPNUMBER() returns the property number of ensemble-based comparison.
			%
			% N = CompareEnsemble.GETPROPNUMBER(CATEGORY) returns the property number of ensemble-based comparison
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = C.GETPROPNUMBER([CATEGORY]) returns the property number of the ensemble-based comparison C.
			%  N = Element.GETPROPNUMBER(C) returns the property number of 'C'.
			%  N = Element.GETPROPNUMBER('CompareEnsemble') returns the property number of 'CompareEnsemble'.
			%
			% Note that the Element.GETPROPNUMBER(C) and Element.GETPROPNUMBER('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(CompareEnsemble.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in ensemble-based comparison/error.
			%
			% CHECK = CompareEnsemble.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = C.EXISTSPROP(PROP) checks whether PROP exists for C.
			%  CHECK = Element.EXISTSPROP(C, PROP) checks whether PROP exists for C.
			%  CHECK = Element.EXISTSPROP(CompareEnsemble, PROP) checks whether PROP exists for CompareEnsemble.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  C.EXISTSPROP(PROP) throws error if PROP does NOT exist for C.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%  Element.EXISTSPROP(C, PROP) throws error if PROP does NOT exist for C.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%  Element.EXISTSPROP(CompareEnsemble, PROP) throws error if PROP does NOT exist for CompareEnsemble.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%
			% Note that the Element.EXISTSPROP(C) and Element.EXISTSPROP('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == CompareEnsemble.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':CompareEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CompareEnsemble:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for CompareEnsemble.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in ensemble-based comparison/error.
			%
			% CHECK = CompareEnsemble.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = C.EXISTSTAG(TAG) checks whether TAG exists for C.
			%  CHECK = Element.EXISTSTAG(C, TAG) checks whether TAG exists for C.
			%  CHECK = Element.EXISTSTAG(CompareEnsemble, TAG) checks whether TAG exists for CompareEnsemble.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%
			% Alternative forms to call this method are:
			%  C.EXISTSTAG(TAG) throws error if TAG does NOT exist for C.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%  Element.EXISTSTAG(C, TAG) throws error if TAG does NOT exist for C.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%  Element.EXISTSTAG(CompareEnsemble, TAG) throws error if TAG does NOT exist for CompareEnsemble.
			%   Error id: [BRAPH2:CompareEnsemble:WrongInput]
			%
			% Note that the Element.EXISTSTAG(C) and Element.EXISTSTAG('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			compareensemble_tag_list = cellfun(@(x) CompareEnsemble.getPropTag(x), num2cell(CompareEnsemble.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, compareensemble_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':CompareEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CompareEnsemble:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for CompareEnsemble.'] ...
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
			%  PROPERTY = C.GETPROPPROP(POINTER) returns property number of POINTER of C.
			%  PROPERTY = Element.GETPROPPROP(CompareEnsemble, POINTER) returns property number of POINTER of CompareEnsemble.
			%  PROPERTY = C.GETPROPPROP(CompareEnsemble, POINTER) returns property number of POINTER of CompareEnsemble.
			%
			% Note that the Element.GETPROPPROP(C) and Element.GETPROPPROP('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				compareensemble_tag_list = cellfun(@(x) CompareEnsemble.getPropTag(x), num2cell(CompareEnsemble.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, compareensemble_tag_list)); % tag = pointer
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
			%  TAG = C.GETPROPTAG(POINTER) returns tag of POINTER of C.
			%  TAG = Element.GETPROPTAG(CompareEnsemble, POINTER) returns tag of POINTER of CompareEnsemble.
			%  TAG = C.GETPROPTAG(CompareEnsemble, POINTER) returns tag of POINTER of CompareEnsemble.
			%
			% Note that the Element.GETPROPTAG(C) and Element.GETPROPTAG('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case CompareEnsemble.WAITBAR
						tag = CompareEnsemble.WAITBAR_TAG;
					case CompareEnsemble.VERBOSE
						tag = CompareEnsemble.VERBOSE_TAG;
					case CompareEnsemble.INTERRUPTIBLE
						tag = CompareEnsemble.INTERRUPTIBLE_TAG;
					case CompareEnsemble.MEMORIZE
						tag = CompareEnsemble.MEMORIZE_TAG;
					case CompareEnsemble.P
						tag = CompareEnsemble.P_TAG;
					case CompareEnsemble.LONGITUDINAL
						tag = CompareEnsemble.LONGITUDINAL_TAG;
					case CompareEnsemble.A1
						tag = CompareEnsemble.A1_TAG;
					case CompareEnsemble.A2
						tag = CompareEnsemble.A2_TAG;
					case CompareEnsemble.PERM_SEEDS
						tag = CompareEnsemble.PERM_SEEDS_TAG;
					case CompareEnsemble.A1_PERM_DICT
						tag = CompareEnsemble.A1_PERM_DICT_TAG;
					case CompareEnsemble.A2_PERM_DICT
						tag = CompareEnsemble.A2_PERM_DICT_TAG;
					case CompareEnsemble.CP_DICT
						tag = CompareEnsemble.CP_DICT_TAG;
					case CompareEnsemble.COMPARISON
						tag = CompareEnsemble.COMPARISON_TAG;
					case CompareEnsemble.PERM
						tag = CompareEnsemble.PERM_TAG;
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
			%  CATEGORY = C.GETPROPCATEGORY(POINTER) returns category of POINTER of C.
			%  CATEGORY = Element.GETPROPCATEGORY(CompareEnsemble, POINTER) returns category of POINTER of CompareEnsemble.
			%  CATEGORY = C.GETPROPCATEGORY(CompareEnsemble, POINTER) returns category of POINTER of CompareEnsemble.
			%
			% Note that the Element.GETPROPCATEGORY(C) and Element.GETPROPCATEGORY('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			switch prop
				case CompareEnsemble.WAITBAR
					prop_category = CompareEnsemble.WAITBAR_CATEGORY;
				case CompareEnsemble.VERBOSE
					prop_category = CompareEnsemble.VERBOSE_CATEGORY;
				case CompareEnsemble.INTERRUPTIBLE
					prop_category = CompareEnsemble.INTERRUPTIBLE_CATEGORY;
				case CompareEnsemble.MEMORIZE
					prop_category = CompareEnsemble.MEMORIZE_CATEGORY;
				case CompareEnsemble.P
					prop_category = CompareEnsemble.P_CATEGORY;
				case CompareEnsemble.LONGITUDINAL
					prop_category = CompareEnsemble.LONGITUDINAL_CATEGORY;
				case CompareEnsemble.A1
					prop_category = CompareEnsemble.A1_CATEGORY;
				case CompareEnsemble.A2
					prop_category = CompareEnsemble.A2_CATEGORY;
				case CompareEnsemble.PERM_SEEDS
					prop_category = CompareEnsemble.PERM_SEEDS_CATEGORY;
				case CompareEnsemble.A1_PERM_DICT
					prop_category = CompareEnsemble.A1_PERM_DICT_CATEGORY;
				case CompareEnsemble.A2_PERM_DICT
					prop_category = CompareEnsemble.A2_PERM_DICT_CATEGORY;
				case CompareEnsemble.CP_DICT
					prop_category = CompareEnsemble.CP_DICT_CATEGORY;
				case CompareEnsemble.COMPARISON
					prop_category = CompareEnsemble.COMPARISON_CATEGORY;
				case CompareEnsemble.PERM
					prop_category = CompareEnsemble.PERM_CATEGORY;
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
			%  FORMAT = C.GETPROPFORMAT(POINTER) returns format of POINTER of C.
			%  FORMAT = Element.GETPROPFORMAT(CompareEnsemble, POINTER) returns format of POINTER of CompareEnsemble.
			%  FORMAT = C.GETPROPFORMAT(CompareEnsemble, POINTER) returns format of POINTER of CompareEnsemble.
			%
			% Note that the Element.GETPROPFORMAT(C) and Element.GETPROPFORMAT('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			switch prop
				case CompareEnsemble.WAITBAR
					prop_format = CompareEnsemble.WAITBAR_FORMAT;
				case CompareEnsemble.VERBOSE
					prop_format = CompareEnsemble.VERBOSE_FORMAT;
				case CompareEnsemble.INTERRUPTIBLE
					prop_format = CompareEnsemble.INTERRUPTIBLE_FORMAT;
				case CompareEnsemble.MEMORIZE
					prop_format = CompareEnsemble.MEMORIZE_FORMAT;
				case CompareEnsemble.P
					prop_format = CompareEnsemble.P_FORMAT;
				case CompareEnsemble.LONGITUDINAL
					prop_format = CompareEnsemble.LONGITUDINAL_FORMAT;
				case CompareEnsemble.A1
					prop_format = CompareEnsemble.A1_FORMAT;
				case CompareEnsemble.A2
					prop_format = CompareEnsemble.A2_FORMAT;
				case CompareEnsemble.PERM_SEEDS
					prop_format = CompareEnsemble.PERM_SEEDS_FORMAT;
				case CompareEnsemble.A1_PERM_DICT
					prop_format = CompareEnsemble.A1_PERM_DICT_FORMAT;
				case CompareEnsemble.A2_PERM_DICT
					prop_format = CompareEnsemble.A2_PERM_DICT_FORMAT;
				case CompareEnsemble.CP_DICT
					prop_format = CompareEnsemble.CP_DICT_FORMAT;
				case CompareEnsemble.COMPARISON
					prop_format = CompareEnsemble.COMPARISON_FORMAT;
				case CompareEnsemble.PERM
					prop_format = CompareEnsemble.PERM_FORMAT;
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
			%  DESCRIPTION = C.GETPROPDESCRIPTION(POINTER) returns description of POINTER of C.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(CompareEnsemble, POINTER) returns description of POINTER of CompareEnsemble.
			%  DESCRIPTION = C.GETPROPDESCRIPTION(CompareEnsemble, POINTER) returns description of POINTER of CompareEnsemble.
			%
			% Note that the Element.GETPROPDESCRIPTION(C) and Element.GETPROPDESCRIPTION('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			switch prop
				case CompareEnsemble.WAITBAR
					prop_description = 'WAITBAR (gui, logical) detemines whether to show the waitbar.';
				case CompareEnsemble.VERBOSE
					prop_description = 'VERBOSE (gui, logical) sets whether to write the progress of the comparisons.';
				case CompareEnsemble.INTERRUPTIBLE
					prop_description = 'INTERRUPTIBLE (gui, scalar) sets whether the comparison computation is interruptible for multitasking.';
				case CompareEnsemble.MEMORIZE
					prop_description = 'MEMORIZE (metadata, logical) sets whether to memorize the permuted analyses.';
				case CompareEnsemble.P
					prop_description = 'P (parameter, scalar) is the permutation number.';
				case CompareEnsemble.LONGITUDINAL
					prop_description = 'LONGITUDINAL (parameter, logical) determines whether the comparison is longitudinal.';
				case CompareEnsemble.A1
					prop_description = 'A1 (data, item) is the first analysis to compare.';
				case CompareEnsemble.A2
					prop_description = 'A2 (data, item) is the second analysis to compare.';
				case CompareEnsemble.PERM_SEEDS
					prop_description = 'PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.';
				case CompareEnsemble.A1_PERM_DICT
					prop_description = 'A1_PERM_DICT (result, idict) is the list of permuted analyses for the first analysis.';
				case CompareEnsemble.A2_PERM_DICT
					prop_description = 'A2_PERM_DICT (result, idict) is the list of permuted analyses for the second analysis.';
				case CompareEnsemble.CP_DICT
					prop_description = 'CP_DICT (result, idict) contains the results of the comparison.';
				case CompareEnsemble.COMPARISON
					prop_description = 'COMPARISON (query, item) returns a comparison.';
				case CompareEnsemble.PERM
					prop_description = 'PERM (query, itemlist) returns the permuted analyses.';
				case CompareEnsemble.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case CompareEnsemble.NAME
					prop_description = 'NAME (constant, string) is the name of the comparison between two ensemble-based analyses.';
				case CompareEnsemble.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the comparison between two ensemble-based analyses.';
				case CompareEnsemble.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the comparison between two ensemble-based analyses.';
				case CompareEnsemble.ID
					prop_description = 'ID (data, string) is a few-letter code for the comparison between two ensemble-based analyses.';
				case CompareEnsemble.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the comparison between two ensemble-based analyses.';
				case CompareEnsemble.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the comparison between two ensemble-based analyses.';
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
			%  SETTINGS = C.GETPROPSETTINGS(POINTER) returns settings of POINTER of C.
			%  SETTINGS = Element.GETPROPSETTINGS(CompareEnsemble, POINTER) returns settings of POINTER of CompareEnsemble.
			%  SETTINGS = C.GETPROPSETTINGS(CompareEnsemble, POINTER) returns settings of POINTER of CompareEnsemble.
			%
			% Note that the Element.GETPROPSETTINGS(C) and Element.GETPROPSETTINGS('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			switch prop
				case CompareEnsemble.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case CompareEnsemble.VERBOSE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case CompareEnsemble.INTERRUPTIBLE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case CompareEnsemble.MEMORIZE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case CompareEnsemble.P
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case CompareEnsemble.LONGITUDINAL
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case CompareEnsemble.A1
					prop_settings = 'AnalyzeEnsemble';
				case CompareEnsemble.A2
					prop_settings = 'AnalyzeEnsemble';
				case CompareEnsemble.PERM_SEEDS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case CompareEnsemble.A1_PERM_DICT
					prop_settings = 'AnalyzeEnsemble';
				case CompareEnsemble.A2_PERM_DICT
					prop_settings = 'AnalyzeEnsemble';
				case CompareEnsemble.CP_DICT
					prop_settings = 'ComparisonEnsemble';
				case CompareEnsemble.COMPARISON
					prop_settings = 'ComparisonEnsemble';
				case CompareEnsemble.PERM
					prop_settings = Format.getFormatSettings(Format.ITEMLIST);
				case CompareEnsemble.TEMPLATE
					prop_settings = 'CompareEnsemble';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = CompareEnsemble.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = CompareEnsemble.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = C.GETPROPDEFAULT(POINTER) returns the default value of POINTER of C.
			%  DEFAULT = Element.GETPROPDEFAULT(CompareEnsemble, POINTER) returns the default value of POINTER of CompareEnsemble.
			%  DEFAULT = C.GETPROPDEFAULT(CompareEnsemble, POINTER) returns the default value of POINTER of CompareEnsemble.
			%
			% Note that the Element.GETPROPDEFAULT(C) and Element.GETPROPDEFAULT('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			switch prop
				case CompareEnsemble.WAITBAR
					prop_default = true;
				case CompareEnsemble.VERBOSE
					prop_default = false;
				case CompareEnsemble.INTERRUPTIBLE
					prop_default = .001;
				case CompareEnsemble.MEMORIZE
					prop_default = Format.getFormatDefault(Format.LOGICAL, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.P
					prop_default = 1e+4;
				case CompareEnsemble.LONGITUDINAL
					prop_default = Format.getFormatDefault(Format.LOGICAL, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.A1
					prop_default = Format.getFormatDefault(Format.ITEM, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.A2
					prop_default = Format.getFormatDefault(Format.ITEM, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.PERM_SEEDS
					prop_default = Format.getFormatDefault(Format.RVECTOR, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.A1_PERM_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.A2_PERM_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.CP_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.COMPARISON
					prop_default = Format.getFormatDefault(Format.ITEM, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.PERM
					prop_default = Format.getFormatDefault(Format.ITEMLIST, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.ELCLASS
					prop_default = 'CompareEnsemble';
				case CompareEnsemble.NAME
					prop_default = 'CompareEnsemble';
				case CompareEnsemble.DESCRIPTION
					prop_default = 'CompareEnsemble compares two ensemble-based analyses, which need to be of the same class.';
				case CompareEnsemble.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.ID
					prop_default = 'CompareEnsemble ID';
				case CompareEnsemble.LABEL
					prop_default = 'CompareEnsemble label';
				case CompareEnsemble.NOTES
					prop_default = 'CompareEnsemble notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = CompareEnsemble.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = CompareEnsemble.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = C.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of C.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(CompareEnsemble, POINTER) returns the conditioned default value of POINTER of CompareEnsemble.
			%  DEFAULT = C.GETPROPDEFAULTCONDITIONED(CompareEnsemble, POINTER) returns the conditioned default value of POINTER of CompareEnsemble.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(C) and Element.GETPROPDEFAULTCONDITIONED('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			prop_default = CompareEnsemble.conditioning(prop, CompareEnsemble.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = C.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = C.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of C.
			%  CHECK = Element.CHECKPROP(CompareEnsemble, PROP, VALUE) checks VALUE format for PROP of CompareEnsemble.
			%  CHECK = C.CHECKPROP(CompareEnsemble, PROP, VALUE) checks VALUE format for PROP of CompareEnsemble.
			% 
			% C.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:CompareEnsemble:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  C.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of C.
			%   Error id: €BRAPH2.STR€:CompareEnsemble:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(CompareEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CompareEnsemble.
			%   Error id: €BRAPH2.STR€:CompareEnsemble:€BRAPH2.WRONG_INPUT€
			%  C.CHECKPROP(CompareEnsemble, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CompareEnsemble.
			%   Error id: €BRAPH2.STR€:CompareEnsemble:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(C) and Element.CHECKPROP('CompareEnsemble')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = CompareEnsemble.getPropProp(pointer);
			
			switch prop
				case CompareEnsemble.WAITBAR % __CompareEnsemble.WAITBAR__
					check = Format.checkFormat(Format.LOGICAL, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.VERBOSE % __CompareEnsemble.VERBOSE__
					check = Format.checkFormat(Format.LOGICAL, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.INTERRUPTIBLE % __CompareEnsemble.INTERRUPTIBLE__
					check = Format.checkFormat(Format.SCALAR, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.MEMORIZE % __CompareEnsemble.MEMORIZE__
					check = Format.checkFormat(Format.LOGICAL, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.P % __CompareEnsemble.P__
					check = Format.checkFormat(Format.SCALAR, value, CompareEnsemble.getPropSettings(prop));
					if check
						check = value > 0 && value == round(value);
					end
				case CompareEnsemble.LONGITUDINAL % __CompareEnsemble.LONGITUDINAL__
					check = Format.checkFormat(Format.LOGICAL, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.A1 % __CompareEnsemble.A1__
					check = Format.checkFormat(Format.ITEM, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.A2 % __CompareEnsemble.A2__
					check = Format.checkFormat(Format.ITEM, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.PERM_SEEDS % __CompareEnsemble.PERM_SEEDS__
					check = Format.checkFormat(Format.RVECTOR, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.A1_PERM_DICT % __CompareEnsemble.A1_PERM_DICT__
					check = Format.checkFormat(Format.IDICT, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.A2_PERM_DICT % __CompareEnsemble.A2_PERM_DICT__
					check = Format.checkFormat(Format.IDICT, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.CP_DICT % __CompareEnsemble.CP_DICT__
					check = Format.checkFormat(Format.IDICT, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.COMPARISON % __CompareEnsemble.COMPARISON__
					check = Format.checkFormat(Format.ITEM, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.PERM % __CompareEnsemble.PERM__
					check = Format.checkFormat(Format.ITEMLIST, value, CompareEnsemble.getPropSettings(prop));
				case CompareEnsemble.TEMPLATE % __CompareEnsemble.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, CompareEnsemble.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':CompareEnsemble:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CompareEnsemble:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' CompareEnsemble.getPropTag(prop) ' (' CompareEnsemble.getFormatTag(CompareEnsemble.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(c, prop, varargin)
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
				case CompareEnsemble.PERM_SEEDS % __CompareEnsemble.PERM_SEEDS__
					rng_settings_ = rng(); rng(c.getPropSeed(CompareEnsemble.PERM_SEEDS), 'twister')
					
					value = randi(intmax('uint32'), 1, c.get('P'));
					
					rng(rng_settings_)
					
				case CompareEnsemble.A1_PERM_DICT % __CompareEnsemble.A1_PERM_DICT__
					rng_settings_ = rng(); rng(c.getPropSeed(CompareEnsemble.A1_PERM_DICT), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'AnalyzeEnsemble', 'IT_KEY', 1);
					
					rng(rng_settings_)
					
				case CompareEnsemble.A2_PERM_DICT % __CompareEnsemble.A2_PERM_DICT__
					rng_settings_ = rng(); rng(c.getPropSeed(CompareEnsemble.A2_PERM_DICT), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'AnalyzeEnsemble', 'IT_KEY', 1);
					
					rng(rng_settings_)
					
				case CompareEnsemble.CP_DICT % __CompareEnsemble.CP_DICT__
					rng_settings_ = rng(); rng(c.getPropSeed(CompareEnsemble.CP_DICT), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'ComparisonEnsemble', 'IT_KEY', ComparisonEnsemble.MEASURE);
					
					rng(rng_settings_)
					
				case CompareEnsemble.COMPARISON % __CompareEnsemble.COMPARISON__
					% CP = c.get('COMPARISON', MEASURE_CLASS) checks if the comparison exists 
					%  in the comparison dictionary CP_DICT. If not, it creates a new comparison
					%  CP of class MEASURE_CLASS. The user must call getValue() for the new
					%  comparison CP to retrieve the value of the comparison. 
					if isempty(varargin)
					    value = ComparisonEnsemble();
					    
					    % % Warning commented because it most likely will lead to an error anyways
					    % warning( ...
					    %     [BRAPH2.STR ':' class(g)], ...
					    %     [BRAPH2.STR ':' class(g) '\n' ...
					    %     'Missing argument MEASURE_CLASS when using CompareGroup.get(''COMPARISON'', MEASURE_CLASS).'] ...
					    %     )
					    
					    return
					end
					measure_class = varargin{1};
					
					g = c.get('A1').get('GRAPH_TEMPLATE');
					m_list = g.get('COMPATIBLE_MEASURES');
					assert( ...
					    contains(measure_class, m_list), ...
					    [BRAPH2.STR ':CompareEnsemble:' BRAPH2.WRONG_INPUT], ...
					    [BRAPH2.STR ':CompareEnsemble:' BRAPH2.WRONG_INPUT ' \n' ...
						 c.get('A1').getClass() ' utilizes graphs of type ' g.getClass() '. \n' ...
					     measure_class ' is not a compatible Measure with ' g.getClass() '. \n' ...
					    'Use ' g.getClass() '().get(''COMPATIBLE_MEASURES'') for a list of compatible measures.']);
					
					
					cp_dict = c.memorize('CP_DICT');
					if cp_dict.get('CONTAINS_KEY', measure_class)
						cp = cp_dict.get('IT', measure_class);
					else
					    cp = ComparisonEnsemble( ...
					        'ID', [measure_class ' comparison ' c.get('A1').get('ID') ' vs. ' c.get('A2').get('ID')], ...
					        'MEASURE', measure_class, ...
					        'C', c ...
					        );
						cp_dict.get('ADD', cp);
					end
					
					value = cp;
					
				case CompareEnsemble.PERM % __CompareEnsemble.PERM__
					% {A1P, A2P} = c.get('PERM', I) retunrs the I-th permutations for the analysis
					%  A1P and A2P. The number of perutations must be smaller than the
					%  permutation number P, which is one of the properties of the comparison.
					%
					% {A1P, A2P} = c.get(C, I, true) memorizes the resulting permutations.
					i = 1;
					if length(varargin) >= 1
					    i = varargin{1};
					end 
					memorize = false;
					if length(varargin) >= 2
					    memorize = varargin{2};
					end
					
					a1 = c.get('A1');
					key1 = [a1.get('ID') ' permutation ' int2str(i)];
					
					a2 = c.get('A2');
					key2 = [a2.get('ID') ' permutation ' int2str(i)];
					
					a1_perm_dict = c.memorize('A1_PERM_DICT');
					a2_perm_dict = c.memorize('A2_PERM_DICT');
					if a1_perm_dict.get('CONTAINS_KEY', key1) && a2_perm_dict.get('CONTAINS_KEY', key2)
						% retrieves if already memorized
					    a1_perm = a1_perm_dict.get('IT', key1);
					    a2_perm = a2_perm_dict.get('IT', key2);
					else    
					    % permutation
					    seeds = c.get('PERM_SEEDS');
					    rng(seeds(i), 'twister')
					
					    subs1 = a1.get('GR').get('SUB_DICT').get('IT_LIST');
					    subs2 = a2.get('GR').get('SUB_DICT').get('IT_LIST');
					
					    gdict1 = a1.get('G_DICT').get('IT_LIST');
					    gdict2 = a2.get('G_DICT').get('IT_LIST');
					
					    subs1_gdict1 = cellfun(@(x, y) {x, y}, subs1, gdict1, 'UniformOutput', false);
					    subs2_gdict2 = cellfun(@(x, y) {x, y}, subs2, gdict2, 'UniformOutput', false);
					
					    [subs1_gdict1_perm, subs2_gdict2_perm] = permutation(subs1_gdict1, subs2_gdict2, c.get('LONGITUDINAL'));
					
					    gr1 = a1.get('GR');
					    a1_perm = eval([a1.getClass() '(''TEMPLATE'', a1)']); % % % a1_perm = c.get('A1').clone();
					    a1_perm.set( ...
					        'ID', key1, ...
					        'GR', Group('TEMPLATE', gr1) ... % % % c.get('A1').get('GR').clone() ...
					        )
					    a1_perm.get('GR').set('SUB_DICT', IndexedDictionary('TEMPLATE', gr1.get('SUB_DICT'))) % % % a1_perm.get('GR').set('SUB_DICT', c.get('A1').get('GR').get('SUB_DICT').clone())
						a1_perm.get('GR').get('SUB_DICT').set('IT_LIST', cellfun(@(x) x(1), subs1_gdict1_perm))
					    a1_perm.memorize('G_DICT').set('IT_LIST', cellfun(@(x) x(2), subs1_gdict1_perm))
					
					    gr2 = a2.get('GR');
					    a2_perm = eval([a2.getClass() '(''TEMPLATE'', a2)']); % % % a2_perm = c.get('A1').clone(); % a2_perm = c.get('A2').clone();
					    a2_perm.set( ...
					        'ID', key2, ...
					        'GR', Group('TEMPLATE', gr2) ... % % % c.get('A2').get('GR').clone() ...
					        )
					    a2_perm.get('GR').set('SUB_DICT', IndexedDictionary('TEMPLATE', gr2.get('SUB_DICT'))) % % % a2_perm.get('GR').set('SUB_DICT', c.get('A2').get('GR').get('SUB_DICT').clone())
						a2_perm.get('GR').get('SUB_DICT').set('IT_LIST', cellfun(@(x) x(1), subs2_gdict2_perm))
						a2_perm.memorize('G_DICT').set('IT_LIST', cellfun(@(x) x(2), subs2_gdict2_perm))
					         
					    % memorize permutations if required
					    if memorize
					        a1_perm_dict.get('ADD', a1_perm)
					        a2_perm_dict.get('ADD', a2_perm)
					    end
					end
					
					value = {a1_perm, a2_perm};
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(c, prop, varargin{:});
					else
						value = calculateValue@Element(c, prop, varargin{:});
					end
			end
			
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(c, prop, value)
			%CHECKVALUE checks the value of a property after it is set/calculated.
			%
			% [CHECK, MSG] = CHECKVALUE(EL, PROP, VALUE) checks the value
			%  of the property PROP after it is set/calculated. This function by
			%  default returns a CHECK = true and MSG = '. It should be implemented in
			%  the subclasses of Element when needed.
			%
			% See also conditioning, preset, checkProp, postset, postprocessing,
			%  calculateValue.
			
			check = true;
			msg = ['Error while checking ' tostring(c) ' ' c.getPropTag(prop) '.'];
			
			switch prop
				case CompareEnsemble.A1 % __CompareEnsemble.A1__
					check = isa(value, c.get('A2').getClass());
					
				case CompareEnsemble.A2 % __CompareEnsemble.A2__
					check = isa(value, c.get('A1').getClass());
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						[check, msg] = checkValue@ConcreteElement(c, prop, value);
					end
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(c, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case CompareEnsemble.CP_DICT % __CompareEnsemble.CP_DICT__
					pr = CompareEnsemblePP_CpDict('EL', c, 'PROP', CompareEnsemble.CP_DICT, ...
					    'WAITBAR', c.getCallback('WAITBAR'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(c, prop, varargin{:});
					
			end
		end
	end
end
