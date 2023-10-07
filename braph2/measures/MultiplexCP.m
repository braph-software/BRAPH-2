classdef MultiplexCP < MultiRC
	%MultiplexCP is the graph Multiplex Core-Periphery.
	% It is a subclass of <a href="matlab:help MultiRC">MultiRC</a>.
	%
	% The Multiplex Core-Periphery (MultiplexCP) of a node is the value of the rank corresponding 
	%  to the maximum multirichness nodes. It returns 1 for a node belonging to the 
	%  core and zero otherwise. The relevance of each layer is controlled by the 
	%  multirichness coefficients that are between 0 and 1, and add up to one; 
	%  the default coefficients are (1/layernumber).
	%
	% MultiplexCP methods (constructor):
	%  MultiplexCP - constructor
	%
	% MultiplexCP methods:
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
	% MultiplexCP methods (display):
	%  tostring - string with information about the multiplex core-periphery
	%  disp - displays information about the multiplex core-periphery
	%  tree - displays the tree of the multiplex core-periphery
	%
	% MultiplexCP methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two multiplex core-periphery are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the multiplex core-periphery
	%
	% MultiplexCP methods (save/load, Static):
	%  save - saves BRAPH2 multiplex core-periphery as b2 file
	%  load - loads a BRAPH2 multiplex core-periphery from a b2 file
	%
	% MultiplexCP method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the multiplex core-periphery
	%
	% MultiplexCP method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the multiplex core-periphery
	%
	% MultiplexCP methods (inspection, Static):
	%  getClass - returns the class of the multiplex core-periphery
	%  getSubclasses - returns all subclasses of MultiplexCP
	%  getProps - returns the property list of the multiplex core-periphery
	%  getPropNumber - returns the property number of the multiplex core-periphery
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
	% MultiplexCP methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MultiplexCP methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MultiplexCP methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MultiplexCP methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MultiplexCP; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MultiplexCP constants</a>.
	%
	
	methods % constructor
		function m = MultiplexCP(varargin)
			%MultiplexCP() creates a multiplex core-periphery.
			%
			% MultiplexCP(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MultiplexCP(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@MultiRC(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the multiplex core-periphery.
			%
			% CLASS = MultiplexCP.GETCLASS() returns the class 'MultiplexCP'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the multiplex core-periphery M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('MultiplexCP') returns 'MultiplexCP'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('MultiplexCP')
			%  are less computationally efficient.
			
			m_class = 'MultiplexCP';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the multiplex core-periphery.
			%
			% LIST = MultiplexCP.GETSUBCLASSES() returns all subclasses of 'MultiplexCP'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the multiplex core-periphery M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('MultiplexCP') returns all subclasses of 'MultiplexCP'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('MultiplexCP')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MultiplexCP', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of multiplex core-periphery.
			%
			% PROPS = MultiplexCP.GETPROPS() returns the property list of multiplex core-periphery
			%  as a row vector.
			%
			% PROPS = MultiplexCP.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the multiplex core-periphery M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('MultiplexCP'[, CATEGORY]) returns the property list of 'MultiplexCP'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('MultiplexCP')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					MultiRC.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						MultiRC.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						MultiRC.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						MultiRC.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						MultiRC.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						MultiRC.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						MultiRC.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						MultiRC.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						MultiRC.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						MultiRC.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of multiplex core-periphery.
			%
			% N = MultiplexCP.GETPROPNUMBER() returns the property number of multiplex core-periphery.
			%
			% N = MultiplexCP.GETPROPNUMBER(CATEGORY) returns the property number of multiplex core-periphery
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the multiplex core-periphery M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('MultiplexCP') returns the property number of 'MultiplexCP'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('MultiplexCP')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MultiplexCP.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in multiplex core-periphery/error.
			%
			% CHECK = MultiplexCP.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(MultiplexCP, PROP) checks whether PROP exists for MultiplexCP.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MultiplexCP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexCP:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexCP:WrongInput]
			%  Element.EXISTSPROP(MultiplexCP, PROP) throws error if PROP does NOT exist for MultiplexCP.
			%   Error id: [BRAPH2:MultiplexCP:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('MultiplexCP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MultiplexCP.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexCP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexCP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MultiplexCP.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in multiplex core-periphery/error.
			%
			% CHECK = MultiplexCP.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(MultiplexCP, TAG) checks whether TAG exists for MultiplexCP.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MultiplexCP:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexCP:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:MultiplexCP:WrongInput]
			%  Element.EXISTSTAG(MultiplexCP, TAG) throws error if TAG does NOT exist for MultiplexCP.
			%   Error id: [BRAPH2:MultiplexCP:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('MultiplexCP')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			multiplexcp_tag_list = cellfun(@(x) MultiplexCP.getPropTag(x), num2cell(MultiplexCP.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, multiplexcp_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexCP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexCP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MultiplexCP.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MultiplexCP, POINTER) returns property number of POINTER of MultiplexCP.
			%  PROPERTY = M.GETPROPPROP(MultiplexCP, POINTER) returns property number of POINTER of MultiplexCP.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('MultiplexCP')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				multiplexcp_tag_list = cellfun(@(x) MultiplexCP.getPropTag(x), num2cell(MultiplexCP.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, multiplexcp_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MultiplexCP, POINTER) returns tag of POINTER of MultiplexCP.
			%  TAG = M.GETPROPTAG(MultiplexCP, POINTER) returns tag of POINTER of MultiplexCP.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('MultiplexCP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					otherwise
						tag = getPropTag@MultiRC(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(MultiplexCP, POINTER) returns category of POINTER of MultiplexCP.
			%  CATEGORY = M.GETPROPCATEGORY(MultiplexCP, POINTER) returns category of POINTER of MultiplexCP.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('MultiplexCP')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexCP.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@MultiRC(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(MultiplexCP, POINTER) returns format of POINTER of MultiplexCP.
			%  FORMAT = M.GETPROPFORMAT(MultiplexCP, POINTER) returns format of POINTER of MultiplexCP.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('MultiplexCP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexCP.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@MultiRC(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MultiplexCP, POINTER) returns description of POINTER of MultiplexCP.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(MultiplexCP, POINTER) returns description of POINTER of MultiplexCP.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('MultiplexCP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MultiplexCP.getPropProp(pointer);
			
			switch prop
				case MultiplexCP.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Multiplex Core-Periphery.';
				case MultiplexCP.NAME
					prop_description = 'NAME (constant, string) is the name of the Multiplex Core-Periphery.';
				case MultiplexCP.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Multiplex Core-Periphery.';
				case MultiplexCP.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Multiplex Core-Periphery.';
				case MultiplexCP.ID
					prop_description = 'ID (data, string) is a few-letter code of the Multiplex Core-Periphery.';
				case MultiplexCP.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Multiplex Core-Periphery.';
				case MultiplexCP.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Multiplex Core-Periphery.';
				case MultiplexCP.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case MultiplexCP.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case MultiplexCP.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case MultiplexCP.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case MultiplexCP.M
					prop_description = 'M (result, cell) is the multiplex core-periphery.';
				otherwise
					prop_description = getPropDescription@MultiRC(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(MultiplexCP, POINTER) returns settings of POINTER of MultiplexCP.
			%  SETTINGS = M.GETPROPSETTINGS(MultiplexCP, POINTER) returns settings of POINTER of MultiplexCP.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('MultiplexCP')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MultiplexCP.getPropProp(pointer);
			
			switch prop
				case MultiplexCP.TEMPLATE
					prop_settings = 'MultiplexCP';
				otherwise
					prop_settings = getPropSettings@MultiRC(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MultiplexCP.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexCP.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(MultiplexCP, POINTER) returns the default value of POINTER of MultiplexCP.
			%  DEFAULT = M.GETPROPDEFAULT(MultiplexCP, POINTER) returns the default value of POINTER of MultiplexCP.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('MultiplexCP')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MultiplexCP.getPropProp(pointer);
			
			switch prop
				case MultiplexCP.ELCLASS
					prop_default = 'MultiplexCP';
				case MultiplexCP.NAME
					prop_default = 'Multiplex Core-Periphery';
				case MultiplexCP.DESCRIPTION
					prop_default = 'The Multiplex Core-Periphery (MultiplexCP) of a node is the value of the rank corresponding to the maximum multirichness nodes. It returns 1 for a node belonging to the  core and zero otherwise. The relevance of each layer is controlled by the  multirichness coefficients that are between 0 and 1, and add up to one;  the default coefficients are (1/layernumber).';
				case MultiplexCP.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MultiplexCP.getPropSettings(prop));
				case MultiplexCP.ID
					prop_default = 'MultiplexCP ID';
				case MultiplexCP.LABEL
					prop_default = 'Multiplex Core-Periphery label';
				case MultiplexCP.NOTES
					prop_default = 'Multiplex Core-Periphery notes';
				case MultiplexCP.SHAPE
					prop_default = Measure.NODAL;
				case MultiplexCP.SCOPE
					prop_default = Measure.SUPERGLOBAL;
				case MultiplexCP.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case MultiplexCP.COMPATIBLE_GRAPHS
					prop_default = {'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'OrdMxBU'};;
				otherwise
					prop_default = getPropDefault@MultiRC(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MultiplexCP.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MultiplexCP.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MultiplexCP, POINTER) returns the conditioned default value of POINTER of MultiplexCP.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(MultiplexCP, POINTER) returns the conditioned default value of POINTER of MultiplexCP.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('MultiplexCP')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MultiplexCP.getPropProp(pointer);
			
			prop_default = MultiplexCP.conditioning(prop, MultiplexCP.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MultiplexCP, PROP, VALUE) checks VALUE format for PROP of MultiplexCP.
			%  CHECK = M.CHECKPROP(MultiplexCP, PROP, VALUE) checks VALUE format for PROP of MultiplexCP.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MultiplexCP:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:MultiplexCP:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MultiplexCP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexCP.
			%   Error id: €BRAPH2.STR€:MultiplexCP:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(MultiplexCP, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MultiplexCP.
			%   Error id: €BRAPH2.STR€:MultiplexCP:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('MultiplexCP')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MultiplexCP.getPropProp(pointer);
			
			switch prop
				case MultiplexCP.TEMPLATE % __MultiplexCP.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MultiplexCP.getPropSettings(prop));
				otherwise
					if prop <= MultiRC.getPropNumber()
						check = checkProp@MultiRC(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MultiplexCP:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MultiplexCP:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MultiplexCP.getPropTag(prop) ' (' MultiplexCP.getFormatTag(MultiplexCP.getPropFormat(prop)) ').'] ...
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
				case MultiplexCP.M % __MultiplexCP.M__
					rng_settings_ = rng(); rng(m.getPropSeed(MultiplexCP.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					l = g.get('LAYERNUMBER');
					ls = g.get('PARTITIONS');
					
					multirichness = calculateValue@MultiRC(m, prop);
					
					if l == 0
					    value = {};
					else
					    N = g.get('NODENUMBER');
					    multirichness_coefficients = m.get('MULTIRICHNESS_COEFFICIENTS');
					    assert(length(multirichness_coefficients) == ls(1) || all(multirichness_coefficients == 0), ...
					        [BRAPH2.STR ':MultiRCness:' BRAPH2.WRONG_INPUT], ...
					        ['MultiRCness coefficients must have the same length than the ' ...
					        'number of layers (' tostring(ls(1)) ') while its length is ' tostring(length(multirichness_coefficients))])
					
					    if length(multirichness_coefficients) == ls(1)
					        assert(all(multirichness_coefficients <= 1) && all(multirichness_coefficients >= 0), ...
					            [BRAPH2.STR ':MultiRCness:' BRAPH2.WRONG_INPUT], ...
					            ['MultiRCness coefficients must be between 0 and 1 ' ...
					            'while they are ' tostring(multirichness_coefficients)])
					        c = multirichness_coefficients;
					
					    else  % same relevance for each layer
					        c = ones(1, l)/ls(1);
					    end
					
					    directionality_layer =  g.get('DIRECTIONALITY_TYPE', l);
					    connectivity_layer =  g.get('CONNECTIVITY_TYPE', l);
					    multiplex_core_periphery = cell(length(ls), 1);
					    count = 1;
					    for i = 1:1:length(ls)
					        overlapping_coefficients = zeros(N(1), 1);
					        multiplex_core_periphery_partition = zeros(N(1), 1);
					        for li = count:1:ls(i) + count - 1
					            if connectivity_layer == Graph.WEIGHTED  % weighted graphs
					                if directionality_layer == Graph.UNDIRECTED  % undirected graphs
					
					                    strength = Strength('G', g).get('M');
					                    deg = strength{li};
					
					                else  % directed graphs
					
					                    in_strength = StrengthIn('G', g).get('M');
					                    out_strength = StrengthOut('G', g).get('M');
					                    deg = (in_strength{li} + out_strength{li})/2;
					                end
					
					            else  % binary graphs
					                if directionality_layer == Graph.UNDIRECTED  % undirected graphs
					
					                    degree = Degree('G', g).get('M');
					                    deg = degree{li};
					
					                else  % directed graphs
					
					                    in_degree = DegreeIn('G', g).get('M');
					                    out_degree = DegreeOut('G', g).get('M');
					                    deg = (in_degree{li} + out_degree{li})/2;
					                end
					            end
					            overlapping_coefficients = overlapping_coefficients + c(li)*deg;
					        end
					        [~, rankingInd] = sort(overlapping_coefficients, 'descend');
					        multirichness_partition = multirichness{i};
					        [~, rankOfMaxMultiRCness] = max(multirichness_partition(rankingInd));  
					        multiplex_core_periphery_partition(rankingInd(1:rankOfMaxMultiRCness)) = 1;
					        count = count + ls(i);
					        multiplex_core_periphery(i) = {multiplex_core_periphery_partition};
					    end
					    value = multiplex_core_periphery;
					end
					
					rng(rng_settings_)
					
				otherwise
					if prop <= MultiRC.getPropNumber()
						value = calculateValue@MultiRC(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
