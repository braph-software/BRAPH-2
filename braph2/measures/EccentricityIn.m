classdef EccentricityIn < Measure
	%EccentricityIn is the graph In-Eccentricity.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The In-Eccentricity (EccentricityIn) of a node is the maximal shortest in-path length 
	% between a node and any other node within a layer.
	%
	% EccentricityIn methods (constructor):
	%  EccentricityIn - constructor
	%
	% EccentricityIn methods:
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
	% EccentricityIn methods (display):
	%  tostring - string with information about the in-eccentricity
	%  disp - displays information about the in-eccentricity
	%  tree - displays the tree of the in-eccentricity
	%
	% EccentricityIn methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two in-eccentricity are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the in-eccentricity
	%
	% EccentricityIn methods (save/load, Static):
	%  save - saves BRAPH2 in-eccentricity as b2 file
	%  load - loads a BRAPH2 in-eccentricity from a b2 file
	%
	% EccentricityIn method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the in-eccentricity
	%
	% EccentricityIn method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the in-eccentricity
	%
	% EccentricityIn methods (inspection, Static):
	%  getClass - returns the class of the in-eccentricity
	%  getSubclasses - returns all subclasses of EccentricityIn
	%  getProps - returns the property list of the in-eccentricity
	%  getPropNumber - returns the property number of the in-eccentricity
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
	% EccentricityIn methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% EccentricityIn methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% EccentricityIn methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% EccentricityIn methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?EccentricityIn; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">EccentricityIn constants</a>.
	%
	
	properties (Constant) % properties
		RULE = Measure.getPropNumber() + 1;
		RULE_TAG = 'RULE';
		RULE_CATEGORY = Category.PARAMETER;
		RULE_FORMAT = Format.OPTION;
	end
	methods % constructor
		function m = EccentricityIn(varargin)
			%EccentricityIn() creates a in-eccentricity.
			%
			% EccentricityIn(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% EccentricityIn(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the in-eccentricity.
			%
			% CLASS = EccentricityIn.GETCLASS() returns the class 'EccentricityIn'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the in-eccentricity M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('EccentricityIn') returns 'EccentricityIn'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('EccentricityIn')
			%  are less computationally efficient.
			
			m_class = 'EccentricityIn';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the in-eccentricity.
			%
			% LIST = EccentricityIn.GETSUBCLASSES() returns all subclasses of 'EccentricityIn'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the in-eccentricity M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('EccentricityIn') returns all subclasses of 'EccentricityIn'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('EccentricityIn')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('EccentricityIn', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of in-eccentricity.
			%
			% PROPS = EccentricityIn.GETPROPS() returns the property list of in-eccentricity
			%  as a row vector.
			%
			% PROPS = EccentricityIn.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the in-eccentricity M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('EccentricityIn'[, CATEGORY]) returns the property list of 'EccentricityIn'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('EccentricityIn')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Measure.getProps() ...
						EccentricityIn.RULE ...
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
						EccentricityIn.RULE ...
						];
				case Category.DATA
					prop_list = [ ...
						Measure.getProps(Category.DATA) ...
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
			%GETPROPNUMBER returns the property number of in-eccentricity.
			%
			% N = EccentricityIn.GETPROPNUMBER() returns the property number of in-eccentricity.
			%
			% N = EccentricityIn.GETPROPNUMBER(CATEGORY) returns the property number of in-eccentricity
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the in-eccentricity M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('EccentricityIn') returns the property number of 'EccentricityIn'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('EccentricityIn')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(EccentricityIn.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in in-eccentricity/error.
			%
			% CHECK = EccentricityIn.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(EccentricityIn, PROP) checks whether PROP exists for EccentricityIn.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:EccentricityIn:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityIn:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityIn:WrongInput]
			%  Element.EXISTSPROP(EccentricityIn, PROP) throws error if PROP does NOT exist for EccentricityIn.
			%   Error id: [BRAPH2:EccentricityIn:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('EccentricityIn')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == EccentricityIn.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':EccentricityIn:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EccentricityIn:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for EccentricityIn.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in in-eccentricity/error.
			%
			% CHECK = EccentricityIn.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(EccentricityIn, TAG) checks whether TAG exists for EccentricityIn.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:EccentricityIn:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityIn:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityIn:WrongInput]
			%  Element.EXISTSTAG(EccentricityIn, TAG) throws error if TAG does NOT exist for EccentricityIn.
			%   Error id: [BRAPH2:EccentricityIn:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('EccentricityIn')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			eccentricityin_tag_list = cellfun(@(x) EccentricityIn.getPropTag(x), num2cell(EccentricityIn.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, eccentricityin_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':EccentricityIn:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EccentricityIn:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for EccentricityIn.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(EccentricityIn, POINTER) returns property number of POINTER of EccentricityIn.
			%  PROPERTY = M.GETPROPPROP(EccentricityIn, POINTER) returns property number of POINTER of EccentricityIn.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('EccentricityIn')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				eccentricityin_tag_list = cellfun(@(x) EccentricityIn.getPropTag(x), num2cell(EccentricityIn.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, eccentricityin_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(EccentricityIn, POINTER) returns tag of POINTER of EccentricityIn.
			%  TAG = M.GETPROPTAG(EccentricityIn, POINTER) returns tag of POINTER of EccentricityIn.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('EccentricityIn')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case EccentricityIn.RULE
						tag = EccentricityIn.RULE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(EccentricityIn, POINTER) returns category of POINTER of EccentricityIn.
			%  CATEGORY = M.GETPROPCATEGORY(EccentricityIn, POINTER) returns category of POINTER of EccentricityIn.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('EccentricityIn')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = EccentricityIn.getPropProp(pointer);
			
			switch prop
				case EccentricityIn.RULE
					prop_category = EccentricityIn.RULE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(EccentricityIn, POINTER) returns format of POINTER of EccentricityIn.
			%  FORMAT = M.GETPROPFORMAT(EccentricityIn, POINTER) returns format of POINTER of EccentricityIn.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('EccentricityIn')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = EccentricityIn.getPropProp(pointer);
			
			switch prop
				case EccentricityIn.RULE
					prop_format = EccentricityIn.RULE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(EccentricityIn, POINTER) returns description of POINTER of EccentricityIn.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(EccentricityIn, POINTER) returns description of POINTER of EccentricityIn.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('EccentricityIn')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = EccentricityIn.getPropProp(pointer);
			
			switch prop
				case EccentricityIn.RULE
					prop_description = 'RULE (parameter, OPTION)  % calculation in a graph or its subgraph';
				case EccentricityIn.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the In-Eccentricity.';
				case EccentricityIn.NAME
					prop_description = 'NAME (constant, string) is the name of the In-Eccentricity.';
				case EccentricityIn.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the In-Eccentricity.';
				case EccentricityIn.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the In-Eccentricity.';
				case EccentricityIn.ID
					prop_description = 'ID (data, string) is a few-letter code of the In-Eccentricity.';
				case EccentricityIn.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the In-Eccentricity.';
				case EccentricityIn.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the In-Eccentricity.';
				case EccentricityIn.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case EccentricityIn.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case EccentricityIn.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case EccentricityIn.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case EccentricityIn.M
					prop_description = 'M (result, cell) is the In-Eccentricity.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(EccentricityIn, POINTER) returns settings of POINTER of EccentricityIn.
			%  SETTINGS = M.GETPROPSETTINGS(EccentricityIn, POINTER) returns settings of POINTER of EccentricityIn.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('EccentricityIn')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = EccentricityIn.getPropProp(pointer);
			
			switch prop
				case EccentricityIn.RULE
					prop_settings = {'all', 'subgraphs'};
				case EccentricityIn.TEMPLATE
					prop_settings = 'EccentricityIn';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = EccentricityIn.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = EccentricityIn.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(EccentricityIn, POINTER) returns the default value of POINTER of EccentricityIn.
			%  DEFAULT = M.GETPROPDEFAULT(EccentricityIn, POINTER) returns the default value of POINTER of EccentricityIn.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('EccentricityIn')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = EccentricityIn.getPropProp(pointer);
			
			switch prop
				case EccentricityIn.RULE
					prop_default = 'all';
				case EccentricityIn.ELCLASS
					prop_default = 'EccentricityIn';
				case EccentricityIn.NAME
					prop_default = 'In-Eccentricity';
				case EccentricityIn.DESCRIPTION
					prop_default = 'The In-Eccentricity (EccentricityIn) of a node is the maximal shortest in-path length between a node and any other node within a layer.';
				case EccentricityIn.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, EccentricityIn.getPropSettings(prop));
				case EccentricityIn.ID
					prop_default = 'EccentricityIn ID';
				case EccentricityIn.LABEL
					prop_default = 'In-Eccentricity label';
				case EccentricityIn.NOTES
					prop_default = 'In-Eccentricity notes';
				case EccentricityIn.SHAPE
					prop_default = Measure.NODAL;
				case EccentricityIn.SCOPE
					prop_default = Measure.UNILAYER;
				case EccentricityIn.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case EccentricityIn.COMPATIBLE_GRAPHS
					prop_default = {'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD' 'OrdMxWD'} ;;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = EccentricityIn.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = EccentricityIn.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(EccentricityIn, POINTER) returns the conditioned default value of POINTER of EccentricityIn.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(EccentricityIn, POINTER) returns the conditioned default value of POINTER of EccentricityIn.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('EccentricityIn')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = EccentricityIn.getPropProp(pointer);
			
			prop_default = EccentricityIn.conditioning(prop, EccentricityIn.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(EccentricityIn, PROP, VALUE) checks VALUE format for PROP of EccentricityIn.
			%  CHECK = M.CHECKPROP(EccentricityIn, PROP, VALUE) checks VALUE format for PROP of EccentricityIn.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:EccentricityIn:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:EccentricityIn:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(EccentricityIn, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EccentricityIn.
			%   Error id: €BRAPH2.STR€:EccentricityIn:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(EccentricityIn, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EccentricityIn.
			%   Error id: €BRAPH2.STR€:EccentricityIn:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('EccentricityIn')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = EccentricityIn.getPropProp(pointer);
			
			switch prop
				case EccentricityIn.RULE % __EccentricityIn.RULE__
					check = Format.checkFormat(Format.OPTION, value, EccentricityIn.getPropSettings(prop));
				case EccentricityIn.TEMPLATE % __EccentricityIn.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, EccentricityIn.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':EccentricityIn:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EccentricityIn:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' EccentricityIn.getPropTag(prop) ' (' EccentricityIn.getFormatTag(EccentricityIn.getPropFormat(prop)) ').'] ...
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
				case EccentricityIn.M % __EccentricityIn.M__
					rng_settings_ = rng(); rng(m.getPropSeed(EccentricityIn.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					
					distance = Distance('G', g).get('M'); 
					eccentricityIn = cell(L, 1);
					eccentricity_rule = m.get('RULE');
					
					parfor li = 1:1:L
					    switch lower(eccentricity_rule)
					        case {'subgraphs'}
					            eccentricityIn(li)  = {max(distance{li}.*(distance{li}~=Inf), [], 1)};
					        case {'all'}
					            eccentricityIn(li)  = {max(distance{li}, [], 1)};
					    end
					end
					
					value = eccentricityIn;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= Measure.getPropNumber()
						value = calculateValue@Measure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
