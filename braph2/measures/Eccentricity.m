classdef Eccentricity < Measure
	%Eccentricity is the graph Eccentricity.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Eccentricity of a node is the maximal shortest path length between a node and any other node within a layer.
	%
	% Eccentricity methods (constructor):
	%  Eccentricity - constructor
	%
	% Eccentricity methods:
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
	% Eccentricity methods (display):
	%  tostring - string with information about the eccentricity
	%  disp - displays information about the eccentricity
	%  tree - displays the tree of the eccentricity
	%
	% Eccentricity methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two eccentricity are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the eccentricity
	%
	% Eccentricity methods (save/load, Static):
	%  save - saves BRAPH2 eccentricity as b2 file
	%  load - loads a BRAPH2 eccentricity from a b2 file
	%
	% Eccentricity method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the eccentricity
	%
	% Eccentricity method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the eccentricity
	%
	% Eccentricity methods (inspection, Static):
	%  getClass - returns the class of the eccentricity
	%  getSubclasses - returns all subclasses of Eccentricity
	%  getProps - returns the property list of the eccentricity
	%  getPropNumber - returns the property number of the eccentricity
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
	% Eccentricity methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Eccentricity methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Eccentricity methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Eccentricity methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Eccentricity; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Eccentricity constants</a>.
	%
	
	properties (Constant) % properties
		RULE = Measure.getPropNumber() + 1;
		RULE_TAG = 'RULE';
		RULE_CATEGORY = Category.PARAMETER;
		RULE_FORMAT = Format.OPTION;
	end
	methods % constructor
		function m = Eccentricity(varargin)
			%Eccentricity() creates a eccentricity.
			%
			% Eccentricity(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Eccentricity(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the eccentricity.
			%
			% CLASS = Eccentricity.GETCLASS() returns the class 'Eccentricity'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the eccentricity M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('Eccentricity') returns 'Eccentricity'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('Eccentricity')
			%  are less computationally efficient.
			
			m_class = 'Eccentricity';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the eccentricity.
			%
			% LIST = Eccentricity.GETSUBCLASSES() returns all subclasses of 'Eccentricity'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the eccentricity M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('Eccentricity') returns all subclasses of 'Eccentricity'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('Eccentricity')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('Eccentricity', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of eccentricity.
			%
			% PROPS = Eccentricity.GETPROPS() returns the property list of eccentricity
			%  as a row vector.
			%
			% PROPS = Eccentricity.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the eccentricity M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('Eccentricity'[, CATEGORY]) returns the property list of 'Eccentricity'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('Eccentricity')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Measure.getProps() ...
						Eccentricity.RULE ...
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
						Eccentricity.RULE ...
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
			%GETPROPNUMBER returns the property number of eccentricity.
			%
			% N = Eccentricity.GETPROPNUMBER() returns the property number of eccentricity.
			%
			% N = Eccentricity.GETPROPNUMBER(CATEGORY) returns the property number of eccentricity
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the eccentricity M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('Eccentricity') returns the property number of 'Eccentricity'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('Eccentricity')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(Eccentricity.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in eccentricity/error.
			%
			% CHECK = Eccentricity.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(Eccentricity, PROP) checks whether PROP exists for Eccentricity.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Eccentricity:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Eccentricity:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Eccentricity:WrongInput]
			%  Element.EXISTSPROP(Eccentricity, PROP) throws error if PROP does NOT exist for Eccentricity.
			%   Error id: [BRAPH2:Eccentricity:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('Eccentricity')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == Eccentricity.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Eccentricity:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Eccentricity:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Eccentricity.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in eccentricity/error.
			%
			% CHECK = Eccentricity.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(Eccentricity, TAG) checks whether TAG exists for Eccentricity.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Eccentricity:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Eccentricity:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Eccentricity:WrongInput]
			%  Element.EXISTSTAG(Eccentricity, TAG) throws error if TAG does NOT exist for Eccentricity.
			%   Error id: [BRAPH2:Eccentricity:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('Eccentricity')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			eccentricity_tag_list = cellfun(@(x) Eccentricity.getPropTag(x), num2cell(Eccentricity.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, eccentricity_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Eccentricity:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Eccentricity:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for Eccentricity.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Eccentricity, POINTER) returns property number of POINTER of Eccentricity.
			%  PROPERTY = M.GETPROPPROP(Eccentricity, POINTER) returns property number of POINTER of Eccentricity.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('Eccentricity')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				eccentricity_tag_list = cellfun(@(x) Eccentricity.getPropTag(x), num2cell(Eccentricity.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, eccentricity_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(Eccentricity, POINTER) returns tag of POINTER of Eccentricity.
			%  TAG = M.GETPROPTAG(Eccentricity, POINTER) returns tag of POINTER of Eccentricity.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('Eccentricity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case Eccentricity.RULE
						tag = Eccentricity.RULE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(Eccentricity, POINTER) returns category of POINTER of Eccentricity.
			%  CATEGORY = M.GETPROPCATEGORY(Eccentricity, POINTER) returns category of POINTER of Eccentricity.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('Eccentricity')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Eccentricity.getPropProp(pointer);
			
			switch prop
				case Eccentricity.RULE
					prop_category = Eccentricity.RULE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(Eccentricity, POINTER) returns format of POINTER of Eccentricity.
			%  FORMAT = M.GETPROPFORMAT(Eccentricity, POINTER) returns format of POINTER of Eccentricity.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('Eccentricity')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Eccentricity.getPropProp(pointer);
			
			switch prop
				case Eccentricity.RULE
					prop_format = Eccentricity.RULE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Eccentricity, POINTER) returns description of POINTER of Eccentricity.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(Eccentricity, POINTER) returns description of POINTER of Eccentricity.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('Eccentricity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Eccentricity.getPropProp(pointer);
			
			switch prop
				case Eccentricity.RULE
					prop_description = 'RULE (parameter, OPTION)  % calculation in a graph or its subgraph';
				case Eccentricity.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Eccentricity.';
				case Eccentricity.NAME
					prop_description = 'NAME (constant, string) is the name of the Eccentricity.';
				case Eccentricity.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Eccentricity.';
				case Eccentricity.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Eccentricity.';
				case Eccentricity.ID
					prop_description = 'ID (data, string) is a few-letter code of the Eccentricity.';
				case Eccentricity.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Eccentricity.';
				case Eccentricity.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Eccentricity.';
				case Eccentricity.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case Eccentricity.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case Eccentricity.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case Eccentricity.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case Eccentricity.M
					prop_description = 'M (result, cell) is the Eccentricity.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(Eccentricity, POINTER) returns settings of POINTER of Eccentricity.
			%  SETTINGS = M.GETPROPSETTINGS(Eccentricity, POINTER) returns settings of POINTER of Eccentricity.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('Eccentricity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Eccentricity.getPropProp(pointer);
			
			switch prop
				case Eccentricity.RULE
					prop_settings = {'all', 'subgraphs'};
				case Eccentricity.TEMPLATE
					prop_settings = 'Eccentricity';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Eccentricity.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Eccentricity.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(Eccentricity, POINTER) returns the default value of POINTER of Eccentricity.
			%  DEFAULT = M.GETPROPDEFAULT(Eccentricity, POINTER) returns the default value of POINTER of Eccentricity.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('Eccentricity')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Eccentricity.getPropProp(pointer);
			
			switch prop
				case Eccentricity.RULE
					prop_default = 'all';
				case Eccentricity.ELCLASS
					prop_default = 'Eccentricity';
				case Eccentricity.NAME
					prop_default = 'Eccentricity';
				case Eccentricity.DESCRIPTION
					prop_default = 'The Eccentricity of a node is the number of edges connected to the node within a layer. Connection weights are ignored in calculations.';
				case Eccentricity.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, Eccentricity.getPropSettings(prop));
				case Eccentricity.ID
					prop_default = 'Eccentricity ID';
				case Eccentricity.LABEL
					prop_default = 'Eccentricity label';
				case Eccentricity.NOTES
					prop_default = 'Eccentricity notes';
				case Eccentricity.SHAPE
					prop_default = Measure.NODAL;
				case Eccentricity.SCOPE
					prop_default = Measure.UNILAYER;
				case Eccentricity.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case Eccentricity.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Eccentricity.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Eccentricity.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Eccentricity, POINTER) returns the conditioned default value of POINTER of Eccentricity.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(Eccentricity, POINTER) returns the conditioned default value of POINTER of Eccentricity.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('Eccentricity')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Eccentricity.getPropProp(pointer);
			
			prop_default = Eccentricity.conditioning(prop, Eccentricity.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Eccentricity, PROP, VALUE) checks VALUE format for PROP of Eccentricity.
			%  CHECK = M.CHECKPROP(Eccentricity, PROP, VALUE) checks VALUE format for PROP of Eccentricity.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:Eccentricity:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:Eccentricity:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(Eccentricity, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Eccentricity.
			%   Error id: €BRAPH2.STR€:Eccentricity:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(Eccentricity, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Eccentricity.
			%   Error id: €BRAPH2.STR€:Eccentricity:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('Eccentricity')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Eccentricity.getPropProp(pointer);
			
			switch prop
				case Eccentricity.RULE % __Eccentricity.RULE__
					check = Format.checkFormat(Format.OPTION, value, Eccentricity.getPropSettings(prop));
				case Eccentricity.TEMPLATE % __Eccentricity.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, Eccentricity.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Eccentricity:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Eccentricity:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Eccentricity.getPropTag(prop) ' (' Eccentricity.getFormatTag(Eccentricity.getPropFormat(prop)) ').'] ...
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
				case Eccentricity.M % __Eccentricity.M__
					rng_settings_ = rng(); rng(m.getPropSeed(Eccentricity.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					
					distance = Distance('G', g).get('M'); 
					eccentricity = cell(L, 1);
					eccentricity_rule = m.get('RULE');
					
					parfor li = 1:1:L
					    switch lower(eccentricity_rule)
					        case {'subgraphs'}
					            eccentricity(li)  = {max(distance{li}.*(distance{li}~=Inf), [], 2)};
					        case {'all'}
					            eccentricity(li)  = {max(distance{li}, [], 2)};
					    end
					end
					
					value = eccentricity;
					
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
