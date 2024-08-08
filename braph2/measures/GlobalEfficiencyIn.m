classdef GlobalEfficiencyIn < Distance
	%GlobalEfficiencyIn is the graph In-Global Efficiency.
	% It is a subclass of <a href="matlab:help Distance">Distance</a>.
	%
	% The In-Global Efficiency (GlobalEfficiencyIn) is the average inverse shortest in-path length within each layer. 
	% It is inversely related to the characteristic in-path length.
	%
	% GlobalEfficiencyIn methods (constructor):
	%  GlobalEfficiencyIn - constructor
	%
	% GlobalEfficiencyIn methods:
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
	% GlobalEfficiencyIn methods (display):
	%  tostring - string with information about the in-global efficiency
	%  disp - displays information about the in-global efficiency
	%  tree - displays the tree of the in-global efficiency
	%
	% GlobalEfficiencyIn methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two in-global efficiency are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the in-global efficiency
	%
	% GlobalEfficiencyIn methods (save/load, Static):
	%  save - saves BRAPH2 in-global efficiency as b2 file
	%  load - loads a BRAPH2 in-global efficiency from a b2 file
	%
	% GlobalEfficiencyIn method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the in-global efficiency
	%
	% GlobalEfficiencyIn method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the in-global efficiency
	%
	% GlobalEfficiencyIn methods (inspection, Static):
	%  getClass - returns the class of the in-global efficiency
	%  getSubclasses - returns all subclasses of GlobalEfficiencyIn
	%  getProps - returns the property list of the in-global efficiency
	%  getPropNumber - returns the property number of the in-global efficiency
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
	% GlobalEfficiencyIn methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GlobalEfficiencyIn methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GlobalEfficiencyIn methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GlobalEfficiencyIn methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GlobalEfficiencyIn; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GlobalEfficiencyIn constants</a>.
	%
	
	methods % constructor
		function m = GlobalEfficiencyIn(varargin)
			%GlobalEfficiencyIn() creates a in-global efficiency.
			%
			% GlobalEfficiencyIn(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GlobalEfficiencyIn(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the in-global efficiency.
			%
			% CLASS = GlobalEfficiencyIn.GETCLASS() returns the class 'GlobalEfficiencyIn'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the in-global efficiency M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('GlobalEfficiencyIn') returns 'GlobalEfficiencyIn'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('GlobalEfficiencyIn')
			%  are less computationally efficient.
			
			m_class = 'GlobalEfficiencyIn';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the in-global efficiency.
			%
			% LIST = GlobalEfficiencyIn.GETSUBCLASSES() returns all subclasses of 'GlobalEfficiencyIn'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the in-global efficiency M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('GlobalEfficiencyIn') returns all subclasses of 'GlobalEfficiencyIn'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('GlobalEfficiencyIn')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GlobalEfficiencyIn', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of in-global efficiency.
			%
			% PROPS = GlobalEfficiencyIn.GETPROPS() returns the property list of in-global efficiency
			%  as a row vector.
			%
			% PROPS = GlobalEfficiencyIn.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the in-global efficiency M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('GlobalEfficiencyIn'[, CATEGORY]) returns the property list of 'GlobalEfficiencyIn'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('GlobalEfficiencyIn')
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
			%GETPROPNUMBER returns the property number of in-global efficiency.
			%
			% N = GlobalEfficiencyIn.GETPROPNUMBER() returns the property number of in-global efficiency.
			%
			% N = GlobalEfficiencyIn.GETPROPNUMBER(CATEGORY) returns the property number of in-global efficiency
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the in-global efficiency M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('GlobalEfficiencyIn') returns the property number of 'GlobalEfficiencyIn'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('GlobalEfficiencyIn')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GlobalEfficiencyIn.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in in-global efficiency/error.
			%
			% CHECK = GlobalEfficiencyIn.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(GlobalEfficiencyIn, PROP) checks whether PROP exists for GlobalEfficiencyIn.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GlobalEfficiencyIn:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyIn:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyIn:WrongInput]
			%  Element.EXISTSPROP(GlobalEfficiencyIn, PROP) throws error if PROP does NOT exist for GlobalEfficiencyIn.
			%   Error id: [BRAPH2:GlobalEfficiencyIn:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('GlobalEfficiencyIn')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GlobalEfficiencyIn.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GlobalEfficiencyIn.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in in-global efficiency/error.
			%
			% CHECK = GlobalEfficiencyIn.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(GlobalEfficiencyIn, TAG) checks whether TAG exists for GlobalEfficiencyIn.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GlobalEfficiencyIn:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyIn:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyIn:WrongInput]
			%  Element.EXISTSTAG(GlobalEfficiencyIn, TAG) throws error if TAG does NOT exist for GlobalEfficiencyIn.
			%   Error id: [BRAPH2:GlobalEfficiencyIn:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('GlobalEfficiencyIn')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			globalefficiencyin_tag_list = cellfun(@(x) GlobalEfficiencyIn.getPropTag(x), num2cell(GlobalEfficiencyIn.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, globalefficiencyin_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GlobalEfficiencyIn.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GlobalEfficiencyIn, POINTER) returns property number of POINTER of GlobalEfficiencyIn.
			%  PROPERTY = M.GETPROPPROP(GlobalEfficiencyIn, POINTER) returns property number of POINTER of GlobalEfficiencyIn.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('GlobalEfficiencyIn')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				globalefficiencyin_tag_list = cellfun(@(x) GlobalEfficiencyIn.getPropTag(x), num2cell(GlobalEfficiencyIn.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, globalefficiencyin_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GlobalEfficiencyIn, POINTER) returns tag of POINTER of GlobalEfficiencyIn.
			%  TAG = M.GETPROPTAG(GlobalEfficiencyIn, POINTER) returns tag of POINTER of GlobalEfficiencyIn.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('GlobalEfficiencyIn')
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
			%  CATEGORY = Element.GETPROPCATEGORY(GlobalEfficiencyIn, POINTER) returns category of POINTER of GlobalEfficiencyIn.
			%  CATEGORY = M.GETPROPCATEGORY(GlobalEfficiencyIn, POINTER) returns category of POINTER of GlobalEfficiencyIn.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('GlobalEfficiencyIn')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyIn.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(GlobalEfficiencyIn, POINTER) returns format of POINTER of GlobalEfficiencyIn.
			%  FORMAT = M.GETPROPFORMAT(GlobalEfficiencyIn, POINTER) returns format of POINTER of GlobalEfficiencyIn.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('GlobalEfficiencyIn')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyIn.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GlobalEfficiencyIn, POINTER) returns description of POINTER of GlobalEfficiencyIn.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(GlobalEfficiencyIn, POINTER) returns description of POINTER of GlobalEfficiencyIn.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('GlobalEfficiencyIn')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyIn.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyIn.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the In-Global Efficiency.';
				case GlobalEfficiencyIn.NAME
					prop_description = 'NAME (constant, string) is the name of the In-Global Efficiency.';
				case GlobalEfficiencyIn.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the In-Global Efficiency.';
				case GlobalEfficiencyIn.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the In-Global Efficiency.';
				case GlobalEfficiencyIn.ID
					prop_description = 'ID (data, string) is a few-letter code of the In-Global Efficiency.';
				case GlobalEfficiencyIn.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the In-Global Efficiency.';
				case GlobalEfficiencyIn.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the In-Global Efficiency.';
				case GlobalEfficiencyIn.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case GlobalEfficiencyIn.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case GlobalEfficiencyIn.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case GlobalEfficiencyIn.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case GlobalEfficiencyIn.M
					prop_description = 'M (result, cell) is the In-Global Efficiency.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(GlobalEfficiencyIn, POINTER) returns settings of POINTER of GlobalEfficiencyIn.
			%  SETTINGS = M.GETPROPSETTINGS(GlobalEfficiencyIn, POINTER) returns settings of POINTER of GlobalEfficiencyIn.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('GlobalEfficiencyIn')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyIn.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyIn.TEMPLATE
					prop_settings = 'GlobalEfficiencyIn';
				otherwise
					prop_settings = getPropSettings@Distance(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GlobalEfficiencyIn.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GlobalEfficiencyIn.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(GlobalEfficiencyIn, POINTER) returns the default value of POINTER of GlobalEfficiencyIn.
			%  DEFAULT = M.GETPROPDEFAULT(GlobalEfficiencyIn, POINTER) returns the default value of POINTER of GlobalEfficiencyIn.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('GlobalEfficiencyIn')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GlobalEfficiencyIn.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyIn.ELCLASS
					prop_default = 'GlobalEfficiencyIn';
				case GlobalEfficiencyIn.NAME
					prop_default = 'In-Global Efficiency';
				case GlobalEfficiencyIn.DESCRIPTION
					prop_default = 'The In-Global Efficiency (GlobalEfficiencyIn) is the average inverse shortest in-path length within each layer. It is inversely related to the characteristic in-path length.';
				case GlobalEfficiencyIn.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, GlobalEfficiencyIn.getPropSettings(prop));
				case GlobalEfficiencyIn.ID
					prop_default = 'GlobalEfficiencyIn ID';
				case GlobalEfficiencyIn.LABEL
					prop_default = 'In-Global Efficiency label';
				case GlobalEfficiencyIn.NOTES
					prop_default = 'In-Global Efficiency notes';
				case GlobalEfficiencyIn.SHAPE
					prop_default = Measure.NODAL;
				case GlobalEfficiencyIn.SCOPE
					prop_default = Measure.UNILAYER;
				case GlobalEfficiencyIn.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case GlobalEfficiencyIn.COMPATIBLE_GRAPHS
					prop_default = {'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD' 'OrdMxBD' 'OrdMxWD'};;
				otherwise
					prop_default = getPropDefault@Distance(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GlobalEfficiencyIn.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GlobalEfficiencyIn.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GlobalEfficiencyIn, POINTER) returns the conditioned default value of POINTER of GlobalEfficiencyIn.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(GlobalEfficiencyIn, POINTER) returns the conditioned default value of POINTER of GlobalEfficiencyIn.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('GlobalEfficiencyIn')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GlobalEfficiencyIn.getPropProp(pointer);
			
			prop_default = GlobalEfficiencyIn.conditioning(prop, GlobalEfficiencyIn.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GlobalEfficiencyIn, PROP, VALUE) checks VALUE format for PROP of GlobalEfficiencyIn.
			%  CHECK = M.CHECKPROP(GlobalEfficiencyIn, PROP, VALUE) checks VALUE format for PROP of GlobalEfficiencyIn.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GlobalEfficiencyIn:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:GlobalEfficiencyIn:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GlobalEfficiencyIn, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GlobalEfficiencyIn.
			%   Error id: €BRAPH2.STR€:GlobalEfficiencyIn:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(GlobalEfficiencyIn, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GlobalEfficiencyIn.
			%   Error id: €BRAPH2.STR€:GlobalEfficiencyIn:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('GlobalEfficiencyIn')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GlobalEfficiencyIn.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyIn.TEMPLATE % __GlobalEfficiencyIn.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, GlobalEfficiencyIn.getPropSettings(prop));
				otherwise
					if prop <= Distance.getPropNumber()
						check = checkProp@Distance(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GlobalEfficiencyIn.getPropTag(prop) ' (' GlobalEfficiencyIn.getFormatTag(GlobalEfficiencyIn.getPropFormat(prop)) ').'] ...
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
				case GlobalEfficiencyIn.M % __GlobalEfficiencyIn.M__
					rng_settings_ = rng(); rng(m.getPropSeed(GlobalEfficiencyIn.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					N = g.get('NODENUMBER');
					
					distance = calculateValue@Distance(m, prop);
					
					in_global_efficiency = cell(L, 1);
					parfor li = 1:1:L
					    inverse_distance = distance{li}.^-1;  % inverse distance
					    inverse_distance(1:N(li)+1:end) = 0;
					    global_efficiency_layer = (sum(inverse_distance, 1) / (N(li)-1));
					    in_global_efficiency(li) = {global_efficiency_layer};
					end
					value = in_global_efficiency;
					
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
