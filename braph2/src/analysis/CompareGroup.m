classdef CompareGroup < ConcreteElement
	%CompareGroup is a comparison between two group-based analyses.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% CompareGroup compares two group-based analyses, which need to be of the same class.
	%
	% CompareGroup methods (constructor):
	%  CompareGroup - constructor
	%
	% CompareGroup methods:
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
	% CompareGroup methods (display):
	%  tostring - string with information about the group-based comparison
	%  disp - displays information about the group-based comparison
	%  tree - displays the tree of the group-based comparison
	%
	% CompareGroup methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two group-based comparison are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the group-based comparison
	%
	% CompareGroup methods (save/load, Static):
	%  save - saves BRAPH2 group-based comparison as b2 file
	%  load - loads a BRAPH2 group-based comparison from a b2 file
	%
	% CompareGroup method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the group-based comparison
	%
	% CompareGroup method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the group-based comparison
	%
	% CompareGroup methods (inspection, Static):
	%  getClass - returns the class of the group-based comparison
	%  getSubclasses - returns all subclasses of CompareGroup
	%  getProps - returns the property list of the group-based comparison
	%  getPropNumber - returns the property number of the group-based comparison
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
	% CompareGroup methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% CompareGroup methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% CompareGroup methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% CompareGroup methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?CompareGroup; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">CompareGroup constants</a>.
	%
	%
	% See also AnalyzeGroup, ComparisonGroup.
	
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
		function c = CompareGroup(varargin)
			%CompareGroup() creates a group-based comparison.
			%
			% CompareGroup(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% CompareGroup(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the group-based comparison.
			%
			% CLASS = CompareGroup.GETCLASS() returns the class 'CompareGroup'.
			%
			% Alternative forms to call this method are:
			%  CLASS = C.GETCLASS() returns the class of the group-based comparison C.
			%  CLASS = Element.GETCLASS(C) returns the class of 'C'.
			%  CLASS = Element.GETCLASS('CompareGroup') returns 'CompareGroup'.
			%
			% Note that the Element.GETCLASS(C) and Element.GETCLASS('CompareGroup')
			%  are less computationally efficient.
			
			c_class = 'CompareGroup';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the group-based comparison.
			%
			% LIST = CompareGroup.GETSUBCLASSES() returns all subclasses of 'CompareGroup'.
			%
			% Alternative forms to call this method are:
			%  LIST = C.GETSUBCLASSES() returns all subclasses of the group-based comparison C.
			%  LIST = Element.GETSUBCLASSES(C) returns all subclasses of 'C'.
			%  LIST = Element.GETSUBCLASSES('CompareGroup') returns all subclasses of 'CompareGroup'.
			%
			% Note that the Element.GETSUBCLASSES(C) and Element.GETSUBCLASSES('CompareGroup')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('CompareGroup', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of group-based comparison.
			%
			% PROPS = CompareGroup.GETPROPS() returns the property list of group-based comparison
			%  as a row vector.
			%
			% PROPS = CompareGroup.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = C.GETPROPS([CATEGORY]) returns the property list of the group-based comparison C.
			%  PROPS = Element.GETPROPS(C[, CATEGORY]) returns the property list of 'C'.
			%  PROPS = Element.GETPROPS('CompareGroup'[, CATEGORY]) returns the property list of 'CompareGroup'.
			%
			% Note that the Element.GETPROPS(C) and Element.GETPROPS('CompareGroup')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						CompareGroup.WAITBAR ...
						CompareGroup.VERBOSE ...
						CompareGroup.INTERRUPTIBLE ...
						CompareGroup.MEMORIZE ...
						CompareGroup.P ...
						CompareGroup.LONGITUDINAL ...
						CompareGroup.A1 ...
						CompareGroup.A2 ...
						CompareGroup.PERM_SEEDS ...
						CompareGroup.A1_PERM_DICT ...
						CompareGroup.A2_PERM_DICT ...
						CompareGroup.CP_DICT ...
						CompareGroup.COMPARISON ...
						CompareGroup.PERM ...
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
						CompareGroup.MEMORIZE ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						CompareGroup.P ...
						CompareGroup.LONGITUDINAL ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						CompareGroup.A1 ...
						CompareGroup.A2 ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						CompareGroup.PERM_SEEDS ...
						CompareGroup.A1_PERM_DICT ...
						CompareGroup.A2_PERM_DICT ...
						CompareGroup.CP_DICT ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						CompareGroup.COMPARISON ...
						CompareGroup.PERM ...
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
						CompareGroup.WAITBAR ...
						CompareGroup.VERBOSE ...
						CompareGroup.INTERRUPTIBLE ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of group-based comparison.
			%
			% N = CompareGroup.GETPROPNUMBER() returns the property number of group-based comparison.
			%
			% N = CompareGroup.GETPROPNUMBER(CATEGORY) returns the property number of group-based comparison
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = C.GETPROPNUMBER([CATEGORY]) returns the property number of the group-based comparison C.
			%  N = Element.GETPROPNUMBER(C) returns the property number of 'C'.
			%  N = Element.GETPROPNUMBER('CompareGroup') returns the property number of 'CompareGroup'.
			%
			% Note that the Element.GETPROPNUMBER(C) and Element.GETPROPNUMBER('CompareGroup')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(CompareGroup.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in group-based comparison/error.
			%
			% CHECK = CompareGroup.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = C.EXISTSPROP(PROP) checks whether PROP exists for C.
			%  CHECK = Element.EXISTSPROP(C, PROP) checks whether PROP exists for C.
			%  CHECK = Element.EXISTSPROP(CompareGroup, PROP) checks whether PROP exists for CompareGroup.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:CompareGroup:WrongInput]
			%
			% Alternative forms to call this method are:
			%  C.EXISTSPROP(PROP) throws error if PROP does NOT exist for C.
			%   Error id: [BRAPH2:CompareGroup:WrongInput]
			%  Element.EXISTSPROP(C, PROP) throws error if PROP does NOT exist for C.
			%   Error id: [BRAPH2:CompareGroup:WrongInput]
			%  Element.EXISTSPROP(CompareGroup, PROP) throws error if PROP does NOT exist for CompareGroup.
			%   Error id: [BRAPH2:CompareGroup:WrongInput]
			%
			% Note that the Element.EXISTSPROP(C) and Element.EXISTSPROP('CompareGroup')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == CompareGroup.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':CompareGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CompareGroup:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for CompareGroup.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in group-based comparison/error.
			%
			% CHECK = CompareGroup.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = C.EXISTSTAG(TAG) checks whether TAG exists for C.
			%  CHECK = Element.EXISTSTAG(C, TAG) checks whether TAG exists for C.
			%  CHECK = Element.EXISTSTAG(CompareGroup, TAG) checks whether TAG exists for CompareGroup.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:CompareGroup:WrongInput]
			%
			% Alternative forms to call this method are:
			%  C.EXISTSTAG(TAG) throws error if TAG does NOT exist for C.
			%   Error id: [BRAPH2:CompareGroup:WrongInput]
			%  Element.EXISTSTAG(C, TAG) throws error if TAG does NOT exist for C.
			%   Error id: [BRAPH2:CompareGroup:WrongInput]
			%  Element.EXISTSTAG(CompareGroup, TAG) throws error if TAG does NOT exist for CompareGroup.
			%   Error id: [BRAPH2:CompareGroup:WrongInput]
			%
			% Note that the Element.EXISTSTAG(C) and Element.EXISTSTAG('CompareGroup')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			comparegroup_tag_list = cellfun(@(x) CompareGroup.getPropTag(x), num2cell(CompareGroup.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, comparegroup_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':CompareGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CompareGroup:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for CompareGroup.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(CompareGroup, POINTER) returns property number of POINTER of CompareGroup.
			%  PROPERTY = C.GETPROPPROP(CompareGroup, POINTER) returns property number of POINTER of CompareGroup.
			%
			% Note that the Element.GETPROPPROP(C) and Element.GETPROPPROP('CompareGroup')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				comparegroup_tag_list = cellfun(@(x) CompareGroup.getPropTag(x), num2cell(CompareGroup.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, comparegroup_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(CompareGroup, POINTER) returns tag of POINTER of CompareGroup.
			%  TAG = C.GETPROPTAG(CompareGroup, POINTER) returns tag of POINTER of CompareGroup.
			%
			% Note that the Element.GETPROPTAG(C) and Element.GETPROPTAG('CompareGroup')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case CompareGroup.WAITBAR
						tag = CompareGroup.WAITBAR_TAG;
					case CompareGroup.VERBOSE
						tag = CompareGroup.VERBOSE_TAG;
					case CompareGroup.INTERRUPTIBLE
						tag = CompareGroup.INTERRUPTIBLE_TAG;
					case CompareGroup.MEMORIZE
						tag = CompareGroup.MEMORIZE_TAG;
					case CompareGroup.P
						tag = CompareGroup.P_TAG;
					case CompareGroup.LONGITUDINAL
						tag = CompareGroup.LONGITUDINAL_TAG;
					case CompareGroup.A1
						tag = CompareGroup.A1_TAG;
					case CompareGroup.A2
						tag = CompareGroup.A2_TAG;
					case CompareGroup.PERM_SEEDS
						tag = CompareGroup.PERM_SEEDS_TAG;
					case CompareGroup.A1_PERM_DICT
						tag = CompareGroup.A1_PERM_DICT_TAG;
					case CompareGroup.A2_PERM_DICT
						tag = CompareGroup.A2_PERM_DICT_TAG;
					case CompareGroup.CP_DICT
						tag = CompareGroup.CP_DICT_TAG;
					case CompareGroup.COMPARISON
						tag = CompareGroup.COMPARISON_TAG;
					case CompareGroup.PERM
						tag = CompareGroup.PERM_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(CompareGroup, POINTER) returns category of POINTER of CompareGroup.
			%  CATEGORY = C.GETPROPCATEGORY(CompareGroup, POINTER) returns category of POINTER of CompareGroup.
			%
			% Note that the Element.GETPROPCATEGORY(C) and Element.GETPROPCATEGORY('CompareGroup')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = CompareGroup.getPropProp(pointer);
			
			switch prop
				case CompareGroup.WAITBAR
					prop_category = CompareGroup.WAITBAR_CATEGORY;
				case CompareGroup.VERBOSE
					prop_category = CompareGroup.VERBOSE_CATEGORY;
				case CompareGroup.INTERRUPTIBLE
					prop_category = CompareGroup.INTERRUPTIBLE_CATEGORY;
				case CompareGroup.MEMORIZE
					prop_category = CompareGroup.MEMORIZE_CATEGORY;
				case CompareGroup.P
					prop_category = CompareGroup.P_CATEGORY;
				case CompareGroup.LONGITUDINAL
					prop_category = CompareGroup.LONGITUDINAL_CATEGORY;
				case CompareGroup.A1
					prop_category = CompareGroup.A1_CATEGORY;
				case CompareGroup.A2
					prop_category = CompareGroup.A2_CATEGORY;
				case CompareGroup.PERM_SEEDS
					prop_category = CompareGroup.PERM_SEEDS_CATEGORY;
				case CompareGroup.A1_PERM_DICT
					prop_category = CompareGroup.A1_PERM_DICT_CATEGORY;
				case CompareGroup.A2_PERM_DICT
					prop_category = CompareGroup.A2_PERM_DICT_CATEGORY;
				case CompareGroup.CP_DICT
					prop_category = CompareGroup.CP_DICT_CATEGORY;
				case CompareGroup.COMPARISON
					prop_category = CompareGroup.COMPARISON_CATEGORY;
				case CompareGroup.PERM
					prop_category = CompareGroup.PERM_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(CompareGroup, POINTER) returns format of POINTER of CompareGroup.
			%  FORMAT = C.GETPROPFORMAT(CompareGroup, POINTER) returns format of POINTER of CompareGroup.
			%
			% Note that the Element.GETPROPFORMAT(C) and Element.GETPROPFORMAT('CompareGroup')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = CompareGroup.getPropProp(pointer);
			
			switch prop
				case CompareGroup.WAITBAR
					prop_format = CompareGroup.WAITBAR_FORMAT;
				case CompareGroup.VERBOSE
					prop_format = CompareGroup.VERBOSE_FORMAT;
				case CompareGroup.INTERRUPTIBLE
					prop_format = CompareGroup.INTERRUPTIBLE_FORMAT;
				case CompareGroup.MEMORIZE
					prop_format = CompareGroup.MEMORIZE_FORMAT;
				case CompareGroup.P
					prop_format = CompareGroup.P_FORMAT;
				case CompareGroup.LONGITUDINAL
					prop_format = CompareGroup.LONGITUDINAL_FORMAT;
				case CompareGroup.A1
					prop_format = CompareGroup.A1_FORMAT;
				case CompareGroup.A2
					prop_format = CompareGroup.A2_FORMAT;
				case CompareGroup.PERM_SEEDS
					prop_format = CompareGroup.PERM_SEEDS_FORMAT;
				case CompareGroup.A1_PERM_DICT
					prop_format = CompareGroup.A1_PERM_DICT_FORMAT;
				case CompareGroup.A2_PERM_DICT
					prop_format = CompareGroup.A2_PERM_DICT_FORMAT;
				case CompareGroup.CP_DICT
					prop_format = CompareGroup.CP_DICT_FORMAT;
				case CompareGroup.COMPARISON
					prop_format = CompareGroup.COMPARISON_FORMAT;
				case CompareGroup.PERM
					prop_format = CompareGroup.PERM_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(CompareGroup, POINTER) returns description of POINTER of CompareGroup.
			%  DESCRIPTION = C.GETPROPDESCRIPTION(CompareGroup, POINTER) returns description of POINTER of CompareGroup.
			%
			% Note that the Element.GETPROPDESCRIPTION(C) and Element.GETPROPDESCRIPTION('CompareGroup')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = CompareGroup.getPropProp(pointer);
			
			switch prop
				case CompareGroup.WAITBAR
					prop_description = 'WAITBAR (gui, logical) detemines whether to show the waitbar.';
				case CompareGroup.VERBOSE
					prop_description = 'VERBOSE (gui, logical) sets whether to write the progress of the comparisons.';
				case CompareGroup.INTERRUPTIBLE
					prop_description = 'INTERRUPTIBLE (gui, scalar) sets whether the comparison computation is interruptible for multitasking.';
				case CompareGroup.MEMORIZE
					prop_description = 'MEMORIZE (metadata, logical) sets whether to memorize the permuted analyses.';
				case CompareGroup.P
					prop_description = 'P (parameter, scalar) is the permutation number.';
				case CompareGroup.LONGITUDINAL
					prop_description = 'LONGITUDINAL (parameter, logical) determines whether the comparison is longitudinal.';
				case CompareGroup.A1
					prop_description = 'A1 (data, item) is the first analysis to compare.';
				case CompareGroup.A2
					prop_description = 'A2 (data, item) is the second analysis to compare.';
				case CompareGroup.PERM_SEEDS
					prop_description = 'PERM_SEEDS (result, rvector) is the list of seeds for the random permutations.';
				case CompareGroup.A1_PERM_DICT
					prop_description = 'A1_PERM_DICT (result, idict) is the list of permuted analyses for the first analysis.';
				case CompareGroup.A2_PERM_DICT
					prop_description = 'A2_PERM_DICT (result, idict) is the list of permuted analyses for the second analysis.';
				case CompareGroup.CP_DICT
					prop_description = 'CP_DICT (result, idict) contains the results of the comparison.';
				case CompareGroup.COMPARISON
					prop_description = 'COMPARISON (query, item) returns a comparison.';
				case CompareGroup.PERM
					prop_description = 'PERM (query, itemlist) returns the permuted analyses.';
				case CompareGroup.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case CompareGroup.NAME
					prop_description = 'NAME (constant, string) is the name of the group-based comparison.';
				case CompareGroup.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the group-based comparison.';
				case CompareGroup.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the group-based comparison.';
				case CompareGroup.ID
					prop_description = 'ID (data, string) is a few-letter code for the group-based comparison.';
				case CompareGroup.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the group-based comparison.';
				case CompareGroup.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the group-based comparison.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(CompareGroup, POINTER) returns settings of POINTER of CompareGroup.
			%  SETTINGS = C.GETPROPSETTINGS(CompareGroup, POINTER) returns settings of POINTER of CompareGroup.
			%
			% Note that the Element.GETPROPSETTINGS(C) and Element.GETPROPSETTINGS('CompareGroup')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = CompareGroup.getPropProp(pointer);
			
			switch prop
				case CompareGroup.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case CompareGroup.VERBOSE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case CompareGroup.INTERRUPTIBLE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case CompareGroup.MEMORIZE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case CompareGroup.P
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case CompareGroup.LONGITUDINAL
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case CompareGroup.A1
					prop_settings = 'AnalyzeGroup';
				case CompareGroup.A2
					prop_settings = 'AnalyzeGroup';
				case CompareGroup.PERM_SEEDS
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case CompareGroup.A1_PERM_DICT
					prop_settings = 'AnalyzeGroup';
				case CompareGroup.A2_PERM_DICT
					prop_settings = 'AnalyzeGroup';
				case CompareGroup.CP_DICT
					prop_settings = 'ComparisonGroup';
				case CompareGroup.COMPARISON
					prop_settings = 'ComparisonGroup';
				case CompareGroup.PERM
					prop_settings = Format.getFormatSettings(Format.ITEMLIST);
				case CompareGroup.TEMPLATE
					prop_settings = 'CompareGroup';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = CompareGroup.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = CompareGroup.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = C.GETPROPDEFAULT(POINTER) returns the default value of POINTER of C.
			%  DEFAULT = Element.GETPROPDEFAULT(CompareGroup, POINTER) returns the default value of POINTER of CompareGroup.
			%  DEFAULT = C.GETPROPDEFAULT(CompareGroup, POINTER) returns the default value of POINTER of CompareGroup.
			%
			% Note that the Element.GETPROPDEFAULT(C) and Element.GETPROPDEFAULT('CompareGroup')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CompareGroup.getPropProp(pointer);
			
			switch prop
				case CompareGroup.WAITBAR
					prop_default = true;
				case CompareGroup.VERBOSE
					prop_default = false;
				case CompareGroup.INTERRUPTIBLE
					prop_default = .001;
				case CompareGroup.MEMORIZE
					prop_default = Format.getFormatDefault(Format.LOGICAL, CompareGroup.getPropSettings(prop));
				case CompareGroup.P
					prop_default = 1e+4;
				case CompareGroup.LONGITUDINAL
					prop_default = Format.getFormatDefault(Format.LOGICAL, CompareGroup.getPropSettings(prop));
				case CompareGroup.A1
					prop_default = Format.getFormatDefault(Format.ITEM, CompareGroup.getPropSettings(prop));
				case CompareGroup.A2
					prop_default = Format.getFormatDefault(Format.ITEM, CompareGroup.getPropSettings(prop));
				case CompareGroup.PERM_SEEDS
					prop_default = Format.getFormatDefault(Format.RVECTOR, CompareGroup.getPropSettings(prop));
				case CompareGroup.A1_PERM_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareGroup.getPropSettings(prop));
				case CompareGroup.A2_PERM_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareGroup.getPropSettings(prop));
				case CompareGroup.CP_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, CompareGroup.getPropSettings(prop));
				case CompareGroup.COMPARISON
					prop_default = Format.getFormatDefault(Format.ITEM, CompareGroup.getPropSettings(prop));
				case CompareGroup.PERM
					prop_default = Format.getFormatDefault(Format.ITEMLIST, CompareGroup.getPropSettings(prop));
				case CompareGroup.ELCLASS
					prop_default = 'CompareGroup';
				case CompareGroup.NAME
					prop_default = 'CompareGroup';
				case CompareGroup.DESCRIPTION
					prop_default = 'CompareGroup compares two group-based analyses, which need to be of the same class.';
				case CompareGroup.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, CompareGroup.getPropSettings(prop));
				case CompareGroup.ID
					prop_default = 'CompareGroup ID';
				case CompareGroup.LABEL
					prop_default = 'CompareGroup label';
				case CompareGroup.NOTES
					prop_default = 'CompareGroup notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = CompareGroup.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = CompareGroup.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = C.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of C.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(CompareGroup, POINTER) returns the conditioned default value of POINTER of CompareGroup.
			%  DEFAULT = C.GETPROPDEFAULTCONDITIONED(CompareGroup, POINTER) returns the conditioned default value of POINTER of CompareGroup.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(C) and Element.GETPROPDEFAULTCONDITIONED('CompareGroup')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = CompareGroup.getPropProp(pointer);
			
			prop_default = CompareGroup.conditioning(prop, CompareGroup.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(CompareGroup, PROP, VALUE) checks VALUE format for PROP of CompareGroup.
			%  CHECK = C.CHECKPROP(CompareGroup, PROP, VALUE) checks VALUE format for PROP of CompareGroup.
			% 
			% C.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:CompareGroup:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  C.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of C.
			%   Error id: €BRAPH2.STR€:CompareGroup:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(CompareGroup, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CompareGroup.
			%   Error id: €BRAPH2.STR€:CompareGroup:€BRAPH2.WRONG_INPUT€
			%  C.CHECKPROP(CompareGroup, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CompareGroup.
			%   Error id: €BRAPH2.STR€:CompareGroup:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(C) and Element.CHECKPROP('CompareGroup')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = CompareGroup.getPropProp(pointer);
			
			switch prop
				case CompareGroup.WAITBAR % __CompareGroup.WAITBAR__
					check = Format.checkFormat(Format.LOGICAL, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.VERBOSE % __CompareGroup.VERBOSE__
					check = Format.checkFormat(Format.LOGICAL, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.INTERRUPTIBLE % __CompareGroup.INTERRUPTIBLE__
					check = Format.checkFormat(Format.SCALAR, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.MEMORIZE % __CompareGroup.MEMORIZE__
					check = Format.checkFormat(Format.LOGICAL, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.P % __CompareGroup.P__
					check = Format.checkFormat(Format.SCALAR, value, CompareGroup.getPropSettings(prop));
					if check
						check = value > 0 && value == round(value);
					end
				case CompareGroup.LONGITUDINAL % __CompareGroup.LONGITUDINAL__
					check = Format.checkFormat(Format.LOGICAL, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.A1 % __CompareGroup.A1__
					check = Format.checkFormat(Format.ITEM, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.A2 % __CompareGroup.A2__
					check = Format.checkFormat(Format.ITEM, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.PERM_SEEDS % __CompareGroup.PERM_SEEDS__
					check = Format.checkFormat(Format.RVECTOR, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.A1_PERM_DICT % __CompareGroup.A1_PERM_DICT__
					check = Format.checkFormat(Format.IDICT, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.A2_PERM_DICT % __CompareGroup.A2_PERM_DICT__
					check = Format.checkFormat(Format.IDICT, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.CP_DICT % __CompareGroup.CP_DICT__
					check = Format.checkFormat(Format.IDICT, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.COMPARISON % __CompareGroup.COMPARISON__
					check = Format.checkFormat(Format.ITEM, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.PERM % __CompareGroup.PERM__
					check = Format.checkFormat(Format.ITEMLIST, value, CompareGroup.getPropSettings(prop));
				case CompareGroup.TEMPLATE % __CompareGroup.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, CompareGroup.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':CompareGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CompareGroup:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' CompareGroup.getPropTag(prop) ' (' CompareGroup.getFormatTag(CompareGroup.getPropFormat(prop)) ').'] ...
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
				case CompareGroup.PERM_SEEDS % __CompareGroup.PERM_SEEDS__
					rng_settings_ = rng(); rng(c.getPropSeed(CompareGroup.PERM_SEEDS), 'twister')
					
					value = randi(intmax('uint32'), 1, c.get('P'));
					
					rng(rng_settings_)
					
				case CompareGroup.A1_PERM_DICT % __CompareGroup.A1_PERM_DICT__
					rng_settings_ = rng(); rng(c.getPropSeed(CompareGroup.A1_PERM_DICT), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'AnalyzeGroup');
					
					rng(rng_settings_)
					
				case CompareGroup.A2_PERM_DICT % __CompareGroup.A2_PERM_DICT__
					rng_settings_ = rng(); rng(c.getPropSeed(CompareGroup.A2_PERM_DICT), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'AnalyzeGroup');
					
					rng(rng_settings_)
					
				case CompareGroup.CP_DICT % __CompareGroup.CP_DICT__
					rng_settings_ = rng(); rng(c.getPropSeed(CompareGroup.CP_DICT), 'twister')
					
					value = IndexedDictionary('IT_CLASS', 'ComparisonGroup', 'IT_KEY', ComparisonGroup.MEASURE);
					
					rng(rng_settings_)
					
				case CompareGroup.COMPARISON % __CompareGroup.COMPARISON__
					% CP = c.get('COMPARISON', MEASURE_CLASS) checks if the comparison exists
					%  in the comparison dictionary CP_DICT. If not, it creates a new comparison
					%  CP of class MEASURE_CLASS. The user must call getValue() for the new
					%  comparison CP to retrieve the value of the comparison. 
					if isempty(varargin)
					    value = ComparisonGroup();
					    
					    % % Warning commented because it most likely will lead to an error anyways
					    % warning( ...
					    %     [BRAPH2.STR ':' class(g)], ...
					    %     [BRAPH2.STR ':' class(g) '\n' ...
					    %     'Missing argument MEASURE_CLASS when using CompareGroup.get(''COMPARISON'', MEASURE_CLASS).'] ...
					    %     )
					    
					    return
					end
					measure_class = varargin{1};
					
					g = c.get('A1').get('G');
					m_list = g.get('COMPATIBLE_MEASURES');
					assert( ...
					    contains(measure_class, m_list), ...
					    [BRAPH2.STR ':CompareGroup:' BRAPH2.WRONG_INPUT], ...
					    [BRAPH2.STR ':CompareGroup:' BRAPH2.WRONG_INPUT ' \n' ...
						 c.get('A1').getClass() ' utilizes graphs of type ' g.getClass() '. \n' ...
					     measure_class ' is not a compatible Measure with ' g.getClass() '. \n' ...
					    'Use ' g.getClass() '().get(''COMPATIBLE_MEASURES'') for a list of compatible measures.']);
					
					cp_dict = c.memorize('CP_DICT');
					if cp_dict.get('CONTAINS_KEY', measure_class)
					    cp = cp_dict.get('IT', measure_class);
					else
					    cp = ComparisonGroup( ...
					        'ID', [measure_class ' comparison ' c.get('A1').get('ID') ' vs. ' c.get('A2').get('ID')], ...
					        'MEASURE', measure_class, ...
					        'C', c ...
					        );
					    cp.lock('MEASURE')
					    
					    cp_dict.get('ADD', cp);
					end
					
					value = cp;
					
				case CompareGroup.PERM % __CompareGroup.PERM__
					% {A1P, A2P} = c.get('PERM', I) returns the I-th permutations for the analysis
					%  A1P and A2P. The number of perutations must be smaller than the
					%  permutation number P, which is one of the properties of the comparison.
					%
					% {A1P, A2P} = c.get('PERM', I, true) memorizes the resulting permutations.
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
					
					    [subs1_perm, subs2_perm] = permutation(subs1, subs2, c.get('LONGITUDINAL'));
					
					    gr1 = a1.get('GR');
					    a1_perm = eval([a1.getClass() '(''TEMPLATE'', a1)']); % % % a1_perm = c.get('A1').clone();
					    a1_perm.set( ...
					        'ID', key1, ...
					        'GR', Group('TEMPLATE', gr1) ... % % % a1.get('GR').clone() ...
					        )
					    a1_perm.get('GR').set('SUB_DICT', IndexedDictionary('TEMPLATE', gr1.get('SUB_DICT'))) % % % a1_perm.get('GR').set('SUB_DICT', c.get('A1').get('GR').get('SUB_DICT').clone())
					    a1_perm.get('GR').get('SUB_DICT').set('IT_LIST', subs1_perm)
					
					    gr2 = a2.get('GR');
					    a2_perm = eval([a2.getClass() '(''TEMPLATE'', a2)']); % % % a2_perm = c.get('A1').clone(); % % % a2_perm = c.get('A2').clone();
					    a2_perm.set( ...
					        'ID', key2, ...
					        'GR', Group('TEMPLATE', gr2) ... % % % c.get('A2').get('GR').clone() ...
					        )
					    a2_perm.get('GR').set('SUB_DICT', IndexedDictionary('TEMPLATE', gr2.get('SUB_DICT'))) % % % a2_perm.get('GR').set('SUB_DICT', c.get('A2').get('GR').get('SUB_DICT').clone())
					    a2_perm.get('GR').get('SUB_DICT').set('IT_LIST', subs2_perm)
					
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
				case CompareGroup.A1 % __CompareGroup.A1__
					check = isa(value, c.get('A2').getClass());
					
				case CompareGroup.A2 % __CompareGroup.A2__
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
				case CompareGroup.CP_DICT % __CompareGroup.CP_DICT__
					pr = CompareGroupPP_CpDict('EL', c, 'PROP', CompareGroup.CP_DICT, ...
					    'WAITBAR', c.getCallback('WAITBAR'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(c, prop, varargin{:});
					
			end
		end
	end
end
