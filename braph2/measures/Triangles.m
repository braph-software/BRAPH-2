classdef Triangles < Measure
	%Triangles is the graph Triangles.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Triangles are calculated as the number of neighbors of a node that are 
	%  also neighbors of each other within a layer. In weighted graphs, the triangles are 
	%  calculated as the geometric mean of the weights of the edges forming the triangle.
	%
	% Triangles methods (constructor):
	%  Triangles - constructor
	%
	% Triangles methods:
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
	% Triangles methods (display):
	%  tostring - string with information about the triangles
	%  disp - displays information about the triangles
	%  tree - displays the tree of the triangles
	%
	% Triangles methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two triangles are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the triangles
	%
	% Triangles methods (save/load, Static):
	%  save - saves BRAPH2 triangles as b2 file
	%  load - loads a BRAPH2 triangles from a b2 file
	%
	% Triangles method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the triangles
	%
	% Triangles method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the triangles
	%
	% Triangles methods (inspection, Static):
	%  getClass - returns the class of the triangles
	%  getSubclasses - returns all subclasses of Triangles
	%  getProps - returns the property list of the triangles
	%  getPropNumber - returns the property number of the triangles
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
	% Triangles methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Triangles methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Triangles methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Triangles methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Triangles; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Triangles constants</a>.
	%
	
	properties (Constant) % properties
		RULE = Measure.getPropNumber() + 1;
		RULE_TAG = 'RULE';
		RULE_CATEGORY = Category.PARAMETER;
		RULE_FORMAT = Format.OPTION;
	end
	methods % constructor
		function m = Triangles(varargin)
			%Triangles() creates a triangles.
			%
			% Triangles(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Triangles(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the triangles.
			%
			% CLASS = Triangles.GETCLASS() returns the class 'Triangles'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the triangles M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('Triangles') returns 'Triangles'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('Triangles')
			%  are less computationally efficient.
			
			m_class = 'Triangles';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the triangles.
			%
			% LIST = Triangles.GETSUBCLASSES() returns all subclasses of 'Triangles'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the triangles M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('Triangles') returns all subclasses of 'Triangles'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('Triangles')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('Triangles', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of triangles.
			%
			% PROPS = Triangles.GETPROPS() returns the property list of triangles
			%  as a row vector.
			%
			% PROPS = Triangles.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the triangles M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('Triangles'[, CATEGORY]) returns the property list of 'Triangles'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('Triangles')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Measure.getProps() ...
						Triangles.RULE ...
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
						Triangles.RULE ...
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
			%GETPROPNUMBER returns the property number of triangles.
			%
			% N = Triangles.GETPROPNUMBER() returns the property number of triangles.
			%
			% N = Triangles.GETPROPNUMBER(CATEGORY) returns the property number of triangles
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the triangles M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('Triangles') returns the property number of 'Triangles'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('Triangles')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(Triangles.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in triangles/error.
			%
			% CHECK = Triangles.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(Triangles, PROP) checks whether PROP exists for Triangles.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Triangles:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Triangles:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Triangles:WrongInput]
			%  Element.EXISTSPROP(Triangles, PROP) throws error if PROP does NOT exist for Triangles.
			%   Error id: [BRAPH2:Triangles:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('Triangles')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == Triangles.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Triangles:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Triangles:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Triangles.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in triangles/error.
			%
			% CHECK = Triangles.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(Triangles, TAG) checks whether TAG exists for Triangles.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Triangles:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Triangles:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Triangles:WrongInput]
			%  Element.EXISTSTAG(Triangles, TAG) throws error if TAG does NOT exist for Triangles.
			%   Error id: [BRAPH2:Triangles:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('Triangles')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			triangles_tag_list = cellfun(@(x) Triangles.getPropTag(x), num2cell(Triangles.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, triangles_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Triangles:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Triangles:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for Triangles.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Triangles, POINTER) returns property number of POINTER of Triangles.
			%  PROPERTY = M.GETPROPPROP(Triangles, POINTER) returns property number of POINTER of Triangles.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('Triangles')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				triangles_tag_list = cellfun(@(x) Triangles.getPropTag(x), num2cell(Triangles.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, triangles_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(Triangles, POINTER) returns tag of POINTER of Triangles.
			%  TAG = M.GETPROPTAG(Triangles, POINTER) returns tag of POINTER of Triangles.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('Triangles')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case Triangles.RULE
						tag = Triangles.RULE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(Triangles, POINTER) returns category of POINTER of Triangles.
			%  CATEGORY = M.GETPROPCATEGORY(Triangles, POINTER) returns category of POINTER of Triangles.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('Triangles')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Triangles.getPropProp(pointer);
			
			switch prop
				case Triangles.RULE
					prop_category = Triangles.RULE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(Triangles, POINTER) returns format of POINTER of Triangles.
			%  FORMAT = M.GETPROPFORMAT(Triangles, POINTER) returns format of POINTER of Triangles.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('Triangles')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Triangles.getPropProp(pointer);
			
			switch prop
				case Triangles.RULE
					prop_format = Triangles.RULE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Triangles, POINTER) returns description of POINTER of Triangles.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(Triangles, POINTER) returns description of POINTER of Triangles.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('Triangles')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Triangles.getPropProp(pointer);
			
			switch prop
				case Triangles.RULE
					prop_description = 'RULE (parameter, option) is the rule to determine what is a triangle in a directed graph.';
				case Triangles.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Triangles.';
				case Triangles.NAME
					prop_description = 'NAME (constant, string) is the name of the Triangles.';
				case Triangles.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Triangles.';
				case Triangles.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Triangles.';
				case Triangles.ID
					prop_description = 'ID (data, string) is a few-letter code of the Triangles.';
				case Triangles.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Triangles.';
				case Triangles.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Triangles.';
				case Triangles.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case Triangles.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case Triangles.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case Triangles.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case Triangles.M
					prop_description = 'M (result, cell) is the Triangles.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(Triangles, POINTER) returns settings of POINTER of Triangles.
			%  SETTINGS = M.GETPROPSETTINGS(Triangles, POINTER) returns settings of POINTER of Triangles.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('Triangles')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Triangles.getPropProp(pointer);
			
			switch prop
				case Triangles.RULE
					prop_settings = {'all' 'middleman' 'in' 'out' 'cycle'};
				case Triangles.TEMPLATE
					prop_settings = 'Triangles';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Triangles.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Triangles.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(Triangles, POINTER) returns the default value of POINTER of Triangles.
			%  DEFAULT = M.GETPROPDEFAULT(Triangles, POINTER) returns the default value of POINTER of Triangles.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('Triangles')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Triangles.getPropProp(pointer);
			
			switch prop
				case Triangles.RULE
					prop_default = 'cycle';
				case Triangles.ELCLASS
					prop_default = 'Triangles';
				case Triangles.NAME
					prop_default = 'Triangles';
				case Triangles.DESCRIPTION
					prop_default = 'The triangles are calculated as the number of neighbors of a node that are also neighbors of each other within a layer. In weighted graphs, the triangles are calculated as the geometric mean of the weights of the edges forming the triangle.';
				case Triangles.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, Triangles.getPropSettings(prop));
				case Triangles.ID
					prop_default = 'Triangles ID';
				case Triangles.LABEL
					prop_default = 'Triangles label';
				case Triangles.NOTES
					prop_default = 'Triangles notes';
				case Triangles.SHAPE
					prop_default = Measure.NODAL;
				case Triangles.SCOPE
					prop_default = Measure.UNILAYER;
				case Triangles.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case Triangles.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBD' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'OrdMxWD' 'OrdMxBU' 'OrdMxBD' 'OrdMxBUT' 'MultilayerWD' 'MultilayerBD'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Triangles.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Triangles.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Triangles, POINTER) returns the conditioned default value of POINTER of Triangles.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(Triangles, POINTER) returns the conditioned default value of POINTER of Triangles.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('Triangles')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Triangles.getPropProp(pointer);
			
			prop_default = Triangles.conditioning(prop, Triangles.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Triangles, PROP, VALUE) checks VALUE format for PROP of Triangles.
			%  CHECK = M.CHECKPROP(Triangles, PROP, VALUE) checks VALUE format for PROP of Triangles.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:Triangles:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:Triangles:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(Triangles, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Triangles.
			%   Error id: €BRAPH2.STR€:Triangles:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(Triangles, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Triangles.
			%   Error id: €BRAPH2.STR€:Triangles:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('Triangles')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Triangles.getPropProp(pointer);
			
			switch prop
				case Triangles.RULE % __Triangles.RULE__
					check = Format.checkFormat(Format.OPTION, value, Triangles.getPropSettings(prop));
				case Triangles.TEMPLATE % __Triangles.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, Triangles.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Triangles:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Triangles:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Triangles.getPropTag(prop) ' (' Triangles.getFormatTag(Triangles.getPropFormat(prop)) ').'] ...
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
				case Triangles.M % __Triangles.M__
					rng_settings_ = rng(); rng(m.getPropSeed(Triangles.M), 'twister')
					
					g = m.get('G');  % graph from measure class
					A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.) 
					L = g.get('LAYERNUMBER');
					
					triangles = cell(L, 1);
					            
					directionality_type =   g.get('DIRECTIONALITY_TYPE', L);
					for li = 1:1:L        
					    Aii = A{li, li};    
					    
					    if directionality_type == Graph.UNDIRECTED  % undirected graphs
					        triangles_layer = diag((Aii.^(1/3))^3) / 2;
					        triangles_layer(isnan(triangles_layer)) = 0;  % Should return zeros, not NaN
					        triangles(li) = {triangles_layer};
					        
					    else  % directed graphs
					        directed_triangles_rule = m.get('RULE');
					        switch lower(directed_triangles_rule)
					            case 'all'  % all rule
					                triangles_layer = diag((Aii.^(1/3) + transpose(Aii).^(1/3))^3) / 2;
					            case 'middleman'  % middleman rule
					                triangles_layer = diag(Aii.^(1/3) * transpose(Aii).^(1/3) * Aii.^(1/3));
					            case 'in'  % in rule
					                triangles_layer = diag(transpose(Aii).^(1/3) * (Aii.^(1/3))^2);
					            case 'out'  % out rule
					                triangles_layer = diag((Aii.^(1/3))^2 * transpose(Aii).^(1/3));
					            otherwise  % {'cycle'}  % cycle rule
					                triangles_layer = diag((Aii.^(1/3))^3);
					        end
					        triangles_layer(isnan(triangles_layer)) = 0;  % Should return zeros, not NaN
					        triangles(li) = {triangles_layer};
					    end
					end
					value = triangles;
					
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
