classdef GlobalEfficiencyOutAv < GlobalEfficiencyOut
	%GlobalEfficiencyOutAv is the graph Average Out-Global Efficiency.
	% It is a subclass of <a href="matlab:help GlobalEfficiencyOut">GlobalEfficiencyOut</a>.
	%
	% The Average Out-Global Efficiency (GlobalEfficiencyOutAv) is the average inverse shortest out-path length within each layer.
	%
	% GlobalEfficiencyOutAv methods (constructor):
	%  GlobalEfficiencyOutAv - constructor
	%
	% GlobalEfficiencyOutAv methods:
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
	% GlobalEfficiencyOutAv methods (display):
	%  tostring - string with information about the average out-global efficiency
	%  disp - displays information about the average out-global efficiency
	%  tree - displays the tree of the average out-global efficiency
	%
	% GlobalEfficiencyOutAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average out-global efficiency are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average out-global efficiency
	%
	% GlobalEfficiencyOutAv methods (save/load, Static):
	%  save - saves BRAPH2 average out-global efficiency as b2 file
	%  load - loads a BRAPH2 average out-global efficiency from a b2 file
	%
	% GlobalEfficiencyOutAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average out-global efficiency
	%
	% GlobalEfficiencyOutAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average out-global efficiency
	%
	% GlobalEfficiencyOutAv methods (inspection, Static):
	%  getClass - returns the class of the average out-global efficiency
	%  getSubclasses - returns all subclasses of GlobalEfficiencyOutAv
	%  getProps - returns the property list of the average out-global efficiency
	%  getPropNumber - returns the property number of the average out-global efficiency
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
	% GlobalEfficiencyOutAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GlobalEfficiencyOutAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GlobalEfficiencyOutAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GlobalEfficiencyOutAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GlobalEfficiencyOutAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GlobalEfficiencyOutAv constants</a>.
	%
	
	methods % constructor
		function m = GlobalEfficiencyOutAv(varargin)
			%GlobalEfficiencyOutAv() creates a average out-global efficiency.
			%
			% GlobalEfficiencyOutAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GlobalEfficiencyOutAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@GlobalEfficiencyOut(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the average out-global efficiency.
			%
			% CLASS = GlobalEfficiencyOutAv.GETCLASS() returns the class 'GlobalEfficiencyOutAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average out-global efficiency M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('GlobalEfficiencyOutAv') returns 'GlobalEfficiencyOutAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('GlobalEfficiencyOutAv')
			%  are less computationally efficient.
			
			m_class = 'GlobalEfficiencyOutAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average out-global efficiency.
			%
			% LIST = GlobalEfficiencyOutAv.GETSUBCLASSES() returns all subclasses of 'GlobalEfficiencyOutAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average out-global efficiency M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('GlobalEfficiencyOutAv') returns all subclasses of 'GlobalEfficiencyOutAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('GlobalEfficiencyOutAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GlobalEfficiencyOutAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average out-global efficiency.
			%
			% PROPS = GlobalEfficiencyOutAv.GETPROPS() returns the property list of average out-global efficiency
			%  as a row vector.
			%
			% PROPS = GlobalEfficiencyOutAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average out-global efficiency M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('GlobalEfficiencyOutAv'[, CATEGORY]) returns the property list of 'GlobalEfficiencyOutAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('GlobalEfficiencyOutAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					GlobalEfficiencyOut.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						GlobalEfficiencyOut.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						GlobalEfficiencyOut.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						GlobalEfficiencyOut.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						GlobalEfficiencyOut.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						GlobalEfficiencyOut.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						GlobalEfficiencyOut.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						GlobalEfficiencyOut.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						GlobalEfficiencyOut.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						GlobalEfficiencyOut.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of average out-global efficiency.
			%
			% N = GlobalEfficiencyOutAv.GETPROPNUMBER() returns the property number of average out-global efficiency.
			%
			% N = GlobalEfficiencyOutAv.GETPROPNUMBER(CATEGORY) returns the property number of average out-global efficiency
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average out-global efficiency M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('GlobalEfficiencyOutAv') returns the property number of 'GlobalEfficiencyOutAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('GlobalEfficiencyOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GlobalEfficiencyOutAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in average out-global efficiency/error.
			%
			% CHECK = GlobalEfficiencyOutAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(GlobalEfficiencyOutAv, PROP) checks whether PROP exists for GlobalEfficiencyOutAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GlobalEfficiencyOutAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyOutAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyOutAv:WrongInput]
			%  Element.EXISTSPROP(GlobalEfficiencyOutAv, PROP) throws error if PROP does NOT exist for GlobalEfficiencyOutAv.
			%   Error id: [BRAPH2:GlobalEfficiencyOutAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('GlobalEfficiencyOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GlobalEfficiencyOutAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GlobalEfficiencyOutAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GlobalEfficiencyOutAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GlobalEfficiencyOutAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average out-global efficiency/error.
			%
			% CHECK = GlobalEfficiencyOutAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(GlobalEfficiencyOutAv, TAG) checks whether TAG exists for GlobalEfficiencyOutAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GlobalEfficiencyOutAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyOutAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyOutAv:WrongInput]
			%  Element.EXISTSTAG(GlobalEfficiencyOutAv, TAG) throws error if TAG does NOT exist for GlobalEfficiencyOutAv.
			%   Error id: [BRAPH2:GlobalEfficiencyOutAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('GlobalEfficiencyOutAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			globalefficiencyoutav_tag_list = cellfun(@(x) GlobalEfficiencyOutAv.getPropTag(x), num2cell(GlobalEfficiencyOutAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, globalefficiencyoutav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GlobalEfficiencyOutAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GlobalEfficiencyOutAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GlobalEfficiencyOutAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GlobalEfficiencyOutAv, POINTER) returns property number of POINTER of GlobalEfficiencyOutAv.
			%  PROPERTY = M.GETPROPPROP(GlobalEfficiencyOutAv, POINTER) returns property number of POINTER of GlobalEfficiencyOutAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('GlobalEfficiencyOutAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				globalefficiencyoutav_tag_list = cellfun(@(x) GlobalEfficiencyOutAv.getPropTag(x), num2cell(GlobalEfficiencyOutAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, globalefficiencyoutav_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GlobalEfficiencyOutAv, POINTER) returns tag of POINTER of GlobalEfficiencyOutAv.
			%  TAG = M.GETPROPTAG(GlobalEfficiencyOutAv, POINTER) returns tag of POINTER of GlobalEfficiencyOutAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('GlobalEfficiencyOutAv')
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
						tag = getPropTag@GlobalEfficiencyOut(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(GlobalEfficiencyOutAv, POINTER) returns category of POINTER of GlobalEfficiencyOutAv.
			%  CATEGORY = M.GETPROPCATEGORY(GlobalEfficiencyOutAv, POINTER) returns category of POINTER of GlobalEfficiencyOutAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('GlobalEfficiencyOutAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyOutAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@GlobalEfficiencyOut(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(GlobalEfficiencyOutAv, POINTER) returns format of POINTER of GlobalEfficiencyOutAv.
			%  FORMAT = M.GETPROPFORMAT(GlobalEfficiencyOutAv, POINTER) returns format of POINTER of GlobalEfficiencyOutAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('GlobalEfficiencyOutAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyOutAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@GlobalEfficiencyOut(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GlobalEfficiencyOutAv, POINTER) returns description of POINTER of GlobalEfficiencyOutAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(GlobalEfficiencyOutAv, POINTER) returns description of POINTER of GlobalEfficiencyOutAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('GlobalEfficiencyOutAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyOutAv.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyOutAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Average Out-Global Efficiency.';
				case GlobalEfficiencyOutAv.NAME
					prop_description = 'NAME (constant, string) is the name of the Average Out-Global Efficiency.';
				case GlobalEfficiencyOutAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Average Out-Global Efficiency.';
				case GlobalEfficiencyOutAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Average Out-Global Efficiency.';
				case GlobalEfficiencyOutAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the Average Out-Global Efficiency.';
				case GlobalEfficiencyOutAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Average Out-Global Efficiency.';
				case GlobalEfficiencyOutAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Average Out-Global Efficiency.';
				case GlobalEfficiencyOutAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.';
				case GlobalEfficiencyOutAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case GlobalEfficiencyOutAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case GlobalEfficiencyOutAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case GlobalEfficiencyOutAv.M
					prop_description = 'M (result, cell) is the Average Out-Global Efficiency.';
				otherwise
					prop_description = getPropDescription@GlobalEfficiencyOut(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(GlobalEfficiencyOutAv, POINTER) returns settings of POINTER of GlobalEfficiencyOutAv.
			%  SETTINGS = M.GETPROPSETTINGS(GlobalEfficiencyOutAv, POINTER) returns settings of POINTER of GlobalEfficiencyOutAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('GlobalEfficiencyOutAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyOutAv.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyOutAv.TEMPLATE
					prop_settings = 'GlobalEfficiencyOutAv';
				otherwise
					prop_settings = getPropSettings@GlobalEfficiencyOut(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GlobalEfficiencyOutAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GlobalEfficiencyOutAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(GlobalEfficiencyOutAv, POINTER) returns the default value of POINTER of GlobalEfficiencyOutAv.
			%  DEFAULT = M.GETPROPDEFAULT(GlobalEfficiencyOutAv, POINTER) returns the default value of POINTER of GlobalEfficiencyOutAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('GlobalEfficiencyOutAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GlobalEfficiencyOutAv.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyOutAv.ELCLASS
					prop_default = 'GlobalEfficiencyOutAv';
				case GlobalEfficiencyOutAv.NAME
					prop_default = 'Average Out-Global Efficiency';
				case GlobalEfficiencyOutAv.DESCRIPTION
					prop_default = 'The Average Out-Global Efficiency (GlobalEfficiencyOutAv) is the average inverse shortest out-path length within each layer.';
				case GlobalEfficiencyOutAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, GlobalEfficiencyOutAv.getPropSettings(prop));
				case GlobalEfficiencyOutAv.ID
					prop_default = 'GlobalEfficiencyOutAv ID';
				case GlobalEfficiencyOutAv.LABEL
					prop_default = 'Average Out-Global Efficiency label';
				case GlobalEfficiencyOutAv.NOTES
					prop_default = 'Average Out-Global Efficiency notes';
				case GlobalEfficiencyOutAv.SHAPE
					prop_default = Measure.GLOBAL;
				case GlobalEfficiencyOutAv.SCOPE
					prop_default = Measure.UNILAYER;
				case GlobalEfficiencyOutAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case GlobalEfficiencyOutAv.COMPATIBLE_GRAPHS
					prop_default = {'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD' 'OrdMxBD' 'OrdMxWD'};;
				otherwise
					prop_default = getPropDefault@GlobalEfficiencyOut(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GlobalEfficiencyOutAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GlobalEfficiencyOutAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GlobalEfficiencyOutAv, POINTER) returns the conditioned default value of POINTER of GlobalEfficiencyOutAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(GlobalEfficiencyOutAv, POINTER) returns the conditioned default value of POINTER of GlobalEfficiencyOutAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('GlobalEfficiencyOutAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GlobalEfficiencyOutAv.getPropProp(pointer);
			
			prop_default = GlobalEfficiencyOutAv.conditioning(prop, GlobalEfficiencyOutAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GlobalEfficiencyOutAv, PROP, VALUE) checks VALUE format for PROP of GlobalEfficiencyOutAv.
			%  CHECK = M.CHECKPROP(GlobalEfficiencyOutAv, PROP, VALUE) checks VALUE format for PROP of GlobalEfficiencyOutAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GlobalEfficiencyOutAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:GlobalEfficiencyOutAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GlobalEfficiencyOutAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GlobalEfficiencyOutAv.
			%   Error id: €BRAPH2.STR€:GlobalEfficiencyOutAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(GlobalEfficiencyOutAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GlobalEfficiencyOutAv.
			%   Error id: €BRAPH2.STR€:GlobalEfficiencyOutAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('GlobalEfficiencyOutAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GlobalEfficiencyOutAv.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyOutAv.TEMPLATE % __GlobalEfficiencyOutAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, GlobalEfficiencyOutAv.getPropSettings(prop));
				otherwise
					if prop <= GlobalEfficiencyOut.getPropNumber()
						check = checkProp@GlobalEfficiencyOut(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GlobalEfficiencyOutAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GlobalEfficiencyOutAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GlobalEfficiencyOutAv.getPropTag(prop) ' (' GlobalEfficiencyOutAv.getFormatTag(GlobalEfficiencyOutAv.getPropFormat(prop)) ').'] ...
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
				case GlobalEfficiencyOutAv.M % __GlobalEfficiencyOutAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(GlobalEfficiencyOutAv.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					L = g.get('LAYERNUMBER');
					
					out_global_efficiency = calculateValue@GlobalEfficiencyOut(m, prop);
					
					out_global_efficiency_av = cell(L, 1);
					parfor li = 1:1:L
					    out_global_efficiency_av(li) = {mean(out_global_efficiency{li})};
					end
					value = out_global_efficiency_av;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= GlobalEfficiencyOut.getPropNumber()
						value = calculateValue@GlobalEfficiencyOut(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
