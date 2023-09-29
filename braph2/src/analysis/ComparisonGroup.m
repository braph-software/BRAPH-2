classdef ComparisonGroup < ConcreteElement
	%ComparisonGroup contains the result of a group-based comparison.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% ComparisonGroup contains the results of a group-based comparison for a given measure.
	% Specifically, it contains the one-tailed and two-tailed p-values and the 95%% confidence interval.
	%
	% ComparisonGroup methods (constructor):
	%  ComparisonGroup - constructor
	%
	% ComparisonGroup methods:
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
	% ComparisonGroup methods (display):
	%  tostring - string with information about the group-based comparison result
	%  disp - displays information about the group-based comparison result
	%  tree - displays the tree of the group-based comparison result
	%
	% ComparisonGroup methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two group-based comparison result are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the group-based comparison result
	%
	% ComparisonGroup methods (save/load, Static):
	%  save - saves BRAPH2 group-based comparison result as b2 file
	%  load - loads a BRAPH2 group-based comparison result from a b2 file
	%
	% ComparisonGroup method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the group-based comparison result
	%
	% ComparisonGroup method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the group-based comparison result
	%
	% ComparisonGroup methods (inspection, Static):
	%  getClass - returns the class of the group-based comparison result
	%  getSubclasses - returns all subclasses of ComparisonGroup
	%  getProps - returns the property list of the group-based comparison result
	%  getPropNumber - returns the property number of the group-based comparison result
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
	% ComparisonGroup methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ComparisonGroup methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ComparisonGroup methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonGroup methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ComparisonGroup; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ComparisonGroup constants</a>.
	%
	%
	% See also AnalyzeGroup, CompareGroup.
	
	properties (Constant) % properties
		MEASURE = ConcreteElement.getPropNumber() + 1;
		MEASURE_TAG = 'MEASURE';
		MEASURE_CATEGORY = Category.PARAMETER;
		MEASURE_FORMAT = Format.CLASS;
		
		C = ConcreteElement.getPropNumber() + 2;
		C_TAG = 'C';
		C_CATEGORY = Category.DATA;
		C_FORMAT = Format.ITEM;
		
		DIFF = ConcreteElement.getPropNumber() + 3;
		DIFF_TAG = 'DIFF';
		DIFF_CATEGORY = Category.RESULT;
		DIFF_FORMAT = Format.CELL;
		
		P1 = ConcreteElement.getPropNumber() + 4;
		P1_TAG = 'P1';
		P1_CATEGORY = Category.RESULT;
		P1_FORMAT = Format.CELL;
		
		P2 = ConcreteElement.getPropNumber() + 5;
		P2_TAG = 'P2';
		P2_CATEGORY = Category.RESULT;
		P2_FORMAT = Format.CELL;
		
		CIL = ConcreteElement.getPropNumber() + 6;
		CIL_TAG = 'CIL';
		CIL_CATEGORY = Category.RESULT;
		CIL_FORMAT = Format.CELL;
		
		CIU = ConcreteElement.getPropNumber() + 7;
		CIU_TAG = 'CIU';
		CIU_CATEGORY = Category.RESULT;
		CIU_FORMAT = Format.CELL;
		
		QVALUE = ConcreteElement.getPropNumber() + 8;
		QVALUE_TAG = 'QVALUE';
		QVALUE_CATEGORY = Category.METADATA;
		QVALUE_FORMAT = Format.SCALAR;
		
		PFC = ConcreteElement.getPropNumber() + 9;
		PFC_TAG = 'PFC';
		PFC_CATEGORY = Category.GUI;
		PFC_FORMAT = Format.ITEM;
		
		PFBG = ConcreteElement.getPropNumber() + 10;
		PFBG_TAG = 'PFBG';
		PFBG_CATEGORY = Category.GUI;
		PFBG_FORMAT = Format.ITEM;
		
		CALCULATE_RESULTS = ConcreteElement.getPropNumber() + 11;
		CALCULATE_RESULTS_TAG = 'CALCULATE_RESULTS';
		CALCULATE_RESULTS_CATEGORY = Category.EVANESCENT;
		CALCULATE_RESULTS_FORMAT = Format.CELL;
	end
	methods % constructor
		function cp = ComparisonGroup(varargin)
			%ComparisonGroup() creates a group-based comparison result.
			%
			% ComparisonGroup(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonGroup(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			cp = cp@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function cp_class = getClass()
			%GETCLASS returns the class of the group-based comparison result.
			%
			% CLASS = ComparisonGroup.GETCLASS() returns the class 'ComparisonGroup'.
			%
			% Alternative forms to call this method are:
			%  CLASS = CP.GETCLASS() returns the class of the group-based comparison result CP.
			%  CLASS = Element.GETCLASS(CP) returns the class of 'CP'.
			%  CLASS = Element.GETCLASS('ComparisonGroup') returns 'ComparisonGroup'.
			%
			% Note that the Element.GETCLASS(CP) and Element.GETCLASS('ComparisonGroup')
			%  are less computationally efficient.
			
			cp_class = 'ComparisonGroup';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the group-based comparison result.
			%
			% LIST = ComparisonGroup.GETSUBCLASSES() returns all subclasses of 'ComparisonGroup'.
			%
			% Alternative forms to call this method are:
			%  LIST = CP.GETSUBCLASSES() returns all subclasses of the group-based comparison result CP.
			%  LIST = Element.GETSUBCLASSES(CP) returns all subclasses of 'CP'.
			%  LIST = Element.GETSUBCLASSES('ComparisonGroup') returns all subclasses of 'ComparisonGroup'.
			%
			% Note that the Element.GETSUBCLASSES(CP) and Element.GETSUBCLASSES('ComparisonGroup')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ComparisonGroup', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of group-based comparison result.
			%
			% PROPS = ComparisonGroup.GETPROPS() returns the property list of group-based comparison result
			%  as a row vector.
			%
			% PROPS = ComparisonGroup.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = CP.GETPROPS([CATEGORY]) returns the property list of the group-based comparison result CP.
			%  PROPS = Element.GETPROPS(CP[, CATEGORY]) returns the property list of 'CP'.
			%  PROPS = Element.GETPROPS('ComparisonGroup'[, CATEGORY]) returns the property list of 'ComparisonGroup'.
			%
			% Note that the Element.GETPROPS(CP) and Element.GETPROPS('ComparisonGroup')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						ComparisonGroup.MEASURE ...
						ComparisonGroup.C ...
						ComparisonGroup.DIFF ...
						ComparisonGroup.P1 ...
						ComparisonGroup.P2 ...
						ComparisonGroup.CIL ...
						ComparisonGroup.CIU ...
						ComparisonGroup.QVALUE ...
						ComparisonGroup.PFC ...
						ComparisonGroup.PFBG ...
						ComparisonGroup.CALCULATE_RESULTS ...
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
						ComparisonGroup.QVALUE ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						ComparisonGroup.MEASURE ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						ComparisonGroup.C ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						ComparisonGroup.DIFF ...
						ComparisonGroup.P1 ...
						ComparisonGroup.P2 ...
						ComparisonGroup.CIL ...
						ComparisonGroup.CIU ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						ComparisonGroup.CALCULATE_RESULTS ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						ComparisonGroup.PFC ...
						ComparisonGroup.PFBG ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of group-based comparison result.
			%
			% N = ComparisonGroup.GETPROPNUMBER() returns the property number of group-based comparison result.
			%
			% N = ComparisonGroup.GETPROPNUMBER(CATEGORY) returns the property number of group-based comparison result
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = CP.GETPROPNUMBER([CATEGORY]) returns the property number of the group-based comparison result CP.
			%  N = Element.GETPROPNUMBER(CP) returns the property number of 'CP'.
			%  N = Element.GETPROPNUMBER('ComparisonGroup') returns the property number of 'ComparisonGroup'.
			%
			% Note that the Element.GETPROPNUMBER(CP) and Element.GETPROPNUMBER('ComparisonGroup')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ComparisonGroup.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in group-based comparison result/error.
			%
			% CHECK = ComparisonGroup.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CP.EXISTSPROP(PROP) checks whether PROP exists for CP.
			%  CHECK = Element.EXISTSPROP(CP, PROP) checks whether PROP exists for CP.
			%  CHECK = Element.EXISTSPROP(ComparisonGroup, PROP) checks whether PROP exists for ComparisonGroup.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonGroup:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CP.EXISTSPROP(PROP) throws error if PROP does NOT exist for CP.
			%   Error id: [BRAPH2:ComparisonGroup:WrongInput]
			%  Element.EXISTSPROP(CP, PROP) throws error if PROP does NOT exist for CP.
			%   Error id: [BRAPH2:ComparisonGroup:WrongInput]
			%  Element.EXISTSPROP(ComparisonGroup, PROP) throws error if PROP does NOT exist for ComparisonGroup.
			%   Error id: [BRAPH2:ComparisonGroup:WrongInput]
			%
			% Note that the Element.EXISTSPROP(CP) and Element.EXISTSPROP('ComparisonGroup')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ComparisonGroup.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroup:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonGroup.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in group-based comparison result/error.
			%
			% CHECK = ComparisonGroup.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CP.EXISTSTAG(TAG) checks whether TAG exists for CP.
			%  CHECK = Element.EXISTSTAG(CP, TAG) checks whether TAG exists for CP.
			%  CHECK = Element.EXISTSTAG(ComparisonGroup, TAG) checks whether TAG exists for ComparisonGroup.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonGroup:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CP.EXISTSTAG(TAG) throws error if TAG does NOT exist for CP.
			%   Error id: [BRAPH2:ComparisonGroup:WrongInput]
			%  Element.EXISTSTAG(CP, TAG) throws error if TAG does NOT exist for CP.
			%   Error id: [BRAPH2:ComparisonGroup:WrongInput]
			%  Element.EXISTSTAG(ComparisonGroup, TAG) throws error if TAG does NOT exist for ComparisonGroup.
			%   Error id: [BRAPH2:ComparisonGroup:WrongInput]
			%
			% Note that the Element.EXISTSTAG(CP) and Element.EXISTSTAG('ComparisonGroup')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			comparisongroup_tag_list = cellfun(@(x) ComparisonGroup.getPropTag(x), num2cell(ComparisonGroup.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, comparisongroup_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroup:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ComparisonGroup.'] ...
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
			%  PROPERTY = CP.GETPROPPROP(POINTER) returns property number of POINTER of CP.
			%  PROPERTY = Element.GETPROPPROP(ComparisonGroup, POINTER) returns property number of POINTER of ComparisonGroup.
			%  PROPERTY = CP.GETPROPPROP(ComparisonGroup, POINTER) returns property number of POINTER of ComparisonGroup.
			%
			% Note that the Element.GETPROPPROP(CP) and Element.GETPROPPROP('ComparisonGroup')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				comparisongroup_tag_list = cellfun(@(x) ComparisonGroup.getPropTag(x), num2cell(ComparisonGroup.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, comparisongroup_tag_list)); % tag = pointer
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
			%  TAG = CP.GETPROPTAG(POINTER) returns tag of POINTER of CP.
			%  TAG = Element.GETPROPTAG(ComparisonGroup, POINTER) returns tag of POINTER of ComparisonGroup.
			%  TAG = CP.GETPROPTAG(ComparisonGroup, POINTER) returns tag of POINTER of ComparisonGroup.
			%
			% Note that the Element.GETPROPTAG(CP) and Element.GETPROPTAG('ComparisonGroup')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ComparisonGroup.MEASURE
						tag = ComparisonGroup.MEASURE_TAG;
					case ComparisonGroup.C
						tag = ComparisonGroup.C_TAG;
					case ComparisonGroup.DIFF
						tag = ComparisonGroup.DIFF_TAG;
					case ComparisonGroup.P1
						tag = ComparisonGroup.P1_TAG;
					case ComparisonGroup.P2
						tag = ComparisonGroup.P2_TAG;
					case ComparisonGroup.CIL
						tag = ComparisonGroup.CIL_TAG;
					case ComparisonGroup.CIU
						tag = ComparisonGroup.CIU_TAG;
					case ComparisonGroup.QVALUE
						tag = ComparisonGroup.QVALUE_TAG;
					case ComparisonGroup.PFC
						tag = ComparisonGroup.PFC_TAG;
					case ComparisonGroup.PFBG
						tag = ComparisonGroup.PFBG_TAG;
					case ComparisonGroup.CALCULATE_RESULTS
						tag = ComparisonGroup.CALCULATE_RESULTS_TAG;
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
			%  CATEGORY = CP.GETPROPCATEGORY(POINTER) returns category of POINTER of CP.
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonGroup, POINTER) returns category of POINTER of ComparisonGroup.
			%  CATEGORY = CP.GETPROPCATEGORY(ComparisonGroup, POINTER) returns category of POINTER of ComparisonGroup.
			%
			% Note that the Element.GETPROPCATEGORY(CP) and Element.GETPROPCATEGORY('ComparisonGroup')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonGroup.getPropProp(pointer);
			
			switch prop
				case ComparisonGroup.MEASURE
					prop_category = ComparisonGroup.MEASURE_CATEGORY;
				case ComparisonGroup.C
					prop_category = ComparisonGroup.C_CATEGORY;
				case ComparisonGroup.DIFF
					prop_category = ComparisonGroup.DIFF_CATEGORY;
				case ComparisonGroup.P1
					prop_category = ComparisonGroup.P1_CATEGORY;
				case ComparisonGroup.P2
					prop_category = ComparisonGroup.P2_CATEGORY;
				case ComparisonGroup.CIL
					prop_category = ComparisonGroup.CIL_CATEGORY;
				case ComparisonGroup.CIU
					prop_category = ComparisonGroup.CIU_CATEGORY;
				case ComparisonGroup.QVALUE
					prop_category = ComparisonGroup.QVALUE_CATEGORY;
				case ComparisonGroup.PFC
					prop_category = ComparisonGroup.PFC_CATEGORY;
				case ComparisonGroup.PFBG
					prop_category = ComparisonGroup.PFBG_CATEGORY;
				case ComparisonGroup.CALCULATE_RESULTS
					prop_category = ComparisonGroup.CALCULATE_RESULTS_CATEGORY;
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
			%  FORMAT = CP.GETPROPFORMAT(POINTER) returns format of POINTER of CP.
			%  FORMAT = Element.GETPROPFORMAT(ComparisonGroup, POINTER) returns format of POINTER of ComparisonGroup.
			%  FORMAT = CP.GETPROPFORMAT(ComparisonGroup, POINTER) returns format of POINTER of ComparisonGroup.
			%
			% Note that the Element.GETPROPFORMAT(CP) and Element.GETPROPFORMAT('ComparisonGroup')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonGroup.getPropProp(pointer);
			
			switch prop
				case ComparisonGroup.MEASURE
					prop_format = ComparisonGroup.MEASURE_FORMAT;
				case ComparisonGroup.C
					prop_format = ComparisonGroup.C_FORMAT;
				case ComparisonGroup.DIFF
					prop_format = ComparisonGroup.DIFF_FORMAT;
				case ComparisonGroup.P1
					prop_format = ComparisonGroup.P1_FORMAT;
				case ComparisonGroup.P2
					prop_format = ComparisonGroup.P2_FORMAT;
				case ComparisonGroup.CIL
					prop_format = ComparisonGroup.CIL_FORMAT;
				case ComparisonGroup.CIU
					prop_format = ComparisonGroup.CIU_FORMAT;
				case ComparisonGroup.QVALUE
					prop_format = ComparisonGroup.QVALUE_FORMAT;
				case ComparisonGroup.PFC
					prop_format = ComparisonGroup.PFC_FORMAT;
				case ComparisonGroup.PFBG
					prop_format = ComparisonGroup.PFBG_FORMAT;
				case ComparisonGroup.CALCULATE_RESULTS
					prop_format = ComparisonGroup.CALCULATE_RESULTS_FORMAT;
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
			%  DESCRIPTION = CP.GETPROPDESCRIPTION(POINTER) returns description of POINTER of CP.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonGroup, POINTER) returns description of POINTER of ComparisonGroup.
			%  DESCRIPTION = CP.GETPROPDESCRIPTION(ComparisonGroup, POINTER) returns description of POINTER of ComparisonGroup.
			%
			% Note that the Element.GETPROPDESCRIPTION(CP) and Element.GETPROPDESCRIPTION('ComparisonGroup')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonGroup.getPropProp(pointer);
			
			switch prop
				case ComparisonGroup.MEASURE
					prop_description = 'MEASURE (parameter, class) is the measure class.';
				case ComparisonGroup.C
					prop_description = 'C (data, item) is the group-based comparison.';
				case ComparisonGroup.DIFF
					prop_description = 'DIFF (result, cell) is the group comparison value.';
				case ComparisonGroup.P1
					prop_description = 'P1 (result, cell) is the one-tailed p-value.';
				case ComparisonGroup.P2
					prop_description = 'P2 (result, cell) is the two-tailed p-value.';
				case ComparisonGroup.CIL
					prop_description = 'CIL (result, cell) is the lower value of the 95%% confidence interval.';
				case ComparisonGroup.CIU
					prop_description = 'CIU (result, cell) is the upper value of the 95%% confidence interval.';
				case ComparisonGroup.QVALUE
					prop_description = 'QVALUE (metadata, scalar) is the selected qvalue threshold.';
				case ComparisonGroup.PFC
					prop_description = 'PFC (gui, item) contains the panel figure of the comparison.';
				case ComparisonGroup.PFBG
					prop_description = 'PFBG (gui, item) contains the panel figure of the brain graph.';
				case ComparisonGroup.CALCULATE_RESULTS
					prop_description = 'CALCULATE_RESULTS (evanescent, cell) calculates the comparison results {diff, p1, p2, ci_lower, ci_upper}.';
				case ComparisonGroup.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case ComparisonGroup.NAME
					prop_description = 'NAME (constant, string) is the name of the group-based comparison result.';
				case ComparisonGroup.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the group-based comparison result.';
				case ComparisonGroup.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the group-based comparison result.';
				case ComparisonGroup.ID
					prop_description = 'ID (data, string) is a few-letter code for the group-based comparison result.';
				case ComparisonGroup.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the group-based comparison result.';
				case ComparisonGroup.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the group-based comparison result.';
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
			%  SETTINGS = CP.GETPROPSETTINGS(POINTER) returns settings of POINTER of CP.
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonGroup, POINTER) returns settings of POINTER of ComparisonGroup.
			%  SETTINGS = CP.GETPROPSETTINGS(ComparisonGroup, POINTER) returns settings of POINTER of ComparisonGroup.
			%
			% Note that the Element.GETPROPSETTINGS(CP) and Element.GETPROPSETTINGS('ComparisonGroup')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonGroup.getPropProp(pointer);
			
			switch prop
				case ComparisonGroup.MEASURE
					prop_settings = 'Measure';
				case ComparisonGroup.C
					prop_settings = 'CompareGroup';
				case ComparisonGroup.DIFF
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ComparisonGroup.P1
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ComparisonGroup.P2
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ComparisonGroup.CIL
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ComparisonGroup.CIU
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ComparisonGroup.QVALUE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ComparisonGroup.PFC
					prop_settings = 'ComparisonGroupPF';
				case ComparisonGroup.PFBG
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case ComparisonGroup.CALCULATE_RESULTS
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ComparisonGroup.TEMPLATE
					prop_settings = 'ComparisonGroup';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonGroup.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonGroup.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CP.GETPROPDEFAULT(POINTER) returns the default value of POINTER of CP.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonGroup, POINTER) returns the default value of POINTER of ComparisonGroup.
			%  DEFAULT = CP.GETPROPDEFAULT(ComparisonGroup, POINTER) returns the default value of POINTER of ComparisonGroup.
			%
			% Note that the Element.GETPROPDEFAULT(CP) and Element.GETPROPDEFAULT('ComparisonGroup')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonGroup.getPropProp(pointer);
			
			switch prop
				case ComparisonGroup.MEASURE
					prop_default = Format.getFormatDefault(Format.CLASS, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.C
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.DIFF
					prop_default = Format.getFormatDefault(Format.CELL, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.P1
					prop_default = Format.getFormatDefault(Format.CELL, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.P2
					prop_default = Format.getFormatDefault(Format.CELL, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.CIL
					prop_default = Format.getFormatDefault(Format.CELL, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.CIU
					prop_default = Format.getFormatDefault(Format.CELL, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.QVALUE
					prop_default = 0.05;
				case ComparisonGroup.PFC
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.PFBG
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.CALCULATE_RESULTS
					prop_default = Format.getFormatDefault(Format.CELL, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.ELCLASS
					prop_default = 'ComparisonGroup';
				case ComparisonGroup.NAME
					prop_default = 'ComparisonGroup';
				case ComparisonGroup.DESCRIPTION
					prop_default = 'ComparisonGroup contains the results of a group-based comparison for a given measure. Specifically, it contains the one-tailed and two-tailed p-values and the 95%% confidence interval.';
				case ComparisonGroup.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.ID
					prop_default = 'ComparisonGroup ID';
				case ComparisonGroup.LABEL
					prop_default = 'ComparisonGroup label';
				case ComparisonGroup.NOTES
					prop_default = 'ComparisonGroup notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonGroup.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonGroup.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CP.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of CP.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonGroup, POINTER) returns the conditioned default value of POINTER of ComparisonGroup.
			%  DEFAULT = CP.GETPROPDEFAULTCONDITIONED(ComparisonGroup, POINTER) returns the conditioned default value of POINTER of ComparisonGroup.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(CP) and Element.GETPROPDEFAULTCONDITIONED('ComparisonGroup')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ComparisonGroup.getPropProp(pointer);
			
			prop_default = ComparisonGroup.conditioning(prop, ComparisonGroup.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = CP.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = CP.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of CP.
			%  CHECK = Element.CHECKPROP(ComparisonGroup, PROP, VALUE) checks VALUE format for PROP of ComparisonGroup.
			%  CHECK = CP.CHECKPROP(ComparisonGroup, PROP, VALUE) checks VALUE format for PROP of ComparisonGroup.
			% 
			% CP.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ComparisonGroup:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CP.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of CP.
			%   Error id: €BRAPH2.STR€:ComparisonGroup:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ComparisonGroup, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonGroup.
			%   Error id: €BRAPH2.STR€:ComparisonGroup:€BRAPH2.WRONG_INPUT€
			%  CP.CHECKPROP(ComparisonGroup, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonGroup.
			%   Error id: €BRAPH2.STR€:ComparisonGroup:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(CP) and Element.CHECKPROP('ComparisonGroup')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ComparisonGroup.getPropProp(pointer);
			
			switch prop
				case ComparisonGroup.MEASURE % __ComparisonGroup.MEASURE__
					check = Format.checkFormat(Format.CLASS, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.C % __ComparisonGroup.C__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.DIFF % __ComparisonGroup.DIFF__
					check = Format.checkFormat(Format.CELL, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.P1 % __ComparisonGroup.P1__
					check = Format.checkFormat(Format.CELL, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.P2 % __ComparisonGroup.P2__
					check = Format.checkFormat(Format.CELL, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.CIL % __ComparisonGroup.CIL__
					check = Format.checkFormat(Format.CELL, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.CIU % __ComparisonGroup.CIU__
					check = Format.checkFormat(Format.CELL, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.QVALUE % __ComparisonGroup.QVALUE__
					check = Format.checkFormat(Format.SCALAR, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.PFC % __ComparisonGroup.PFC__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.PFBG % __ComparisonGroup.PFBG__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.CALCULATE_RESULTS % __ComparisonGroup.CALCULATE_RESULTS__
					check = Format.checkFormat(Format.CELL, value, ComparisonGroup.getPropSettings(prop));
				case ComparisonGroup.TEMPLATE % __ComparisonGroup.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroup.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroup:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroup:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonGroup.getPropTag(prop) ' (' ComparisonGroup.getFormatTag(ComparisonGroup.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(cp, prop)
			%POSTPROCESSING postprocessesing after setting.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing of PROP after setting. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% The postprocessing of all properties occurs each time set is called.
			%
			% See also conditioning, preset, checkProp, postset, calculateValue,
			%  checkValue.
			
			switch prop
				case ComparisonGroup.PFC % __ComparisonGroup.PFC__
					if isa(cp.getr('PFC'), 'NoValue')
					    
					    measure = cp.get('MEASURE');
					
					    switch Element.getPropDefault(measure, 'SHAPE')
					        case Measure.GLOBAL % __Measure.GLOBAL__
					            switch Element.getPropDefault(measure, 'SCOPE')
					                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
					                    cp.set('PFC', ComparisonGroupPF_GS('CP', cp))
					                case Measure.UNILAYER % __Measure.UNILAYER__
					                    cp.set('PFC', ComparisonGroupPF_GU('CP', cp))
					                case Measure.BILAYER % __Measure.BILAYER__
					                    cp.set('PFC', ComparisonGroupPF_GB('CP', cp))
					            end
					        case Measure.NODAL % __Measure.NODAL__
					            switch Element.getPropDefault(measure, 'SCOPE')
					                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
					                    cp.set('PFC', ComparisonGroupPF_NS('CP', cp))
					                case Measure.UNILAYER % __Measure.UNILAYER__
					                    cp.set('PFC', ComparisonGroupPF_NU('CP', cp))
					                case Measure.BILAYER % __Measure.BILAYER__
					                    cp.set('PFC', ComparisonGroupPF_NB('CP', cp))
					            end
					        case Measure.BINODAL % __Measure.BINODAL__
					            switch Element.getPropDefault(measure, 'SCOPE')
					                case Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
					                    cp.set('PFC', ComparisonGroupPF_BS('CP', cp))
					                case Measure.UNILAYER % __Measure.UNILAYER__
					                    cp.set('PFC', ComparisonGroupPF_BU('CP', cp))
					                case Measure.BILAYER % __Measure.BILAYER__
					                    cp.set('PFC', ComparisonGroupPF_BB('CP', cp))
					            end
					    end
					end
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						postprocessing@ConcreteElement(cp, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(cp, prop, varargin)
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
				case ComparisonGroup.DIFF % __ComparisonGroup.DIFF__
					rng_settings_ = rng(); rng(cp.getPropSeed(ComparisonGroup.DIFF), 'twister')
					
					results = cp.memorize('CALCULATE_RESULTS');
					value = results{1}; % diff
					
					rng(rng_settings_)
					
				case ComparisonGroup.P1 % __ComparisonGroup.P1__
					rng_settings_ = rng(); rng(cp.getPropSeed(ComparisonGroup.P1), 'twister')
					
					results = cp.memorize('CALCULATE_RESULTS');
					value = results{2}; % p1
					
					rng(rng_settings_)
					
				case ComparisonGroup.P2 % __ComparisonGroup.P2__
					rng_settings_ = rng(); rng(cp.getPropSeed(ComparisonGroup.P2), 'twister')
					
					results = cp.memorize('CALCULATE_RESULTS');
					value = results{3}; % p2
					
					rng(rng_settings_)
					
				case ComparisonGroup.CIL % __ComparisonGroup.CIL__
					rng_settings_ = rng(); rng(cp.getPropSeed(ComparisonGroup.CIL), 'twister')
					
					results = cp.memorize('CALCULATE_RESULTS');
					value = results{4}; % ci_lower
					
					rng(rng_settings_)
					
				case ComparisonGroup.CIU % __ComparisonGroup.CIU__
					rng_settings_ = rng(); rng(cp.getPropSeed(ComparisonGroup.CIU), 'twister')
					
					results = cp.memorize('CALCULATE_RESULTS');
					value = results{5}; % ci_upper
					
					rng(rng_settings_)
					
				case ComparisonGroup.CALCULATE_RESULTS % __ComparisonGroup.CALCULATE_RESULTS__
					% {DIFF, P1, P2, CIL, CIU} = cp.get('CALCULATE_RESULTS') calcultes the
					%  difference, the one-tailed p-value P1, the two-tailed p-value P2,
					%  the lower bound of the confidence interval CIL, and the the upper
					%  bound of the confidence interval. 
					%  Typically, this method is only called internally.
					
					measure_class = cp.get('MEASURE');
					if strcmpi(cp.get('MEASURE'), 'Measure')
					    diff = {};
					    p1 = {};
					    p2 = {};
					    ci_lower = {};
					    ci_upper = {};
					    value = {diff, p1, p2, ci_lower, ci_upper};
					    return
					end
					    
					c = cp.get('C');
					
					wb = braph2waitbar(c.get('WAITBAR'), 0, ['Comparing group ' cp.get('MEASURE') '...']);
					
					% Measure for groups 1 and 2, and their difference
					m1 = c.get('A1').get('G').get('MEASURE', measure_class).memorize('M');
					m2 = c.get('A2').get('G').get('MEASURE', measure_class).memorize('M');
					diff = cellfun(@(x, y) y - x, m1, m2, 'UniformOutput', false);
					
					% Permutations
					P = c.get('P'); %#ok<*PROPLC>
					
					m1_perms = cell(1, P);
					m2_perms = cell(1, P);
					diff_perms = cell(1, P);
					
					start = tic;
					for j = 1:20:P
					    parfor i = j:min(j+20, P)
					        a1_a2_perms = c.get('PERM', i, c.get('MEMORIZE'));
					        a1_perm = a1_a2_perms{1};
					        a2_perm = a1_a2_perms{2};
					
					        m1_perms{1, i} = a1_perm.memorize('G').get('MEASURE', measure_class).memorize('M'); %#ok<PFOUS>
					        m2_perms{1, i} = a2_perm.memorize('G').get('MEASURE', measure_class).memorize('M'); %#ok<PFOUS>
					        diff_perms{1, i} = cellfun(@(x, y) y - x, m1_perms{1, i}, m2_perms{1, i}, 'UniformOutput', false);
					    end
					
					    braph2waitbar(wb, j / P, ['Comparing group ' cp.get('MEASURE') '. Permutation ' num2str(j) ' of ' num2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's ...'])
					    if c.get('VERBOSE')
					        disp(['** PERMUTATION TEST - sampling #' int2str(j) '/' int2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
					    end
					    if c.get('INTERRUPTIBLE')
					        pause(c.get('INTERRUPTIBLE'))
					    end        
					end
					
					braph2waitbar(wb, 'close')
					
					% Statistical analysis
					p1 = cell(size(diff));
					p2 = cell(size(diff));
					ci_lower = cell(size(diff));
					ci_upper = cell(size(diff));
					for i = 1:1:size(diff, 1)
					    for j = 1:1:size(diff, 2)
					        p1(i, j) = pvalue1(diff(i, j), cellfun(@(x) x{i, j}, diff_perms, 'UniformOutput', false));
					        p2(i, j) = pvalue2(diff(i, j), cellfun(@(x) x{i, j}, diff_perms, 'UniformOutput', false));
					        qtl = quantiles(cellfun(@(x) x{i, j}, diff_perms, 'UniformOutput', false), 40);
					        ci_lower(i, j) = {cellfun(@(x) x(2), qtl)};
					        ci_upper(i, j) = {cellfun(@(x) x(40), qtl)};
					    end
					end
					
					value = {diff, p1, p2, ci_lower, ci_upper};
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						value = calculateValue@ConcreteElement(cp, prop, varargin{:});
					else
						value = calculateValue@Element(cp, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(cp, prop, varargin)
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
				case ComparisonGroup.DIFF % __ComparisonGroup.DIFF__
					g = cp.get('C').get('A1').get('G');
					measure = cp.get('MEASURE');
					
					pr = PanelPropCell('EL', cp, 'PROP', ComparisonGroup.DIFF, varargin{:});
					
					if Element.getPropDefault(measure, 'SHAPE') == Measure.GLOBAL % __Measure.GLOBAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(4), ...
					        'ROWNAME', {}, ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == Measure.NODAL % __Measure.NODAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(40), ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == Measure.BINODAL % __Measure.BINODAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(40), ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', g.getCallback('ANODELABELS') ...
					        )
					end
					
					if g.get('LAYERNUMBER') == 1
					    pr.set( ...
					        'XSLIDERSHOW', false, ...
					        'YSLIDERSHOW', false ...
					        )
					else % multilayer
					    if  Element.getPropDefault(measure, 'SCOPE') == Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.UNILAYER % __Measure.UNILAYER__
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.BILAYER % __Measure.BILAYER__
					        pr.set( ...
					            'TABLE_HEIGHT', max(3 + pr.get('TABLE_HEIGHT'), s(3) + s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', true, ...
					            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'XSLIDERHEIGHT', s(3), ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    end
					end
					
				case ComparisonGroup.P1 % __ComparisonGroup.P1__
					g = cp.get('C').get('A1').get('G');
					measure = cp.get('MEASURE');
					
					pr = PanelPropCell('EL', cp, 'PROP', ComparisonGroup.P1, varargin{:});
					
					if Element.getPropDefault(measure, 'SHAPE') == Measure.GLOBAL % __Measure.GLOBAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(4), ...
					        'ROWNAME', {}, ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == Measure.NODAL % __Measure.NODAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(40), ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == Measure.BINODAL % __Measure.BINODAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(40), ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', g.getCallback('ANODELABELS') ...
					        )
					end
					
					if g.get('LAYERNUMBER') == 1
					    pr.set( ...
					        'XSLIDERSHOW', false, ...
					        'YSLIDERSHOW', false ...
					        )
					else % multilayer
					    if  Element.getPropDefault(measure, 'SCOPE') == Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.UNILAYER % __Measure.UNILAYER__
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.BILAYER % __Measure.BILAYER__
					        pr.set( ...
					            'TABLE_HEIGHT', max(3 + pr.get('TABLE_HEIGHT'), s(3) + s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', true, ...
					            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'XSLIDERHEIGHT', s(3), ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    end
					end
					
				case ComparisonGroup.P2 % __ComparisonGroup.P2__
					g = cp.get('C').get('A1').get('G');
					measure = cp.get('MEASURE');
					
					pr = PanelPropCell('EL', cp, 'PROP', ComparisonGroup.P2, varargin{:});
					
					if Element.getPropDefault(measure, 'SHAPE') == Measure.GLOBAL % __Measure.GLOBAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(4), ...
					        'ROWNAME', {}, ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == Measure.NODAL % __Measure.NODAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(40), ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == Measure.BINODAL % __Measure.BINODAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(40), ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', g.getCallback('ANODELABELS') ...
					        )
					end
					
					if g.get('LAYERNUMBER') == 1
					    pr.set( ...
					        'XSLIDERSHOW', false, ...
					        'YSLIDERSHOW', false ...
					        )
					else % multilayer
					    if  Element.getPropDefault(measure, 'SCOPE') == Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.UNILAYER % __Measure.UNILAYER__
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.BILAYER % __Measure.BILAYER__
					        pr.set( ...
					            'TABLE_HEIGHT', max(3 + pr.get('TABLE_HEIGHT'), s(3) + s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', true, ...
					            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'XSLIDERHEIGHT', s(3), ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    end
					end
					
				case ComparisonGroup.CIL % __ComparisonGroup.CIL__
					g = cp.get('C').get('A1').get('G');
					measure = cp.get('MEASURE');
					
					pr = PanelPropCell('EL', cp, 'PROP', ComparisonGroup.CIL, varargin{:});
					
					if Element.getPropDefault(measure, 'SHAPE') == Measure.GLOBAL % __Measure.GLOBAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(4), ...
					        'ROWNAME', {}, ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == Measure.NODAL % __Measure.NODAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(40), ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == Measure.BINODAL % __Measure.BINODAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(40), ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', g.getCallback('ANODELABELS') ...
					        )
					end
					
					if g.get('LAYERNUMBER') == 1
					    pr.set( ...
					        'XSLIDERSHOW', false, ...
					        'YSLIDERSHOW', false ...
					        )
					else % multilayer
					    if  Element.getPropDefault(measure, 'SCOPE') == Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.UNILAYER % __Measure.UNILAYER__
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.BILAYER % __Measure.BILAYER__
					        pr.set( ...
					            'TABLE_HEIGHT', max(3 + pr.get('TABLE_HEIGHT'), s(3) + s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', true, ...
					            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'XSLIDERHEIGHT', s(3), ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    end
					end
					
				case ComparisonGroup.CIU % __ComparisonGroup.CIU__
					g = cp.get('C').get('A1').get('G');
					measure = cp.get('MEASURE');
					
					pr = PanelPropCell('EL', cp, 'PROP', ComparisonGroup.CIU, varargin{:});
					
					if Element.getPropDefault(measure, 'SHAPE') == Measure.GLOBAL % __Measure.GLOBAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(4), ...
					        'ROWNAME', {}, ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == Measure.NODAL % __Measure.NODAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(40), ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', {} ...
					        )
					elseif Element.getPropDefault(measure, 'SHAPE') == Measure.BINODAL % __Measure.BINODAL__
					    pr.set( ...
					        'TABLE_HEIGHT', s(40), ...
					        'ROWNAME', g.getCallback('ANODELABELS'), ...
					        'COLUMNNAME', g.getCallback('ANODELABELS') ...
					        )
					end
					
					if g.get('LAYERNUMBER') == 1
					    pr.set( ...
					        'XSLIDERSHOW', false, ...
					        'YSLIDERSHOW', false ...
					        )
					else % multilayer
					    if  Element.getPropDefault(measure, 'SCOPE') == Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.UNILAYER % __Measure.UNILAYER__
					        pr.set( ...
					            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', false, ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    elseif Element.getPropDefault(measure, 'SCOPE') == Measure.BILAYER % __Measure.BILAYER__
					        pr.set( ...
					            'TABLE_HEIGHT', max(3 + pr.get('TABLE_HEIGHT'), s(3) + s(1) * g.get('LAYERNUMBER')), ...
					            'XSLIDERSHOW', true, ...
					            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'XSLIDERHEIGHT', s(3), ...
					            'YSLIDERSHOW', true, ...
					            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
					            'YSLIDERWIDTH', s(5) ...
					            )
					    end
					end
					
				case ComparisonGroup.PFC % __ComparisonGroup.PFC__
					pr = PanelPropItem('EL', cp, 'PROP', ComparisonGroup.PFC, ...
					    'GUICLASS', 'GUIFig', ...
						'BUTTON_TEXT', ['Plot ' cp.get('MEASURE') ' Comparison'], ...
					    varargin{:});
					
				case ComparisonGroup.PFBG % __ComparisonGroup.PFBG__
					pr = PanelPropItem('EL', cp, 'PROP', ComparisonGroup.PFBG, ...
					    'GUICLASS', 'GUIFig', ...
						'BUTTON_TEXT', ['Brain Graph ' cp.get('MEASURE') ' Comparison'], ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(cp, prop, varargin{:});
					
			end
		end
	end
end
