classdef EccentricityOut < Measure
	%EccentricityOut is the graph Out-Eccentricity.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Out-Eccentricity (EccentricityOut) of a node is the maximal shortest out-path length 
	% between a node and any other node within a layer.
	%
	% EccentricityOut methods (constructor):
	%  EccentricityOut - constructor
	%
	% EccentricityOut methods:
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
	% EccentricityOut methods (display):
	%  tostring - string with information about the out-eccentricity
	%  disp - displays information about the out-eccentricity
	%  tree - displays the tree of the out-eccentricity
	%
	% EccentricityOut methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two out-eccentricity are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the out-eccentricity
	%
	% EccentricityOut methods (save/load, Static):
	%  save - saves BRAPH2 out-eccentricity as b2 file
	%  load - loads a BRAPH2 out-eccentricity from a b2 file
	%
	% EccentricityOut method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the out-eccentricity
	%
	% EccentricityOut method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the out-eccentricity
	%
	% EccentricityOut methods (inspection, Static):
	%  getClass - returns the class of the out-eccentricity
	%  getSubclasses - returns all subclasses of EccentricityOut
	%  getProps - returns the property list of the out-eccentricity
	%  getPropNumber - returns the property number of the out-eccentricity
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
	% EccentricityOut methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% EccentricityOut methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% EccentricityOut methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% EccentricityOut methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?EccentricityOut; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">EccentricityOut constants</a>.
	%
	
	properties (Constant) % properties
		RULE = Measure.getPropNumber() + 1;
		RULE_TAG = 'RULE';
		RULE_CATEGORY = Category.PARAMETER;
		RULE_FORMAT = Format.OPTION;
	end
	methods % constructor
		function m = EccentricityOut(varargin)
			%EccentricityOut() creates a out-eccentricity.
			%
			% EccentricityOut(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% EccentricityOut(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the out-eccentricity.
			%
			% CLASS = EccentricityOut.GETCLASS() returns the class 'EccentricityOut'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the out-eccentricity M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('EccentricityOut') returns 'EccentricityOut'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('EccentricityOut')
			%  are less computationally efficient.
			
			m_class = 'EccentricityOut';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the out-eccentricity.
			%
			% LIST = EccentricityOut.GETSUBCLASSES() returns all subclasses of 'EccentricityOut'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the out-eccentricity M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('EccentricityOut') returns all subclasses of 'EccentricityOut'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('EccentricityOut')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('EccentricityOut', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of out-eccentricity.
			%
			% PROPS = EccentricityOut.GETPROPS() returns the property list of out-eccentricity
			%  as a row vector.
			%
			% PROPS = EccentricityOut.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the out-eccentricity M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('EccentricityOut'[, CATEGORY]) returns the property list of 'EccentricityOut'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('EccentricityOut')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Measure.getProps() ...
						EccentricityOut.RULE ...
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
						EccentricityOut.RULE ...
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
			%GETPROPNUMBER returns the property number of out-eccentricity.
			%
			% N = EccentricityOut.GETPROPNUMBER() returns the property number of out-eccentricity.
			%
			% N = EccentricityOut.GETPROPNUMBER(CATEGORY) returns the property number of out-eccentricity
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the out-eccentricity M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('EccentricityOut') returns the property number of 'EccentricityOut'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('EccentricityOut')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(EccentricityOut.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in out-eccentricity/error.
			%
			% CHECK = EccentricityOut.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(EccentricityOut, PROP) checks whether PROP exists for EccentricityOut.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:EccentricityOut:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityOut:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityOut:WrongInput]
			%  Element.EXISTSPROP(EccentricityOut, PROP) throws error if PROP does NOT exist for EccentricityOut.
			%   Error id: [BRAPH2:EccentricityOut:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('EccentricityOut')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == EccentricityOut.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':EccentricityOut:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EccentricityOut:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for EccentricityOut.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in out-eccentricity/error.
			%
			% CHECK = EccentricityOut.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(EccentricityOut, TAG) checks whether TAG exists for EccentricityOut.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:EccentricityOut:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityOut:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:EccentricityOut:WrongInput]
			%  Element.EXISTSTAG(EccentricityOut, TAG) throws error if TAG does NOT exist for EccentricityOut.
			%   Error id: [BRAPH2:EccentricityOut:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('EccentricityOut')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			eccentricityout_tag_list = cellfun(@(x) EccentricityOut.getPropTag(x), num2cell(EccentricityOut.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, eccentricityout_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':EccentricityOut:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EccentricityOut:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for EccentricityOut.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(EccentricityOut, POINTER) returns property number of POINTER of EccentricityOut.
			%  PROPERTY = M.GETPROPPROP(EccentricityOut, POINTER) returns property number of POINTER of EccentricityOut.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('EccentricityOut')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				eccentricityout_tag_list = cellfun(@(x) EccentricityOut.getPropTag(x), num2cell(EccentricityOut.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, eccentricityout_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(EccentricityOut, POINTER) returns tag of POINTER of EccentricityOut.
			%  TAG = M.GETPROPTAG(EccentricityOut, POINTER) returns tag of POINTER of EccentricityOut.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('EccentricityOut')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case EccentricityOut.RULE
						tag = EccentricityOut.RULE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(EccentricityOut, POINTER) returns category of POINTER of EccentricityOut.
			%  CATEGORY = M.GETPROPCATEGORY(EccentricityOut, POINTER) returns category of POINTER of EccentricityOut.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('EccentricityOut')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = EccentricityOut.getPropProp(pointer);
			
			switch prop
				case EccentricityOut.RULE
					prop_category = EccentricityOut.RULE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(EccentricityOut, POINTER) returns format of POINTER of EccentricityOut.
			%  FORMAT = M.GETPROPFORMAT(EccentricityOut, POINTER) returns format of POINTER of EccentricityOut.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('EccentricityOut')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = EccentricityOut.getPropProp(pointer);
			
			switch prop
				case EccentricityOut.RULE
					prop_format = EccentricityOut.RULE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(EccentricityOut, POINTER) returns description of POINTER of EccentricityOut.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(EccentricityOut, POINTER) returns description of POINTER of EccentricityOut.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('EccentricityOut')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = EccentricityOut.getPropProp(pointer);
			
			switch prop
				case EccentricityOut.RULE
					prop_description = 'RULE (parameter, OPTION)  % calculation in a graph or its subgraph';
				case EccentricityOut.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Out-Eccentricity.';
				case EccentricityOut.NAME
					prop_description = 'NAME (constant, string) is the name of the Out-Eccentricity.';
				case EccentricityOut.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Out-Eccentricity.';
				case EccentricityOut.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Out-Eccentricity.';
				case EccentricityOut.ID
					prop_description = 'ID (data, string) is a few-letter code of the Out-Eccentricity.';
				case EccentricityOut.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Out-Eccentricity.';
				case EccentricityOut.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Out-Eccentricity.';
				case EccentricityOut.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case EccentricityOut.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case EccentricityOut.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case EccentricityOut.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case EccentricityOut.M
					prop_description = 'M (result, cell) is the Out-Eccentricity.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(EccentricityOut, POINTER) returns settings of POINTER of EccentricityOut.
			%  SETTINGS = M.GETPROPSETTINGS(EccentricityOut, POINTER) returns settings of POINTER of EccentricityOut.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('EccentricityOut')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = EccentricityOut.getPropProp(pointer);
			
			switch prop
				case EccentricityOut.RULE
					prop_settings = {'all', 'subgraphs'};
				case EccentricityOut.TEMPLATE
					prop_settings = 'EccentricityOut';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = EccentricityOut.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = EccentricityOut.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(EccentricityOut, POINTER) returns the default value of POINTER of EccentricityOut.
			%  DEFAULT = M.GETPROPDEFAULT(EccentricityOut, POINTER) returns the default value of POINTER of EccentricityOut.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('EccentricityOut')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = EccentricityOut.getPropProp(pointer);
			
			switch prop
				case EccentricityOut.RULE
					prop_default = 'all';
				case EccentricityOut.ELCLASS
					prop_default = 'EccentricityOut';
				case EccentricityOut.NAME
					prop_default = 'Out-Eccentricity';
				case EccentricityOut.DESCRIPTION
					prop_default = 'The Out-Eccentricity (EccentricityOut) of a node is the maximal shortest out-path length between a node and any other node within a layer.';
				case EccentricityOut.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, EccentricityOut.getPropSettings(prop));
				case EccentricityOut.ID
					prop_default = 'EccentricityOut ID';
				case EccentricityOut.LABEL
					prop_default = 'Out-Eccentricity label';
				case EccentricityOut.NOTES
					prop_default = 'Out-Eccentricity notes';
				case EccentricityOut.SHAPE
					prop_default = Measure.NODAL;
				case EccentricityOut.SCOPE
					prop_default = Measure.UNILAYER;
				case EccentricityOut.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case EccentricityOut.COMPATIBLE_GRAPHS
					prop_default = {'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD' 'OrdMxWD'} ;;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = EccentricityOut.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = EccentricityOut.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(EccentricityOut, POINTER) returns the conditioned default value of POINTER of EccentricityOut.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(EccentricityOut, POINTER) returns the conditioned default value of POINTER of EccentricityOut.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('EccentricityOut')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = EccentricityOut.getPropProp(pointer);
			
			prop_default = EccentricityOut.conditioning(prop, EccentricityOut.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(EccentricityOut, PROP, VALUE) checks VALUE format for PROP of EccentricityOut.
			%  CHECK = M.CHECKPROP(EccentricityOut, PROP, VALUE) checks VALUE format for PROP of EccentricityOut.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:EccentricityOut:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:EccentricityOut:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(EccentricityOut, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EccentricityOut.
			%   Error id: €BRAPH2.STR€:EccentricityOut:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(EccentricityOut, PROP, VALUE) throws error if VALUE has not a valid format for PROP of EccentricityOut.
			%   Error id: €BRAPH2.STR€:EccentricityOut:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('EccentricityOut')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = EccentricityOut.getPropProp(pointer);
			
			switch prop
				case EccentricityOut.RULE % __EccentricityOut.RULE__
					check = Format.checkFormat(Format.OPTION, value, EccentricityOut.getPropSettings(prop));
				case EccentricityOut.TEMPLATE % __EccentricityOut.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, EccentricityOut.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':EccentricityOut:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':EccentricityOut:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' EccentricityOut.getPropTag(prop) ' (' EccentricityOut.getFormatTag(EccentricityOut.getPropFormat(prop)) ').'] ...
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
				case EccentricityOut.M % __EccentricityOut.M__
					rng_settings_ = rng(); rng(m.getPropSeed(EccentricityOut.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					
					distance = Distance('G', g).get('M'); 
					eccentricityOut = cell(L, 1);
					eccentricity_rule = m.get('RULE');
					
					parfor li = 1:1:L
					    switch lower(eccentricity_rule)
					        case {'subgraphs'}
					            eccentricityOut(li)  = {max(distance{li}.*(distance{li}~=Inf), [], 2)};
					        case {'all'}
					            eccentricityOut(li)  = {max(distance{li}, [], 2)};
					    end
					end
					
					value = eccentricityOut;
					
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
