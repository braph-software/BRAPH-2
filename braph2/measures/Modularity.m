classdef Modularity < CommunityStructure
	%Modularity is the graph Modularity.
	% It is a subclass of <a href="matlab:help CommunityStructure">CommunityStructure</a>.
	%
	% The Modularity (Modularity) of a graph is the quality function Q of the resulting partition of the network.
	%
	% Modularity methods (constructor):
	%  Modularity - constructor
	%
	% Modularity methods:
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
	% Modularity methods (display):
	%  tostring - string with information about the modularity
	%  disp - displays information about the modularity
	%  tree - displays the tree of the modularity
	%
	% Modularity methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two modularity are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the modularity
	%
	% Modularity methods (save/load, Static):
	%  save - saves BRAPH2 modularity as b2 file
	%  load - loads a BRAPH2 modularity from a b2 file
	%
	% Modularity method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the modularity
	%
	% Modularity method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the modularity
	%
	% Modularity methods (inspection, Static):
	%  getClass - returns the class of the modularity
	%  getSubclasses - returns all subclasses of Modularity
	%  getProps - returns the property list of the modularity
	%  getPropNumber - returns the property number of the modularity
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
	% Modularity methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Modularity methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Modularity methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Modularity methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Modularity; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Modularity constants</a>.
	%
	
	methods % constructor
		function m = Modularity(varargin)
			%Modularity() creates a modularity.
			%
			% Modularity(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Modularity(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			m = m@CommunityStructure(varargin{:});
		end
	end
	methods (Static) % inspection
		function m_class = getClass()
			%GETCLASS returns the class of the modularity.
			%
			% CLASS = Modularity.GETCLASS() returns the class 'Modularity'.
			%
			% Alternative forms to call this method are:
			%  CLASS = M.GETCLASS() returns the class of the modularity M.
			%  CLASS = Element.GETCLASS(M) returns the class of 'M'.
			%  CLASS = Element.GETCLASS('Modularity') returns 'Modularity'.
			%
			% Note that the Element.GETCLASS(M) and Element.GETCLASS('Modularity')
			%  are less computationally efficient.
			
			m_class = 'Modularity';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the modularity.
			%
			% LIST = Modularity.GETSUBCLASSES() returns all subclasses of 'Modularity'.
			%
			% Alternative forms to call this method are:
			%  LIST = M.GETSUBCLASSES() returns all subclasses of the modularity M.
			%  LIST = Element.GETSUBCLASSES(M) returns all subclasses of 'M'.
			%  LIST = Element.GETSUBCLASSES('Modularity') returns all subclasses of 'Modularity'.
			%
			% Note that the Element.GETSUBCLASSES(M) and Element.GETSUBCLASSES('Modularity')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('Modularity', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of modularity.
			%
			% PROPS = Modularity.GETPROPS() returns the property list of modularity
			%  as a row vector.
			%
			% PROPS = Modularity.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = M.GETPROPS([CATEGORY]) returns the property list of the modularity M.
			%  PROPS = Element.GETPROPS(M[, CATEGORY]) returns the property list of 'M'.
			%  PROPS = Element.GETPROPS('Modularity'[, CATEGORY]) returns the property list of 'Modularity'.
			%
			% Note that the Element.GETPROPS(M) and Element.GETPROPS('Modularity')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					CommunityStructure.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						CommunityStructure.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						CommunityStructure.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						CommunityStructure.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						CommunityStructure.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						CommunityStructure.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						CommunityStructure.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						CommunityStructure.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						CommunityStructure.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						CommunityStructure.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of modularity.
			%
			% N = Modularity.GETPROPNUMBER() returns the property number of modularity.
			%
			% N = Modularity.GETPROPNUMBER(CATEGORY) returns the property number of modularity
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = M.GETPROPNUMBER([CATEGORY]) returns the property number of the modularity M.
			%  N = Element.GETPROPNUMBER(M) returns the property number of 'M'.
			%  N = Element.GETPROPNUMBER('Modularity') returns the property number of 'Modularity'.
			%
			% Note that the Element.GETPROPNUMBER(M) and Element.GETPROPNUMBER('Modularity')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(Modularity.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in modularity/error.
			%
			% CHECK = Modularity.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSPROP(PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(M, PROP) checks whether PROP exists for M.
			%  CHECK = Element.EXISTSPROP(Modularity, PROP) checks whether PROP exists for Modularity.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Modularity:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSPROP(PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Modularity:WrongInput]
			%  Element.EXISTSPROP(M, PROP) throws error if PROP does NOT exist for M.
			%   Error id: [BRAPH2:Modularity:WrongInput]
			%  Element.EXISTSPROP(Modularity, PROP) throws error if PROP does NOT exist for Modularity.
			%   Error id: [BRAPH2:Modularity:WrongInput]
			%
			% Note that the Element.EXISTSPROP(M) and Element.EXISTSPROP('Modularity')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == Modularity.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Modularity:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Modularity:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Modularity.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in modularity/error.
			%
			% CHECK = Modularity.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = M.EXISTSTAG(TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(M, TAG) checks whether TAG exists for M.
			%  CHECK = Element.EXISTSTAG(Modularity, TAG) checks whether TAG exists for Modularity.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Modularity:WrongInput]
			%
			% Alternative forms to call this method are:
			%  M.EXISTSTAG(TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Modularity:WrongInput]
			%  Element.EXISTSTAG(M, TAG) throws error if TAG does NOT exist for M.
			%   Error id: [BRAPH2:Modularity:WrongInput]
			%  Element.EXISTSTAG(Modularity, TAG) throws error if TAG does NOT exist for Modularity.
			%   Error id: [BRAPH2:Modularity:WrongInput]
			%
			% Note that the Element.EXISTSTAG(M) and Element.EXISTSTAG('Modularity')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			modularity_tag_list = cellfun(@(x) Modularity.getPropTag(x), num2cell(Modularity.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, modularity_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Modularity:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Modularity:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for Modularity.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(Modularity, POINTER) returns property number of POINTER of Modularity.
			%  PROPERTY = M.GETPROPPROP(Modularity, POINTER) returns property number of POINTER of Modularity.
			%
			% Note that the Element.GETPROPPROP(M) and Element.GETPROPPROP('Modularity')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				modularity_tag_list = cellfun(@(x) Modularity.getPropTag(x), num2cell(Modularity.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, modularity_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(Modularity, POINTER) returns tag of POINTER of Modularity.
			%  TAG = M.GETPROPTAG(Modularity, POINTER) returns tag of POINTER of Modularity.
			%
			% Note that the Element.GETPROPTAG(M) and Element.GETPROPTAG('Modularity')
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
						tag = getPropTag@CommunityStructure(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(Modularity, POINTER) returns category of POINTER of Modularity.
			%  CATEGORY = M.GETPROPCATEGORY(Modularity, POINTER) returns category of POINTER of Modularity.
			%
			% Note that the Element.GETPROPCATEGORY(M) and Element.GETPROPCATEGORY('Modularity')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Modularity.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@CommunityStructure(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(Modularity, POINTER) returns format of POINTER of Modularity.
			%  FORMAT = M.GETPROPFORMAT(Modularity, POINTER) returns format of POINTER of Modularity.
			%
			% Note that the Element.GETPROPFORMAT(M) and Element.GETPROPFORMAT('Modularity')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Modularity.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@CommunityStructure(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Modularity, POINTER) returns description of POINTER of Modularity.
			%  DESCRIPTION = M.GETPROPDESCRIPTION(Modularity, POINTER) returns description of POINTER of Modularity.
			%
			% Note that the Element.GETPROPDESCRIPTION(M) and Element.GETPROPDESCRIPTION('Modularity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Modularity.getPropProp(pointer);
			
			switch prop
				case Modularity.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the Modularity.';
				case Modularity.NAME
					prop_description = 'NAME (constant, string) is the name of the Modularity.';
				case Modularity.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the Modularity.';
				case Modularity.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the Modularity.';
				case Modularity.ID
					prop_description = 'ID (data, string) is a few-letter code of the Modularity.';
				case Modularity.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the Modularity.';
				case Modularity.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the Modularity.';
				case Modularity.SHAPE
					prop_description = 'SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.';
				case Modularity.SCOPE
					prop_description = 'SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.';
				case Modularity.PARAMETRICITY
					prop_description = 'PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.';
				case Modularity.COMPATIBLE_GRAPHS
					prop_description = 'COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.';
				case Modularity.M
					prop_description = 'M (result, cell) is the Modularity.';
				otherwise
					prop_description = getPropDescription@CommunityStructure(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(Modularity, POINTER) returns settings of POINTER of Modularity.
			%  SETTINGS = M.GETPROPSETTINGS(Modularity, POINTER) returns settings of POINTER of Modularity.
			%
			% Note that the Element.GETPROPSETTINGS(M) and Element.GETPROPSETTINGS('Modularity')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Modularity.getPropProp(pointer);
			
			switch prop
				case Modularity.TEMPLATE
					prop_settings = 'Modularity';
				otherwise
					prop_settings = getPropSettings@CommunityStructure(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Modularity.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Modularity.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULT(POINTER) returns the default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULT(Modularity, POINTER) returns the default value of POINTER of Modularity.
			%  DEFAULT = M.GETPROPDEFAULT(Modularity, POINTER) returns the default value of POINTER of Modularity.
			%
			% Note that the Element.GETPROPDEFAULT(M) and Element.GETPROPDEFAULT('Modularity')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Modularity.getPropProp(pointer);
			
			switch prop
				case Modularity.ELCLASS
					prop_default = 'Modularity';
				case Modularity.NAME
					prop_default = 'Modularity';
				case Modularity.DESCRIPTION
					prop_default = 'The Modularity (Modularity) of a graph is the quality function Q of the resulting partition of the network.';
				case Modularity.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, Modularity.getPropSettings(prop));
				case Modularity.ID
					prop_default = 'Modularity ID';
				case Modularity.LABEL
					prop_default = 'Modularity label';
				case Modularity.NOTES
					prop_default = 'Modularity notes';
				case Modularity.SHAPE
					prop_default = Measure.GLOBAL;
				case Modularity.SCOPE
					prop_default = Measure.UNILAYER;
				case Modularity.PARAMETRICITY
					prop_default = Measure.NONPARAMETRIC;
				case Modularity.COMPATIBLE_GRAPHS
					prop_default = {'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUT' 'MultigraphBUD'};;
				otherwise
					prop_default = getPropDefault@CommunityStructure(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Modularity.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Modularity.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of M.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Modularity, POINTER) returns the conditioned default value of POINTER of Modularity.
			%  DEFAULT = M.GETPROPDEFAULTCONDITIONED(Modularity, POINTER) returns the conditioned default value of POINTER of Modularity.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(M) and Element.GETPROPDEFAULTCONDITIONED('Modularity')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Modularity.getPropProp(pointer);
			
			prop_default = Modularity.conditioning(prop, Modularity.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(Modularity, PROP, VALUE) checks VALUE format for PROP of Modularity.
			%  CHECK = M.CHECKPROP(Modularity, PROP, VALUE) checks VALUE format for PROP of Modularity.
			% 
			% M.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:Modularity:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  M.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of M.
			%   Error id: €BRAPH2.STR€:Modularity:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(Modularity, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Modularity.
			%   Error id: €BRAPH2.STR€:Modularity:€BRAPH2.WRONG_INPUT€
			%  M.CHECKPROP(Modularity, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Modularity.
			%   Error id: €BRAPH2.STR€:Modularity:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(M) and Element.CHECKPROP('Modularity')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Modularity.getPropProp(pointer);
			
			switch prop
				case Modularity.TEMPLATE % __Modularity.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, Modularity.getPropSettings(prop));
				otherwise
					if prop <= CommunityStructure.getPropNumber()
						check = checkProp@CommunityStructure(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Modularity:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Modularity:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Modularity.getPropTag(prop) ' (' Modularity.getFormatTag(Modularity.getPropFormat(prop)) ').'] ...
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
				case Modularity.M % __Modularity.M__
					rng_settings_ = rng(); rng(m.getPropSeed(Modularity.M), 'twister')
					
					community_structure = calculateValue@CommunityStructure(m, prop);
					Q = {0};
					if ~isempty(community_structure)
					    Q = m.get('QUALITY_FUNCTION');
					end
					modularity = Q;  % assign normalized quality function
					value = modularity;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= CommunityStructure.getPropNumber()
						value = calculateValue@CommunityStructure(m, prop, varargin{:});
					else
						value = calculateValue@Element(m, prop, varargin{:});
					end
			end
			
		end
	end
end
