classdef Participation < Measure
	%Participation is the graph Participation.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Participation of a node is the ratio of edges that a node forms within 
	%  a single layer community to the total number of edges that forms within the whole single layer graph.
	%
	% Participation methods (constructor):
	%  Participation - constructor
	%
	% Participation methods:
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
	% Participation methods (display):
	%  tostring - string with information about the participation
	%  disp - displays information about the participation
	%  tree - displays the tree of the participation
	%
	% Participation methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two participation are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the participation
	%
	% Participation methods (save/load, Static):
	%  save - saves BRAPH2 participation as b2 file
	%  load - loads a BRAPH2 participation from a b2 file
	%
	% Participation method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the participation
	%
	% Participation method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the participation
	%
	% Participation methods (inspection, Static):
	%  getClass - returns the class of the participation
	%  getSubclasses - returns all subclasses of Participation
	%  getProps - returns the property list of the participation
	%  getPropNumber - returns the property number of the participation
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
	% Participation methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Participation methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Participation methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Participation methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Participation; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Participation constants</a>.
	%
	
	properties (Constant) % properties
		CI = Measure.getPropNumber() + 1;
		CI_TAG = 'CI';
		CI_CATEGORY = Category.PARAMETER;
		CI_FORMAT = Format.MATRIX;
		
		RULE = Measure.getPropNumber() + 2;
		RULE_TAG = 'RULE';
		RULE_CATEGORY = Category.PARAMETER;
		RULE_FORMAT = Format.OPTION;
	end
	methods % constructor
		function m = Participation(varargin)
			%Participation() creates a participation.
			%
			% Participation(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Participation(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the participation.
			%
			% CLASS = Participation.GETCLASS() returns the class 'Participation'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the participation M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('Participation') returns 'Participation'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('Participation')
			%  are less computationally efficient.
			
			m_class = 'Participation';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the participation.
			%
			% LIST = Participation.GETSUBCLASSES() returns all subclasses of 'Participation'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the participation M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('Participation') returns all subclasses of 'Participation'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('Participation')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('Participation', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of participation.
			%
			% PROPS = Participation.GETPROPS() returns the property list of participation
			%  as a row vector.
			%
			% PROPS = Participation.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the participation M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('Participation'[, CATEGORY]) returns the property list of 'Participation'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('Participation')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Measure.getProps() ...
						Participation.CI ...
						Participation.RULE ...
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
						Participation.CI ...
						Participation.RULE ...
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
			%GETPROPNUMBER returns the property number of participation.
			%
			% N = Participation.GETPROPNUMBER() returns the property number of participation.
			%
			% N = Participation.GETPROPNUMBER(CATEGORY) returns the property number of participation
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the participation M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('Participation') returns the property number of 'Participation'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('Participation')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(Participation.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in participation/error.
			%
			% CHECK = Participation.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(Participation, PROP) checks whether PROP exists for Participation.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Participation:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Participation:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Participation:WrongInput]
			%  Element.EXISTSPROP(Participation, PROP) throws error if PROP does NOT exist for Participation.
			%   Error id: [BRAPH2:Participation:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('Participation')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == Participation.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Participation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Participation:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Participation.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in participation/error.
			%
			% CHECK = Participation.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(Participation, TAG) checks whether TAG exists for Participation.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Participation:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Participation:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Participation:WrongInput]
			%  Element.EXISTSTAG(Participation, TAG) throws error if TAG does NOT exist for Participation.
			%   Error id: [BRAPH2:Participation:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('Participation')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			participation_tag_list = cellfun(@(x) Participation.getPropTag(x), num2cell(Participation.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, participation_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Participation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Participation:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for Participation.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Participation, POINTER) returns property number of POINTER of Participation.
			%  PROPERTY = M.GETPROPPROP(Participation, POINTER) returns property number of POINTER of Participation.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('Participation')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				participation_tag_list = cellfun(@(x) Participation.getPropTag(x), num2cell(Participation.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, participation_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(Participation, POINTER) returns tag of POINTER of Participation.
			%  TAG = M.GETPROPTAG(Participation, POINTER) returns tag of POINTER of Participation.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('Participation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case Participation.CI
						tag = Participation.CI_TAG;
					case Participation.RULE
						tag = Participation.RULE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(Participation, POINTER) returns category of POINTER of Participation.
			%  CATEGORY = M.GETPROPCATEGORY(Participation, POINTER) returns category of POINTER of Participation.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('Participation')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Participation.getPropProp(pointer);
			
			switch prop
				case Participation.CI
					prop_category = Participation.CI_CATEGORY;
				case Participation.RULE
					prop_category = Participation.RULE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(Participation, POINTER) returns format of POINTER of Participation.
			%  FORMAT = M.GETPROPFORMAT(Participation, POINTER) returns format of POINTER of Participation.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('Participation')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Participation.getPropProp(pointer);
			
			switch prop
				case Participation.CI
					prop_format = Participation.CI_FORMAT;
				case Participation.RULE
					prop_format = Participation.RULE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Participation, POINTER) returns description of POINTER of Participation.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(Participation, POINTER) returns description of POINTER of Participation.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('Participation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Participation.getPropProp(pointer);
			
			switch prop
				case Participation.CI
					prop_description = 'CI (parameter, MATRIX) ';
				case Participation.RULE
					prop_description = 'RULE (parameter, option)';
				case Participation.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Participation.';
				case Participation.NAME
					prop_description = 'NAME (constant, string) is the name of the Participation.';
				case Participation.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Participation.';
				case Participation.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Participation.';
				case Participation.ID
					prop_description = 'ID (data, string) is a few-letter code of the Participation.';
				case Participation.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Participation.';
				case Participation.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Participation.';
				case Participation.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case Participation.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case Participation.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case Participation.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case Participation.M
					prop_description = 'M (result, cell) is the Participation.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(Participation, POINTER) returns settings of POINTER of Participation.
			%  SETTINGS = M.GETPROPSETTINGS(Participation, POINTER) returns settings of POINTER of Participation.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('Participation')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Participation.getPropProp(pointer);
			
			switch prop
				case Participation.CI
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case Participation.RULE
					prop_settings = {'in', 'out'};
				case Participation.TEMPLATE
					prop_settings = 'Participation';
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Participation.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Participation.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(Participation, POINTER) returns the default value of POINTER of Participation.
			%  DEFAULT = M.GETPROPDEFAULT(Participation, POINTER) returns the default value of POINTER of Participation.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('Participation')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Participation.getPropProp(pointer);
			
			switch prop
				case Participation.CI
					prop_default = 1;
				case Participation.RULE
					prop_default = 'out';
				case Participation.ELCLASS
					prop_default = 'Participation';
				case Participation.NAME
					prop_default = 'Participation';
				case Participation.DESCRIPTION
					prop_default = 'The Participation of a node is the ratio of edges that a node forms within a single layer community to the total number of edges that forms within the whole single layer graph.';
				case Participation.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, Participation.getPropSettings(prop));
				case Participation.ID
					prop_default = 'Participation ID';
				case Participation.LABEL
					prop_default = 'Participation label';
				case Participation.NOTES
					prop_default = 'Participation notes';
				case Participation.SHAPE
					prop_default = Measure.NODAL;
				case Participation.SCOPE
					prop_default = Measure.UNILAYER;
				case Participation.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case Participation.COMPATIBLE_GRAPHS
					prop_default = {'GraphBD' 'GraphBU' 'MultigraphBUT' 'MultiplexBU'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Participation.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Participation.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Participation, POINTER) returns the conditioned default value of POINTER of Participation.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(Participation, POINTER) returns the conditioned default value of POINTER of Participation.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('Participation')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Participation.getPropProp(pointer);
			
			prop_default = Participation.conditioning(prop, Participation.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Participation, PROP, VALUE) checks VALUE format for PROP of Participation.
			%  CHECK = M.CHECKPROP(Participation, PROP, VALUE) checks VALUE format for PROP of Participation.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:Participation:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:Participation:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(Participation, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Participation.
			%   Error id: €BRAPH2.STR€:Participation:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(Participation, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Participation.
			%   Error id: €BRAPH2.STR€:Participation:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('Participation')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Participation.getPropProp(pointer);
			
			switch prop
				case Participation.CI % __Participation.CI__
					check = Format.checkFormat(Format.MATRIX, value, Participation.getPropSettings(prop));
				case Participation.RULE % __Participation.RULE__
					check = Format.checkFormat(Format.OPTION, value, Participation.getPropSettings(prop));
				case Participation.TEMPLATE % __Participation.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, Participation.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Participation:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Participation:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Participation.getPropTag(prop) ' (' Participation.getFormatTag(Participation.getPropFormat(prop)) ').'] ...
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
				case Participation.M % __Participation.M__
					rng_settings_ = rng(); rng(m.getPropSeed(Participation.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					N = g.get('NODENUMBER');
					ls = g.get('PARTITIONS');
					directed_participation_rule = m.get('RULE');
					participation = cell(L, 1);
					directionality_type =   g.get('DIRECTIONALITY_TYPE', L);
					connectivity_type =  g.get('CONNECTIVITY_TYPE', L);
					if ls == 1
					    S = CommunityStructure('G', g).get('M');
					else
					    S = MultilayerCommunity('G', g).get('M');
					end
					
					for li = 1:1:L
					    connectivity_layer = connectivity_type(li, li);
					    directionality_layer = directionality_type(li, li);
					    Aii = A{li, li};
					    m.set('CI', cell2mat(S));
					   
					    if connectivity_layer == Graph.WEIGHTED  % weighted graphs
					        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
					            ko = Strength('G', g).get('M');
					        else  % directed graphs
					            directed_participation_rule = m.get('rule');
					            switch lower(directed_participation_rule)
					                case {'in'}  % in-strength rule                   
					                    ko = InStrength('G', g).get('M');                   
					                otherwise  % {'out'}  % out-strength rule
					                    ko = OutStrength('G', g).get('M');
					            end
					        end
					    else  % binary graphs
					        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
					            ko = Degree('G', g).get('M');
					        else  % directed graphs
					            directed_participation_rule = m.get('RULE');
					            switch lower(directed_participation_rule)
					                case {'in'}  % in-degree rule
					                    ko = DegreeIn('G', g).get('M');
					                otherwise  % {'out'}  % out-degree rule
					                    ko = DegreeOut('G', g).get('M');
					            end
					        end
					    end
					
					    Gc = (Aii~=0)*diag(S{li});  % neighbor community affiliation
					    Kc2 = zeros(N(1), 1);  % community-specific neighbors
					    for i=1:max(S{li})
					        Kc2 = Kc2 + (sum(Aii.*(Gc==i), 2).^2);
					    end
					    participation_layer = ones(N(1), 1) - Kc2./(ko{li}.^2);
					    participation_layer(~ko{li}) = 0;  % participation = 0 if for nodes with no (out)neighbors
					    participation(li) = {participation_layer};
					end
					value = participation;
					
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
