classdef GlobalEfficiencyOut < Distance
	%GlobalEfficiencyOut is the graph Out-Global Efficiency.
	% It is a subclass of <a href="matlab:help Distance">Distance</a>.
	%
	% The Out-Global Efficiency (GlobalEfficiencyOut) is the average inverse shortest in-path length within each layer. 
	% It is inversely related to the characteristic in-path length.
	%
	% GlobalEfficiencyOut methods (constructor):
	%  GlobalEfficiencyOut - constructor
	%
	% GlobalEfficiencyOut methods:
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
	% GlobalEfficiencyOut methods (display):
	%  tostring - string with information about the out-global efficiency
	%  disp - displays information about the out-global efficiency
	%  tree - displays the tree of the out-global efficiency
	%
	% GlobalEfficiencyOut methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two out-global efficiency are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the out-global efficiency
	%
	% GlobalEfficiencyOut methods (save/load, Static):
	%  save - saves BRAPH2 out-global efficiency as b2 file
	%  load - loads a BRAPH2 out-global efficiency from a b2 file
	%
	% GlobalEfficiencyOut method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the out-global efficiency
	%
	% GlobalEfficiencyOut method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the out-global efficiency
	%
	% GlobalEfficiencyOut methods (inspection, Static):
	%  getClass - returns the class of the out-global efficiency
	%  getSubclasses - returns all subclasses of GlobalEfficiencyOut
	%  getProps - returns the property list of the out-global efficiency
	%  getPropNumber - returns the property number of the out-global efficiency
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
	% GlobalEfficiencyOut methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GlobalEfficiencyOut methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GlobalEfficiencyOut methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GlobalEfficiencyOut methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GlobalEfficiencyOut; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GlobalEfficiencyOut constants</a>.
	%
	
	methods % constructor
		function m = GlobalEfficiencyOut(varargin)
			%GlobalEfficiencyOut() creates a out-global efficiency.
			%
			% GlobalEfficiencyOut(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GlobalEfficiencyOut(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the out-global efficiency.
			%
			% CLASS = GlobalEfficiencyOut.GETCLASS() returns the class 'GlobalEfficiencyOut'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the out-global efficiency M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('GlobalEfficiencyOut') returns 'GlobalEfficiencyOut'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('GlobalEfficiencyOut')
			%  are less computationally efficient.
			
			m_class = 'GlobalEfficiencyOut';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the out-global efficiency.
			%
			% LIST = GlobalEfficiencyOut.GETSUBCLASSES() returns all subclasses of 'GlobalEfficiencyOut'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the out-global efficiency M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('GlobalEfficiencyOut') returns all subclasses of 'GlobalEfficiencyOut'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('GlobalEfficiencyOut')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GlobalEfficiencyOut', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of out-global efficiency.
			%
			% PROPS = GlobalEfficiencyOut.GETPROPS() returns the property list of out-global efficiency
			%  as a row vector.
			%
			% PROPS = GlobalEfficiencyOut.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the out-global efficiency M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('GlobalEfficiencyOut'[, CATEGORY]) returns the property list of 'GlobalEfficiencyOut'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('GlobalEfficiencyOut')
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
			%GETPROPNUMBER returns the property number of out-global efficiency.
			%
			% N = GlobalEfficiencyOut.GETPROPNUMBER() returns the property number of out-global efficiency.
			%
			% N = GlobalEfficiencyOut.GETPROPNUMBER(CATEGORY) returns the property number of out-global efficiency
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the out-global efficiency M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('GlobalEfficiencyOut') returns the property number of 'GlobalEfficiencyOut'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('GlobalEfficiencyOut')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GlobalEfficiencyOut.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in out-global efficiency/error.
			%
			% CHECK = GlobalEfficiencyOut.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(GlobalEfficiencyOut, PROP) checks whether PROP exists for GlobalEfficiencyOut.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GlobalEfficiencyOut:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyOut:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyOut:WrongInput]
			%  Element.EXISTSPROP(GlobalEfficiencyOut, PROP) throws error if PROP does NOT exist for GlobalEfficiencyOut.
			%   Error id: [BRAPH2:GlobalEfficiencyOut:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('GlobalEfficiencyOut')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GlobalEfficiencyOut.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GlobalEfficiencyOut:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GlobalEfficiencyOut:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GlobalEfficiencyOut.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in out-global efficiency/error.
			%
			% CHECK = GlobalEfficiencyOut.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(GlobalEfficiencyOut, TAG) checks whether TAG exists for GlobalEfficiencyOut.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GlobalEfficiencyOut:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyOut:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyOut:WrongInput]
			%  Element.EXISTSTAG(GlobalEfficiencyOut, TAG) throws error if TAG does NOT exist for GlobalEfficiencyOut.
			%   Error id: [BRAPH2:GlobalEfficiencyOut:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('GlobalEfficiencyOut')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			globalefficiencyout_tag_list = cellfun(@(x) GlobalEfficiencyOut.getPropTag(x), num2cell(GlobalEfficiencyOut.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, globalefficiencyout_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GlobalEfficiencyOut:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GlobalEfficiencyOut:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GlobalEfficiencyOut.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GlobalEfficiencyOut, POINTER) returns property number of POINTER of GlobalEfficiencyOut.
			%  PROPERTY = M.GETPROPPROP(GlobalEfficiencyOut, POINTER) returns property number of POINTER of GlobalEfficiencyOut.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('GlobalEfficiencyOut')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				globalefficiencyout_tag_list = cellfun(@(x) GlobalEfficiencyOut.getPropTag(x), num2cell(GlobalEfficiencyOut.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, globalefficiencyout_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GlobalEfficiencyOut, POINTER) returns tag of POINTER of GlobalEfficiencyOut.
			%  TAG = M.GETPROPTAG(GlobalEfficiencyOut, POINTER) returns tag of POINTER of GlobalEfficiencyOut.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('GlobalEfficiencyOut')
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
			%  CATEGORY = Element.GETPROPCATEGORY(GlobalEfficiencyOut, POINTER) returns category of POINTER of GlobalEfficiencyOut.
			%  CATEGORY = M.GETPROPCATEGORY(GlobalEfficiencyOut, POINTER) returns category of POINTER of GlobalEfficiencyOut.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('GlobalEfficiencyOut')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyOut.getPropProp(pointer);
			
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
			%  FORMAT = Element.GETPROPFORMAT(GlobalEfficiencyOut, POINTER) returns format of POINTER of GlobalEfficiencyOut.
			%  FORMAT = M.GETPROPFORMAT(GlobalEfficiencyOut, POINTER) returns format of POINTER of GlobalEfficiencyOut.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('GlobalEfficiencyOut')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyOut.getPropProp(pointer);
			
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GlobalEfficiencyOut, POINTER) returns description of POINTER of GlobalEfficiencyOut.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(GlobalEfficiencyOut, POINTER) returns description of POINTER of GlobalEfficiencyOut.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('GlobalEfficiencyOut')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyOut.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyOut.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Out-Global Efficiency.';
				case GlobalEfficiencyOut.NAME
					prop_description = 'NAME (constant, string) is the name of the Out-Global Efficiency.';
				case GlobalEfficiencyOut.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Out-Global Efficiency.';
				case GlobalEfficiencyOut.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Out-Global Efficiency.';
				case GlobalEfficiencyOut.ID
					prop_description = 'ID (data, string) is a few-letter code of the Out-Global Efficiency.';
				case GlobalEfficiencyOut.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Out-Global Efficiency.';
				case GlobalEfficiencyOut.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Out-Global Efficiency.';
				case GlobalEfficiencyOut.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case GlobalEfficiencyOut.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case GlobalEfficiencyOut.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case GlobalEfficiencyOut.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case GlobalEfficiencyOut.M
					prop_description = 'M (result, cell) is the Out-Global Efficiency.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(GlobalEfficiencyOut, POINTER) returns settings of POINTER of GlobalEfficiencyOut.
			%  SETTINGS = M.GETPROPSETTINGS(GlobalEfficiencyOut, POINTER) returns settings of POINTER of GlobalEfficiencyOut.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('GlobalEfficiencyOut')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyOut.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyOut.TEMPLATE
					prop_settings = 'GlobalEfficiencyOut';
				otherwise
					prop_settings = getPropSettings@Distance(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GlobalEfficiencyOut.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GlobalEfficiencyOut.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(GlobalEfficiencyOut, POINTER) returns the default value of POINTER of GlobalEfficiencyOut.
			%  DEFAULT = M.GETPROPDEFAULT(GlobalEfficiencyOut, POINTER) returns the default value of POINTER of GlobalEfficiencyOut.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('GlobalEfficiencyOut')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GlobalEfficiencyOut.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyOut.ELCLASS
					prop_default = 'GlobalEfficiencyOut';
				case GlobalEfficiencyOut.NAME
					prop_default = 'GlobalEfficiencyOut';
				case GlobalEfficiencyOut.DESCRIPTION
					prop_default = 'The Out-Global Efficiency (GlobalEfficiencyOut) is the average inverse shortest out-path length within each layer. It is inversely related to the characteristic out-path length.';
				case GlobalEfficiencyOut.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, GlobalEfficiencyOut.getPropSettings(prop));
				case GlobalEfficiencyOut.ID
					prop_default = 'GlobalEfficiencyOut ID';
				case GlobalEfficiencyOut.LABEL
					prop_default = 'Out-Global Efficiency label';
				case GlobalEfficiencyOut.NOTES
					prop_default = 'Out-Global Efficiency notes';
				case GlobalEfficiencyOut.SHAPE
					prop_default = Measure.NODAL;
				case GlobalEfficiencyOut.SCOPE
					prop_default = Measure.UNILAYER;
				case GlobalEfficiencyOut.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case GlobalEfficiencyOut.COMPATIBLE_GRAPHS
					prop_default = {'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD' 'OrdMxBD' 'OrdMxWD'};;
				otherwise
					prop_default = getPropDefault@Distance(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GlobalEfficiencyOut.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GlobalEfficiencyOut.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GlobalEfficiencyOut, POINTER) returns the conditioned default value of POINTER of GlobalEfficiencyOut.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(GlobalEfficiencyOut, POINTER) returns the conditioned default value of POINTER of GlobalEfficiencyOut.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('GlobalEfficiencyOut')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GlobalEfficiencyOut.getPropProp(pointer);
			
			prop_default = GlobalEfficiencyOut.conditioning(prop, GlobalEfficiencyOut.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GlobalEfficiencyOut, PROP, VALUE) checks VALUE format for PROP of GlobalEfficiencyOut.
			%  CHECK = M.CHECKPROP(GlobalEfficiencyOut, PROP, VALUE) checks VALUE format for PROP of GlobalEfficiencyOut.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GlobalEfficiencyOut:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:GlobalEfficiencyOut:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GlobalEfficiencyOut, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GlobalEfficiencyOut.
			%   Error id: €BRAPH2.STR€:GlobalEfficiencyOut:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(GlobalEfficiencyOut, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GlobalEfficiencyOut.
			%   Error id: €BRAPH2.STR€:GlobalEfficiencyOut:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('GlobalEfficiencyOut')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GlobalEfficiencyOut.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyOut.TEMPLATE % __GlobalEfficiencyOut.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, GlobalEfficiencyOut.getPropSettings(prop));
				otherwise
					if prop <= Distance.getPropNumber()
						check = checkProp@Distance(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GlobalEfficiencyOut:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GlobalEfficiencyOut:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GlobalEfficiencyOut.getPropTag(prop) ' (' GlobalEfficiencyOut.getFormatTag(GlobalEfficiencyOut.getPropFormat(prop)) ').'] ...
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
				case GlobalEfficiencyOut.M % __GlobalEfficiencyOut.M__
					rng_settings_ = rng(); rng(m.getPropSeed(GlobalEfficiencyOut.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					N = g.get('NODENUMBER');
					
					distance = calculateValue@Distance(m, prop);
					
					out_global_efficiency = cell(L, 1);
					parfor li = 1:1:L
					    inverse_distance = distance{li}.^-1;  % inverse distance
					    inverse_distance(1:N(li)+1:end) = 0;
					    global_efficiency_layer = (sum(inverse_distance, 2) / (N(li)-1));
					    out_global_efficiency(li) = {global_efficiency_layer};
					end
					value = out_global_efficiency;
					
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
