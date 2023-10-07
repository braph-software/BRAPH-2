classdef MultilayerCommunity < Measure
	%MultilayerCommunity is the graph Multilayer Community Structure.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Multilayer Community Structure (MultilayerCommunity) of a multilayer graph is a subdivision of 
	%  the network into non-overlapping groups of nodes which maximizes the number 
	%  of within group edges, and minimizes the number of between group edges.
	%
	% MultilayerCommunity methods (constructor):
	%  MultilayerCommunity - constructor
	%
	% MultilayerCommunity methods:
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
	% MultilayerCommunity methods (display):
	%  tostring - string with information about the multilayer community structure
	%  disp - displays information about the multilayer community structure
	%  tree - displays the tree of the multilayer community structure
	%
	% MultilayerCommunity methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multilayer community structure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multilayer community structure
	%
	% MultilayerCommunity methods (save/load, Static):
	%  save - saves BRAPH2 multilayer community structure as b2 file
	%  load - loads a BRAPH2 multilayer community structure from a b2 file
	%
	% MultilayerCommunity method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multilayer community structure
	%
	% MultilayerCommunity method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multilayer community structure
	%
	% MultilayerCommunity methods (inspection, Static):
	%  getClass - returns the class of the multilayer community structure
	%  getSubclasses - returns all subclasses of MultilayerCommunity
	%  getProps - returns the property list of the multilayer community structure
	%  getPropNumber - returns the property number of the multilayer community structure
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
	% MultilayerCommunity methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultilayerCommunity methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultilayerCommunity methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultilayerCommunity methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultilayerCommunity; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultilayerCommunity constants</a>.
	%
	
	properties (Constant) % properties
		LIMIT = Measure.getPropNumber() + 1;
		LIMIT_TAG = 'LIMIT';
		LIMIT_CATEGORY = Category.PARAMETER;
		LIMIT_FORMAT = Format.SCALAR;
		
		RANDORD = Measure.getPropNumber() + 2;
		RANDORD_TAG = 'RANDORD';
		RANDORD_CATEGORY = Category.PARAMETER;
		RANDORD_FORMAT = Format.LOGICAL;
		
		RANDMOVE = Measure.getPropNumber() + 3;
		RANDMOVE_TAG = 'RANDMOVE';
		RANDMOVE_CATEGORY = Category.PARAMETER;
		RANDMOVE_FORMAT = Format.LOGICAL;
		
		GAMMA = Measure.getPropNumber() + 4;
		GAMMA_TAG = 'GAMMA';
		GAMMA_CATEGORY = Category.PARAMETER;
		GAMMA_FORMAT = Format.SCALAR;
		
		OMEGA = Measure.getPropNumber() + 5;
		OMEGA_TAG = 'OMEGA';
		OMEGA_CATEGORY = Category.PARAMETER;
		OMEGA_FORMAT = Format.SCALAR;
		
		S0 = Measure.getPropNumber() + 6;
		S0_TAG = 'S0';
		S0_CATEGORY = Category.DATA;
		S0_FORMAT = Format.CVECTOR;
		
		OM = Measure.getPropNumber() + 7;
		OM_TAG = 'OM';
		OM_CATEGORY = Category.DATA;
		OM_FORMAT = Format.MATRIX;
		
		QUALITY_FUNCTION = Measure.getPropNumber() + 8;
		QUALITY_FUNCTION_TAG = 'QUALITY_FUNCTION';
		QUALITY_FUNCTION_CATEGORY = Category.DATA;
		QUALITY_FUNCTION_FORMAT = Format.MATRIX;
	end
	methods % constructor
		function m = MultilayerCommunity(varargin)
			%MultilayerCommunity() creates a multilayer community structure.
			%
			% MultilayerCommunity(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultilayerCommunity(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the multilayer community structure.
			%
			% CLASS = MultilayerCommunity.GETCLASS() returns the class 'MultilayerCommunity'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the multilayer community structure M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultilayerCommunity') returns 'MultilayerCommunity'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('MultilayerCommunity')
			%  are less computationally efficient.
			
			m_class = 'MultilayerCommunity';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multilayer community structure.
			%
			% LIST = MultilayerCommunity.GETSUBCLASSES() returns all subclasses of 'MultilayerCommunity'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the multilayer community structure M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('MultilayerCommunity') returns all subclasses of 'MultilayerCommunity'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultilayerCommunity', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multilayer community structure.
			%
			% PROPS = MultilayerCommunity.GETPROPS() returns the property list of multilayer community structure
			%  as a row vector.
			%
			% PROPS = MultilayerCommunity.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the multilayer community structure M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultilayerCommunity'[, CATEGORY]) returns the property list of 'MultilayerCommunity'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Measure.getProps() ...
						MultilayerCommunity.LIMIT ...
						MultilayerCommunity.RANDORD ...
						MultilayerCommunity.RANDMOVE ...
						MultilayerCommunity.GAMMA ...
						MultilayerCommunity.OMEGA ...
						MultilayerCommunity.S0 ...
						MultilayerCommunity.OM ...
						MultilayerCommunity.QUALITY_FUNCTION ...
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
						];
				case Category.PARAMETER
					prop_list = [ ...
						Measure.getProps(Category.PARAMETER) ...
						MultilayerCommunity.LIMIT ...
						MultilayerCommunity.RANDORD ...
						MultilayerCommunity.RANDMOVE ...
						MultilayerCommunity.GAMMA ...
						MultilayerCommunity.OMEGA ...
						];
				case Category.DATA
					prop_list = [ ...
						Measure.getProps(Category.DATA) ...
						MultilayerCommunity.S0 ...
						MultilayerCommunity.OM ...
						MultilayerCommunity.QUALITY_FUNCTION ...
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
			%GETPROPNUMBER returns the property number of multilayer community structure.
			%
			% N = MultilayerCommunity.GETPROPNUMBER() returns the property number of multilayer community structure.
			%
			% N = MultilayerCommunity.GETPROPNUMBER(CATEGORY) returns the property number of multilayer community structure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the multilayer community structure M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultilayerCommunity') returns the property number of 'MultilayerCommunity'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultilayerCommunity.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multilayer community structure/error.
			%
			% CHECK = MultilayerCommunity.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultilayerCommunity, PROP) checks whether PROP exists for MultilayerCommunity.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultilayerCommunity:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerCommunity:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerCommunity:WrongInput]
			%  Element.EXISTSPROP(MultilayerCommunity, PROP) throws error if PROP does NOT exist for MultilayerCommunity.
			%   Error id: [BRAPH2:MultilayerCommunity:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultilayerCommunity.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerCommunity:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerCommunity:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultilayerCommunity.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multilayer community structure/error.
			%
			% CHECK = MultilayerCommunity.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultilayerCommunity, TAG) checks whether TAG exists for MultilayerCommunity.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultilayerCommunity:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerCommunity:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultilayerCommunity:WrongInput]
			%  Element.EXISTSTAG(MultilayerCommunity, TAG) throws error if TAG does NOT exist for MultilayerCommunity.
			%   Error id: [BRAPH2:MultilayerCommunity:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multilayercommunity_tag_list = cellfun(@(x) MultilayerCommunity.getPropTag(x), num2cell(MultilayerCommunity.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multilayercommunity_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerCommunity:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerCommunity:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultilayerCommunity.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultilayerCommunity, POINTER) returns property number of POINTER of MultilayerCommunity.
			%  PROPERTY = M.GETPROPPROP(MultilayerCommunity, POINTER) returns property number of POINTER of MultilayerCommunity.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multilayercommunity_tag_list = cellfun(@(x) MultilayerCommunity.getPropTag(x), num2cell(MultilayerCommunity.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multilayercommunity_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultilayerCommunity, POINTER) returns tag of POINTER of MultilayerCommunity.
			%  TAG = M.GETPROPTAG(MultilayerCommunity, POINTER) returns tag of POINTER of MultilayerCommunity.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MultilayerCommunity.LIMIT
						tag = MultilayerCommunity.LIMIT_TAG;
					case MultilayerCommunity.RANDORD
						tag = MultilayerCommunity.RANDORD_TAG;
					case MultilayerCommunity.RANDMOVE
						tag = MultilayerCommunity.RANDMOVE_TAG;
					case MultilayerCommunity.GAMMA
						tag = MultilayerCommunity.GAMMA_TAG;
					case MultilayerCommunity.OMEGA
						tag = MultilayerCommunity.OMEGA_TAG;
					case MultilayerCommunity.S0
						tag = MultilayerCommunity.S0_TAG;
					case MultilayerCommunity.OM
						tag = MultilayerCommunity.OM_TAG;
					case MultilayerCommunity.QUALITY_FUNCTION
						tag = MultilayerCommunity.QUALITY_FUNCTION_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultilayerCommunity, POINTER) returns category of POINTER of MultilayerCommunity.
			%  CATEGORY = M.GETPROPCATEGORY(MultilayerCommunity, POINTER) returns category of POINTER of MultilayerCommunity.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultilayerCommunity.getPropProp(pointer);
			
			switch prop
				case MultilayerCommunity.LIMIT
					prop_category = MultilayerCommunity.LIMIT_CATEGORY;
				case MultilayerCommunity.RANDORD
					prop_category = MultilayerCommunity.RANDORD_CATEGORY;
				case MultilayerCommunity.RANDMOVE
					prop_category = MultilayerCommunity.RANDMOVE_CATEGORY;
				case MultilayerCommunity.GAMMA
					prop_category = MultilayerCommunity.GAMMA_CATEGORY;
				case MultilayerCommunity.OMEGA
					prop_category = MultilayerCommunity.OMEGA_CATEGORY;
				case MultilayerCommunity.S0
					prop_category = MultilayerCommunity.S0_CATEGORY;
				case MultilayerCommunity.OM
					prop_category = MultilayerCommunity.OM_CATEGORY;
				case MultilayerCommunity.QUALITY_FUNCTION
					prop_category = MultilayerCommunity.QUALITY_FUNCTION_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(MultilayerCommunity, POINTER) returns format of POINTER of MultilayerCommunity.
			%  FORMAT = M.GETPROPFORMAT(MultilayerCommunity, POINTER) returns format of POINTER of MultilayerCommunity.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultilayerCommunity.getPropProp(pointer);
			
			switch prop
				case MultilayerCommunity.LIMIT
					prop_format = MultilayerCommunity.LIMIT_FORMAT;
				case MultilayerCommunity.RANDORD
					prop_format = MultilayerCommunity.RANDORD_FORMAT;
				case MultilayerCommunity.RANDMOVE
					prop_format = MultilayerCommunity.RANDMOVE_FORMAT;
				case MultilayerCommunity.GAMMA
					prop_format = MultilayerCommunity.GAMMA_FORMAT;
				case MultilayerCommunity.OMEGA
					prop_format = MultilayerCommunity.OMEGA_FORMAT;
				case MultilayerCommunity.S0
					prop_format = MultilayerCommunity.S0_FORMAT;
				case MultilayerCommunity.OM
					prop_format = MultilayerCommunity.OM_FORMAT;
				case MultilayerCommunity.QUALITY_FUNCTION
					prop_format = MultilayerCommunity.QUALITY_FUNCTION_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultilayerCommunity, POINTER) returns description of POINTER of MultilayerCommunity.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultilayerCommunity, POINTER) returns description of POINTER of MultilayerCommunity.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultilayerCommunity.getPropProp(pointer);
			
			switch prop
				case MultilayerCommunity.LIMIT
					prop_description = 'LIMIT (parameter, SCALAR) is the maximum size of multilayer modularity matrix.';
				case MultilayerCommunity.RANDORD
					prop_description = 'RANDORD (parameter, LOGICAL) is used to set randperm.';
				case MultilayerCommunity.RANDMOVE
					prop_description = 'RANDMOVE (parameter, LOGICAL) is the move function.';
				case MultilayerCommunity.GAMMA
					prop_description = 'GAMMA (parameter, SCALAR) is the resolution parameter.';
				case MultilayerCommunity.OMEGA
					prop_description = 'OMEGA (parameter, SCALAR) is the inter-layer coupling parameter.';
				case MultilayerCommunity.S0
					prop_description = 'S0 (data, cvector) is the initial partition size of the multilayer modularity matrix.';
				case MultilayerCommunity.OM
					prop_description = 'OM (data, MATRIX) is the multilayer modularity matrix.';
				case MultilayerCommunity.QUALITY_FUNCTION
					prop_description = 'QUALITY_FUNCTION (data, MATRIX) is the multilayer modularity quality function.';
				case MultilayerCommunity.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Multilayer Community Structure.';
				case MultilayerCommunity.NAME
					prop_description = 'NAME (constant, string) is the name of the Multilayer Community Structure.';
				case MultilayerCommunity.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Multilayer Community Structure.';
				case MultilayerCommunity.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Multilayer Community Structure.';
				case MultilayerCommunity.ID
					prop_description = 'ID (data, string) is a few-letter code of the Multilayer Community Structure.';
				case MultilayerCommunity.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Multilayer Community Structure.';
				case MultilayerCommunity.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Multilayer Community Structure.';
				case MultilayerCommunity.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case MultilayerCommunity.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case MultilayerCommunity.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case MultilayerCommunity.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case MultilayerCommunity.M
					prop_description = 'M (result, cell) is the Multilayer Community Structure.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultilayerCommunity, POINTER) returns settings of POINTER of MultilayerCommunity.
			%  SETTINGS = M.GETPROPSETTINGS(MultilayerCommunity, POINTER) returns settings of POINTER of MultilayerCommunity.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultilayerCommunity.getPropProp(pointer);
			
			switch prop
				case MultilayerCommunity.LIMIT
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MultilayerCommunity.RANDORD
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case MultilayerCommunity.RANDMOVE
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case MultilayerCommunity.GAMMA
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MultilayerCommunity.OMEGA
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MultilayerCommunity.S0
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case MultilayerCommunity.OM
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case MultilayerCommunity.QUALITY_FUNCTION
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case MultilayerCommunity.TEMPLATE
					prop_settings = 'MultilayerCommunity';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultilayerCommunity.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerCommunity.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultilayerCommunity, POINTER) returns the default value of POINTER of MultilayerCommunity.
			%  DEFAULT = M.GETPROPDEFAULT(MultilayerCommunity, POINTER) returns the default value of POINTER of MultilayerCommunity.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultilayerCommunity.getPropProp(pointer);
			
			switch prop
				case MultilayerCommunity.LIMIT
					prop_default = 10000;
				case MultilayerCommunity.RANDORD
					prop_default = true;
				case MultilayerCommunity.RANDMOVE
					prop_default = true;
				case MultilayerCommunity.GAMMA
					prop_default = 1;
				case MultilayerCommunity.OMEGA
					prop_default = 1;
				case MultilayerCommunity.S0
					prop_default = [];
				case MultilayerCommunity.OM
					prop_default = [];
				case MultilayerCommunity.QUALITY_FUNCTION
					prop_default = [];
				case MultilayerCommunity.ELCLASS
					prop_default = 'MultilayerCommunity';
				case MultilayerCommunity.NAME
					prop_default = 'Multilayer Community Structure';
				case MultilayerCommunity.DESCRIPTION
					prop_default = 'The Multilayer Community Structure (MultilayerCommunity) of a multilayer graph is a subdivision of the network into non-overlapping groups of nodes which maximizes the number of within group edges, and minimizes the number of between group edges.';
				case MultilayerCommunity.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultilayerCommunity.getPropSettings(prop));
				case MultilayerCommunity.ID
					prop_default = 'MultilayerCommunity ID';
				case MultilayerCommunity.LABEL
					prop_default = 'Multilayer Community Structure label';
				case MultilayerCommunity.NOTES
					prop_default = 'Multilayer Community Structure notes';
				case MultilayerCommunity.SHAPE
					prop_default = Measure.NODAL;
				case MultilayerCommunity.SCOPE
					prop_default = Measure.UNILAYER;
				case MultilayerCommunity.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case MultilayerCommunity.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'OrdMxWU' 'MultiplexBU' 'MultiplexBUT' 'MultiplexBUD' 'MultilayerBU' 'MultilayerWU' 'OrdMlWU'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultilayerCommunity.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultilayerCommunity.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultilayerCommunity, POINTER) returns the conditioned default value of POINTER of MultilayerCommunity.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultilayerCommunity, POINTER) returns the conditioned default value of POINTER of MultilayerCommunity.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultilayerCommunity.getPropProp(pointer);
			
			prop_default = MultilayerCommunity.conditioning(prop, MultilayerCommunity.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultilayerCommunity, PROP, VALUE) checks VALUE format for PROP of MultilayerCommunity.
			%  CHECK = M.CHECKPROP(MultilayerCommunity, PROP, VALUE) checks VALUE format for PROP of MultilayerCommunity.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultilayerCommunity:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:MultilayerCommunity:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultilayerCommunity, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerCommunity.
			%   Error id: €BRAPH2.STR€:MultilayerCommunity:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(MultilayerCommunity, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultilayerCommunity.
			%   Error id: €BRAPH2.STR€:MultilayerCommunity:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('MultilayerCommunity')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultilayerCommunity.getPropProp(pointer);
			
			switch prop
				case MultilayerCommunity.LIMIT % __MultilayerCommunity.LIMIT__
					check = Format.checkFormat(Format.SCALAR, value, MultilayerCommunity.getPropSettings(prop));
				case MultilayerCommunity.RANDORD % __MultilayerCommunity.RANDORD__
					check = Format.checkFormat(Format.LOGICAL, value, MultilayerCommunity.getPropSettings(prop));
				case MultilayerCommunity.RANDMOVE % __MultilayerCommunity.RANDMOVE__
					check = Format.checkFormat(Format.LOGICAL, value, MultilayerCommunity.getPropSettings(prop));
				case MultilayerCommunity.GAMMA % __MultilayerCommunity.GAMMA__
					check = Format.checkFormat(Format.SCALAR, value, MultilayerCommunity.getPropSettings(prop));
				case MultilayerCommunity.OMEGA % __MultilayerCommunity.OMEGA__
					check = Format.checkFormat(Format.SCALAR, value, MultilayerCommunity.getPropSettings(prop));
				case MultilayerCommunity.S0 % __MultilayerCommunity.S0__
					check = Format.checkFormat(Format.CVECTOR, value, MultilayerCommunity.getPropSettings(prop));
				case MultilayerCommunity.OM % __MultilayerCommunity.OM__
					check = Format.checkFormat(Format.MATRIX, value, MultilayerCommunity.getPropSettings(prop));
				case MultilayerCommunity.QUALITY_FUNCTION % __MultilayerCommunity.QUALITY_FUNCTION__
					check = Format.checkFormat(Format.MATRIX, value, MultilayerCommunity.getPropSettings(prop));
				case MultilayerCommunity.TEMPLATE % __MultilayerCommunity.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultilayerCommunity.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultilayerCommunity:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultilayerCommunity:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultilayerCommunity.getPropTag(prop) ' (' MultilayerCommunity.getFormatTag(MultilayerCommunity.getPropFormat(prop)) ').'] ...
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
				case MultilayerCommunity.M % __MultilayerCommunity.M__
					rng_settings_ = rng(); rng(m.getPropSeed(MultilayerCommunity.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					L = g.get('LAYERNUMBER');
					N = g.get('NODENUMBER');
					graph_type = g.get('GRAPH_TYPE');
					limit = m.get('LIMIT');  % set default for maximum size of multilayer modularity matrix
					randord = m.get('RANDORD');  % set randperm
					randmove = m.get('RANDMOVE');  % set move function
					gamma = m.get('GAMMA');
					omega = m.get('OMEGA');
					S0 = m.get('S0');
					OM = m.get('OM');
					
					if L == 0  % no value case
					    value = {};
					    return;
					end
					% set randperm- v. index-ordered
					if randord
					    myord = @(n) randperm(n);
					else
					    myord = @(n) 1:n;
					end
					
					% set move function (maximal (original Louvain) or random improvement)
					if randmove
					    if ischar(randmove)
					        if any(strcmp(randmove,{'move','moverand','moverandw'}))
					            movefunction = randmove;
					        else
					            error('unknown value for ''randmove''');
					        end
					    else
					        % backwards compatibility: randmove=true
					        movefunction = 'moverand';
					    end
					else
					    movefunction = 'move';
					end
					
					if isempty(OM)
					    directionality_type =  g.get('DIRECTIONALITY_TYPE', L);
					    directionality_firstlayer = directionality_type(1, 1);
					    A = cell(L, 1);
					    A_hold = g.get('A');
					    for i=1:L
					        A(i) = {A_hold{i, i}};
					    end
					    if graph_type == Graph.MULTIPLEX || graph_type == Graph.MULTILAYER
					        if directionality_firstlayer == Graph.UNDIRECTED  % undirected
					            [OM, twom] = multicat_undirected(m, A, gamma, omega, N(1), L);
					        else  % directed
					            [OM, twom] = multicat_directed(m, A, gamma, omega, N(1), L);
					        end
					    elseif graph_type== Graph.ORDERED_MULTIPLEX || graph_type== Graph.ORDERED_MULTILAYER
					        if directionality_firstlayer == Graph.UNDIRECTED  % undirected
					            [OM, twom] = multiord_undirected(m, A, gamma, omega, N(1), L);
					        else  % directed
					            [OM, twom] = multiord_directed(m, A, gamma, omega, N(1), L);
					        end
					    end
					end
					
					% initialise variables and do symmetry check
					if isa(OM,'function_handle')
					    n = length(OM(1));
					    S = (1:n)';
					    
					    if isempty(S0)
					        S0 = (1:n)';
					    else
					        if numel(S0) == n
					            group_handler('assign', S0);
					            S0 = group_handler('return'); % tidy config
					        else
					            error([BRAPH2.STR ':MultilayerCommunity:' BRAPH2.WRONG_INPUT], ...
					                ['Initial partition size for the modularity matrix should be equal to %i,' ...
					                ' while it is ' tostring(numel(S0))], n)
					        end
					    end
					    
					    % symmetry check (only checks symmetry of a small part of the matrix)
					    M = OM;
					    it(:,1) = M(1);
					    ii = find(it(2:end)>0,3) + 1;
					    ii = [1,ii'];
					    for i=2:length(ii)
					        it(:,i)=M(ii(i));
					    end
					    it = it(ii,:);
					%     if norm(full(it-it')) > 2*eps
					%         error([BRAPH2.STR ':MultilayerCommunity:' BRAPH2.WRONG_INPUT], ...
					%             'Function handle does not correspond to a symmetric matrix. Deviation: %i', norm(full(it-it')))
					%     end
					else
					    n = length(OM);
					    S = (1:n)';
					    if isempty(S0)
					        S0 = (1:n)';
					    else
					        if numel(S0)==n
					            % clean input partition
					            group_handler('assign', S0);
					            S0 = group_handler('return');
					        else
					            error([BRAPH2.STR ':MultilayerCommunity:' BRAPH2.WRONG_INPUT], ...
					                ['Initial partition size for the modularity matrix should be equal to %i,' ...
					                ' while it is ' tostring(numel(S0))], n)
					        end
					    end
					    %symmetry check and fix if not symmetric
					    if nnz(OM-OM')
					        OM = (OM+OM')/2;
					        %                     disp('WARNING: Forced symmetric OM matrix')
					    end
					    M = OM;
					end
					
					dtot = eps;  % keeps track of total change in modularity
					y = S0;
					% Run using function handle, if provided
					while (isa(M,'function_handle'))  % loop around each "pass" (in language of Blondel et al) with OM function handle
					    Sb = S;
					    yb = [];
					    while ~isequal(yb,y)
					        dstep = 1;  % keeps track of change in modularity in pass
					        yb = [];
					        while (~isequal(yb,y)) && (dstep/dtot>2*eps) && (dstep>10*eps)  % This is the loop around Blondel et al's "first phase"
					            yb = y;
					            dstep = 0;
					            group_handler('assign',y);
					            for i = myord(length(M(1)))
					                di = group_handler(movefunction, i, M(i));
					                dstep = dstep + di;
					            end
					            
					            dtot = dtot + dstep;
					            y = group_handler('return');
					        end
					        yb = y;
					    end
					    
					    % update partition
					    S = y(S);  % group_handler implements tidyconfig
					    y = unique(y);  % unique also puts elements in ascending order
					    
					    % calculate modularity and return if converged
					    if isequal(Sb,S)
					        Q = 0;
					        P = sparse(y,1:length(y),1);
					        for i=1:length(M(1))
					            Q = Q + (P*M(i))'*P(:,i);
					        end
					        Q = full(Q);
					        clear('group_handler');
					        clear('metanetwork_reduce');
					        m.set('QUALITY_FUNCTION', Q/twom)  % save normalized quality function
					        S = reshape(S, N(1), L);
					        multilayer_community_structure = cell(L, 1);
					        for li = 1:1:L
					            multilayer_community_structure(li) = {S(:, li)};
					        end
					        return
					    end
					    
					    % check wether #groups < limit
					    t = length(unique(S));
					    if (t > limit)
					        metanetwork_reduce('assign', S);  % inputs group information to metanetwork_reduce
					        M = @(i) metanetwork_i(m,OM,i);  % use function handle if #groups > limit
					    else
					        metanetwork_reduce('assign', S);
					        J = zeros(t);  % convert to matrix if #groups small enough
					        for c=1:t
					            J(:,c) = metanetwork_i(m,OM,c);
					        end
					        OM = J;
					        M = OM;
					    end
					end
					
					% Run using matrix OM (old B)
					S2 = (1:length(OM))';
					Sb = [];
					while ~isequal(Sb, S2)  % loop around each "pass" (in language of Blondel et al) with B matrix
					    Sb = S2;
					    yb = [];
					    while ~isequal(yb,y)
					        dstep = 1;
					        while (~isequal(yb,y)) && (dstep/dtot > 2*eps) && (dstep > 10*eps)  % This is the loop around Blondel et al's "first phase"
					            yb = y;
					            dstep = 0;
					            group_handler('assign',y);
					            for i = myord(length(M))
					                di = group_handler(movefunction,i,M(:,i));
					                dstep = dstep+di;
					            end
					            dtot = dtot + dstep;
					            y = group_handler('return');
					        end
					        yb = y;
					    end
					    
					    % update partition
					    S = y(S);
					    S2 = y(S2);
					    
					    if isequal(Sb,S2)
					        P = sparse(y,1:length(y),1);
					        Q = full(sum(sum((P*M).*P)));
					        m.set('QUALITY_FUNCTION', Q/twom);  % save normalized quality function
					        S = reshape(S, N(1), L);
					        multilayer_community_structure = cell(L, 1);
					        for li = 1:1:L
					            multilayer_community_structure(li) = {S(:, li)};
					        end
					        value = multilayer_community_structure;
					        return
					    end
					    
					    M = metanetwork(m, OM, S2);
					    y = unique(S2);  % unique also puts elements in ascending order
					end
					m.set('QUALITY_FUNCTION', Q/twom);  % save normalized quality function
					S = reshape(S, N(1), L);
					multilayer_community_structure = cell(L, 1);
					for li = 1:1:L
					    multilayer_community_structure(li) = {S(:, li)};
					end
					
					value = multilayer_community_structure;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Measure.getPropNumber()
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
			function [OM, twom] = multiord_undirected(m, A, gamma, omega, N, T)
			% MULTIORDUNDIRECTED returns the multilayer modularity matrix for ordered undirected networks
			%
			% [B, twom] = MULTIORDUNDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer
			% Newman-Girvan modularity matrix for ordered undirected networks.
			%
			%   Input: A: Cell array of NxN adjacency matrices for each layer of an
			%          ordered undirected multilayer network
			%          gamma: intralayer resolution parameter
			%          omega: interlayer coupling strength
			%
			%   Output: B: function handle where B(i) returns the ith column of
			%          [NxT]x[NxT] flattened modularity tensor for the
			%           multilayer network with uniform ordinal coupling (T is
			%           the number of layers of the network)
			%           twom: normalisation constant
			%
			%   Example of usage: [B,twom]=multiord_f(A,gamma,omega);
			%          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
			%          postprocess_ordinal_multilayer.m for how to improve output
			%          multilayer partition
			%          Q=Q/twom;
			%          S=reshape(S,N,T);
			%
			%   [B,twom] = MULTIORD_F(A,GAMMA, OMEGA) with A a cell array of square
			%   symmetric matrices of equal size each representing an undirected network
			%   "layer" computes the multilayer Newman-Girvan modularity matrix using
			%   the quality function described in Mucha et al. 2010, with intralayer
			%   resolution parameter GAMMA, and with interlayer coupling OMEGA connecting
			%   nearest-neighbor ordered layers.  The null model used for the quality
			%   function is the Newman-Girvan null model (see e.g. Bazzi et al. for other
			%   possible null models). Once the mulilayer modularity matrix is computed,
			%   optimization can be performed by the generalized Louvain code GENLOUVAIN
			%   or ITERATED_GENLOUVAIN. The output B can be used with other heuristics,
			%   provided the same mapping is used to go from the multilayer tensor to
			%   the multilayer flattened matrix. That is, the node-layer tuple (i,s)
			%   is mapped to i + (s-1)*N. [Note that we can define a mapping between a
			%   multilayer partition S_m stored as an N by T matrix and the corresponding
			%   flattened partition S stored as an NT by 1 vector. In particular
			%   S_m = reshape(S,N,T) and S = S_m(:).]
			%
			%
			%   See also
			%       genlouvain heuristics:      GENLOUVAIN, ITERATED_GENLOUVAIN
			%       multilayer wrappers:        MULTICAT, MULTICATF, MULTIORD
			%       other heuristics:           SPECTRAL23
			%       Kernighan-Lin improvement:  KLNB
			%
			%   Notes:
			%     The matrices in the cell array A are assumed to be square,
			%     symmetric, and of equal size.  These assumptions are not checked here.
			%
			%     For smaller systems, it is potentially more efficient (and easier) to
			%     directly use the sparse quality/modularity matrix B in MULTIORD. For
			%     large systems with directed layer networks, use MULTIORDDIR_F.
			%
			%     This code serves as a template and can be modified for situations
			%     with other wrinkles (e.g., different intralayer null models,
			%     different numbers of nodes from layer-to-layer, or systems which are
			%     both multiplex and longitudinal).  That is, this code is only a
			%     starting point; it is by no means exhaustive.
			%
			%     By using this code, the user implicitly acknowledges that the authors
			%     accept no liability associated with that use.  (What are you doing
			%     with it anyway that might cause there to be a potential liability?!?)
			
			if nargin < 2 || isempty(gamma)
			    gamma = 1;
			end
			
			if nargin < 3
			    omega = 1;
			end
			
			if length(gamma) == 1
			    gamma = repmat(gamma, T, 1);
			end
			
			ii=[]; jj=[]; vv=[];
			ki=[]; kj=[]; kv=[];
			twom = 0;
			for s=1:T
			    indx = (1:N)' + (s-1)*N;
			    [i, j, v] = find(A{s});
			    ii = [ii; indx(i)];
			    jj = [jj; indx(j)];
			    vv = [vv; v];
			    k = sum(A{s});
			    mm = sum(k);
			    twom = twom + mm;
			    ki = [ki; indx];
			    kj = [kj; ones(N,1)*s];
			    kv = [kv; k(:)./mm];
			end
			AA = sparse(ii, jj, vv, N*T, N*T);
			K = sparse(ki, kj, kv, N*T, T);
			clear ii jj vv ki kj kv
			kvec = full(sum(AA));
			AA = AA + omega*spdiags(ones(N*T,2),[-N,N],N*T,N*T);
			OM = @(i) AA(:,i) - gamma(ceil(i/(N+eps)))*K(:,ceil(i/(N+eps)))*kvec(i);
			twom = twom + 2*N*(T-1)*omega;
			end
			function [OM, twom] = multiord_directed(m, A, gamma, omega, N, T)
			% MULTIORDDIRECTED returns the multilayer modularity matrix for ordered directed networks
			%
			% [B, twom] = MULTIORDDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer
			% Leicht-Newman modularity matrix for ordered directed networks.
			%
			%   Input: A: Cell array of NxN adjacency matrices for each layer of an
			%          ordered directed multilayer network
			%          gamma: intralayer resolution parameter
			%          omega: interlayer coupling strength
			%
			%   Output: B: function handle where B(i) returns the ith column of
			%          [NxT]x[NxT] flattened modularity tensor for the
			%           multilayer network with uniform ordinal coupling (T is
			%           the number of layers of the network)
			%           twom: normalisation constant
			%
			%   Example of usage: [B,twom]=multiorddir_f(A,gamma,omega);
			%          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
			%          postprocess_ordinal_multilayer.m for how to improve output
			%          multilayer partition
			%          Q=Q/twom;
			%          S=reshape(S,N,T);
			%
			%   [B,twom] = MULTIORDDIR_F(A,GAMMA, OMEGA) with A a cell array of square
			%   matrices of equal size each representing an directed network "layer"
			%   computes the Leicht-Newman multilayer modularity matrix Susing the
			%   quality function described in Mucha et al. 2010, with intralayer
			%   resolution parameter GAMMA, and with interlayer coupling OMEGA
			%   connecting nearest-neighbor ordered layers. Once the mulilayer modularity
			%   matrix is computed, optimization can be performed by the generalized
			%   Louvain code GENLOUVAIN or ITERATED_GENLOUVAIN. The output B can be used
			%   with other heuristics, provided the same mapping is used to go from the
			%   multilayer tensor to the multilayer flattened matrix. That is, the
			%   node-layer tuple (i,s) is mapped to i + (s-1)*N. [Note that we can
			%   define a mapping between a multilayer partition S_m stored as an N by T
			%   matrix and the corresponding flattened partition S stored as an NT by 1
			%   vector. In particular S_m = reshape(S,N,T) and S = S_m(:).]
			%
			%   See also
			%       genlouvain heuristics:      GENLOUVAIN, ITERATED_GENLOUVAIN
			%       multilayer wrappers:        MULTICAT, MULTICATF, MULTIORD
			%       other heuristics:           SPECTRAL23
			%       Kernighan-Lin improvement:  KLNB
			%
			%   Notes:
			%     The matrices in the cell array A are assumed to be square,
			%     and of equal size.  These assumptions are not checked here.
			%
			%     For smaller systems, it is potentially more efficient (and easier) to
			%     directly use the sparse quality/modularity matrix B in MULTIORD. For
			%     large systems with undirected layer networks, use MULTIORD_F.
			%
			%     This code serves as a template and can be modified for situations
			%     with other wrinkles (e.g., different intralayer null models,
			%     different numbers of nodes from layer-to-layer, or systems which are
			%     both multiplex and longitudinal).  That is, this code is only a
			%     starting point; it is by no means exhaustive.
			%
			%     By using this code, the user implicitly acknowledges that the authors
			%     accept no liability associated with that use.  (What are you doing
			%     with it anyway that might cause there to be a potential liability?!?)
			
			if nargin < 2 || isempty(gamma)
			    gamma = 1;
			end
			
			if nargin < 3 || isempty(omega)
			    omega = 1;
			end
			
			if length(gamma) == 1
			    gamma = repmat(gamma,T,1);
			end
			m = zeros(T,1);
			for i=1:T
			    m(i) = sum(A{i}(:));
			end
			A = blkdiag(A{:});
			kout = sum(A,1);
			koutmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kout);
			kin = sum(A,2);
			kinmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kin);
			A = (A+A')./2;
			A = A + omega*spdiags(ones(N*T,2), [-N,N], N*T, N*T);
			
			OM = @(i) A(:,i) - gamma(ceil(i./(N+eps))).*(kout(i).*kinmat(:,ceil(i./(N+eps)))+kin(i).*koutmat(:,ceil(i./(N+eps))))./(2*m(ceil(i./(N+eps))));
			twom = sum(m) + omega*2*N*(T-1);
			end
			function [OM, twom] = multicat_undirected(m, A, gamma, omega, N, T)
			% MULTICATUNDIRECTED returns the multilayer modularity matrix for unordered undirected networks
			%
			% [B, twom] = MULTICATUNDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer
			% Newman-Girvan modularity matrix for unordered undirected networks.
			%
			%   Input: A: Cell array of NxN adjacency matrices for each layer of an
			%          unordered multilayer undirected network
			%          gamma: intralayer resolution parameter
			%          omega: interlayer coupling strength
			%
			%   Output: B: [NxT]x[NxT] function handle where B(i) returns the ith column
			%           of the flattened modularity tensor for the
			%           multilayer network with uniform categorical coupling (T is
			%           the number of layers of the network)
			%           twom: normalisation constant
			%
			%   Example of usage: [B,twom]=multicat_f(A,gamma,omega);
			%          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
			%          postprocess_categorical_multilayer.m for how to improve output
			%          multilayer partition
			%          Q=Q/twom;
			%          S=reshape(S,N,T);
			%
			%   [B,twom] = MULTICAT(A,GAMMA, OMEGA) with A a cell array of square
			%   symmetric matrices of equal size each representing an undirected network
			%   "layer" computes the multilayer modularity matrix using the quality
			%   function described in Mucha et al. 2010, with intralayer resolution
			%   parameter GAMMA, and with interlayer coupling OMEGA connecting
			%   all-to-all categorical layers. Once the mulilayer modularity matrix is
			%   computed, optimization can be performed by the generalized Louvain code
			%   GENLOUVAIN or ITERATED_GENLOUVAIN. The output B can be used with other
			%   heuristics, provided the same mapping is used to go from the multilayer
			%   tensor to the multilayer flattened matrix. That is, the node-layer tuple
			%   (i,s) is mapped to i + (s-1)*N. [Note that we can define a mapping between
			%   a multilayer partition S_m stored as an N by T matrix and the corresponding
			%   flattened partition S stored as an NT by 1 vector. In particular
			%   S_m = reshape(S,N,T) and S = S_m(:).]
			%
			%   Notes:
			%     The matrices in the cell array A are assumed to be symmetric, square,
			%     and of equal size.  These assumptions are not checked here.
			%
			%     For smaller systems, it is potentially more efficient (and easier) to
			%     directly use the sparse quality/modularity matrix B, as in MULTICAT.
			%
			%     This code serves as a template and can be modified for situations
			%     with other wrinkles (e.g., different intralayer null models,
			%     different numbers of nodes from layer-to-layer, or systems which are
			%     both multiplex and longitudinal).  That is, this code is only a
			%     starting point; it is by no means exhaustive.
			%
			%     By using this code, the user implicitly acknowledges that the authors
			%     accept no liability associated with that use.  (What are you doing
			%     with it anyway that might cause there to be a potential liability?!?)
			
			if nargin < 2 || isempty(gamma)
			    gamma = 1;
			end
			
			if nargin < 3 || isempty(omega)
			    omega = 1;
			end
			
			if length(gamma) == 1
			    gamma = repmat(gamma, T, 1);
			end
			
			ii = []; jj = []; vv = [];
			ki = []; kj = []; kv = [];
			twom = 0;
			for s=1:T
			    indx = [1:N]' + (s-1)*N;
			    [i, j, v] = find(A{s});
			    ii = [ii; indx(i)];
			    jj = [jj; indx(j)];
			    vv = [vv; v];
			    k = sum(A{s});
			    mm = sum(k);
			    ki = [ki; indx];
			    kj = [kj; ones(N,1)*s];
			    kv = [kv; k(:)./mm];
			    twom = twom + sum(k);
			end
			AA = sparse(ii,jj,vv,N*T,N*T);
			K=sparse(ki,kj,kv,N*T,T);
			clear ii jj vv ki kj kv
			kvec = full(sum(AA));
			all2all = N*[(-T+1):-1,1:(T-1)];
			AA = AA + omega*spdiags(ones(N*T, 2*T-2), all2all, N*T, N*T);
			OM = @(i) AA(:,i) - gamma(ceil(i/(N+eps)))*K(:, ceil(i/(N+eps)))*kvec(i);
			twom = twom + 2*N*(T-1)*T*omega;
			end
			function [OM, twom] = multicat_directed(m, A, gamma, omega, N, T)
			% MULTICATDIRECTED returns the multilayer modularity matrix for unordered directed networks
			%
			% [B, twom] = MULTICATDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer
			% Leicht-Newman modularity matrix for unordered directed networks.
			%
			%   Input: A: Cell array of NxN adjacency matrices for each layer of a
			%          categorical directed multilayer network
			%          gamma: intralayer resolution parameter
			%          omega: interlayer coupling strength
			%
			%   Output: B: function handle where B(i) returns the ith column of
			%          [NxT]x[NxT] flattened modularity tensor for the
			%           multilayer network with uniform ordinal coupling (T is
			%           the number of layers of the network)
			%           twom: normalisation constant
			%
			%   Example of usage: [B,twom]=multicatdir_f(A,gamma,omega);
			%          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
			%          postprocess_categorical_multilayer.m for how to improve output
			%          multilayer partition
			%          Q=Q/twom;
			%          S=reshape(S,N,T);
			%
			%   [B,twom] = MULTICATDIR_F(A,GAMMA, OMEGA) with A a cell array of square
			%   matrices of equal size each representing an directed network "layer"
			%   computes the Leicht-Newman multilayer modularity matrix B using the
			%   quality function described in Mucha et al. 2010, with intralayer
			%   resolution parameter GAMMA, and with interlayer coupling OMEGA
			%   connecting all-to-all categorical layers. Once the mulilayer modularity
			%   matrix is computed, optimization can be performed by the generalized
			%   Louvain code GENLOUVAIN or ITERATED_GENLOUVAIN. The output B can be used
			%   with other heuristics, provided the same mapping is used to go from the
			%   multilayer tensor to the multilayer flattened matrix. That is, the
			%   node-layer tuple (i,s) is mapped to i + (s-1)*N. [Note that we can
			%   define a mapping between a multilayer partition S_m stored as an N by T
			%   matrix and the corresponding flattened partition S stored as an NT by 1
			%   vector. In particular S_m = reshape(S,N,T) and S = S_m(:).]
			%
			%   Notes:
			%     The matrices in the cell array A are assumed to be square,
			%     and of equal size.  These assumptions are not checked here.
			%
			%     For smaller systems, it is potentially more efficient (and easier) to
			%     directly use the sparse quality/modularity matrix B in MULTICAT. For
			%     large systems with undirected layer networks, use MULTICAT_F.
			%
			%     This code serves as a template and can be modified for situations
			%     with other wrinkles (e.g., different intralayer null models,
			%     different numbers of nodes from layer-to-layer, or systems which are
			%     both multiplex and longitudinal).  That is, this code is only a
			%     starting point; it is by no means exhaustive.
			%
			%     By using this code, the user implicitly acknowledges that the authors
			%     accept no liability associated with that use.  (What are you doing
			%     with it anyway that might cause there to be a potential liability?!?)
			
			if nargin < 2 || isempty(gamma)
			    gamma = 1;
			end
			
			if nargin < 3 || isempty(omega)
			    omega = 1;
			end
			
			if length(gamma) == 1
			    gamma = repmat(gamma, T, 1);
			end
			
			m = zeros(T, 1);
			for i=1:T
			    m(i) = sum(A{i}(:));
			end
			A = blkdiag(A{:});
			kout = sum(A,1);
			koutmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kout);
			kin = sum(A,2);
			kinmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kin);
			A = (A+A')./2;
			all2all = N*[(-T+1):-1,1:(T-1)];
			A = A + omega*spdiags(ones(N*T, 2*T-2), all2all, N*T, N*T);
			
			OM = @(i) A(:,i) - gamma(ceil(i./(N+eps))).*(kout(i).*kinmat(:,ceil(i./(N+eps))) + kin(i).*koutmat(:, ceil(i./(N+eps))))./(2*m(ceil(i./(N+eps))));
			twom = sum(m) + omega*2*N*(T-1);
			end
			function M = metanetwork(m, J, S)
			% METANETWORK returns the new aggregated network (communities --> nodes)
			%
			% [B, twom] = METANETWORK(J, S) returns the new aggregated
			% network (communities --> nodes)
			
			PP = sparse(1:length(S), S, 1);
			M = PP'*J*PP;
			end
			function Mi = metanetwork_i(m, J, i)
			% METANETWORKI returns the ith column of the metanetwork
			%
			% [B, twom] = METANETWORKI(J, S) returns the ith column of
			% the metanetwork. J is a function handle
			
			ind = metanetwork_reduce('nodes',i);
			for j=ind(:)'
			    metanetwork_reduce('reduce',J(j));
			end
			Mi = metanetwork_reduce('return');
			end
		end
	end
end
