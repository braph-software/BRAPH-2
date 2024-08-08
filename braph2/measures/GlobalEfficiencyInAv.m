classdef GlobalEfficiencyInAv < GlobalEfficiencyIn
	%GlobalEfficiencyInAv is the graph Average In-Global Efficiency.
	% It is a subclass of <a href="matlab:help GlobalEfficiencyIn">GlobalEfficiencyIn</a>.
	%
	% The Average In-Global Efficiency (GlobalEfficiencyInAv) is the average inverse shortest in-path length within each layer.
	%
	% GlobalEfficiencyInAv methods (constructor):
	%  GlobalEfficiencyInAv - constructor
	%
	% GlobalEfficiencyInAv methods:
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
	% GlobalEfficiencyInAv methods (display):
	%  tostring - string with information about the average in-global efficiency
	%  disp - displays information about the average in-global efficiency
	%  tree - displays the tree of the average in-global efficiency
	%
	% GlobalEfficiencyInAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average in-global efficiency are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average in-global efficiency
	%
	% GlobalEfficiencyInAv methods (save/load, Static):
	%  save - saves BRAPH2 average in-global efficiency as b2 file
	%  load - loads a BRAPH2 average in-global efficiency from a b2 file
	%
	% GlobalEfficiencyInAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average in-global efficiency
	%
	% GlobalEfficiencyInAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average in-global efficiency
	%
	% GlobalEfficiencyInAv methods (inspection, Static):
	%  getClass - returns the class of the average in-global efficiency
	%  getSubclasses - returns all subclasses of GlobalEfficiencyInAv
	%  getProps - returns the property list of the average in-global efficiency
	%  getPropNumber - returns the property number of the average in-global efficiency
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
	% GlobalEfficiencyInAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GlobalEfficiencyInAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GlobalEfficiencyInAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GlobalEfficiencyInAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GlobalEfficiencyInAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GlobalEfficiencyInAv constants</a>.
	%
	
	methods % constructor
		function m = GlobalEfficiencyInAv(varargin)
			%GlobalEfficiencyInAv() creates a average in-global efficiency.
			%
			% GlobalEfficiencyInAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GlobalEfficiencyInAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@GlobalEfficiencyIn(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the average in-global efficiency.
			%
			% CLASS = GlobalEfficiencyInAv.GETCLASS() returns the class 'GlobalEfficiencyInAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average in-global efficiency M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('GlobalEfficiencyInAv') returns 'GlobalEfficiencyInAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('GlobalEfficiencyInAv')
			%  are less computationally efficient.
			
			m_class = 'GlobalEfficiencyInAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average in-global efficiency.
			%
			% LIST = GlobalEfficiencyInAv.GETSUBCLASSES() returns all subclasses of 'GlobalEfficiencyInAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average in-global efficiency M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('GlobalEfficiencyInAv') returns all subclasses of 'GlobalEfficiencyInAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('GlobalEfficiencyInAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GlobalEfficiencyInAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average in-global efficiency.
			%
			% PROPS = GlobalEfficiencyInAv.GETPROPS() returns the property list of average in-global efficiency
			%  as a row vector.
			%
			% PROPS = GlobalEfficiencyInAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average in-global efficiency M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('GlobalEfficiencyInAv'[, CATEGORY]) returns the property list of 'GlobalEfficiencyInAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('GlobalEfficiencyInAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					GlobalEfficiencyIn.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						GlobalEfficiencyIn.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						GlobalEfficiencyIn.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						GlobalEfficiencyIn.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						GlobalEfficiencyIn.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						GlobalEfficiencyIn.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						GlobalEfficiencyIn.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						GlobalEfficiencyIn.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						GlobalEfficiencyIn.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						GlobalEfficiencyIn.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of average in-global efficiency.
			%
			% N = GlobalEfficiencyInAv.GETPROPNUMBER() returns the property number of average in-global efficiency.
			%
			% N = GlobalEfficiencyInAv.GETPROPNUMBER(CATEGORY) returns the property number of average in-global efficiency
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average in-global efficiency M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('GlobalEfficiencyInAv') returns the property number of 'GlobalEfficiencyInAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('GlobalEfficiencyInAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GlobalEfficiencyInAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in average in-global efficiency/error.
			%
			% CHECK = GlobalEfficiencyInAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(GlobalEfficiencyInAv, PROP) checks whether PROP exists for GlobalEfficiencyInAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GlobalEfficiencyInAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyInAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyInAv:WrongInput]
			%  Element.EXISTSPROP(GlobalEfficiencyInAv, PROP) throws error if PROP does NOT exist for GlobalEfficiencyInAv.
			%   Error id: [BRAPH2:GlobalEfficiencyInAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('GlobalEfficiencyInAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GlobalEfficiencyInAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GlobalEfficiencyInAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GlobalEfficiencyInAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GlobalEfficiencyInAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average in-global efficiency/error.
			%
			% CHECK = GlobalEfficiencyInAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(GlobalEfficiencyInAv, TAG) checks whether TAG exists for GlobalEfficiencyInAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GlobalEfficiencyInAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyInAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyInAv:WrongInput]
			%  Element.EXISTSTAG(GlobalEfficiencyInAv, TAG) throws error if TAG does NOT exist for GlobalEfficiencyInAv.
			%   Error id: [BRAPH2:GlobalEfficiencyInAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('GlobalEfficiencyInAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			globalefficiencyinav_tag_list = cellfun(@(x) GlobalEfficiencyInAv.getPropTag(x), num2cell(GlobalEfficiencyInAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, globalefficiencyinav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GlobalEfficiencyInAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GlobalEfficiencyInAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GlobalEfficiencyInAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GlobalEfficiencyInAv, POINTER) returns property number of POINTER of GlobalEfficiencyInAv.
			%  PROPERTY = M.GETPROPPROP(GlobalEfficiencyInAv, POINTER) returns property number of POINTER of GlobalEfficiencyInAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('GlobalEfficiencyInAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				globalefficiencyinav_tag_list = cellfun(@(x) GlobalEfficiencyInAv.getPropTag(x), num2cell(GlobalEfficiencyInAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, globalefficiencyinav_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GlobalEfficiencyInAv, POINTER) returns tag of POINTER of GlobalEfficiencyInAv.
			%  TAG = M.GETPROPTAG(GlobalEfficiencyInAv, POINTER) returns tag of POINTER of GlobalEfficiencyInAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('GlobalEfficiencyInAv')
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
						tag = getPropTag@GlobalEfficiencyIn(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(GlobalEfficiencyInAv, POINTER) returns category of POINTER of GlobalEfficiencyInAv.
			%  CATEGORY = M.GETPROPCATEGORY(GlobalEfficiencyInAv, POINTER) returns category of POINTER of GlobalEfficiencyInAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('GlobalEfficiencyInAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyInAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@GlobalEfficiencyIn(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(GlobalEfficiencyInAv, POINTER) returns format of POINTER of GlobalEfficiencyInAv.
			%  FORMAT = M.GETPROPFORMAT(GlobalEfficiencyInAv, POINTER) returns format of POINTER of GlobalEfficiencyInAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('GlobalEfficiencyInAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyInAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@GlobalEfficiencyIn(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GlobalEfficiencyInAv, POINTER) returns description of POINTER of GlobalEfficiencyInAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(GlobalEfficiencyInAv, POINTER) returns description of POINTER of GlobalEfficiencyInAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('GlobalEfficiencyInAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyInAv.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyInAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the graph Average In-Global Efficiency.';
				case GlobalEfficiencyInAv.NAME
					prop_description = 'NAME (constant, string) is the name of the graph Average In-Global Efficiency.';
				case GlobalEfficiencyInAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the graph Average In-Global Efficiency.';
				case GlobalEfficiencyInAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the graph Average In-Global Efficiency.';
				case GlobalEfficiencyInAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the graph Average In-Global Efficiency.';
				case GlobalEfficiencyInAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the graph Average In-Global Efficiency.';
				case GlobalEfficiencyInAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the graph Average In-Global Efficiency.';
				case GlobalEfficiencyInAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.';
				case GlobalEfficiencyInAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case GlobalEfficiencyInAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case GlobalEfficiencyInAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case GlobalEfficiencyInAv.M
					prop_description = 'M (result, cell) is the Average In-Global Efficiency.';
				otherwise
					prop_description = getPropDescription@GlobalEfficiencyIn(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(GlobalEfficiencyInAv, POINTER) returns settings of POINTER of GlobalEfficiencyInAv.
			%  SETTINGS = M.GETPROPSETTINGS(GlobalEfficiencyInAv, POINTER) returns settings of POINTER of GlobalEfficiencyInAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('GlobalEfficiencyInAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyInAv.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyInAv.TEMPLATE
					prop_settings = 'GlobalEfficiencyInAv';
				otherwise
					prop_settings = getPropSettings@GlobalEfficiencyIn(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GlobalEfficiencyInAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GlobalEfficiencyInAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(GlobalEfficiencyInAv, POINTER) returns the default value of POINTER of GlobalEfficiencyInAv.
			%  DEFAULT = M.GETPROPDEFAULT(GlobalEfficiencyInAv, POINTER) returns the default value of POINTER of GlobalEfficiencyInAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('GlobalEfficiencyInAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GlobalEfficiencyInAv.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyInAv.ELCLASS
					prop_default = 'GlobalEfficiencyInAv';
				case GlobalEfficiencyInAv.NAME
					prop_default = 'Average In-Global Efficiency';
				case GlobalEfficiencyInAv.DESCRIPTION
					prop_default = 'The Average In-Global Efficiency (GlobalEfficiencyInAv) is the average inverse shortest in-path length within each layer.';
				case GlobalEfficiencyInAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, GlobalEfficiencyInAv.getPropSettings(prop));
				case GlobalEfficiencyInAv.ID
					prop_default = 'GlobalEfficiencyInAv ID';
				case GlobalEfficiencyInAv.LABEL
					prop_default = 'Average In-Global Efficiency label';
				case GlobalEfficiencyInAv.NOTES
					prop_default = 'Average In-Global Efficiency notes';
				case GlobalEfficiencyInAv.SHAPE
					prop_default = Measure.GLOBAL;
				case GlobalEfficiencyInAv.SCOPE
					prop_default = Measure.UNILAYER;
				case GlobalEfficiencyInAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case GlobalEfficiencyInAv.COMPATIBLE_GRAPHS
					prop_default = {'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD' 'OrdMxBD' 'OrdMxWD'};;
				otherwise
					prop_default = getPropDefault@GlobalEfficiencyIn(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GlobalEfficiencyInAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GlobalEfficiencyInAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GlobalEfficiencyInAv, POINTER) returns the conditioned default value of POINTER of GlobalEfficiencyInAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(GlobalEfficiencyInAv, POINTER) returns the conditioned default value of POINTER of GlobalEfficiencyInAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('GlobalEfficiencyInAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GlobalEfficiencyInAv.getPropProp(pointer);
			
			prop_default = GlobalEfficiencyInAv.conditioning(prop, GlobalEfficiencyInAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GlobalEfficiencyInAv, PROP, VALUE) checks VALUE format for PROP of GlobalEfficiencyInAv.
			%  CHECK = M.CHECKPROP(GlobalEfficiencyInAv, PROP, VALUE) checks VALUE format for PROP of GlobalEfficiencyInAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GlobalEfficiencyInAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:GlobalEfficiencyInAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GlobalEfficiencyInAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GlobalEfficiencyInAv.
			%   Error id: €BRAPH2.STR€:GlobalEfficiencyInAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(GlobalEfficiencyInAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GlobalEfficiencyInAv.
			%   Error id: €BRAPH2.STR€:GlobalEfficiencyInAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('GlobalEfficiencyInAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GlobalEfficiencyInAv.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyInAv.TEMPLATE % __GlobalEfficiencyInAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, GlobalEfficiencyInAv.getPropSettings(prop));
				otherwise
					if prop <= GlobalEfficiencyIn.getPropNumber()
						check = checkProp@GlobalEfficiencyIn(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GlobalEfficiencyInAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GlobalEfficiencyInAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GlobalEfficiencyInAv.getPropTag(prop) ' (' GlobalEfficiencyInAv.getFormatTag(GlobalEfficiencyInAv.getPropFormat(prop)) ').'] ...
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
				case GlobalEfficiencyInAv.M % __GlobalEfficiencyInAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(GlobalEfficiencyInAv.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					L = g.get('LAYERNUMBER');
					
					in_global_efficiency = calculateValue@GlobalEfficiencyIn(m, prop);
					
					in_global_efficiency_av = cell(L, 1);
					parfor li = 1:1:L
					    in_global_efficiency_av(li) = {mean(in_global_efficiency{li})};
					end
					value = in_global_efficiency_av;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= GlobalEfficiencyIn.getPropNumber()
						value = calculateValue@GlobalEfficiencyIn(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
