classdef AnalyzeGroup_FUN_GA_WU < AnalyzeGroup
	%AnalyzeGroup_FUN_GA_WU is a graph analysis using averaged functional data.
	% It is a subclass of <a href="matlab:help AnalyzeGroup">AnalyzeGroup</a>.
	%
	% AnalyzeGroup_FUN_GA_WU uses functional data averaged over a group 
	% and analyzes them using weighted undirected graphs.
	%
	% AnalyzeGroup_FUN_GA_WU methods (constructor):
	%  AnalyzeGroup_FUN_GA_WU - constructor
	%
	% AnalyzeGroup_FUN_GA_WU methods:
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
	% AnalyzeGroup_FUN_GA_WU methods (display):
	%  tostring - string with information about the graph analysis with averaged functional data
	%  disp - displays information about the graph analysis with averaged functional data
	%  tree - displays the tree of the graph analysis with averaged functional data
	%
	% AnalyzeGroup_FUN_GA_WU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph analysis with averaged functional data are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph analysis with averaged functional data
	%
	% AnalyzeGroup_FUN_GA_WU methods (save/load, Static):
	%  save - saves BRAPH2 graph analysis with averaged functional data as b2 file
	%  load - loads a BRAPH2 graph analysis with averaged functional data from a b2 file
	%
	% AnalyzeGroup_FUN_GA_WU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph analysis with averaged functional data
	%
	% AnalyzeGroup_FUN_GA_WU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph analysis with averaged functional data
	%
	% AnalyzeGroup_FUN_GA_WU methods (inspection, Static):
	%  getClass - returns the class of the graph analysis with averaged functional data
	%  getSubclasses - returns all subclasses of AnalyzeGroup_FUN_GA_WU
	%  getProps - returns the property list of the graph analysis with averaged functional data
	%  getPropNumber - returns the property number of the graph analysis with averaged functional data
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
	% AnalyzeGroup_FUN_GA_WU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% AnalyzeGroup_FUN_GA_WU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% AnalyzeGroup_FUN_GA_WU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeGroup_FUN_GA_WU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?AnalyzeGroup_FUN_GA_WU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">AnalyzeGroup_FUN_GA_WU constants</a>.
	%
	%
	% See also SubjectFUN, GraphWU.
	
	properties (Constant) % properties
		REPETITION = AnalyzeGroup.getPropNumber() + 1;
		REPETITION_TAG = 'REPETITION';
		REPETITION_CATEGORY = Category.PARAMETER;
		REPETITION_FORMAT = Format.SCALAR;
		
		F_MIN = AnalyzeGroup.getPropNumber() + 2;
		F_MIN_TAG = 'F_MIN';
		F_MIN_CATEGORY = Category.PARAMETER;
		F_MIN_FORMAT = Format.SCALAR;
		
		F_MAX = AnalyzeGroup.getPropNumber() + 3;
		F_MAX_TAG = 'F_MAX';
		F_MAX_CATEGORY = Category.PARAMETER;
		F_MAX_FORMAT = Format.SCALAR;
		
		CORRELATION_RULE = AnalyzeGroup.getPropNumber() + 4;
		CORRELATION_RULE_TAG = 'CORRELATION_RULE';
		CORRELATION_RULE_CATEGORY = Category.PARAMETER;
		CORRELATION_RULE_FORMAT = Format.OPTION;
		
		NEGATIVE_WEIGHT_RULE = AnalyzeGroup.getPropNumber() + 5;
		NEGATIVE_WEIGHT_RULE_TAG = 'NEGATIVE_WEIGHT_RULE';
		NEGATIVE_WEIGHT_RULE_CATEGORY = Category.PARAMETER;
		NEGATIVE_WEIGHT_RULE_FORMAT = Format.OPTION;
	end
	methods % constructor
		function a = AnalyzeGroup_FUN_GA_WU(varargin)
			%AnalyzeGroup_FUN_GA_WU() creates a graph analysis with averaged functional data.
			%
			% AnalyzeGroup_FUN_GA_WU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeGroup_FUN_GA_WU(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			a = a@AnalyzeGroup(varargin{:});
		end
	end
	methods (Static) % inspection
		function a_class = getClass()
			%GETCLASS returns the class of the graph analysis with averaged functional data.
			%
			% CLASS = AnalyzeGroup_FUN_GA_WU.GETCLASS() returns the class 'AnalyzeGroup_FUN_GA_WU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = A.GETCLASS() returns the class of the graph analysis with averaged functional data A.
			%  CLASS = Element.GETCLASS(A) returns the class of 'A'.
			%  CLASS = Element.GETCLASS('AnalyzeGroup_FUN_GA_WU') returns 'AnalyzeGroup_FUN_GA_WU'.
			%
			% Note that the Element.GETCLASS(A) and Element.GETCLASS('AnalyzeGroup_FUN_GA_WU')
			%  are less computationally efficient.
			
			a_class = 'AnalyzeGroup_FUN_GA_WU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph analysis with averaged functional data.
			%
			% LIST = AnalyzeGroup_FUN_GA_WU.GETSUBCLASSES() returns all subclasses of 'AnalyzeGroup_FUN_GA_WU'.
			%
			% Alternative forms to call this method are:
			%  LIST = A.GETSUBCLASSES() returns all subclasses of the graph analysis with averaged functional data A.
			%  LIST = Element.GETSUBCLASSES(A) returns all subclasses of 'A'.
			%  LIST = Element.GETSUBCLASSES('AnalyzeGroup_FUN_GA_WU') returns all subclasses of 'AnalyzeGroup_FUN_GA_WU'.
			%
			% Note that the Element.GETSUBCLASSES(A) and Element.GETSUBCLASSES('AnalyzeGroup_FUN_GA_WU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('AnalyzeGroup_FUN_GA_WU', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph analysis with averaged functional data.
			%
			% PROPS = AnalyzeGroup_FUN_GA_WU.GETPROPS() returns the property list of graph analysis with averaged functional data
			%  as a row vector.
			%
			% PROPS = AnalyzeGroup_FUN_GA_WU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = A.GETPROPS([CATEGORY]) returns the property list of the graph analysis with averaged functional data A.
			%  PROPS = Element.GETPROPS(A[, CATEGORY]) returns the property list of 'A'.
			%  PROPS = Element.GETPROPS('AnalyzeGroup_FUN_GA_WU'[, CATEGORY]) returns the property list of 'AnalyzeGroup_FUN_GA_WU'.
			%
			% Note that the Element.GETPROPS(A) and Element.GETPROPS('AnalyzeGroup_FUN_GA_WU')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					AnalyzeGroup.getProps() ...
						AnalyzeGroup_FUN_GA_WU.REPETITION ...
						AnalyzeGroup_FUN_GA_WU.F_MIN ...
						AnalyzeGroup_FUN_GA_WU.F_MAX ...
						AnalyzeGroup_FUN_GA_WU.CORRELATION_RULE ...
						AnalyzeGroup_FUN_GA_WU.NEGATIVE_WEIGHT_RULE ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						AnalyzeGroup.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						AnalyzeGroup.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						AnalyzeGroup.getProps(Category.PARAMETER) ...
						AnalyzeGroup_FUN_GA_WU.REPETITION ...
						AnalyzeGroup_FUN_GA_WU.F_MIN ...
						AnalyzeGroup_FUN_GA_WU.F_MAX ...
						AnalyzeGroup_FUN_GA_WU.CORRELATION_RULE ...
						AnalyzeGroup_FUN_GA_WU.NEGATIVE_WEIGHT_RULE ...
						];
				case Category.DATA
					prop_list = [ ...
						AnalyzeGroup.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						AnalyzeGroup.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						AnalyzeGroup.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						AnalyzeGroup.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						AnalyzeGroup.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						AnalyzeGroup.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of graph analysis with averaged functional data.
			%
			% N = AnalyzeGroup_FUN_GA_WU.GETPROPNUMBER() returns the property number of graph analysis with averaged functional data.
			%
			% N = AnalyzeGroup_FUN_GA_WU.GETPROPNUMBER(CATEGORY) returns the property number of graph analysis with averaged functional data
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = A.GETPROPNUMBER([CATEGORY]) returns the property number of the graph analysis with averaged functional data A.
			%  N = Element.GETPROPNUMBER(A) returns the property number of 'A'.
			%  N = Element.GETPROPNUMBER('AnalyzeGroup_FUN_GA_WU') returns the property number of 'AnalyzeGroup_FUN_GA_WU'.
			%
			% Note that the Element.GETPROPNUMBER(A) and Element.GETPROPNUMBER('AnalyzeGroup_FUN_GA_WU')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(AnalyzeGroup_FUN_GA_WU.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph analysis with averaged functional data/error.
			%
			% CHECK = AnalyzeGroup_FUN_GA_WU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSPROP(PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(A, PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(AnalyzeGroup_FUN_GA_WU, PROP) checks whether PROP exists for AnalyzeGroup_FUN_GA_WU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeGroup_FUN_GA_WU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSPROP(PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_FUN_GA_WU:WrongInput]
			%  Element.EXISTSPROP(A, PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_FUN_GA_WU:WrongInput]
			%  Element.EXISTSPROP(AnalyzeGroup_FUN_GA_WU, PROP) throws error if PROP does NOT exist for AnalyzeGroup_FUN_GA_WU.
			%   Error id: [BRAPH2:AnalyzeGroup_FUN_GA_WU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(A) and Element.EXISTSPROP('AnalyzeGroup_FUN_GA_WU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == AnalyzeGroup_FUN_GA_WU.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeGroup_FUN_GA_WU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroup_FUN_GA_WU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeGroup_FUN_GA_WU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph analysis with averaged functional data/error.
			%
			% CHECK = AnalyzeGroup_FUN_GA_WU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSTAG(TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(A, TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(AnalyzeGroup_FUN_GA_WU, TAG) checks whether TAG exists for AnalyzeGroup_FUN_GA_WU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeGroup_FUN_GA_WU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSTAG(TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_FUN_GA_WU:WrongInput]
			%  Element.EXISTSTAG(A, TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_FUN_GA_WU:WrongInput]
			%  Element.EXISTSTAG(AnalyzeGroup_FUN_GA_WU, TAG) throws error if TAG does NOT exist for AnalyzeGroup_FUN_GA_WU.
			%   Error id: [BRAPH2:AnalyzeGroup_FUN_GA_WU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(A) and Element.EXISTSTAG('AnalyzeGroup_FUN_GA_WU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			analyzegroup_fun_ga_wu_tag_list = cellfun(@(x) AnalyzeGroup_FUN_GA_WU.getPropTag(x), num2cell(AnalyzeGroup_FUN_GA_WU.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, analyzegroup_fun_ga_wu_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeGroup_FUN_GA_WU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroup_FUN_GA_WU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for AnalyzeGroup_FUN_GA_WU.'] ...
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
			%  PROPERTY = A.GETPROPPROP(POINTER) returns property number of POINTER of A.
			%  PROPERTY = Element.GETPROPPROP(AnalyzeGroup_FUN_GA_WU, POINTER) returns property number of POINTER of AnalyzeGroup_FUN_GA_WU.
			%  PROPERTY = A.GETPROPPROP(AnalyzeGroup_FUN_GA_WU, POINTER) returns property number of POINTER of AnalyzeGroup_FUN_GA_WU.
			%
			% Note that the Element.GETPROPPROP(A) and Element.GETPROPPROP('AnalyzeGroup_FUN_GA_WU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				analyzegroup_fun_ga_wu_tag_list = cellfun(@(x) AnalyzeGroup_FUN_GA_WU.getPropTag(x), num2cell(AnalyzeGroup_FUN_GA_WU.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, analyzegroup_fun_ga_wu_tag_list)); % tag = pointer
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
			%  TAG = A.GETPROPTAG(POINTER) returns tag of POINTER of A.
			%  TAG = Element.GETPROPTAG(AnalyzeGroup_FUN_GA_WU, POINTER) returns tag of POINTER of AnalyzeGroup_FUN_GA_WU.
			%  TAG = A.GETPROPTAG(AnalyzeGroup_FUN_GA_WU, POINTER) returns tag of POINTER of AnalyzeGroup_FUN_GA_WU.
			%
			% Note that the Element.GETPROPTAG(A) and Element.GETPROPTAG('AnalyzeGroup_FUN_GA_WU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case AnalyzeGroup_FUN_GA_WU.REPETITION
						tag = AnalyzeGroup_FUN_GA_WU.REPETITION_TAG;
					case AnalyzeGroup_FUN_GA_WU.F_MIN
						tag = AnalyzeGroup_FUN_GA_WU.F_MIN_TAG;
					case AnalyzeGroup_FUN_GA_WU.F_MAX
						tag = AnalyzeGroup_FUN_GA_WU.F_MAX_TAG;
					case AnalyzeGroup_FUN_GA_WU.CORRELATION_RULE
						tag = AnalyzeGroup_FUN_GA_WU.CORRELATION_RULE_TAG;
					case AnalyzeGroup_FUN_GA_WU.NEGATIVE_WEIGHT_RULE
						tag = AnalyzeGroup_FUN_GA_WU.NEGATIVE_WEIGHT_RULE_TAG;
					otherwise
						tag = getPropTag@AnalyzeGroup(prop);
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
			%  CATEGORY = A.GETPROPCATEGORY(POINTER) returns category of POINTER of A.
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeGroup_FUN_GA_WU, POINTER) returns category of POINTER of AnalyzeGroup_FUN_GA_WU.
			%  CATEGORY = A.GETPROPCATEGORY(AnalyzeGroup_FUN_GA_WU, POINTER) returns category of POINTER of AnalyzeGroup_FUN_GA_WU.
			%
			% Note that the Element.GETPROPCATEGORY(A) and Element.GETPROPCATEGORY('AnalyzeGroup_FUN_GA_WU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeGroup_FUN_GA_WU.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_FUN_GA_WU.REPETITION
					prop_category = AnalyzeGroup_FUN_GA_WU.REPETITION_CATEGORY;
				case AnalyzeGroup_FUN_GA_WU.F_MIN
					prop_category = AnalyzeGroup_FUN_GA_WU.F_MIN_CATEGORY;
				case AnalyzeGroup_FUN_GA_WU.F_MAX
					prop_category = AnalyzeGroup_FUN_GA_WU.F_MAX_CATEGORY;
				case AnalyzeGroup_FUN_GA_WU.CORRELATION_RULE
					prop_category = AnalyzeGroup_FUN_GA_WU.CORRELATION_RULE_CATEGORY;
				case AnalyzeGroup_FUN_GA_WU.NEGATIVE_WEIGHT_RULE
					prop_category = AnalyzeGroup_FUN_GA_WU.NEGATIVE_WEIGHT_RULE_CATEGORY;
				otherwise
					prop_category = getPropCategory@AnalyzeGroup(prop);
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
			%  FORMAT = A.GETPROPFORMAT(POINTER) returns format of POINTER of A.
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeGroup_FUN_GA_WU, POINTER) returns format of POINTER of AnalyzeGroup_FUN_GA_WU.
			%  FORMAT = A.GETPROPFORMAT(AnalyzeGroup_FUN_GA_WU, POINTER) returns format of POINTER of AnalyzeGroup_FUN_GA_WU.
			%
			% Note that the Element.GETPROPFORMAT(A) and Element.GETPROPFORMAT('AnalyzeGroup_FUN_GA_WU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeGroup_FUN_GA_WU.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_FUN_GA_WU.REPETITION
					prop_format = AnalyzeGroup_FUN_GA_WU.REPETITION_FORMAT;
				case AnalyzeGroup_FUN_GA_WU.F_MIN
					prop_format = AnalyzeGroup_FUN_GA_WU.F_MIN_FORMAT;
				case AnalyzeGroup_FUN_GA_WU.F_MAX
					prop_format = AnalyzeGroup_FUN_GA_WU.F_MAX_FORMAT;
				case AnalyzeGroup_FUN_GA_WU.CORRELATION_RULE
					prop_format = AnalyzeGroup_FUN_GA_WU.CORRELATION_RULE_FORMAT;
				case AnalyzeGroup_FUN_GA_WU.NEGATIVE_WEIGHT_RULE
					prop_format = AnalyzeGroup_FUN_GA_WU.NEGATIVE_WEIGHT_RULE_FORMAT;
				otherwise
					prop_format = getPropFormat@AnalyzeGroup(prop);
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
			%  DESCRIPTION = A.GETPROPDESCRIPTION(POINTER) returns description of POINTER of A.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeGroup_FUN_GA_WU, POINTER) returns description of POINTER of AnalyzeGroup_FUN_GA_WU.
			%  DESCRIPTION = A.GETPROPDESCRIPTION(AnalyzeGroup_FUN_GA_WU, POINTER) returns description of POINTER of AnalyzeGroup_FUN_GA_WU.
			%
			% Note that the Element.GETPROPDESCRIPTION(A) and Element.GETPROPDESCRIPTION('AnalyzeGroup_FUN_GA_WU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeGroup_FUN_GA_WU.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_FUN_GA_WU.REPETITION
					prop_description = 'REPETITION (parameter, scalar) is the number of repetitions';
				case AnalyzeGroup_FUN_GA_WU.F_MIN
					prop_description = 'F_MIN (parameter, scalar) is the minimum frequency value';
				case AnalyzeGroup_FUN_GA_WU.F_MAX
					prop_description = 'F_MAX (parameter, scalar) is the maximum frequency value';
				case AnalyzeGroup_FUN_GA_WU.CORRELATION_RULE
					prop_description = 'CORRELATION_RULE (parameter, option) is the correlation type.';
				case AnalyzeGroup_FUN_GA_WU.NEGATIVE_WEIGHT_RULE
					prop_description = 'NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.';
				case AnalyzeGroup_FUN_GA_WU.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case AnalyzeGroup_FUN_GA_WU.NAME
					prop_description = 'NAME (constant, string) is the name of the graph analysis with averaged functional data.';
				case AnalyzeGroup_FUN_GA_WU.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the graph analysis with averaged functional data.';
				case AnalyzeGroup_FUN_GA_WU.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the graph analysis with averaged functional data.';
				case AnalyzeGroup_FUN_GA_WU.ID
					prop_description = 'ID (data, string) is a few-letter code for the graph analysis with averaged functional data.';
				case AnalyzeGroup_FUN_GA_WU.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graph analysis with averaged functional data.';
				case AnalyzeGroup_FUN_GA_WU.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graph analysis with averaged functional data.';
				case AnalyzeGroup_FUN_GA_WU.GR
					prop_description = 'GR (data, item) is the subject group, which also defines the subject class SubjectFUN.';
				case AnalyzeGroup_FUN_GA_WU.G
					prop_description = 'G (result, item) is the average graph obtained from this analysis.';
				otherwise
					prop_description = getPropDescription@AnalyzeGroup(prop);
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
			%  SETTINGS = A.GETPROPSETTINGS(POINTER) returns settings of POINTER of A.
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeGroup_FUN_GA_WU, POINTER) returns settings of POINTER of AnalyzeGroup_FUN_GA_WU.
			%  SETTINGS = A.GETPROPSETTINGS(AnalyzeGroup_FUN_GA_WU, POINTER) returns settings of POINTER of AnalyzeGroup_FUN_GA_WU.
			%
			% Note that the Element.GETPROPSETTINGS(A) and Element.GETPROPSETTINGS('AnalyzeGroup_FUN_GA_WU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeGroup_FUN_GA_WU.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_FUN_GA_WU.REPETITION
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case AnalyzeGroup_FUN_GA_WU.F_MIN
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case AnalyzeGroup_FUN_GA_WU.F_MAX
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case AnalyzeGroup_FUN_GA_WU.CORRELATION_RULE
					prop_settings = Correlation.CORRELATION_RULE_LIST(1:3);
				case AnalyzeGroup_FUN_GA_WU.NEGATIVE_WEIGHT_RULE
					prop_settings = Correlation.NEGATIVE_WEIGHT_RULE_LIST;
				case AnalyzeGroup_FUN_GA_WU.TEMPLATE
					prop_settings = 'AnalyzeGroup_FUN_GA_WU';
				case AnalyzeGroup_FUN_GA_WU.G
					prop_settings = 'GraphWU';
				otherwise
					prop_settings = getPropSettings@AnalyzeGroup(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeGroup_FUN_GA_WU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeGroup_FUN_GA_WU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULT(POINTER) returns the default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeGroup_FUN_GA_WU, POINTER) returns the default value of POINTER of AnalyzeGroup_FUN_GA_WU.
			%  DEFAULT = A.GETPROPDEFAULT(AnalyzeGroup_FUN_GA_WU, POINTER) returns the default value of POINTER of AnalyzeGroup_FUN_GA_WU.
			%
			% Note that the Element.GETPROPDEFAULT(A) and Element.GETPROPDEFAULT('AnalyzeGroup_FUN_GA_WU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeGroup_FUN_GA_WU.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_FUN_GA_WU.REPETITION
					prop_default = 1;
				case AnalyzeGroup_FUN_GA_WU.F_MIN
					prop_default = 0;
				case AnalyzeGroup_FUN_GA_WU.F_MAX
					prop_default = Inf;
				case AnalyzeGroup_FUN_GA_WU.CORRELATION_RULE
					prop_default = Correlation.CORRELATION_RULE_LIST{1};
				case AnalyzeGroup_FUN_GA_WU.NEGATIVE_WEIGHT_RULE
					prop_default = Correlation.NEGATIVE_WEIGHT_RULE_LIST{1};
				case AnalyzeGroup_FUN_GA_WU.ELCLASS
					prop_default = 'AnalyzeGroup_FUN_GA_WU';
				case AnalyzeGroup_FUN_GA_WU.NAME
					prop_default = 'AnalyzeGroup_FUN_GA_WU';
				case AnalyzeGroup_FUN_GA_WU.DESCRIPTION
					prop_default = 'AnalyzeGroup_FUN_GA_WU uses functional data averaged over a group and analyzes them using weighted undirected graphs.';
				case AnalyzeGroup_FUN_GA_WU.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, AnalyzeGroup_FUN_GA_WU.getPropSettings(prop));
				case AnalyzeGroup_FUN_GA_WU.ID
					prop_default = 'AnalyzeGroup_FUN_GA_WU ID';
				case AnalyzeGroup_FUN_GA_WU.LABEL
					prop_default = 'AnalyzeGroup_FUN_GA_WU label';
				case AnalyzeGroup_FUN_GA_WU.NOTES
					prop_default = 'AnalyzeGroup_FUN_GA_WU notes';
				case AnalyzeGroup_FUN_GA_WU.GR
					prop_default = Group('SUB_CLASS', 'SubjectFUN');
				case AnalyzeGroup_FUN_GA_WU.G
					prop_default = GraphWU();
				otherwise
					prop_default = getPropDefault@AnalyzeGroup(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeGroup_FUN_GA_WU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeGroup_FUN_GA_WU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeGroup_FUN_GA_WU, POINTER) returns the conditioned default value of POINTER of AnalyzeGroup_FUN_GA_WU.
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(AnalyzeGroup_FUN_GA_WU, POINTER) returns the conditioned default value of POINTER of AnalyzeGroup_FUN_GA_WU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(A) and Element.GETPROPDEFAULTCONDITIONED('AnalyzeGroup_FUN_GA_WU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = AnalyzeGroup_FUN_GA_WU.getPropProp(pointer);
			
			prop_default = AnalyzeGroup_FUN_GA_WU.conditioning(prop, AnalyzeGroup_FUN_GA_WU.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = A.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = A.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of A.
			%  CHECK = Element.CHECKPROP(AnalyzeGroup_FUN_GA_WU, PROP, VALUE) checks VALUE format for PROP of AnalyzeGroup_FUN_GA_WU.
			%  CHECK = A.CHECKPROP(AnalyzeGroup_FUN_GA_WU, PROP, VALUE) checks VALUE format for PROP of AnalyzeGroup_FUN_GA_WU.
			% 
			% A.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:AnalyzeGroup_FUN_GA_WU:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  A.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of A.
			%   Error id: €BRAPH2.STR€:AnalyzeGroup_FUN_GA_WU:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(AnalyzeGroup_FUN_GA_WU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeGroup_FUN_GA_WU.
			%   Error id: €BRAPH2.STR€:AnalyzeGroup_FUN_GA_WU:€BRAPH2.WRONG_INPUT€
			%  A.CHECKPROP(AnalyzeGroup_FUN_GA_WU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeGroup_FUN_GA_WU.
			%   Error id: €BRAPH2.STR€:AnalyzeGroup_FUN_GA_WU:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(A) and Element.CHECKPROP('AnalyzeGroup_FUN_GA_WU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = AnalyzeGroup_FUN_GA_WU.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_FUN_GA_WU.REPETITION % __AnalyzeGroup_FUN_GA_WU.REPETITION__
					check = Format.checkFormat(Format.SCALAR, value, AnalyzeGroup_FUN_GA_WU.getPropSettings(prop));
				case AnalyzeGroup_FUN_GA_WU.F_MIN % __AnalyzeGroup_FUN_GA_WU.F_MIN__
					check = Format.checkFormat(Format.SCALAR, value, AnalyzeGroup_FUN_GA_WU.getPropSettings(prop));
				case AnalyzeGroup_FUN_GA_WU.F_MAX % __AnalyzeGroup_FUN_GA_WU.F_MAX__
					check = Format.checkFormat(Format.SCALAR, value, AnalyzeGroup_FUN_GA_WU.getPropSettings(prop));
				case AnalyzeGroup_FUN_GA_WU.CORRELATION_RULE % __AnalyzeGroup_FUN_GA_WU.CORRELATION_RULE__
					check = Format.checkFormat(Format.OPTION, value, AnalyzeGroup_FUN_GA_WU.getPropSettings(prop));
				case AnalyzeGroup_FUN_GA_WU.NEGATIVE_WEIGHT_RULE % __AnalyzeGroup_FUN_GA_WU.NEGATIVE_WEIGHT_RULE__
					check = Format.checkFormat(Format.OPTION, value, AnalyzeGroup_FUN_GA_WU.getPropSettings(prop));
				case AnalyzeGroup_FUN_GA_WU.TEMPLATE % __AnalyzeGroup_FUN_GA_WU.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, AnalyzeGroup_FUN_GA_WU.getPropSettings(prop));
				case AnalyzeGroup_FUN_GA_WU.G % __AnalyzeGroup_FUN_GA_WU.G__
					check = Format.checkFormat(Format.ITEM, value, AnalyzeGroup_FUN_GA_WU.getPropSettings(prop));
				otherwise
					if prop <= AnalyzeGroup.getPropNumber()
						check = checkProp@AnalyzeGroup(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeGroup_FUN_GA_WU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroup_FUN_GA_WU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeGroup_FUN_GA_WU.getPropTag(prop) ' (' AnalyzeGroup_FUN_GA_WU.getFormatTag(AnalyzeGroup_FUN_GA_WU.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(a, prop, varargin)
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
				case AnalyzeGroup_FUN_GA_WU.G % __AnalyzeGroup_FUN_GA_WU.G__
					rng_settings_ = rng(); rng(a.getPropSeed(AnalyzeGroup_FUN_GA_WU.G), 'twister')
					
					gr = a.get('GR');
					T = a.get('REPETITION');
					fmin = a.get('F_MIN');
					fmax = a.get('F_MAX');
					A_fun = [];
					for i = 1:1:gr.get('SUB_DICT').get('LENGTH')
						sub = gr.get('SUB_DICT').get('IT', i);
					    data = sub.getr('FUN');
					    fs = 1 / T;
					    
					    if fmax > fmin && T > 0
					        NFFT = 2 * ceil(size(data, 1) / 2);
					        ft = fft(data, NFFT);  % Fourier transform
					        f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
					        ft(f < fmin | f > fmax, :) = 0;
					        data = ifft(ft, NFFT);
					    end
					    A = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));
					    
					    if i == 1
					        A_fun = A;
					    else
					        A_fun = A_fun + A;
					    end    
					end
					A_fun = A_fun / gr.get('SUB_DICT').get('LENGTH');
					
					g = GraphWU( ...
					    'ID', ['Graph ' gr.get('ID')], ...
					    'B', A_fun ...
					    );
					
					if ~isa(a.getr('TEMPLATE'), 'NoValue') % the analysis has a template
					    g.set('TEMPLATE', a.get('TEMPLATE').memorize('G')) % the template is memorized
					end
					
					if a.get('GR').get('SUB_DICT').get('LENGTH')
					    g.set('NODELABELS', a.get('GR').get('SUB_DICT').get('IT', 1).get('BA').get('BR_DICT').get('KEYS'))
					end
					
					value = g;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= AnalyzeGroup.getPropNumber()
						value = calculateValue@AnalyzeGroup(a, prop, varargin{:});
					else
						value = calculateValue@Element(a, prop, varargin{:});
					end
			end
			
		end
	end
end
