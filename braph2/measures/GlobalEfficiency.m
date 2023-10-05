classdef GlobalEfficiency < Distance
	%GlobalEfficiency is the graph Global Efficiency.
	% It is a subclass of <a href="matlab:help Distance">Distance</a>.
	%
	% The Global Efficiency (GlobalEfficiency) is the average inverse shortest path length within each layer. 
	% It is inversely related to the characteristic path length.
	%
	% GlobalEfficiency methods (constructor):
	%  GlobalEfficiency - constructor
	%
	% GlobalEfficiency methods:
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
	% GlobalEfficiency methods (display):
	%  tostring - string with information about the global efficiency
	%  disp - displays information about the global efficiency
	%  tree - displays the tree of the global efficiency
	%
	% GlobalEfficiency methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two global efficiency are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the global efficiency
	%
	% GlobalEfficiency methods (save/load, Static):
	%  save - saves BRAPH2 global efficiency as b2 file
	%  load - loads a BRAPH2 global efficiency from a b2 file
	%
	% GlobalEfficiency method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the global efficiency
	%
	% GlobalEfficiency method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the global efficiency
	%
	% GlobalEfficiency methods (inspection, Static):
	%  getClass - returns the class of the global efficiency
	%  getSubclasses - returns all subclasses of GlobalEfficiency
	%  getProps - returns the property list of the global efficiency
	%  getPropNumber - returns the property number of the global efficiency
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
	% GlobalEfficiency methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GlobalEfficiency methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GlobalEfficiency methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GlobalEfficiency methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GlobalEfficiency; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GlobalEfficiency constants</a>.
	%
	
	methods % constructor
		function m = GlobalEfficiency(varargin)
			%GlobalEfficiency() creates a global efficiency.
			%
			% GlobalEfficiency(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GlobalEfficiency(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@Distance(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the global efficiency.
			%
			% CLASS = GlobalEfficiency.GETCLASS() returns the class 'GlobalEfficiency'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the global efficiency M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('GlobalEfficiency') returns 'GlobalEfficiency'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('GlobalEfficiency')
			%  are less computationally efficient.
			
			m_class = 'GlobalEfficiency';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the global efficiency.
			%
			% LIST = GlobalEfficiency.GETSUBCLASSES() returns all subclasses of 'GlobalEfficiency'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the global efficiency M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('GlobalEfficiency') returns all subclasses of 'GlobalEfficiency'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('GlobalEfficiency')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GlobalEfficiency', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of global efficiency.
			%
			% PROPS = GlobalEfficiency.GETPROPS() returns the property list of global efficiency
			%  as a row vector.
			%
			% PROPS = GlobalEfficiency.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the global efficiency M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('GlobalEfficiency'[, CATEGORY]) returns the property list of 'GlobalEfficiency'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('GlobalEfficiency')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Distance.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						Distance.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						Distance.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						Distance.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						Distance.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						Distance.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						Distance.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						Distance.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						Distance.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						Distance.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of global efficiency.
			%
			% N = GlobalEfficiency.GETPROPNUMBER() returns the property number of global efficiency.
			%
			% N = GlobalEfficiency.GETPROPNUMBER(CATEGORY) returns the property number of global efficiency
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the global efficiency M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('GlobalEfficiency') returns the property number of 'GlobalEfficiency'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('GlobalEfficiency')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GlobalEfficiency.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in global efficiency/error.
			%
			% CHECK = GlobalEfficiency.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(GlobalEfficiency, PROP) checks whether PROP exists for GlobalEfficiency.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GlobalEfficiency:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiency:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiency:WrongInput]
			%  Element.EXISTSPROP(GlobalEfficiency, PROP) throws error if PROP does NOT exist for GlobalEfficiency.
			%   Error id: [BRAPH2:GlobalEfficiency:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('GlobalEfficiency')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GlobalEfficiency.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GlobalEfficiency:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GlobalEfficiency:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GlobalEfficiency.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in global efficiency/error.
			%
			% CHECK = GlobalEfficiency.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(GlobalEfficiency, TAG) checks whether TAG exists for GlobalEfficiency.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GlobalEfficiency:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiency:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiency:WrongInput]
			%  Element.EXISTSTAG(GlobalEfficiency, TAG) throws error if TAG does NOT exist for GlobalEfficiency.
			%   Error id: [BRAPH2:GlobalEfficiency:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('GlobalEfficiency')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			globalefficiency_tag_list = cellfun(@(x) GlobalEfficiency.getPropTag(x), num2cell(GlobalEfficiency.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, globalefficiency_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GlobalEfficiency:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GlobalEfficiency:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GlobalEfficiency.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GlobalEfficiency, POINTER) returns property number of POINTER of GlobalEfficiency.
			%  PROPERTY = M.GETPROPPROP(GlobalEfficiency, POINTER) returns property number of POINTER of GlobalEfficiency.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('GlobalEfficiency')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				globalefficiency_tag_list = cellfun(@(x) GlobalEfficiency.getPropTag(x), num2cell(GlobalEfficiency.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, globalefficiency_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GlobalEfficiency, POINTER) returns tag of POINTER of GlobalEfficiency.
			%  TAG = M.GETPROPTAG(GlobalEfficiency, POINTER) returns tag of POINTER of GlobalEfficiency.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('GlobalEfficiency')
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
						tag = getPropTag@Distance(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(GlobalEfficiency, POINTER) returns category of POINTER of GlobalEfficiency.
			%  CATEGORY = M.GETPROPCATEGORY(GlobalEfficiency, POINTER) returns category of POINTER of GlobalEfficiency.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('GlobalEfficiency')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GlobalEfficiency.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@Distance(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(GlobalEfficiency, POINTER) returns format of POINTER of GlobalEfficiency.
			%  FORMAT = M.GETPROPFORMAT(GlobalEfficiency, POINTER) returns format of POINTER of GlobalEfficiency.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('GlobalEfficiency')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GlobalEfficiency.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@Distance(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GlobalEfficiency, POINTER) returns description of POINTER of GlobalEfficiency.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(GlobalEfficiency, POINTER) returns description of POINTER of GlobalEfficiency.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('GlobalEfficiency')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GlobalEfficiency.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiency.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Global Efficiency.';
				case GlobalEfficiency.NAME
					prop_description = 'NAME (constant, string) is the name of the Global Efficiency.';
				case GlobalEfficiency.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Global Efficiency.';
				case GlobalEfficiency.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Global Efficiency.';
				case GlobalEfficiency.ID
					prop_description = 'ID (data, string) is a few-letter code of the degree.';
				case GlobalEfficiency.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Global Efficiency.';
				case GlobalEfficiency.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Global Efficiency.';
				case GlobalEfficiency.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case GlobalEfficiency.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case GlobalEfficiency.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case GlobalEfficiency.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case GlobalEfficiency.M
					prop_description = 'M (result, cell) is the Global Efficiency.';
				otherwise
					prop_description = getPropDescription@Distance(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(GlobalEfficiency, POINTER) returns settings of POINTER of GlobalEfficiency.
			%  SETTINGS = M.GETPROPSETTINGS(GlobalEfficiency, POINTER) returns settings of POINTER of GlobalEfficiency.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('GlobalEfficiency')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GlobalEfficiency.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiency.TEMPLATE
					prop_settings = 'GlobalEfficiency';
				otherwise
					prop_settings = getPropSettings@Distance(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GlobalEfficiency.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GlobalEfficiency.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(GlobalEfficiency, POINTER) returns the default value of POINTER of GlobalEfficiency.
			%  DEFAULT = M.GETPROPDEFAULT(GlobalEfficiency, POINTER) returns the default value of POINTER of GlobalEfficiency.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('GlobalEfficiency')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GlobalEfficiency.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiency.ELCLASS
					prop_default = 'GlobalEfficiency';
				case GlobalEfficiency.NAME
					prop_default = 'Global Efficiency';
				case GlobalEfficiency.DESCRIPTION
					prop_default = 'The Global Efficiency (GlobalEfficiency) is the average inverse shortest path length within each layer. It is inversely related to the characteristic path length.';
				case GlobalEfficiency.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, GlobalEfficiency.getPropSettings(prop));
				case GlobalEfficiency.ID
					prop_default = 'GlobalEfficiency ID';
				case GlobalEfficiency.LABEL
					prop_default = 'Global Efficiency label';
				case GlobalEfficiency.NOTES
					prop_default = 'Global Efficiency notes';
				case GlobalEfficiency.SHAPE
					prop_default = Measure.NODAL;
				case GlobalEfficiency.SCOPE
					prop_default = Measure.UNILAYER;
				case GlobalEfficiency.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case GlobalEfficiency.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'OrdMxBU' 'OrdMxBUT' 'OrdMxBUD' 'MultilayerWU' 'OrdMlWU' 'MultilayerBUT' 'MultilayerBU' 'MultilayerBUD' 'OrdMlBU' 'OrdMlBUD' 'OrdMlBUT'};
				otherwise
					prop_default = getPropDefault@Distance(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GlobalEfficiency.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GlobalEfficiency.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GlobalEfficiency, POINTER) returns the conditioned default value of POINTER of GlobalEfficiency.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(GlobalEfficiency, POINTER) returns the conditioned default value of POINTER of GlobalEfficiency.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('GlobalEfficiency')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GlobalEfficiency.getPropProp(pointer);
			
			prop_default = GlobalEfficiency.conditioning(prop, GlobalEfficiency.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GlobalEfficiency, PROP, VALUE) checks VALUE format for PROP of GlobalEfficiency.
			%  CHECK = M.CHECKPROP(GlobalEfficiency, PROP, VALUE) checks VALUE format for PROP of GlobalEfficiency.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GlobalEfficiency:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:GlobalEfficiency:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GlobalEfficiency, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GlobalEfficiency.
			%   Error id: €BRAPH2.STR€:GlobalEfficiency:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(GlobalEfficiency, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GlobalEfficiency.
			%   Error id: €BRAPH2.STR€:GlobalEfficiency:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('GlobalEfficiency')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GlobalEfficiency.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiency.TEMPLATE % __GlobalEfficiency.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, GlobalEfficiency.getPropSettings(prop));
				otherwise
					if prop <= Distance.getPropNumber()
						check = checkProp@Distance(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GlobalEfficiency:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GlobalEfficiency:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GlobalEfficiency.getPropTag(prop) ' (' GlobalEfficiency.getFormatTag(GlobalEfficiency.getPropFormat(prop)) ').'] ...
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
				case GlobalEfficiency.M % __GlobalEfficiency.M__
					rng_settings_ = rng(); rng(m.getPropSeed(GlobalEfficiency.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					N = g.get('NODENUMBER');
					
					distance = calculateValue@Distance(m, prop);
					
					global_efficiency = cell(L, 1);
					parfor li = 1:1:L
					    inverse_distance = distance{li}.^-1;  % inverse distance
					    inverse_distance(1:N(li)+1:end) = 0;
					    global_efficiency_layer = (sum(inverse_distance, 2) / (N(li)-1));
					    global_efficiency(li) = {global_efficiency_layer};
					end
					value = global_efficiency;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Distance.getPropNumber()
						value = calculateValue@Distance(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
