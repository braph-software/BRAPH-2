classdef Diameter < Measure
	%Diameter is the graph Diameter.
	% It is a subclass of <a href="matlab:help Measure">Measure</a>.
	%
	% The Diameter (Diameter) is the maximum eccentricity among the vertices within a layer.
	%
	% Diameter methods (constructor):
	%  Diameter - constructor
	%
	% Diameter methods:
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
	% Diameter methods (display):
	%  tostring - string with information about the diameter
	%  disp - displays information about the diameter
	%  tree - displays the tree of the diameter
	%
	% Diameter methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two diameter are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the diameter
	%
	% Diameter methods (save/load, Static):
	%  save - saves BRAPH2 diameter as b2 file
	%  load - loads a BRAPH2 diameter from a b2 file
	%
	% Diameter method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the diameter
	%
	% Diameter method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the diameter
	%
	% Diameter methods (inspection, Static):
	%  getClass - returns the class of the diameter
	%  getSubclasses - returns all subclasses of Diameter
	%  getProps - returns the property list of the diameter
	%  getPropNumber - returns the property number of the diameter
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
	% Diameter methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Diameter methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Diameter methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Diameter methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Diameter; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Diameter constants</a>.
	%
	
	properties (Constant) % properties
		RULE = Measure.getPropNumber() + 1;
		RULE_TAG = 'RULE';
		RULE_CATEGORY = Category.PARAMETER;
		RULE_FORMAT = Format.OPTION;
	end
	methods % constructor
		function m = Diameter(varargin)
			%Diameter() creates a diameter.
			%
			% Diameter(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Diameter(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the diameter.
			%
			% CLASS = Diameter.GETCLASS() returns the class 'Diameter'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the diameter M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('Diameter') returns 'Diameter'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('Diameter')
			%  are less computationally efficient.
			
			m_class = 'Diameter';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the diameter.
			%
			% LIST = Diameter.GETSUBCLASSES() returns all subclasses of 'Diameter'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the diameter M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('Diameter') returns all subclasses of 'Diameter'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('Diameter')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('Diameter', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of diameter.
			%
			% PROPS = Diameter.GETPROPS() returns the property list of diameter
			%  as a row vector.
			%
			% PROPS = Diameter.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the diameter M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('Diameter'[, CATEGORY]) returns the property list of 'Diameter'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('Diameter')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					Measure.getProps() ...
						Diameter.RULE ...
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
						Diameter.RULE ...
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
			%GETPROPNUMBER returns the property number of diameter.
			%
			% N = Diameter.GETPROPNUMBER() returns the property number of diameter.
			%
			% N = Diameter.GETPROPNUMBER(CATEGORY) returns the property number of diameter
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the diameter M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('Diameter') returns the property number of 'Diameter'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('Diameter')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(Diameter.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in diameter/error.
			%
			% CHECK = Diameter.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(Diameter, PROP) checks whether PROP exists for Diameter.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Diameter:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Diameter:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Diameter:WrongInput]
			%  Element.EXISTSPROP(Diameter, PROP) throws error if PROP does NOT exist for Diameter.
			%   Error id: [BRAPH2:Diameter:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('Diameter')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == Diameter.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Diameter:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Diameter:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Diameter.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in diameter/error.
			%
			% CHECK = Diameter.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(Diameter, TAG) checks whether TAG exists for Diameter.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Diameter:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Diameter:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Diameter:WrongInput]
			%  Element.EXISTSTAG(Diameter, TAG) throws error if TAG does NOT exist for Diameter.
			%   Error id: [BRAPH2:Diameter:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('Diameter')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			diameter_tag_list = cellfun(@(x) Diameter.getPropTag(x), num2cell(Diameter.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, diameter_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Diameter:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Diameter:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for Diameter.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Diameter, POINTER) returns property number of POINTER of Diameter.
			%  PROPERTY = M.GETPROPPROP(Diameter, POINTER) returns property number of POINTER of Diameter.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('Diameter')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				diameter_tag_list = cellfun(@(x) Diameter.getPropTag(x), num2cell(Diameter.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, diameter_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(Diameter, POINTER) returns tag of POINTER of Diameter.
			%  TAG = M.GETPROPTAG(Diameter, POINTER) returns tag of POINTER of Diameter.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('Diameter')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case Diameter.RULE
						tag = Diameter.RULE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(Diameter, POINTER) returns category of POINTER of Diameter.
			%  CATEGORY = M.GETPROPCATEGORY(Diameter, POINTER) returns category of POINTER of Diameter.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('Diameter')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Diameter.getPropProp(pointer);
			
			switch prop
				case Diameter.RULE
					prop_category = Diameter.RULE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(Diameter, POINTER) returns format of POINTER of Diameter.
			%  FORMAT = M.GETPROPFORMAT(Diameter, POINTER) returns format of POINTER of Diameter.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('Diameter')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Diameter.getPropProp(pointer);
			
			switch prop
				case Diameter.RULE
					prop_format = Diameter.RULE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Diameter, POINTER) returns description of POINTER of Diameter.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(Diameter, POINTER) returns description of POINTER of Diameter.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('Diameter')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Diameter.getPropProp(pointer);
			
			switch prop
				case Diameter.RULE
					prop_description = 'RULE (parameter, OPTION)  % calculation in a graph or its subgraph';
				case Diameter.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Diameter.';
				case Diameter.NAME
					prop_description = 'NAME (constant, string) is the name of the Diameter.';
				case Diameter.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Diameter.';
				case Diameter.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Diameter.';
				case Diameter.ID
					prop_description = 'ID (data, string) is a few-letter code of the Diameter.';
				case Diameter.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Diameter.';
				case Diameter.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Diameter.';
				case Diameter.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.';
				case Diameter.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case Diameter.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case Diameter.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case Diameter.M
					prop_description = 'M (result, cell) is the Diameter.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(Diameter, POINTER) returns settings of POINTER of Diameter.
			%  SETTINGS = M.GETPROPSETTINGS(Diameter, POINTER) returns settings of POINTER of Diameter.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('Diameter')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Diameter.getPropProp(pointer);
			
			switch prop
				case Diameter.RULE
					prop_settings = {'all', 'subgraphs'};
				otherwise
					prop_settings = getPropSettings@Measure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Diameter.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Diameter.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(Diameter, POINTER) returns the default value of POINTER of Diameter.
			%  DEFAULT = M.GETPROPDEFAULT(Diameter, POINTER) returns the default value of POINTER of Diameter.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('Diameter')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Diameter.getPropProp(pointer);
			
			switch prop
				case Diameter.RULE
					prop_default = 'all';
				case Diameter.ELCLASS
					prop_default = 'Diameter';
				case Diameter.NAME
					prop_default = 'Diameter';
				case Diameter.DESCRIPTION
					prop_default = 'The Diameter (Diameter) is the maximum eccentricity among the vertices within a layer.';
				case Diameter.ID
					prop_default = 'Diameter ID';
				case Diameter.LABEL
					prop_default = 'Diameter label';
				case Diameter.NOTES
					prop_default = 'Diameter notes';
				case Diameter.SHAPE
					prop_default = Measure.GLOBAL;
				case Diameter.SCOPE
					prop_default = Measure.UNILAYER;
				case Diameter.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case Diameter.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU'};;
				otherwise
					prop_default = getPropDefault@Measure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Diameter.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Diameter.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Diameter, POINTER) returns the conditioned default value of POINTER of Diameter.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(Diameter, POINTER) returns the conditioned default value of POINTER of Diameter.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('Diameter')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Diameter.getPropProp(pointer);
			
			prop_default = Diameter.conditioning(prop, Diameter.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Diameter, PROP, VALUE) checks VALUE format for PROP of Diameter.
			%  CHECK = M.CHECKPROP(Diameter, PROP, VALUE) checks VALUE format for PROP of Diameter.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:Diameter:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:Diameter:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(Diameter, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Diameter.
			%   Error id: €BRAPH2.STR€:Diameter:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(Diameter, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Diameter.
			%   Error id: €BRAPH2.STR€:Diameter:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('Diameter')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Diameter.getPropProp(pointer);
			
			switch prop
				case Diameter.RULE % __Diameter.RULE__
					check = Format.checkFormat(Format.OPTION, value, Diameter.getPropSettings(prop));
				otherwise
					if prop <= Measure.getPropNumber()
						check = checkProp@Measure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Diameter:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Diameter:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Diameter.getPropTag(prop) ' (' Diameter.getFormatTag(Diameter.getPropFormat(prop)) ').'] ...
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
				case Diameter.M % __Diameter.M__
					rng_settings_ = rng(); rng(m.getPropSeed(Diameter.M), 'twister')
					
					g = m.get('G'); % graph from measure class
					A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
					L = g.get('LAYERNUMBER');
					
					eccentricity = Eccentricity('G', g, 'RULE', m.get('RULE')).get('M'); 
					diameter = cell(L, 1);
					
					parfor li = 1:L
					    diameter(li) = {max(eccentricity{li})};
					end
					
					value = diameter;
					
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
