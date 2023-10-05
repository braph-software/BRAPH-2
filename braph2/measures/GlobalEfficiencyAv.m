classdef GlobalEfficiencyAv < GlobalEfficiency
	%GlobalEfficiencyAv is the graph Average Global Efficiency.
	% It is a subclass of <a href="matlab:help GlobalEfficiency">GlobalEfficiency</a>.
	%
	% The Average Global Efficiency (GlobalEfficiencyAv) is the average of the 
	% global efficiency within each layer.
	%
	% GlobalEfficiencyAv methods (constructor):
	%  GlobalEfficiencyAv - constructor
	%
	% GlobalEfficiencyAv methods:
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
	% GlobalEfficiencyAv methods (display):
	%  tostring - string with information about the average global efficiency
	%  disp - displays information about the average global efficiency
	%  tree - displays the tree of the average global efficiency
	%
	% GlobalEfficiencyAv methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two average global efficiency are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the average global efficiency
	%
	% GlobalEfficiencyAv methods (save/load, Static):
	%  save - saves BRAPH2 average global efficiency as b2 file
	%  load - loads a BRAPH2 average global efficiency from a b2 file
	%
	% GlobalEfficiencyAv method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the average global efficiency
	%
	% GlobalEfficiencyAv method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the average global efficiency
	%
	% GlobalEfficiencyAv methods (inspection, Static):
	%  getClass - returns the class of the average global efficiency
	%  getSubclasses - returns all subclasses of GlobalEfficiencyAv
	%  getProps - returns the property list of the average global efficiency
	%  getPropNumber - returns the property number of the average global efficiency
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
	% GlobalEfficiencyAv methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% GlobalEfficiencyAv methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% GlobalEfficiencyAv methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% GlobalEfficiencyAv methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?GlobalEfficiencyAv; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">GlobalEfficiencyAv constants</a>.
	%
	
	methods % constructor
		function m = GlobalEfficiencyAv(varargin)
			%GlobalEfficiencyAv() creates a average global efficiency.
			%
			% GlobalEfficiencyAv(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% GlobalEfficiencyAv(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@GlobalEfficiency(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the average global efficiency.
			%
			% CLASS = GlobalEfficiencyAv.GETCLASS() returns the class 'GlobalEfficiencyAv'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the average global efficiency M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('GlobalEfficiencyAv') returns 'GlobalEfficiencyAv'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('GlobalEfficiencyAv')
			%  are less computationally efficient.
			
			m_class = 'GlobalEfficiencyAv';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the average global efficiency.
			%
			% LIST = GlobalEfficiencyAv.GETSUBCLASSES() returns all subclasses of 'GlobalEfficiencyAv'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the average global efficiency M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('GlobalEfficiencyAv') returns all subclasses of 'GlobalEfficiencyAv'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('GlobalEfficiencyAv')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('GlobalEfficiencyAv', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of average global efficiency.
			%
			% PROPS = GlobalEfficiencyAv.GETPROPS() returns the property list of average global efficiency
			%  as a row vector.
			%
			% PROPS = GlobalEfficiencyAv.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the average global efficiency M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('GlobalEfficiencyAv'[, CATEGORY]) returns the property list of 'GlobalEfficiencyAv'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('GlobalEfficiencyAv')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					GlobalEfficiency.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						GlobalEfficiency.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						GlobalEfficiency.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						GlobalEfficiency.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						GlobalEfficiency.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						GlobalEfficiency.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						GlobalEfficiency.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						GlobalEfficiency.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						GlobalEfficiency.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						GlobalEfficiency.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of average global efficiency.
			%
			% N = GlobalEfficiencyAv.GETPROPNUMBER() returns the property number of average global efficiency.
			%
			% N = GlobalEfficiencyAv.GETPROPNUMBER(CATEGORY) returns the property number of average global efficiency
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the average global efficiency M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('GlobalEfficiencyAv') returns the property number of 'GlobalEfficiencyAv'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('GlobalEfficiencyAv')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(GlobalEfficiencyAv.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in average global efficiency/error.
			%
			% CHECK = GlobalEfficiencyAv.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(GlobalEfficiencyAv, PROP) checks whether PROP exists for GlobalEfficiencyAv.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:GlobalEfficiencyAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyAv:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyAv:WrongInput]
			%  Element.EXISTSPROP(GlobalEfficiencyAv, PROP) throws error if PROP does NOT exist for GlobalEfficiencyAv.
			%   Error id: [BRAPH2:GlobalEfficiencyAv:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('GlobalEfficiencyAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == GlobalEfficiencyAv.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for GlobalEfficiencyAv.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in average global efficiency/error.
			%
			% CHECK = GlobalEfficiencyAv.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(GlobalEfficiencyAv, TAG) checks whether TAG exists for GlobalEfficiencyAv.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:GlobalEfficiencyAv:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyAv:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:GlobalEfficiencyAv:WrongInput]
			%  Element.EXISTSTAG(GlobalEfficiencyAv, TAG) throws error if TAG does NOT exist for GlobalEfficiencyAv.
			%   Error id: [BRAPH2:GlobalEfficiencyAv:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('GlobalEfficiencyAv')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			globalefficiencyav_tag_list = cellfun(@(x) GlobalEfficiencyAv.getPropTag(x), num2cell(GlobalEfficiencyAv.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, globalefficiencyav_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for GlobalEfficiencyAv.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(GlobalEfficiencyAv, POINTER) returns property number of POINTER of GlobalEfficiencyAv.
			%  PROPERTY = M.GETPROPPROP(GlobalEfficiencyAv, POINTER) returns property number of POINTER of GlobalEfficiencyAv.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('GlobalEfficiencyAv')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				globalefficiencyav_tag_list = cellfun(@(x) GlobalEfficiencyAv.getPropTag(x), num2cell(GlobalEfficiencyAv.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, globalefficiencyav_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(GlobalEfficiencyAv, POINTER) returns tag of POINTER of GlobalEfficiencyAv.
			%  TAG = M.GETPROPTAG(GlobalEfficiencyAv, POINTER) returns tag of POINTER of GlobalEfficiencyAv.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('GlobalEfficiencyAv')
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
						tag = getPropTag@GlobalEfficiency(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(GlobalEfficiencyAv, POINTER) returns category of POINTER of GlobalEfficiencyAv.
			%  CATEGORY = M.GETPROPCATEGORY(GlobalEfficiencyAv, POINTER) returns category of POINTER of GlobalEfficiencyAv.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('GlobalEfficiencyAv')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@GlobalEfficiency(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(GlobalEfficiencyAv, POINTER) returns format of POINTER of GlobalEfficiencyAv.
			%  FORMAT = M.GETPROPFORMAT(GlobalEfficiencyAv, POINTER) returns format of POINTER of GlobalEfficiencyAv.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('GlobalEfficiencyAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@GlobalEfficiency(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(GlobalEfficiencyAv, POINTER) returns description of POINTER of GlobalEfficiencyAv.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(GlobalEfficiencyAv, POINTER) returns description of POINTER of GlobalEfficiencyAv.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('GlobalEfficiencyAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyAv.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Average Global Efficiency.';
				case GlobalEfficiencyAv.NAME
					prop_description = 'NAME (constant, string) is the name of the Average Global Efficiency.';
				case GlobalEfficiencyAv.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Average Global Efficiency.';
				case GlobalEfficiencyAv.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Average Global Efficiency.';
				case GlobalEfficiencyAv.ID
					prop_description = 'ID (data, string) is a few-letter code of the Average Global Efficiency.';
				case GlobalEfficiencyAv.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Average Global Efficiency.';
				case GlobalEfficiencyAv.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Average Global Efficiency.';
				case GlobalEfficiencyAv.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case GlobalEfficiencyAv.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case GlobalEfficiencyAv.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case GlobalEfficiencyAv.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case GlobalEfficiencyAv.M
					prop_description = 'M (result, cell) is the Average Global Efficiency.';
				otherwise
					prop_description = getPropDescription@GlobalEfficiency(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(GlobalEfficiencyAv, POINTER) returns settings of POINTER of GlobalEfficiencyAv.
			%  SETTINGS = M.GETPROPSETTINGS(GlobalEfficiencyAv, POINTER) returns settings of POINTER of GlobalEfficiencyAv.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('GlobalEfficiencyAv')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = GlobalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyAv.TEMPLATE
					prop_settings = 'GlobalEfficiencyAv';
				otherwise
					prop_settings = getPropSettings@GlobalEfficiency(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = GlobalEfficiencyAv.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = GlobalEfficiencyAv.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(GlobalEfficiencyAv, POINTER) returns the default value of POINTER of GlobalEfficiencyAv.
			%  DEFAULT = M.GETPROPDEFAULT(GlobalEfficiencyAv, POINTER) returns the default value of POINTER of GlobalEfficiencyAv.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('GlobalEfficiencyAv')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = GlobalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyAv.ELCLASS
					prop_default = 'GlobalEfficiencyAv';
				case GlobalEfficiencyAv.NAME
					prop_default = 'Average Global Efficiency';
				case GlobalEfficiencyAv.DESCRIPTION
					prop_default = 'The Average Global Efficiency (GlobalEfficiencyAv) is the average of the global efficiency within each layer.';
				case GlobalEfficiencyAv.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, GlobalEfficiencyAv.getPropSettings(prop));
				case GlobalEfficiencyAv.ID
					prop_default = 'GlobalEfficiencyAv ID';
				case GlobalEfficiencyAv.LABEL
					prop_default = 'Average Global Efficiency label';
				case GlobalEfficiencyAv.NOTES
					prop_default = 'Average Global Efficiency notes';
				case GlobalEfficiencyAv.SHAPE
					prop_default = Measure.GLOBAL;
				case GlobalEfficiencyAv.SCOPE
					prop_default = Measure.UNILAYER;
				case GlobalEfficiencyAv.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case GlobalEfficiencyAv.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'OrdMxBU' 'OrdMxBUT' 'OrdMxBUD' 'MultilayerWU' 'OrdMlWU' 'MultilayerBUT' 'MultilayerBU' 'MultilayerBUD' 'OrdMlBU' 'OrdMlBUD' 'OrdMlBUT'};
				otherwise
					prop_default = getPropDefault@GlobalEfficiency(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = GlobalEfficiencyAv.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = GlobalEfficiencyAv.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(GlobalEfficiencyAv, POINTER) returns the conditioned default value of POINTER of GlobalEfficiencyAv.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(GlobalEfficiencyAv, POINTER) returns the conditioned default value of POINTER of GlobalEfficiencyAv.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('GlobalEfficiencyAv')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = GlobalEfficiencyAv.getPropProp(pointer);
			
			prop_default = GlobalEfficiencyAv.conditioning(prop, GlobalEfficiencyAv.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(GlobalEfficiencyAv, PROP, VALUE) checks VALUE format for PROP of GlobalEfficiencyAv.
			%  CHECK = M.CHECKPROP(GlobalEfficiencyAv, PROP, VALUE) checks VALUE format for PROP of GlobalEfficiencyAv.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:GlobalEfficiencyAv:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:GlobalEfficiencyAv:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(GlobalEfficiencyAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GlobalEfficiencyAv.
			%   Error id: €BRAPH2.STR€:GlobalEfficiencyAv:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(GlobalEfficiencyAv, PROP, VALUE) throws error if VALUE has not a valid format for PROP of GlobalEfficiencyAv.
			%   Error id: €BRAPH2.STR€:GlobalEfficiencyAv:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('GlobalEfficiencyAv')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = GlobalEfficiencyAv.getPropProp(pointer);
			
			switch prop
				case GlobalEfficiencyAv.TEMPLATE % __GlobalEfficiencyAv.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, GlobalEfficiencyAv.getPropSettings(prop));
				otherwise
					if prop <= GlobalEfficiency.getPropNumber()
						check = checkProp@GlobalEfficiency(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':GlobalEfficiencyAv:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' GlobalEfficiencyAv.getPropTag(prop) ' (' GlobalEfficiencyAv.getFormatTag(GlobalEfficiencyAv.getPropFormat(prop)) ').'] ...
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
				case GlobalEfficiencyAv.M % __GlobalEfficiencyAv.M__
					rng_settings_ = rng(); rng(m.getPropSeed(GlobalEfficiencyAv.M), 'twister')
					
					global_efficiency = calculateValue@GlobalEfficiency(m, prop);
					g = m.get('G');  % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					
					global_efficiency_av = cell(L, 1);
					parfor li = 1:1:L
					    global_efficiency_av(li) = {mean(global_efficiency{li})};
					end
					value = global_efficiency_av;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= GlobalEfficiency.getPropNumber()
						value = calculateValue@GlobalEfficiency(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
