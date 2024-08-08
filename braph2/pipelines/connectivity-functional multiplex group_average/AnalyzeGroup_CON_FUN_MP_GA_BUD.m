classdef AnalyzeGroup_CON_FUN_MP_GA_BUD < AnalyzeGroup
	%AnalyzeGroup_CON_FUN_MP_GA_BUD is a graph analysis using connectivity and functional multiplex data of fixed density.
	% It is a subclass of <a href="matlab:help AnalyzeGroup">AnalyzeGroup</a>.
	%
	% This graph analysis uses connectivity and functional multiplex data of 
	% fixed density and analyzes them using binary undirected graphs.
	%
	% AnalyzeGroup_CON_FUN_MP_GA_BUD methods (constructor):
	%  AnalyzeGroup_CON_FUN_MP_GA_BUD - constructor
	%
	% AnalyzeGroup_CON_FUN_MP_GA_BUD methods:
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
	% AnalyzeGroup_CON_FUN_MP_GA_BUD methods (display):
	%  tostring - string with information about the graph analysis with connectivity and functional multiplex data of fixed density
	%  disp - displays information about the graph analysis with connectivity and functional multiplex data of fixed density
	%  tree - displays the tree of the graph analysis with connectivity and functional multiplex data of fixed density
	%
	% AnalyzeGroup_CON_FUN_MP_GA_BUD methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two graph analysis with connectivity and functional multiplex data of fixed density are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the graph analysis with connectivity and functional multiplex data of fixed density
	%
	% AnalyzeGroup_CON_FUN_MP_GA_BUD methods (save/load, Static):
	%  save - saves BRAPH2 graph analysis with connectivity and functional multiplex data of fixed density as b2 file
	%  load - loads a BRAPH2 graph analysis with connectivity and functional multiplex data of fixed density from a b2 file
	%
	% AnalyzeGroup_CON_FUN_MP_GA_BUD method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the graph analysis with connectivity and functional multiplex data of fixed density
	%
	% AnalyzeGroup_CON_FUN_MP_GA_BUD method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the graph analysis with connectivity and functional multiplex data of fixed density
	%
	% AnalyzeGroup_CON_FUN_MP_GA_BUD methods (inspection, Static):
	%  getClass - returns the class of the graph analysis with connectivity and functional multiplex data of fixed density
	%  getSubclasses - returns all subclasses of AnalyzeGroup_CON_FUN_MP_GA_BUD
	%  getProps - returns the property list of the graph analysis with connectivity and functional multiplex data of fixed density
	%  getPropNumber - returns the property number of the graph analysis with connectivity and functional multiplex data of fixed density
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
	% AnalyzeGroup_CON_FUN_MP_GA_BUD methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% AnalyzeGroup_CON_FUN_MP_GA_BUD methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% AnalyzeGroup_CON_FUN_MP_GA_BUD methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% AnalyzeGroup_CON_FUN_MP_GA_BUD methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?AnalyzeGroup_CON_FUN_MP_GA_BUD; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">AnalyzeGroup_CON_FUN_MP_GA_BUD constants</a>.
	%
	%
	% See also SubjectCON_FUN_MP, MultiplexBUD.
	
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
		
		DENSITIES = AnalyzeGroup.getPropNumber() + 6;
		DENSITIES_TAG = 'DENSITIES';
		DENSITIES_CATEGORY = Category.PARAMETER;
		DENSITIES_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function a = AnalyzeGroup_CON_FUN_MP_GA_BUD(varargin)
			%AnalyzeGroup_CON_FUN_MP_GA_BUD() creates a graph analysis with connectivity and functional multiplex data of fixed density.
			%
			% AnalyzeGroup_CON_FUN_MP_GA_BUD(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% AnalyzeGroup_CON_FUN_MP_GA_BUD(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the graph analysis with connectivity and functional multiplex data of fixed density.
			%
			% CLASS = AnalyzeGroup_CON_FUN_MP_GA_BUD.GETCLASS() returns the class 'AnalyzeGroup_CON_FUN_MP_GA_BUD'.
			%
			% Alternative forms to call this method are:
			%  CLASS = A.GETCLASS() returns the class of the graph analysis with connectivity and functional multiplex data of fixed density A.
			%  CLASS = Element.GETCLASS(A) returns the class of 'A'.
			%  CLASS = Element.GETCLASS('AnalyzeGroup_CON_FUN_MP_GA_BUD') returns 'AnalyzeGroup_CON_FUN_MP_GA_BUD'.
			%
			% Note that the Element.GETCLASS(A) and Element.GETCLASS('AnalyzeGroup_CON_FUN_MP_GA_BUD')
			%  are less computationally efficient.
			
			a_class = 'AnalyzeGroup_CON_FUN_MP_GA_BUD';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the graph analysis with connectivity and functional multiplex data of fixed density.
			%
			% LIST = AnalyzeGroup_CON_FUN_MP_GA_BUD.GETSUBCLASSES() returns all subclasses of 'AnalyzeGroup_CON_FUN_MP_GA_BUD'.
			%
			% Alternative forms to call this method are:
			%  LIST = A.GETSUBCLASSES() returns all subclasses of the graph analysis with connectivity and functional multiplex data of fixed density A.
			%  LIST = Element.GETSUBCLASSES(A) returns all subclasses of 'A'.
			%  LIST = Element.GETSUBCLASSES('AnalyzeGroup_CON_FUN_MP_GA_BUD') returns all subclasses of 'AnalyzeGroup_CON_FUN_MP_GA_BUD'.
			%
			% Note that the Element.GETSUBCLASSES(A) and Element.GETSUBCLASSES('AnalyzeGroup_CON_FUN_MP_GA_BUD')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('AnalyzeGroup_CON_FUN_MP_GA_BUD', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of graph analysis with connectivity and functional multiplex data of fixed density.
			%
			% PROPS = AnalyzeGroup_CON_FUN_MP_GA_BUD.GETPROPS() returns the property list of graph analysis with connectivity and functional multiplex data of fixed density
			%  as a row vector.
			%
			% PROPS = AnalyzeGroup_CON_FUN_MP_GA_BUD.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = A.GETPROPS([CATEGORY]) returns the property list of the graph analysis with connectivity and functional multiplex data of fixed density A.
			%  PROPS = Element.GETPROPS(A[, CATEGORY]) returns the property list of 'A'.
			%  PROPS = Element.GETPROPS('AnalyzeGroup_CON_FUN_MP_GA_BUD'[, CATEGORY]) returns the property list of 'AnalyzeGroup_CON_FUN_MP_GA_BUD'.
			%
			% Note that the Element.GETPROPS(A) and Element.GETPROPS('AnalyzeGroup_CON_FUN_MP_GA_BUD')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					AnalyzeGroup.getProps() ...
						AnalyzeGroup_CON_FUN_MP_GA_BUD.REPETITION ...
						AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MIN ...
						AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MAX ...
						AnalyzeGroup_CON_FUN_MP_GA_BUD.CORRELATION_RULE ...
						AnalyzeGroup_CON_FUN_MP_GA_BUD.NEGATIVE_WEIGHT_RULE ...
						AnalyzeGroup_CON_FUN_MP_GA_BUD.DENSITIES ...
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
						AnalyzeGroup_CON_FUN_MP_GA_BUD.REPETITION ...
						AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MIN ...
						AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MAX ...
						AnalyzeGroup_CON_FUN_MP_GA_BUD.CORRELATION_RULE ...
						AnalyzeGroup_CON_FUN_MP_GA_BUD.NEGATIVE_WEIGHT_RULE ...
						AnalyzeGroup_CON_FUN_MP_GA_BUD.DENSITIES ...
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
			%GETPROPNUMBER returns the property number of graph analysis with connectivity and functional multiplex data of fixed density.
			%
			% N = AnalyzeGroup_CON_FUN_MP_GA_BUD.GETPROPNUMBER() returns the property number of graph analysis with connectivity and functional multiplex data of fixed density.
			%
			% N = AnalyzeGroup_CON_FUN_MP_GA_BUD.GETPROPNUMBER(CATEGORY) returns the property number of graph analysis with connectivity and functional multiplex data of fixed density
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = A.GETPROPNUMBER([CATEGORY]) returns the property number of the graph analysis with connectivity and functional multiplex data of fixed density A.
			%  N = Element.GETPROPNUMBER(A) returns the property number of 'A'.
			%  N = Element.GETPROPNUMBER('AnalyzeGroup_CON_FUN_MP_GA_BUD') returns the property number of 'AnalyzeGroup_CON_FUN_MP_GA_BUD'.
			%
			% Note that the Element.GETPROPNUMBER(A) and Element.GETPROPNUMBER('AnalyzeGroup_CON_FUN_MP_GA_BUD')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(AnalyzeGroup_CON_FUN_MP_GA_BUD.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in graph analysis with connectivity and functional multiplex data of fixed density/error.
			%
			% CHECK = AnalyzeGroup_CON_FUN_MP_GA_BUD.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSPROP(PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(A, PROP) checks whether PROP exists for A.
			%  CHECK = Element.EXISTSPROP(AnalyzeGroup_CON_FUN_MP_GA_BUD, PROP) checks whether PROP exists for AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:AnalyzeGroup_CON_FUN_MP_GA_BUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSPROP(PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_CON_FUN_MP_GA_BUD:WrongInput]
			%  Element.EXISTSPROP(A, PROP) throws error if PROP does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_CON_FUN_MP_GA_BUD:WrongInput]
			%  Element.EXISTSPROP(AnalyzeGroup_CON_FUN_MP_GA_BUD, PROP) throws error if PROP does NOT exist for AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%   Error id: [BRAPH2:AnalyzeGroup_CON_FUN_MP_GA_BUD:WrongInput]
			%
			% Note that the Element.EXISTSPROP(A) and Element.EXISTSPROP('AnalyzeGroup_CON_FUN_MP_GA_BUD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == AnalyzeGroup_CON_FUN_MP_GA_BUD.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeGroup_CON_FUN_MP_GA_BUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroup_CON_FUN_MP_GA_BUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for AnalyzeGroup_CON_FUN_MP_GA_BUD.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in graph analysis with connectivity and functional multiplex data of fixed density/error.
			%
			% CHECK = AnalyzeGroup_CON_FUN_MP_GA_BUD.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = A.EXISTSTAG(TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(A, TAG) checks whether TAG exists for A.
			%  CHECK = Element.EXISTSTAG(AnalyzeGroup_CON_FUN_MP_GA_BUD, TAG) checks whether TAG exists for AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:AnalyzeGroup_CON_FUN_MP_GA_BUD:WrongInput]
			%
			% Alternative forms to call this method are:
			%  A.EXISTSTAG(TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_CON_FUN_MP_GA_BUD:WrongInput]
			%  Element.EXISTSTAG(A, TAG) throws error if TAG does NOT exist for A.
			%   Error id: [BRAPH2:AnalyzeGroup_CON_FUN_MP_GA_BUD:WrongInput]
			%  Element.EXISTSTAG(AnalyzeGroup_CON_FUN_MP_GA_BUD, TAG) throws error if TAG does NOT exist for AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%   Error id: [BRAPH2:AnalyzeGroup_CON_FUN_MP_GA_BUD:WrongInput]
			%
			% Note that the Element.EXISTSTAG(A) and Element.EXISTSTAG('AnalyzeGroup_CON_FUN_MP_GA_BUD')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			analyzegroup_con_fun_mp_ga_bud_tag_list = cellfun(@(x) AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropTag(x), num2cell(AnalyzeGroup_CON_FUN_MP_GA_BUD.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, analyzegroup_con_fun_mp_ga_bud_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeGroup_CON_FUN_MP_GA_BUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroup_CON_FUN_MP_GA_BUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for AnalyzeGroup_CON_FUN_MP_GA_BUD.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(AnalyzeGroup_CON_FUN_MP_GA_BUD, POINTER) returns property number of POINTER of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%  PROPERTY = A.GETPROPPROP(AnalyzeGroup_CON_FUN_MP_GA_BUD, POINTER) returns property number of POINTER of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%
			% Note that the Element.GETPROPPROP(A) and Element.GETPROPPROP('AnalyzeGroup_CON_FUN_MP_GA_BUD')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				analyzegroup_con_fun_mp_ga_bud_tag_list = cellfun(@(x) AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropTag(x), num2cell(AnalyzeGroup_CON_FUN_MP_GA_BUD.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, analyzegroup_con_fun_mp_ga_bud_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(AnalyzeGroup_CON_FUN_MP_GA_BUD, POINTER) returns tag of POINTER of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%  TAG = A.GETPROPTAG(AnalyzeGroup_CON_FUN_MP_GA_BUD, POINTER) returns tag of POINTER of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%
			% Note that the Element.GETPROPTAG(A) and Element.GETPROPTAG('AnalyzeGroup_CON_FUN_MP_GA_BUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case AnalyzeGroup_CON_FUN_MP_GA_BUD.REPETITION
						tag = AnalyzeGroup_CON_FUN_MP_GA_BUD.REPETITION_TAG;
					case AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MIN
						tag = AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MIN_TAG;
					case AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MAX
						tag = AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MAX_TAG;
					case AnalyzeGroup_CON_FUN_MP_GA_BUD.CORRELATION_RULE
						tag = AnalyzeGroup_CON_FUN_MP_GA_BUD.CORRELATION_RULE_TAG;
					case AnalyzeGroup_CON_FUN_MP_GA_BUD.NEGATIVE_WEIGHT_RULE
						tag = AnalyzeGroup_CON_FUN_MP_GA_BUD.NEGATIVE_WEIGHT_RULE_TAG;
					case AnalyzeGroup_CON_FUN_MP_GA_BUD.DENSITIES
						tag = AnalyzeGroup_CON_FUN_MP_GA_BUD.DENSITIES_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(AnalyzeGroup_CON_FUN_MP_GA_BUD, POINTER) returns category of POINTER of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%  CATEGORY = A.GETPROPCATEGORY(AnalyzeGroup_CON_FUN_MP_GA_BUD, POINTER) returns category of POINTER of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%
			% Note that the Element.GETPROPCATEGORY(A) and Element.GETPROPCATEGORY('AnalyzeGroup_CON_FUN_MP_GA_BUD')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.REPETITION
					prop_category = AnalyzeGroup_CON_FUN_MP_GA_BUD.REPETITION_CATEGORY;
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MIN
					prop_category = AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MIN_CATEGORY;
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MAX
					prop_category = AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MAX_CATEGORY;
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.CORRELATION_RULE
					prop_category = AnalyzeGroup_CON_FUN_MP_GA_BUD.CORRELATION_RULE_CATEGORY;
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.NEGATIVE_WEIGHT_RULE
					prop_category = AnalyzeGroup_CON_FUN_MP_GA_BUD.NEGATIVE_WEIGHT_RULE_CATEGORY;
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.DENSITIES
					prop_category = AnalyzeGroup_CON_FUN_MP_GA_BUD.DENSITIES_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(AnalyzeGroup_CON_FUN_MP_GA_BUD, POINTER) returns format of POINTER of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%  FORMAT = A.GETPROPFORMAT(AnalyzeGroup_CON_FUN_MP_GA_BUD, POINTER) returns format of POINTER of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%
			% Note that the Element.GETPROPFORMAT(A) and Element.GETPROPFORMAT('AnalyzeGroup_CON_FUN_MP_GA_BUD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.REPETITION
					prop_format = AnalyzeGroup_CON_FUN_MP_GA_BUD.REPETITION_FORMAT;
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MIN
					prop_format = AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MIN_FORMAT;
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MAX
					prop_format = AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MAX_FORMAT;
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.CORRELATION_RULE
					prop_format = AnalyzeGroup_CON_FUN_MP_GA_BUD.CORRELATION_RULE_FORMAT;
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.NEGATIVE_WEIGHT_RULE
					prop_format = AnalyzeGroup_CON_FUN_MP_GA_BUD.NEGATIVE_WEIGHT_RULE_FORMAT;
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.DENSITIES
					prop_format = AnalyzeGroup_CON_FUN_MP_GA_BUD.DENSITIES_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(AnalyzeGroup_CON_FUN_MP_GA_BUD, POINTER) returns description of POINTER of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%  DESCRIPTION = A.GETPROPDESCRIPTION(AnalyzeGroup_CON_FUN_MP_GA_BUD, POINTER) returns description of POINTER of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%
			% Note that the Element.GETPROPDESCRIPTION(A) and Element.GETPROPDESCRIPTION('AnalyzeGroup_CON_FUN_MP_GA_BUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.REPETITION
					prop_description = 'REPETITION (parameter, scalar) is the number of repetitions for functional data';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MIN
					prop_description = 'F_MIN (parameter, scalar) is the minimum frequency value for functional data';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MAX
					prop_description = 'F_MAX (parameter, scalar) is the maximum frequency value for functional data';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.CORRELATION_RULE
					prop_description = 'CORRELATION_RULE (parameter, option) is the correlation type for functional data.';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.NEGATIVE_WEIGHT_RULE
					prop_description = 'NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights of functional data.';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.DENSITIES
					prop_description = 'DENSITIES (parameter, rvector) is the vector of densities.';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the graph analysis with connectivity and functional multiplex data of fixed density.';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.NAME
					prop_description = 'NAME (constant, string) is the name of the graph analysis with connectivity and functional multiplex data of fixed density.';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the graph analysis with connectivity and functional multiplex data of fixed density.';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the graph analysis with connectivity and functional multiplex data of fixed density.';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.ID
					prop_description = 'ID (data, string) is a few-letter code for the graph analysis with connectivity and functional multiplex data of fixed density.';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graph analysis with connectivity and functional multiplex data of fixed density.';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graph analysis with connectivity and functional multiplex data of fixed density.';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.GR
					prop_description = 'GR (data, item) is the subject group, which also defines the subject class SubjectCON_FUN_MP.';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.G
					prop_description = 'G (result, item) is the average multiplex graph obtained from this analysis.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(AnalyzeGroup_CON_FUN_MP_GA_BUD, POINTER) returns settings of POINTER of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%  SETTINGS = A.GETPROPSETTINGS(AnalyzeGroup_CON_FUN_MP_GA_BUD, POINTER) returns settings of POINTER of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%
			% Note that the Element.GETPROPSETTINGS(A) and Element.GETPROPSETTINGS('AnalyzeGroup_CON_FUN_MP_GA_BUD')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.REPETITION
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MIN
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MAX
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.CORRELATION_RULE
					prop_settings = Correlation.CORRELATION_RULE_LIST(1:3);
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.NEGATIVE_WEIGHT_RULE
					prop_settings = Correlation.NEGATIVE_WEIGHT_RULE_LIST;
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.DENSITIES
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.TEMPLATE
					prop_settings = 'AnalyzeGroup_CON_FUN_MP_GA_BUD';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.G
					prop_settings = 'MultiplexBUD';
				otherwise
					prop_settings = getPropSettings@AnalyzeGroup(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = AnalyzeGroup_CON_FUN_MP_GA_BUD.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeGroup_CON_FUN_MP_GA_BUD.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULT(POINTER) returns the default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULT(AnalyzeGroup_CON_FUN_MP_GA_BUD, POINTER) returns the default value of POINTER of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%  DEFAULT = A.GETPROPDEFAULT(AnalyzeGroup_CON_FUN_MP_GA_BUD, POINTER) returns the default value of POINTER of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%
			% Note that the Element.GETPROPDEFAULT(A) and Element.GETPROPDEFAULT('AnalyzeGroup_CON_FUN_MP_GA_BUD')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.REPETITION
					prop_default = 1;
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MIN
					prop_default = 0;
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MAX
					prop_default = Inf;
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.CORRELATION_RULE
					prop_default = Correlation.CORRELATION_RULE_LIST{1};
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.NEGATIVE_WEIGHT_RULE
					prop_default = Correlation.NEGATIVE_WEIGHT_RULE_LIST{1};
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.DENSITIES
					prop_default = [1:1:10];
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.ELCLASS
					prop_default = 'AnalyzeGroup_CON_FUN_MP_GA_BUD';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.NAME
					prop_default = 'Multiplex Connectivity-Functional Weighted Directed Group Average Analyze';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.DESCRIPTION
					prop_default = 'This graph analysis uses connectivity and functional multiplex data of fixed density and analyzes them using binary undirected graphs.';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropSettings(prop));
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.ID
					prop_default = 'AnalyzeGroup_CON_FUN_MP_GA_BUD ID';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.LABEL
					prop_default = 'AnalyzeGroup_CON_FUN_MP_GA_BUD label';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.NOTES
					prop_default = 'AnalyzeGroup_CON_FUN_MP_GA_BUD notes';
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.GR
					prop_default = Group('SUB_CLASS', 'SubjectCON_FUN_MP');
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.G
					prop_default = MultiplexBUD();
				otherwise
					prop_default = getPropDefault@AnalyzeGroup(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = AnalyzeGroup_CON_FUN_MP_GA_BUD.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = AnalyzeGroup_CON_FUN_MP_GA_BUD.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of A.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(AnalyzeGroup_CON_FUN_MP_GA_BUD, POINTER) returns the conditioned default value of POINTER of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%  DEFAULT = A.GETPROPDEFAULTCONDITIONED(AnalyzeGroup_CON_FUN_MP_GA_BUD, POINTER) returns the conditioned default value of POINTER of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(A) and Element.GETPROPDEFAULTCONDITIONED('AnalyzeGroup_CON_FUN_MP_GA_BUD')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropProp(pointer);
			
			prop_default = AnalyzeGroup_CON_FUN_MP_GA_BUD.conditioning(prop, AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(AnalyzeGroup_CON_FUN_MP_GA_BUD, PROP, VALUE) checks VALUE format for PROP of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%  CHECK = A.CHECKPROP(AnalyzeGroup_CON_FUN_MP_GA_BUD, PROP, VALUE) checks VALUE format for PROP of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			% 
			% A.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:AnalyzeGroup_CON_FUN_MP_GA_BUD:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  A.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of A.
			%   Error id: €BRAPH2.STR€:AnalyzeGroup_CON_FUN_MP_GA_BUD:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(AnalyzeGroup_CON_FUN_MP_GA_BUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%   Error id: €BRAPH2.STR€:AnalyzeGroup_CON_FUN_MP_GA_BUD:€BRAPH2.WRONG_INPUT€
			%  A.CHECKPROP(AnalyzeGroup_CON_FUN_MP_GA_BUD, PROP, VALUE) throws error if VALUE has not a valid format for PROP of AnalyzeGroup_CON_FUN_MP_GA_BUD.
			%   Error id: €BRAPH2.STR€:AnalyzeGroup_CON_FUN_MP_GA_BUD:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(A) and Element.CHECKPROP('AnalyzeGroup_CON_FUN_MP_GA_BUD')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropProp(pointer);
			
			switch prop
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.REPETITION % __AnalyzeGroup_CON_FUN_MP_GA_BUD.REPETITION__
					check = Format.checkFormat(Format.SCALAR, value, AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropSettings(prop));
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MIN % __AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MIN__
					check = Format.checkFormat(Format.SCALAR, value, AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropSettings(prop));
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MAX % __AnalyzeGroup_CON_FUN_MP_GA_BUD.F_MAX__
					check = Format.checkFormat(Format.SCALAR, value, AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropSettings(prop));
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.CORRELATION_RULE % __AnalyzeGroup_CON_FUN_MP_GA_BUD.CORRELATION_RULE__
					check = Format.checkFormat(Format.OPTION, value, AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropSettings(prop));
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.NEGATIVE_WEIGHT_RULE % __AnalyzeGroup_CON_FUN_MP_GA_BUD.NEGATIVE_WEIGHT_RULE__
					check = Format.checkFormat(Format.OPTION, value, AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropSettings(prop));
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.DENSITIES % __AnalyzeGroup_CON_FUN_MP_GA_BUD.DENSITIES__
					check = Format.checkFormat(Format.RVECTOR, value, AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropSettings(prop));
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.TEMPLATE % __AnalyzeGroup_CON_FUN_MP_GA_BUD.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropSettings(prop));
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.G % __AnalyzeGroup_CON_FUN_MP_GA_BUD.G__
					check = Format.checkFormat(Format.ITEM, value, AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropSettings(prop));
				otherwise
					if prop <= AnalyzeGroup.getPropNumber()
						check = checkProp@AnalyzeGroup(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':AnalyzeGroup_CON_FUN_MP_GA_BUD:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':AnalyzeGroup_CON_FUN_MP_GA_BUD:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropTag(prop) ' (' AnalyzeGroup_CON_FUN_MP_GA_BUD.getFormatTag(AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropFormat(prop)) ').'] ...
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
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.G % __AnalyzeGroup_CON_FUN_MP_GA_BUD.G__
					rng_settings_ = rng(); rng(a.getPropSeed(AnalyzeGroup_CON_FUN_MP_GA_BUD.G), 'twister')
					
					gr = a.get('GR');
					T = a.get('REPETITION');
					fmin = a.get('F_MIN');
					fmax = a.get('F_MAX');
					densities = a.get('DENSITIES'); % this is a vector
					A = cell(1, 2);
					data = cell(1, 2);
					layerlabels = {};
					
					for i = 1:1:gr.get('SUB_DICT').get('LENGTH')
					    sub = gr.get('SUB_DICT').get('IT', i);
					    
					    % FUN data
					    data_fun = sub.get('FUN');
					    fs = 1 / T;
					    
					    if fmax > fmin && T > 0
					        NFFT = 2 * ceil(size(data_fun, 1) / 2);
					        ft = fft(data_fun, NFFT);  % Fourier transform
					        f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
					        ft(f < fmin | f > fmax, :) = 0;
					        data_fun = ifft(ft, NFFT);
					    end
					    
					    A_fun = Correlation.getAdjacencyMatrix(data_fun, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));
					       
					    % CON data
					    if i == 1
					        data{1} = sub.get('CON');
					        data{2} = A_fun;
					    else
					        data{1} = data{1} + sub.get('CON');
					        data{2} = data{2} + A_fun;
					    end
					end
					
					A{1} = data{1} / gr.get('SUB_DICT').get('LENGTH');
					A{2} = data{2} / gr.get('SUB_DICT').get('LENGTH');
					                    
					g = MultiplexBUD( ...
					    'ID', ['Graph ' gr.get('ID')], ...
					    'B', A, ...
					    'DENSITIES', densities, ...
					    'LAYERLABELS', {'CON', 'FUN'} ...
					    );
					
					if ~isa(a.getr('TEMPLATE'), 'NoValue') % the analysis has a template
					    g.set('TEMPLATE', a.get('TEMPLATE').memorize('G'))  % the template is memorized - overwrite densities
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
	methods % GUI
		function pr = getPanelProp(a, prop, varargin)
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
				case AnalyzeGroup_CON_FUN_MP_GA_BUD.DENSITIES % __AnalyzeGroup_CON_FUN_MP_GA_BUD.DENSITIES__
					pr = PanelPropRVectorSmart('EL', a, 'PROP', AnalyzeGroup_CON_FUN_MP_GA_BUD.DENSITIES, ...
					    'MIN', 0, 'MAX', 100, ...
					    'DEFAULT', AnalyzeGroup_CON_FUN_MP_GA_BUD.getPropDefault('DENSITIES'), ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@AnalyzeGroup(a, prop, varargin{:});
					
			end
		end
	end
end
