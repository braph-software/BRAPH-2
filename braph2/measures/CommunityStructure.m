classdef CommunityStructure < Measure
	%CommunityStructure is the graph Community Structure.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Community Structure (CommunityStructure) of a graph is a subdivision of the network into 
	% non-overlapping groups of nodes which maximizes the number of within group 
	% edges, and minimizes the number of between group edges.
	%
	% CommunityStructure methods (constructor):
	%  CommunityStructure - constructor
	%
	% CommunityStructure methods:
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
	% CommunityStructure methods (display):
	%  tostring - string with information about the community structure
	%  disp - displays information about the community structure
	%  tree - displays the tree of the community structure
	%
	% CommunityStructure methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two community structure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the community structure
	%
	% CommunityStructure methods (save/load, Static):
	%  save - saves BRAPH2 community structure as b2 file
	%  load - loads a BRAPH2 community structure from a b2 file
	%
	% CommunityStructure method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the community structure
	%
	% CommunityStructure method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the community structure
	%
	% CommunityStructure methods (inspection, Static):
	%  getClass - returns the class of the community structure
	%  getSubclasses - returns all subclasses of CommunityStructure
	%  getProps - returns the property list of the community structure
	%  getPropNumber - returns the property number of the community structure
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
	% CommunityStructure methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% CommunityStructure methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% CommunityStructure methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% CommunityStructure methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?CommunityStructure; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">CommunityStructure constants</a>.
	%
	
	properties (Constant) % properties
		RULE = Measure.getPropNumber() + 1;
		RULE_TAG = 'RULE';
		RULE_CATEGORY = Category.PARAMETER;
		RULE_FORMAT = Format.OPTION;
		
		GAMMA = Measure.getPropNumber() + 2;
		GAMMA_TAG = 'GAMMA';
		GAMMA_CATEGORY = Category.PARAMETER;
		GAMMA_FORMAT = Format.SCALAR;
		
		M0 = Measure.getPropNumber() + 3;
		M0_TAG = 'M0';
		M0_CATEGORY = Category.DATA;
		M0_FORMAT = Format.RVECTOR;
		
		LOUVAIN_OM = Measure.getPropNumber() + 4;
		LOUVAIN_OM_TAG = 'LOUVAIN_OM';
		LOUVAIN_OM_CATEGORY = Category.DATA;
		LOUVAIN_OM_FORMAT = Format.MATRIX;
		
		OM_TYPE = Measure.getPropNumber() + 5;
		OM_TYPE_TAG = 'OM_TYPE';
		OM_TYPE_CATEGORY = Category.DATA;
		OM_TYPE_FORMAT = Format.OPTION;
		
		QUALITY_FUNCTION = Measure.getPropNumber() + 6;
		QUALITY_FUNCTION_TAG = 'QUALITY_FUNCTION';
		QUALITY_FUNCTION_CATEGORY = Category.METADATA;
		QUALITY_FUNCTION_FORMAT = Format.CELL;
	end
	methods % constructor
		function m = CommunityStructure(varargin)
			%CommunityStructure() creates a community structure.
			%
			% CommunityStructure(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% CommunityStructure(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@Measure(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the community structure.
			%
			% CLASS = CommunityStructure.GETCLASS() returns the class 'CommunityStructure'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the community structure M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('CommunityStructure') returns 'CommunityStructure'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('CommunityStructure')
			%  are less computationally efficient.
			
			m_class = 'CommunityStructure';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the community structure.
			%
			% LIST = CommunityStructure.GETSUBCLASSES() returns all subclasses of 'CommunityStructure'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the community structure M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('CommunityStructure') returns all subclasses of 'CommunityStructure'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('CommunityStructure', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of community structure.
			%
			% PROPS = CommunityStructure.GETPROPS() returns the property list of community structure
			%  as a row vector.
			%
			% PROPS = CommunityStructure.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the community structure M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('CommunityStructure'[, CATEGORY]) returns the property list of 'CommunityStructure'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Measure.getProps() ...
						CommunityStructure.RULE ...
						CommunityStructure.GAMMA ...
						CommunityStructure.M0 ...
						CommunityStructure.LOUVAIN_OM ...
						CommunityStructure.OM_TYPE ...
						CommunityStructure.QUALITY_FUNCTION ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Measure.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Measure.getProps(Category.METADATA) ...
						CommunityStructure.QUALITY_FUNCTION ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Measure.getProps(Category.PARAMETER) ...
						CommunityStructure.RULE ...
						CommunityStructure.GAMMA ...
						];
				case Category.DATA
					prop_list = [ ...
						Measure.getProps(Category.DATA) ...
						CommunityStructure.M0 ...
						CommunityStructure.LOUVAIN_OM ...
						CommunityStructure.OM_TYPE ...
						];
				case Category.RESULT
					prop_list = [
						Measure.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Measure.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Measure.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Measure.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Measure.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of community structure.
			%
			% N = CommunityStructure.GETPROPNUMBER() returns the property number of community structure.
			%
			% N = CommunityStructure.GETPROPNUMBER(CATEGORY) returns the property number of community structure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the community structure M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('CommunityStructure') returns the property number of 'CommunityStructure'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(CommunityStructure.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in community structure/error.
			%
			% CHECK = CommunityStructure.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(CommunityStructure, PROP) checks whether PROP exists for CommunityStructure.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:CommunityStructure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%  Element.EXISTSPROP(CommunityStructure, PROP) throws error if PROP does NOT exist for CommunityStructure.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == CommunityStructure.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for CommunityStructure.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in community structure/error.
			%
			% CHECK = CommunityStructure.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(CommunityStructure, TAG) checks whether TAG exists for CommunityStructure.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:CommunityStructure:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%  Element.EXISTSTAG(CommunityStructure, TAG) throws error if TAG does NOT exist for CommunityStructure.
			%   Error id: [BRAPH2:CommunityStructure:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			communitystructure_tag_list = cellfun(@(x) CommunityStructure.getPropTag(x), num2cell(CommunityStructure.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, communitystructure_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for CommunityStructure.'] ...
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
			%  PROPERTY = M.GETPROPPROP(POINTER) returns property number of POINTER of M.
			%  PROPERTY = Element.GETPROPPROP(CommunityStructure, POINTER) returns property number of POINTER of CommunityStructure.
			%  PROPERTY = M.GETPROPPROP(CommunityStructure, POINTER) returns property number of POINTER of CommunityStructure.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				communitystructure_tag_list = cellfun(@(x) CommunityStructure.getPropTag(x), num2cell(CommunityStructure.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, communitystructure_tag_list)); % tag = pointer
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
			%  TAG = M.GETPROPTAG(POINTER) returns tag of POINTER of M.
			%  TAG = Element.GETPROPTAG(CommunityStructure, POINTER) returns tag of POINTER of CommunityStructure.
			%  TAG = M.GETPROPTAG(CommunityStructure, POINTER) returns tag of POINTER of CommunityStructure.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case CommunityStructure.RULE
						tag = CommunityStructure.RULE_TAG;
					case CommunityStructure.GAMMA
						tag = CommunityStructure.GAMMA_TAG;
					case CommunityStructure.M0
						tag = CommunityStructure.M0_TAG;
					case CommunityStructure.LOUVAIN_OM
						tag = CommunityStructure.LOUVAIN_OM_TAG;
					case CommunityStructure.OM_TYPE
						tag = CommunityStructure.OM_TYPE_TAG;
					case CommunityStructure.QUALITY_FUNCTION
						tag = CommunityStructure.QUALITY_FUNCTION_TAG;
					otherwise
						tag = getPropTag@Measure(prop);
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
			%  CATEGORY = M.GETPROPCATEGORY(POINTER) returns category of POINTER of M.
			%  CATEGORY = Element.GETPROPCATEGORY(CommunityStructure, POINTER) returns category of POINTER of CommunityStructure.
			%  CATEGORY = M.GETPROPCATEGORY(CommunityStructure, POINTER) returns category of POINTER of CommunityStructure.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			switch prop
				case CommunityStructure.RULE
					prop_category = CommunityStructure.RULE_CATEGORY;
				case CommunityStructure.GAMMA
					prop_category = CommunityStructure.GAMMA_CATEGORY;
				case CommunityStructure.M0
					prop_category = CommunityStructure.M0_CATEGORY;
				case CommunityStructure.LOUVAIN_OM
					prop_category = CommunityStructure.LOUVAIN_OM_CATEGORY;
				case CommunityStructure.OM_TYPE
					prop_category = CommunityStructure.OM_TYPE_CATEGORY;
				case CommunityStructure.QUALITY_FUNCTION
					prop_category = CommunityStructure.QUALITY_FUNCTION_CATEGORY;
				otherwise
					prop_category = getPropCategory@Measure(prop);
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
			%  FORMAT = M.GETPROPFORMAT(POINTER) returns format of POINTER of M.
			%  FORMAT = Element.GETPROPFORMAT(CommunityStructure, POINTER) returns format of POINTER of CommunityStructure.
			%  FORMAT = M.GETPROPFORMAT(CommunityStructure, POINTER) returns format of POINTER of CommunityStructure.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			switch prop
				case CommunityStructure.RULE
					prop_format = CommunityStructure.RULE_FORMAT;
				case CommunityStructure.GAMMA
					prop_format = CommunityStructure.GAMMA_FORMAT;
				case CommunityStructure.M0
					prop_format = CommunityStructure.M0_FORMAT;
				case CommunityStructure.LOUVAIN_OM
					prop_format = CommunityStructure.LOUVAIN_OM_FORMAT;
				case CommunityStructure.OM_TYPE
					prop_format = CommunityStructure.OM_TYPE_FORMAT;
				case CommunityStructure.QUALITY_FUNCTION
					prop_format = CommunityStructure.QUALITY_FUNCTION_FORMAT;
				otherwise
					prop_format = getPropFormat@Measure(prop);
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
			%  DESCRIPTION = M.GETPROPDESCRIPTION(POINTER) returns description of POINTER of M.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(CommunityStructure, POINTER) returns description of POINTER of CommunityStructure.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(CommunityStructure, POINTER) returns description of POINTER of CommunityStructure.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			switch prop
				case CommunityStructure.RULE
					prop_description = 'RULE (parameter, option)';
				case CommunityStructure.GAMMA
					prop_description = 'GAMMA (parameter, SCALAR) is the resolution parameter.';
				case CommunityStructure.M0
					prop_description = 'M0 (data, rvector) is the initial community affiliation vector.';
				case CommunityStructure.LOUVAIN_OM
					prop_description = 'LOUVAIN_OM (data, MATRIX) is the custom objective matrix (Louvain).';
				case CommunityStructure.OM_TYPE
					prop_description = 'OM_TYPE (data, OPTION) is the objective-function type algorithm (Louvain).';
				case CommunityStructure.QUALITY_FUNCTION
					prop_description = 'QUALITY_FUNCTION (metadata, CELL)';
				case CommunityStructure.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Community Structure.';
				case CommunityStructure.NAME
					prop_description = 'NAME (constant, string) is the name of the Community Structure.';
				case CommunityStructure.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Community Structure.';
				case CommunityStructure.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Community Structure.';
				case CommunityStructure.ID
					prop_description = 'ID (data, string) is a few-letter code of the Community Structure.';
				case CommunityStructure.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the community structure.';
				case CommunityStructure.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Community Structure.';
				case CommunityStructure.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case CommunityStructure.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case CommunityStructure.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case CommunityStructure.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case CommunityStructure.M
					prop_description = 'M (result, cell) is the Community Structure.';
				otherwise
					prop_description = getPropDescription@Measure(prop);
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
			%  SETTINGS = M.GETPROPSETTINGS(POINTER) returns settings of POINTER of M.
			%  SETTINGS = Element.GETPROPSETTINGS(CommunityStructure, POINTER) returns settings of POINTER of CommunityStructure.
			%  SETTINGS = M.GETPROPSETTINGS(CommunityStructure, POINTER) returns settings of POINTER of CommunityStructure.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			switch prop
				case CommunityStructure.RULE
					prop_settings = { 'louvain' 'newman' 'fixed'};
				case CommunityStructure.GAMMA
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case CommunityStructure.M0
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case CommunityStructure.LOUVAIN_OM
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case CommunityStructure.OM_TYPE
					prop_settings = {'modularity' 'potts' 'negative_sym' 'negative_asym'};
				case CommunityStructure.QUALITY_FUNCTION
					prop_settings = Format.getFormatSettings(Format.CELL);
				case CommunityStructure.TEMPLATE
					prop_settings = 'CommunityStructure';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = CommunityStructure.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = CommunityStructure.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(CommunityStructure, POINTER) returns the default value of POINTER of CommunityStructure.
			%  DEFAULT = M.GETPROPDEFAULT(CommunityStructure, POINTER) returns the default value of POINTER of CommunityStructure.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			switch prop
				case CommunityStructure.RULE
					prop_default = 'louvain';
				case CommunityStructure.GAMMA
					prop_default = 1;
				case CommunityStructure.M0
					prop_default = [];
				case CommunityStructure.LOUVAIN_OM
					prop_default = [];
				case CommunityStructure.OM_TYPE
					prop_default = 'modularity';
				case CommunityStructure.QUALITY_FUNCTION
					prop_default = Format.getFormatDefault(Format.CELL, CommunityStructure.getPropSettings(prop));
				case CommunityStructure.ELCLASS
					prop_default = 'CommunityStructure';
				case CommunityStructure.NAME
					prop_default = 'Community Structure';
				case CommunityStructure.DESCRIPTION
					prop_default = 'The Community Structure (CommunityStructure) of a graph is a subdivision of the network into non-overlapping groups of nodes which maximizes the number of within group edges, and minimizes the number of between group edges.';
				case CommunityStructure.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, CommunityStructure.getPropSettings(prop));
				case CommunityStructure.ID
					prop_default = 'CommunityStructure ID';
				case CommunityStructure.LABEL
					prop_default = 'Community Structure label';
				case CommunityStructure.NOTES
					prop_default = 'Community Structure notes';
				case CommunityStructure.SHAPE
					prop_default = Measure.NODAL;
				case CommunityStructure.SCOPE
					prop_default = Measure.UNILAYER;
				case CommunityStructure.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case CommunityStructure.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT'} ;;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = CommunityStructure.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = CommunityStructure.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(CommunityStructure, POINTER) returns the conditioned default value of POINTER of CommunityStructure.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(CommunityStructure, POINTER) returns the conditioned default value of POINTER of CommunityStructure.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			prop_default = CommunityStructure.conditioning(prop, CommunityStructure.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = M.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = M.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of M.
			%  CHECK = Element.CHECKPROP(CommunityStructure, PROP, VALUE) checks VALUE format for PROP of CommunityStructure.
			%  CHECK = M.CHECKPROP(CommunityStructure, PROP, VALUE) checks VALUE format for PROP of CommunityStructure.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:CommunityStructure:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:CommunityStructure:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(CommunityStructure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CommunityStructure.
			%   Error id: €BRAPH2.STR€:CommunityStructure:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(CommunityStructure, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CommunityStructure.
			%   Error id: €BRAPH2.STR€:CommunityStructure:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('CommunityStructure')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = CommunityStructure.getPropProp(pointer);
			
			switch prop
				case CommunityStructure.RULE % __CommunityStructure.RULE__
					check = Format.checkFormat(Format.OPTION, value, CommunityStructure.getPropSettings(prop));
				case CommunityStructure.GAMMA % __CommunityStructure.GAMMA__
					check = Format.checkFormat(Format.SCALAR, value, CommunityStructure.getPropSettings(prop));
				case CommunityStructure.M0 % __CommunityStructure.M0__
					check = Format.checkFormat(Format.RVECTOR, value, CommunityStructure.getPropSettings(prop));
				case CommunityStructure.LOUVAIN_OM % __CommunityStructure.LOUVAIN_OM__
					check = Format.checkFormat(Format.MATRIX, value, CommunityStructure.getPropSettings(prop));
				case CommunityStructure.OM_TYPE % __CommunityStructure.OM_TYPE__
					check = Format.checkFormat(Format.OPTION, value, CommunityStructure.getPropSettings(prop));
				case CommunityStructure.QUALITY_FUNCTION % __CommunityStructure.QUALITY_FUNCTION__
					check = Format.checkFormat(Format.CELL, value, CommunityStructure.getPropSettings(prop));
				case CommunityStructure.TEMPLATE % __CommunityStructure.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, CommunityStructure.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' CommunityStructure.getPropTag(prop) ' (' CommunityStructure.getFormatTag(CommunityStructure.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(m, prop, varargin)
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
				case CommunityStructure.M % __CommunityStructure.M__
					rng_settings_ = rng(); rng(m.getPropSeed(CommunityStructure.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					A = g.get('A');
					L = g.get('LAYERNUMBER');
					N = g.get('NODENUMBER');
					community_structure = cell(L, 1);
					gamma = m.get('GAMMA');
					community_structure_algorithm = m.get('RULE');
					
					q_function = {};
					for li = 1:1:L
					    Aii = A{li, li};
					    [community_structure(li), q_function{li}] =  community(m, Aii, N(li), gamma, community_structure_algorithm);
					end
					m.set('QUALITY_FUNCTION', q_function);
					value = community_structure;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Measure.getPropNumber()
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
			function [comm_str, quality_function] = community(m, A, N, gamma, community_structure_algorithm)
			A = A;
			N = N;
			gamma = gamma;
			community_structure_algorithm = community_structure_algorithm;
			    switch lower(community_structure_algorithm)
			        case {'fixed'}
			            M0 = m.get('M0');
			            assert(isequal(size(M0, 2), size(1:N, 2)), ...
			                    [BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
			                    ['M0 initial community affiliation vector must have the same length than the number of nodes' ...
			                    '(' tostring(size(1:N, 2)) ') while its length is ' tostring(size(M0, 2))])
			            community_structure = {M0'};
			            quality_function = 1;
			
			        case {'newman'}  % Newman algorithm
			            directionality_type = g.get('DIRECTIONALITY_TYPE', g.get('LAYERNUMBER'));
			            if directionality_type(1, 1) == Graph.UNDIRECTED  % directed graphs
			                n_perm = randperm(N);  % randomly permute order of nodes
			                A = A(n_perm, n_perm);  % DB: use permuted matrix for subsequent analysis
			                Ki = sum(A, 1);  % in-degree
			                Ko = sum(A, 2);  % out-degree
			                mo = sum(Ki);  % number of edges
			                b = A - gamma*(Ko*Ki).'/mo;
			                B = b+b.';  % directed modularity matrix
			                Ci = ones(N,1);  % community indices
			                cn = 1;  % number of communities
			                U = [1 0];  % array of unexamined communites
			
			                ind = 1:N;
			                Bg = B;
			                Ng = N;
			
			                while U(1)  % examine community U(1)
			                    [V, D] = eig(Bg);
			                    [d1, i1] = max(real(diag(D)));  % most positive eigenvalue of Bg
			                    v1 = V(:,i1);  % corresponding eigenvector
			                    S = ones(Ng,1);
			                    S(v1 < 0) = -1;
			                    q = S.' * Bg * S;  % contribution to modularity
			
			                    if q > 1e-10  % contribution positive: U(1) is divisible
			                        qmax = q;  % maximal contribution to modularity
			                        Bg(logical(eye(Ng))) = 0;  % Bg is modified, to enable fine-tuning
			                        indg = ones(Ng, 1);  % array of unmoved indices
			                        Sit = S;
			                        while any(indg)  % iterative fine-tuning
			                            Qit = qmax - 4*Sit.*(Bg*Sit);  % this line is equivalent to:
			                            qmax = max(Qit.*indg);  % for i=1:Ng
			                            imax = (Qit==qmax);  % Sit(i)=-Sit(i);
			                            Sit(imax) = -Sit(imax);  % Qit(i)=Sit.'*Bg*Sit;
			                            indg(imax) = nan;  % Sit(i)=-Sit(i);
			                            if qmax > q  % end
			                                q = qmax;
			                                S = Sit;
			                            end
			                        end
			
			                        if abs(sum(S)) == Ng  % unsuccessful splitting of U(1)
			                            U(1) = [];
			                        else
			                            cn = cn + 1;
			                            Ci(ind(S == 1)) = U(1);  % split old U(1) into new U(1) and into cn
			                            Ci(ind(S == -1)) = cn;
			                            U = [cn, U];
			                        end
			                    else  % contribution nonpositive: U(1) is indivisible
			                        U(1) = [];
			                    end
			
			                    ind = find(Ci==U(1));  % indices of unexamined community U(1)
			                    bg = B(ind, ind);
			                    Bg = bg - diag(sum(bg));  % modularity matrix for U(1)
			                    Ng = length(ind);  % number of vertices in U(1)
			                end
			
			                s = Ci(:, ones(1, N));  % compute modularity
			                Q =~ (s-s.').*B/(2*mo);
			                Q = sum(Q(:));
			                Ci_corrected = zeros(N, 1);  % initialize Ci_corrected
			                Ci_corrected(n_perm) = Ci;  % return order of nodes to the order used at the input stage.
			                Ci = Ci_corrected;  % output corrected community assignments
			
			                quality_function = Q;   % save normalized quality function/modularity
			                community_structure = {Ci};
			
			            else  % undirected graphs
			                n_perm = randperm(N);  % randomly permute order of nodes
			                A = A(n_perm, n_perm);  % DB: use permuted matrix for subsequent analysis
			                K = sum(A);  % degree
			                mo = sum(K);  % number of edges (each undirected edge is counted twice)
			                B = A - gamma*(K.'*K)/mo;  % modularity matrix
			                Ci = ones(N, 1);  % community indices
			                cn = 1;  % number of communities
			                U = [1 0];  % array of unexamined communites
			
			                ind = 1:N;
			                Bg = B;
			                Ng = N;
			
			                while U(1)  % examine community U(1)
			                    [V, D] = eig(Bg);
			                    [d1, i1] = max(real(diag(D)));  % maximal positive (real part of) eigenvalue of Bg
			                    v1 = V(:,i1);  % corresponding eigenvector
			
			                    S = ones(Ng,1);
			                    S(v1<0) = -1;
			                    q = S.'*Bg*S;  % contribution to modularity
			
			                    if q > 1e-10  % contribution positive: U(1) is divisible
			                        qmax = q;  % maximal contribution to modularity
			                        Bg(logical(eye(Ng))) = 0;  % Bg is modified, to enable fine-tuning
			                        indg = ones(Ng, 1);  % array of unmoved indices
			                        Sit = S;
			                        while any(indg)  % iterative fine-tuning
			                            Qit = qmax-  4*Sit.*(Bg*Sit);  % this line is equivalent to:
			                            qmax = max(Qit.*indg);  % for i=1:Ng
			                            imax = (Qit == qmax);  % Sit(i)=-Sit(i);
			                            Sit(imax) = -Sit(imax);  % Qit(i)=Sit.'*Bg*Sit;
			                            indg(imax) = nan;  % Sit(i)=-Sit(i);
			                            if qmax > q  % end
			                                q = qmax;
			                                S = Sit;
			                            end
			                        end
			
			                        if abs(sum(S)) == Ng  % unsuccessful splitting of U(1)
			                            U(1) = [];
			                        else
			                            cn = cn + 1;
			                            Ci(ind(S==1)) = U(1);  % split old U(1) into new U(1) and into cn
			                            Ci(ind(S==-1)) = cn;
			                            U = [cn, U];
			                        end
			                    else  % contribution nonpositive: U(1) is indivisible
			                        U(1) = [];
			                    end
			
			                    ind = find(Ci==U(1));  % indices of unexamined community U(1)
			                    bg = B(ind, ind);
			                    Bg = bg-diag(sum(bg));  % modularity matrix for U(1)
			                    Ng = length(ind);  % number of vertices in U(1)
			                end
			
			                s = Ci(:,ones(1, N));  % compute modularity
			                Q =~ (s-s.').*B/mo;
			                Q = sum(Q(:));
			                Ci_corrected = zeros(N, 1);  % initialize Ci_corrected
			                Ci_corrected(n_perm) = Ci;  % return order of nodes to the order used at the input stage.
			                Ci = Ci_corrected;  % output corrected community assignments
			
			                quality_function = Q; % save normalized quality function/modularity
			                community_structure = {Ci};
			            end
			
			        otherwise  % {'Louvain'}  % Louvain algorithm
			
			            M0 = m.get('M0');  % initial community affiliation vector
			            OM = m.get('LOUVAIN_OM');  % custom objective matrix
			            type_OM =  m.get('OM_TYPE');  % objective-function type
			            W = double(A);  % convert to double format
			            s = sum(sum(W));  % get sum of edges
			
			            if isempty(M0)
			                M0 = 1:N;
			            else
			                assert(isequal(size(M0, 2), size(1:N, 2)), ...
			                    [BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
			                    ['M0 initial community affiliation vector must have the same length than the number of nodes' ...
			                    '(' tostring(size(1:N, 2)) ') while its length is ' tostring(size(M0, 2))])
			            end
			            [~,~,Mb] = unique(M0);
			            M = Mb;
			
			            if isempty(OM)
			                % calculate OM according to type_B
			
			                switch lower(type_OM)
			                    case {'potts'}
			                        assert(all(all(W == logical(W))), ...
			                            [BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
			                            ['Potts-model Hamiltonian requires a binary adjacency matrix' ...
			                            'while it is ' tostring(W)])
			                        OM =  W - gamma*(~W);
			                    otherwise  % {'modularity'} default
			                        OM = W - gamma*(sum(W, 2)*sum(W, 1))/s;
			                end
			            else  % OM matrix exists
			                assert(isequal(size(W), size(OM)), ...
			                    [BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
			                    ['OM matrix must have the same size than the adjacency matrix' ...
			                    '(' tostring(size(W)) ') while its size is ' tostring(size(OM))])
			            end
			
			            OM = (OM+OM.')/2;  % symmetrize modularity matrix
			            Hnm = zeros(N, N);  % node-to-module degree
			            for mo = 1:max(Mb)  % loop over modules
			                Hnm(:, mo) = sum(OM(:, Mb== mo), 2);
			            end
			            H = sum(Hnm, 2);  % node degree
			            Hm = sum(Hnm, 1);  % module degree
			
			            Q0 = -inf;
			            Q = sum(OM(bsxfun(@eq, M0, M0.')))/s;  % compute modularity
			            first_iteration = true;
			            n = N;
			            while Q-Q0 > 1e-10
			                flag = true;  % flag for within-hierarchy search
			                while flag
			                    flag = false;
			                    for u = randperm(n)  % loop over all nodes in random order
			                        ma = Mb(u);  % current module of u
			                        dQ = Hnm(u, :)- Hnm(u,ma) + OM(u, u);
			                        dQ(ma) = 0;  % (line above) algorithm condition
			
			                        [max_dQ, mb] = max(dQ);  % maximal increase in modularity and corresponding module
			                        if max_dQ > 1e-10  % if maximal increase is positive
			                            flag = true;
			                            Mb(u) = mb;  % reassign module
			
			                            Hnm(:,mb) = Hnm(:,mb) + OM(:,u);  % change node-to-module strengths
			                            Hnm(:,ma) = Hnm(:,ma) - OM(:,u);
			                            Hm(mb) = Hm(mb) + H(u);  % change module strengths
			                            Hm(ma) = Hm(ma) - H(u);
			                        end
			                    end
			                end
			                [~,~,Mb] = unique(Mb);  % new module assignments
			
			                M0 = M;
			                if first_iteration
			                    M = Mb;
			                    first_iteration = false;
			                else
			                    for u = 1:n  % loop through initial module assignments
			                        M(M0==u) = Mb(u);  % assign new modules
			                    end
			                end
			
			                n = max(Mb);  % new number of modules
			                B1 = zeros(n);  % new weighted matrix
			                for u = 1:n
			                    for v = u:n
			                        bm = sum(sum(OM(Mb==u,Mb==v)));  % pool weights of nodes in same module
			                        B1(u,v) = bm;
			                        B1(v,u) = bm;
			                    end
			                end
			                OM = B1;
			
			                Mb = 1:n;  % initial module assignments
			                Hnm = OM;  % node-to-module strength
			                H = sum(OM);  % node strength
			                Hm = H;  % module strength
			
			                Q0 = Q;
			                Q = trace(OM)/s;  % compute modularity
			            end
			            quality_function = Q;  % save normalized quality function/modularity
			            community_structure = {M};
			    end
			    comm_str = community_structure;
			end
		end
	end
end
